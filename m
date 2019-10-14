From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:16 +0000
Subject: [PATCH v2 15/15] staging/mgakms: Update matroxfb driver code for DRM
Message-Id: <20191014140416.28517-16-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

With the update, all driver code coming from matroxfb is build
unconditionally. The driver registers itself with the mgakms driver,
instead of the fbdev core.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/mgakms/Kconfig            |  5 ++
 drivers/staging/mgakms/Makefile           | 11 ++++
 drivers/staging/mgakms/matroxfb_DAC1064.c | 77 +++++++----------------
 drivers/staging/mgakms/matroxfb_DAC1064.h |  6 --
 drivers/staging/mgakms/matroxfb_Ti3026.c  |  2 -
 drivers/staging/mgakms/matroxfb_Ti3026.h  |  2 -
 drivers/staging/mgakms/matroxfb_base.c    | 29 +++------
 drivers/staging/mgakms/matroxfb_base.h    | 20 ++----
 drivers/staging/mgakms/matroxfb_g450.h    |  5 --
 9 files changed, 51 insertions(+), 106 deletions(-)

diff --git a/drivers/staging/mgakms/Kconfig b/drivers/staging/mgakms/Kconfig
index de23e76317bd..66c5b3b8669f 100644
--- a/drivers/staging/mgakms/Kconfig
+++ b/drivers/staging/mgakms/Kconfig
@@ -4,6 +4,11 @@ config DRM_MGAKMS
 	select DRM_FBCONV_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select FB_CFB_COPYAREA
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
+	select FB_MACMODES if PPC_PMAC
+	select FB_TILEBLITTING
 	help
 	  Choose this option if you have a Matrox Millennium,
 	  Matrox Millennium II, Matrox Mystique, Matrox Mystique 220,
diff --git a/drivers/staging/mgakms/Makefile b/drivers/staging/mgakms/Makefile
index 65695f04eb7f..b368f8a5e38a 100644
--- a/drivers/staging/mgakms/Makefile
+++ b/drivers/staging/mgakms/Makefile
@@ -3,4 +3,15 @@
 mgakms-y	:= mga_device.o \
 		   mga_drv.o
 
+# Old matroxfb driver code. Keep this separate and
+# remove it after conversion.
+mgakms-y	+= g450_pll.o \
+		   i2c-matroxfb.o \
+		   matroxfb_accel.o \
+		   matroxfb_base.o \
+		   matroxfb_DAC1064.o \
+		   matroxfb_g450.o \
+		   matroxfb_misc.o \
+		   matroxfb_Ti3026.o
+
 obj-$(CONFIG_DRM_MGAKMS)	+= mgakms.o
diff --git a/drivers/staging/mgakms/matroxfb_DAC1064.c b/drivers/staging/mgakms/matroxfb_DAC1064.c
index b380a393cbc3..6bb214c548af 100644
--- a/drivers/staging/mgakms/matroxfb_DAC1064.c
+++ b/drivers/staging/mgakms/matroxfb_DAC1064.c
@@ -19,7 +19,6 @@
 #include "g450_pll.h"
 #include <linux/matroxfb.h>
 
-#ifdef NEED_DAC1064
 #define outDAC1064 matroxfb_DAC_out
 #define inDAC1064 matroxfb_DAC_in
 
@@ -42,11 +41,11 @@ static void DAC1064_calcclock(const struct matrox_fb_info *minfo,
 	unsigned int p;
 
 	DBG(__func__)
-	
+
 	/* only for devices older than G450 */
 
 	fvco = PLL_calcclock(minfo, freq, fmax, in, feed, &p);
-	
+
 	p = (1 << p) - 1;
 	if (fvco <= 100000)
 		;
@@ -160,7 +159,6 @@ static void DAC1064_setmclk(struct matrox_fb_info *minfo, int oscinfo,
 	hw->MXoptionReg = mx;
 }
 
-#ifdef CONFIG_FB_MATROX_G
 static void g450_set_plls(struct matrox_fb_info *minfo)
 {
 	u_int32_t c2_ctl;
@@ -168,7 +166,7 @@ static void g450_set_plls(struct matrox_fb_info *minfo)
 	struct matrox_hw_state *hw = &minfo->hw;
 	int pixelmnp;
 	int videomnp;
-	
+
 	c2_ctl = hw->crtc2.ctl & ~0x4007;	/* Clear PLL + enable for CRTC2 */
 	c2_ctl |= 0x0001;			/* Enable CRTC2 */
 	hw->DACreg[POS1064_XPWRCTRL] &= ~0x02;	/* Stop VIDEO PLL */
@@ -191,7 +189,7 @@ static void g450_set_plls(struct matrox_fb_info *minfo)
 		}
 		c2_ctl |=  0x0006;	/* Use video PLL */
 		hw->DACreg[POS1064_XPWRCTRL] |= 0x02;
-		
+
 		outDAC1064(minfo, M1064_XPWRCTRL, hw->DACreg[POS1064_XPWRCTRL]);
 		matroxfb_g450_setpll_cond(minfo, videomnp, M_VIDEO_PLL);
 	}
@@ -199,7 +197,7 @@ static void g450_set_plls(struct matrox_fb_info *minfo)
 	hw->DACreg[POS1064_XPIXCLKCTRL] &= ~M1064_XPIXCLKCTRL_PLL_UP;
 	if (pixelmnp >= 0) {
 		hw->DACreg[POS1064_XPIXCLKCTRL] |= M1064_XPIXCLKCTRL_PLL_UP;
-		
+
 		outDAC1064(minfo, M1064_XPIXCLKCTRL, hw->DACreg[POS1064_XPIXCLKCTRL]);
 		matroxfb_g450_setpll_cond(minfo, pixelmnp, M_PIXEL_PLL_C);
 	}
@@ -251,7 +249,6 @@ static void g450_set_plls(struct matrox_fb_info *minfo)
 		}
 	}
 }
-#endif
 
 void DAC1064_global_init(struct matrox_fb_info *minfo)
 {
@@ -260,7 +257,6 @@ void DAC1064_global_init(struct matrox_fb_info *minfo)
 	hw->DACreg[POS1064_XMISCCTRL] &= M1064_XMISCCTRL_DAC_WIDTHMASK;
 	hw->DACreg[POS1064_XMISCCTRL] |= M1064_XMISCCTRL_LUT_EN;
 	hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_PLL;
-#ifdef CONFIG_FB_MATROX_G
 	if (minfo->devflags.g450dac) {
 		hw->DACreg[POS1064_XPWRCTRL] = 0x1F;	/* powerup everything */
 		hw->DACreg[POS1064_XOUTPUTCONN] = 0x00;	/* disable outputs */
@@ -302,15 +298,14 @@ void DAC1064_global_init(struct matrox_fb_info *minfo)
 				   poweroff TMDS. But if we boot with DFP connected,
 				   TMDS generated clocks are used instead of ALL pixclocks
 				   available... If someone knows which register
-				   handles it, please reveal this secret to me... */			
+				   handles it, please reveal this secret to me... */
 				hw->DACreg[POS1064_XPWRCTRL] &= ~0x04;		/* Poweroff TMDS */
-#endif				
+#endif
 				break;
 		}
 		/* Now set timming related variables... */
 		g450_set_plls(minfo);
 	} else
-#endif
 	{
 		if (minfo->outputs[1].src = MATROXFB_SRC_CRTC1) {
 			hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_EXT;
@@ -510,7 +505,6 @@ static struct matrox_altout m1064 = {
 	.compute = m1064_compute,
 };
 
-#ifdef CONFIG_FB_MATROX_G
 static int g450_compute(void* out, struct my_timming* m) {
 #define minfo ((struct matrox_fb_info*)out)
 	if (m->mnp < 0) {
@@ -527,11 +521,7 @@ static struct matrox_altout g450out = {
 	.name	 = "Primary output",
 	.compute = g450_compute,
 };
-#endif
 
-#endif /* NEED_DAC1064 */
-
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 static int MGA1064_init(struct matrox_fb_info *minfo, struct my_timming *m)
 {
 	struct matrox_hw_state *hw = &minfo->hw;
@@ -552,9 +542,7 @@ static int MGA1064_init(struct matrox_fb_info *minfo, struct my_timming *m)
 	if (DAC1064_init_2(minfo, m)) return 1;
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_G
 static int MGAG100_init(struct matrox_fb_info *minfo, struct my_timming *m)
 {
 	struct matrox_hw_state *hw = &minfo->hw;
@@ -576,9 +564,7 @@ static int MGAG100_init(struct matrox_fb_info *minfo, struct my_timming *m)
 	if (DAC1064_init_2(minfo, m)) return 1;
 	return 0;
 }
-#endif	/* G */
 
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
 {
 
@@ -596,9 +582,7 @@ static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
 	/* maybe cmdline MCLK= ?, doc says gclkDMHz, mclkfMHz... it was 55/83 with old values */
 	DAC1064_setmclk(minfo, DAC1064_OPT_MDIV2 | DAC1064_OPT_GDIV3 | DAC1064_OPT_SCLK_PLL, 133333);
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_G
 /* BIOS environ */
 static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
 				/* G100 wants 0x10, G200 SGRAM does not care... */
@@ -662,9 +646,7 @@ static void MGAG100_setPixClock(const struct matrox_fb_info *minfo, int flags,
 	DAC1064_calcclock(minfo, freq, minfo->max_pixel_clock, &m, &n, &p);
 	MGAG100_progPixClock(minfo, flags, m, n, p);
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 static int MGA1064_preinit(struct matrox_fb_info *minfo)
 {
 	static const int vxres_mystique[] = { 512,        640, 768,  800,  832,  960,
@@ -710,9 +692,7 @@ static void MGA1064_reset(struct matrox_fb_info *minfo)
 
 	MGA1064_ramdac_init(minfo);
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_G
 static void g450_mclk_init(struct matrox_fb_info *minfo)
 {
 	/* switch all clocks to PCI source */
@@ -727,14 +707,14 @@ static void g450_mclk_init(struct matrox_fb_info *minfo)
 	} else {
 		unsigned long flags;
 		unsigned int pwr;
-		
+
 		matroxfb_DAC_lock_irqsave(flags);
 		pwr = inDAC1064(minfo, M1064_XPWRCTRL) & ~0x02;
 		outDAC1064(minfo, M1064_XPWRCTRL, pwr);
 		matroxfb_DAC_unlock_irqrestore(flags);
 	}
 	matroxfb_g450_setclk(minfo, minfo->values.pll.system, M_SYSTEM_PLL);
-	
+
 	/* switch clocks to their real PLL source(s) */
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION_REG, minfo->hw.MXoptionReg | 4);
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION3_REG, minfo->values.reg.opt3);
@@ -747,15 +727,15 @@ static void g450_memory_init(struct matrox_fb_info *minfo)
 	/* disable memory refresh */
 	minfo->hw.MXoptionReg &= ~0x001F8000;
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION_REG, minfo->hw.MXoptionReg);
-	
+
 	/* set memory interface parameters */
 	minfo->hw.MXoptionReg &= ~0x00207E00;
 	minfo->hw.MXoptionReg |= 0x00207E00 & minfo->values.reg.opt;
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION_REG, minfo->hw.MXoptionReg);
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION2_REG, minfo->values.reg.opt2);
-	
+
 	mga_outl(M_CTLWTST, minfo->values.reg.mctlwtst);
-	
+
 	/* first set up memory interface with disabled memory interface clocks */
 	pci_write_config_dword(minfo->pcidev, PCI_MEMMISC_REG, minfo->values.reg.memmisc & ~0x80000000U);
 	mga_outl(M_MEMRDBK, minfo->values.reg.memrdbk);
@@ -764,25 +744,25 @@ static void g450_memory_init(struct matrox_fb_info *minfo)
 	pci_write_config_dword(minfo->pcidev, PCI_MEMMISC_REG, minfo->values.reg.memmisc | 0x80000000U);
 
 	udelay(200);
-	
+
 	if (minfo->values.memory.ddr && (!minfo->values.memory.emrswen || !minfo->values.memory.dll)) {
 		mga_outl(M_MEMRDBK, minfo->values.reg.memrdbk & ~0x1000);
 	}
 	mga_outl(M_MACCESS, minfo->values.reg.maccess | 0x8000);
-	
+
 	udelay(200);
-	
+
 	minfo->hw.MXoptionReg |= 0x001F8000 & minfo->values.reg.opt;
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION_REG, minfo->hw.MXoptionReg);
-	
+
 	/* value is written to memory chips only if old != new */
 	mga_outl(M_PLNWT, 0);
 	mga_outl(M_PLNWT, ~0);
-	
+
 	if (minfo->values.reg.mctlwtst != minfo->values.reg.mctlwtst_core) {
 		mga_outl(M_CTLWTST, minfo->values.reg.mctlwtst_core);
 	}
-	
+
 }
 
 static void g450_preinit(struct matrox_fb_info *minfo)
@@ -790,7 +770,7 @@ static void g450_preinit(struct matrox_fb_info *minfo)
 	u_int32_t c2ctl;
 	u_int8_t curctl;
 	u_int8_t c1ctl;
-	
+
 	/* minfo->hw.MXoptionReg = minfo->values.reg.opt; */
 	minfo->hw.MXoptionReg &= 0xC0000100;
 	minfo->hw.MXoptionReg |= 0x00000020;
@@ -804,7 +784,7 @@ static void g450_preinit(struct matrox_fb_info *minfo)
 	pci_write_config_dword(minfo->pcidev, PCI_OPTION_REG, minfo->hw.MXoptionReg);
 
 	/* Init system clocks */
-		
+
 	/* stop crtc2 */
 	c2ctl = mga_inl(M_C2CTL);
 	mga_outl(M_C2CTL, c2ctl & ~1);
@@ -817,20 +797,20 @@ static void g450_preinit(struct matrox_fb_info *minfo)
 
 	g450_mclk_init(minfo);
 	g450_memory_init(minfo);
-	
+
 	/* set legacy VGA clock sources for DOSEmu or VMware... */
 	matroxfb_g450_setclk(minfo, 25175, M_PIXEL_PLL_A);
 	matroxfb_g450_setclk(minfo, 28322, M_PIXEL_PLL_B);
 
 	/* restore crtc1 */
 	mga_setr(M_SEQ_INDEX, 1, c1ctl);
-	
+
 	/* restore cursor */
 	outDAC1064(minfo, M1064_XCURCTRL, curctl);
 
 	/* restore crtc2 */
 	mga_outl(M_C2CTL, c2ctl);
-	
+
 	return;
 }
 
@@ -1031,9 +1011,7 @@ static void MGAG100_reset(struct matrox_fb_info *minfo)
 		}
 	}
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 static void MGA1064_restore(struct matrox_fb_info *minfo)
 {
 	int i;
@@ -1058,9 +1036,7 @@ static void MGA1064_restore(struct matrox_fb_info *minfo)
 		mga_setr(M_EXTVGA_INDEX, i, hw->CRTCEXT[i]);
 	DAC1064_restore_2(minfo);
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_G
 static void MGAG100_restore(struct matrox_fb_info *minfo)
 {
 	int i;
@@ -1084,9 +1060,7 @@ static void MGAG100_restore(struct matrox_fb_info *minfo)
 		mga_setr(M_EXTVGA_INDEX, i, hw->CRTCEXT[i]);
 	DAC1064_restore_2(minfo);
 }
-#endif
 
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 struct matrox_switch matrox_mystique = {
 	.preinit	= MGA1064_preinit,
 	.reset		= MGA1064_reset,
@@ -1094,9 +1068,7 @@ struct matrox_switch matrox_mystique = {
 	.restore	= MGA1064_restore,
 };
 EXPORT_SYMBOL(matrox_mystique);
-#endif
 
-#ifdef CONFIG_FB_MATROX_G
 struct matrox_switch matrox_G100 = {
 	.preinit	= MGAG100_preinit,
 	.reset		= MGAG100_reset,
@@ -1104,10 +1076,7 @@ struct matrox_switch matrox_G100 = {
 	.restore	= MGAG100_restore,
 };
 EXPORT_SYMBOL(matrox_G100);
-#endif
 
-#ifdef NEED_DAC1064
 EXPORT_SYMBOL(DAC1064_global_init);
 EXPORT_SYMBOL(DAC1064_global_restore);
-#endif
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/mgakms/matroxfb_DAC1064.h b/drivers/staging/mgakms/matroxfb_DAC1064.h
index 3b2a6fd35fff..3d388941b51d 100644
--- a/drivers/staging/mgakms/matroxfb_DAC1064.h
+++ b/drivers/staging/mgakms/matroxfb_DAC1064.h
@@ -5,16 +5,10 @@
 
 #include "matroxfb_base.h"
 
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 extern struct matrox_switch matrox_mystique;
-#endif
-#ifdef CONFIG_FB_MATROX_G
 extern struct matrox_switch matrox_G100;
-#endif
-#ifdef NEED_DAC1064
 void DAC1064_global_init(struct matrox_fb_info *minfo);
 void DAC1064_global_restore(struct matrox_fb_info *minfo);
-#endif
 
 #define M1064_INDEX	0x00
 #define M1064_PALWRADD	0x00
diff --git a/drivers/staging/mgakms/matroxfb_Ti3026.c b/drivers/staging/mgakms/matroxfb_Ti3026.c
index 9ff9be85759e..e82e2a3cf76a 100644
--- a/drivers/staging/mgakms/matroxfb_Ti3026.c
+++ b/drivers/staging/mgakms/matroxfb_Ti3026.c
@@ -84,7 +84,6 @@
 #include "matroxfb_accel.h"
 #include <linux/matroxfb.h>
 
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 #define outTi3026 matroxfb_DAC_out
 #define inTi3026 matroxfb_DAC_in
 
@@ -744,5 +743,4 @@ struct matrox_switch matrox_millennium = {
 	.restore	= Ti3026_restore
 };
 EXPORT_SYMBOL(matrox_millennium);
-#endif
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/mgakms/matroxfb_Ti3026.h b/drivers/staging/mgakms/matroxfb_Ti3026.h
index faee149d0ba0..2fda3b30b9e7 100644
--- a/drivers/staging/mgakms/matroxfb_Ti3026.h
+++ b/drivers/staging/mgakms/matroxfb_Ti3026.h
@@ -5,8 +5,6 @@
 
 #include "matroxfb_base.h"
 
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 extern struct matrox_switch matrox_millennium;
-#endif
 
 #endif	/* __MATROXFB_TI3026_H__ */
diff --git a/drivers/staging/mgakms/matroxfb_base.c b/drivers/staging/mgakms/matroxfb_base.c
index d11b5e6210ed..7ee0ea046a5f 100644
--- a/drivers/staging/mgakms/matroxfb_base.c
+++ b/drivers/staging/mgakms/matroxfb_base.c
@@ -114,6 +114,7 @@
 #include <linux/nvram.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include "mga_drv.h"
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
@@ -368,7 +369,7 @@ static void matroxfb_remove(struct matrox_fb_info *minfo, int dummy)
 		return;
 	}
 	matroxfb_unregister_device(minfo);
-	unregister_framebuffer(&minfo->fbcon);
+	mga_unregister_framebuffer(minfo->mdev);
 	matroxfb_g450_shutdown(minfo);
 	arch_phys_wc_del(minfo->wc_cookie);
 	iounmap(minfo->mmio.vbase.vaddr);
@@ -1319,9 +1320,7 @@ static int matroxfb_getmemory(struct matrox_fb_info *minfo,
 	mga_outb(M_EXTVGA_DATA, orig);
 
 	*realSize = offs - 0x100000;
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 	minfo->interleave = !(!isMillenium(minfo) || ((offs - 0x100000) & 0x3FFFFF));
-#endif
 	return 1;
 }
 
@@ -1331,7 +1330,6 @@ struct video_board {
 	int accelID;
 	struct matrox_switch* lowlevel;
 		 };
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 static struct video_board vbMillennium = {
 	.maxvram = 0x0800000,
 	.maxdisplayable = 0x0800000,
@@ -1352,16 +1350,12 @@ static struct video_board vbMillennium2A = {
 	.accelID = FB_ACCEL_MATROX_MGA2164W_AGP,
 	.lowlevel = &matrox_millennium
 };
-#endif	/* CONFIG_FB_MATROX_MILLENIUM */
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 static struct video_board vbMystique = {
 	.maxvram = 0x0800000,
 	.maxdisplayable = 0x0800000,
 	.accelID = FB_ACCEL_MATROX_MGA1064SG,
 	.lowlevel = &matrox_mystique
 };
-#endif	/* CONFIG_FB_MATROX_MYSTIQUE */
-#ifdef CONFIG_FB_MATROX_G
 static struct video_board vbG100 = {
 	.maxvram = 0x0800000,
 	.maxdisplayable = 0x0800000,
@@ -1383,7 +1377,6 @@ static struct video_board vbG400 = {
 	.accelID = FB_ACCEL_MATROX_MGAG400,
 	.lowlevel = &matrox_G100
 };
-#endif
 
 #define DEVF_VIDEO64BIT		0x0001
 #define	DEVF_SWAPS		0x0002
@@ -1418,7 +1411,6 @@ static struct board {
 	struct video_board* base;
 	const char* name;
 		} dev_list[] = {
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,	0xFF,
 		0,			0,
 		DEVF_TEXT4B,
@@ -1440,8 +1432,6 @@ static struct board {
 		MGA_2164,
 		&vbMillennium2A,
 		"Millennium II (AGP)"},
-#endif
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,	0x02,
 		0,			0,
 		DEVF_VIDEO64BIT | DEVF_CROSS4MB,
@@ -1470,8 +1460,6 @@ static struct board {
 		MGA_1164,
 		&vbMystique,
 		"Mystique 220 (AGP)"},
-#endif
-#ifdef CONFIG_FB_MATROX_G
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,	0xFF,
 		0,			0,
 		DEVF_G100,
@@ -1563,7 +1551,6 @@ static struct board {
 		MGA_G550,
 		&vbG400,
 		"G550"},
-#endif
 	{0,			0,				0xFF,
 		0,			0,
 		0,
@@ -1622,6 +1609,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 	unsigned long video_base_phys = 0;
 	unsigned int memsize;
 	int err;
+	struct mga_device *mdev;
 
 	static const struct pci_device_id intel_82437[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
@@ -1918,9 +1906,12 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
  * and we do not want currcon = 0 for subsequent framebuffers */
 
 	minfo->fbcon.device = &minfo->pcidev->dev;
-	if (register_framebuffer(&minfo->fbcon) < 0) {
+	mdev = mga_register_framebuffer(&minfo->fbcon, minfo->pcidev);
+	if (IS_ERR(mdev)) {
+		err = PTR_ERR(mdev);
 		goto failVideoIO;
 	}
+	minfo->mdev = mdev;
 	fb_info(&minfo->fbcon, "%s frame buffer device\n", minfo->fbcon.fix.id);
 
 	/* there is no console on this fb... but we have to initialize hardware
@@ -2116,19 +2107,14 @@ static void pci_remove_matrox(struct pci_dev* pdev) {
 }
 
 static const struct pci_device_id matroxfb_devices[] = {
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2_AGP,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-#endif
-#ifdef CONFIG_FB_MATROX_MYSTIQUE
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-#endif
-#ifdef CONFIG_FB_MATROX_G
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_AGP,
@@ -2141,7 +2127,6 @@ static const struct pci_device_id matroxfb_devices[] = {
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G550,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-#endif
 	{0,			0,
 		0,		0,		0, 0, 0}
 };
diff --git a/drivers/staging/mgakms/matroxfb_base.h b/drivers/staging/mgakms/matroxfb_base.h
index f85ad25659e5..f7548549b3a6 100644
--- a/drivers/staging/mgakms/matroxfb_base.h
+++ b/drivers/staging/mgakms/matroxfb_base.h
@@ -115,11 +115,7 @@
 
 #define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
 
-/* G-series and Mystique have (almost) same DAC */
-#undef NEED_DAC1064
-#if defined(CONFIG_FB_MATROX_MYSTIQUE) || defined(CONFIG_FB_MATROX_G)
-#define NEED_DAC1064 1
-#endif
+struct mga_device;
 
 typedef struct {
 	void __iomem*	vaddr;
@@ -282,9 +278,7 @@ struct matrox_hw_state {
 };
 
 struct matrox_accel_data {
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 	unsigned char	ramdac_rev;
-#endif
 	u_int32_t	m_dwg_rect;
 	u_int32_t	m_opmode;
 	u_int32_t	m_access;
@@ -302,9 +296,9 @@ struct matrox_altout {
 	int		(*verifymode)(void* altout_dev, u_int32_t mode);
 	int		(*getqueryctrl)(void* altout_dev,
 					struct v4l2_queryctrl* ctrl);
-	int		(*getctrl)(void* altout_dev, 
+	int		(*getctrl)(void* altout_dev,
 				   struct v4l2_control* ctrl);
-	int		(*setctrl)(void* altout_dev, 
+	int		(*setctrl)(void* altout_dev,
 				   struct v4l2_control* ctrl);
 };
 
@@ -338,6 +332,8 @@ struct matrox_vsync {
 struct matrox_fb_info {
 	struct fb_info		fbcon;
 
+	struct mga_device	*mdev;
+
 	struct list_head	next_fb;
 
 	int			dead;
@@ -676,15 +672,9 @@ void matroxfb_unregister_driver(struct matroxfb_driver* drv);
 #define WaitTillIdle()	do { mga_inl(M_STATUS); do {} while (mga_inl(M_STATUS) & 0x10000); } while (0)
 
 /* code speedup */
-#ifdef CONFIG_FB_MATROX_MILLENIUM
 #define isInterleave(x)	 (x->interleave)
 #define isMillenium(x)	 (x->millenium)
 #define isMilleniumII(x) (x->milleniumII)
-#else
-#define isInterleave(x)  (0)
-#define isMillenium(x)	 (0)
-#define isMilleniumII(x) (0)
-#endif
 
 #define matroxfb_DAC_lock()                   spin_lock(&minfo->lock.DAC)
 #define matroxfb_DAC_unlock()                 spin_unlock(&minfo->lock.DAC)
diff --git a/drivers/staging/mgakms/matroxfb_g450.h b/drivers/staging/mgakms/matroxfb_g450.h
index b5f17b86eae5..2cec778a2a81 100644
--- a/drivers/staging/mgakms/matroxfb_g450.h
+++ b/drivers/staging/mgakms/matroxfb_g450.h
@@ -4,12 +4,7 @@
 
 #include "matroxfb_base.h"
 
-#ifdef CONFIG_FB_MATROX_G
 void matroxfb_g450_connect(struct matrox_fb_info *minfo);
 void matroxfb_g450_shutdown(struct matrox_fb_info *minfo);
-#else
-static inline void matroxfb_g450_connect(struct matrox_fb_info *minfo) { };
-static inline void matroxfb_g450_shutdown(struct matrox_fb_info *minfo) { };
-#endif
 
 #endif /* __MATROXFB_G450_H__ */
-- 
2.23.0
