From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: URGENT: status of atyfb
Date: Fri, 6 Aug 2004 08:09:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408060809.37494.alex.kern@gmx.de>
References: <1091417497.7393.63.camel@gaston> <200408032257.51111.alex.kern@gmx.de> <1091568340.1900.14.camel@gaston>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hCyEBE65fg/efcr"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bsxva-0002zG-9n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Aug 2004 23:10:06 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BsxvY-0002KF-Kz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Aug 2004 23:10:06 -0700
In-Reply-To: <1091568340.1900.14.camel@gaston>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ville =?utf-8?q?Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>


--Boundary-00=_hCyEBE65fg/efcr
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 3. August 2004 23:25 schrieb Benjamin Herrenschmidt:
> > Hi, I do not have any information or hardware about PPC. Should it own
> > something like OpenFirmware? In this case it is possible to read clock
> > information from this.
>
> On some models, yes, on some no. Older machines have a firmware that
> won't tell you anything, the MacOS driver back then was hard coding the
> values.
>
> Anyway, the clocks are ok, apparently (maybe not the engine one though,
> see later), the problem was that the DLL magic was reverted for the
> LT-G, plus some minor issues with the driver blowing up on non-BIOS
> machines that I can fix.
>
> The engine tends to lockup quickly though, I'll do experiments.
>
> > I found, that we change a little behaviour. Please give a try for this
> > patch...
>
> Your patch seem to address the DLL issue, I did that too, fixes the
> display, I'll toy around and let you know.
>
> Also, when just dropping the existing driver into the current linus tree,
> the cursor code is blowing up, I don't know why yet, I suppose some changes
> to the common code in the fbdev tree. I'll have a look.
>
> I really want this new driver to be sent upstream ASAP. What I may do is
> once I get it working well enough, I'll send it to andrew for the -mm tree
> and leave it there for a while to get it properly tested.
>
> Ben.
Hi, here a snapshot from my tree over 2.6.7 + js3

Changes:

revert SDRAM_MAGIC_PLL to old behaviour
do a "from BIOS" initialisation only by __i386__

Regards
Alex

--Boundary-00=_hCyEBE65fg/efcr
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="mach64-js3-ak6a.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="mach64-js3-ak6a.diff"

diff -ur -X patches/exclude linux-2.6.7.js3/drivers/video/aty/atyfb.h linux=
=2D2.6.7.ak/drivers/video/aty/atyfb.h
=2D-- linux-2.6.7.js3/drivers/video/aty/atyfb.h	2004-06-27 01:35:27.0000000=
00 +0200
+++ linux-2.6.7.ak/drivers/video/aty/atyfb.h	2004-08-04 22:25:21.000000000 =
+0200
@@ -3,6 +3,8 @@
  */
=20
 #include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
     /*
      *  Elements of the hardware specific atyfb_par structure
      */
@@ -30,9 +32,18 @@
 	u32 shadow_h_sync_strt_wid;
 	u32 shadow_v_tot_disp;
 	u32 shadow_v_sync_strt_wid;
+	u32 lcd_gen_cntl;
+	u32 lcd_config_panel;
+	u32 lcd_index;
 #endif
 };
=20
+struct aty_interrupt {
+	wait_queue_head_t wait;
+	unsigned int count;
+	int pan_display;
+};
+
 struct pll_info {
 	int pll_max;
 	int pll_min;
@@ -116,6 +127,7 @@
=20
 struct atyfb_par {
 	struct aty_cmap_regs *aty_cmap_regs;
+	struct { u8 red, green, blue; } palette[256];
 	const struct aty_dac_ops *dac_ops;
 	const struct aty_pll_ops *pll_ops;
 	unsigned long ati_regbase;
@@ -141,8 +153,8 @@
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
=2D	int open;
 #endif
+	int open;
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	unsigned long bios_base_phys;
 	unsigned long bios_base;
@@ -165,6 +177,10 @@
 #endif
 	unsigned long aux_start; /* auxiliary aperture */
 	unsigned long aux_size;
+	struct aty_interrupt vblank;
+	unsigned long irq_flags;
+	unsigned int irq;
+	spinlock_t int_lock;
 };
=20
     /*
@@ -177,7 +193,7 @@
 #define M64F_MAGIC_FIFO		0x00000002
 #define M64F_GTB_DSP		0x00000004
 #define M64F_FIFO_32		0x00000008
=2D#define M64F_NO_EXT_PLL		0x00000010
+#define M64F_SDRAM_MAGIC_PLL	0x00000010
 #define M64F_MAGIC_POSTDIV	0x00000020
 #define M64F_INTEGRATED		0x00000040
 #define M64F_CT_BUS		0x00000080
@@ -191,7 +207,7 @@
 #define M64F_G3_PB_1_1		0x00008000
 #define M64F_G3_PB_1024x768	0x00010000
 #define M64F_EXTRA_BRIGHT	0x00020000
=2D#define M64F_LT_SLEEP		0x00040000
+#define M64F_LT_LCD_REGS	0x00040000
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
 #define M64F_HW_TRIPLE		0x00200000
@@ -251,6 +267,11 @@
 #endif
 }
=20
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFI=
G_FB_ATY_GENERIC_LCD)
+extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
+extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
+#endif
+
     /*
      *  DAC operations
      */
@@ -275,6 +296,7 @@
 	int (*var_to_pll) (const struct fb_info * info, u32 vclk_per, u32 bpp, un=
ion aty_pll * pll);
 	u32 (*pll_to_var) (const struct fb_info * info, const union aty_pll * pll=
);
 	void (*set_pll)   (const struct fb_info * info, const union aty_pll * pll=
);
+	void (*get_pll)   (const struct fb_info *info, union aty_pll * pll);
 	int (*init_pll)   (const struct fb_info * info, union aty_pll * pll);
 };
=20
diff -ur -X patches/exclude linux-2.6.7.js3/drivers/video/aty/atyfb_base.c =
linux-2.6.7.ak/drivers/video/aty/atyfb_base.c
=2D-- linux-2.6.7.js3/drivers/video/aty/atyfb_base.c	2004-06-27 01:35:27.00=
0000000 +0200
+++ linux-2.6.7.ak/drivers/video/aty/atyfb_base.c	2004-08-04 22:57:50.00000=
0000 +0200
@@ -26,6 +26,7 @@
  *			   Anthony Tong <atong@uiuc.edu>
  *
  *  Generic LCD support written by Daniel Mantione, ported from 2.4.20 by =
Alex Kern
+ *  Many Thanks to Ville Syrj=E4l=E4 for patches and fixing nasting 16 bit=
 color bug.
  *
  *  This file is subject to the terms and conditions of the GNU General Pu=
blic
  *  License. See the file COPYING in the main directory of this archive for
@@ -41,15 +42,16 @@
     - cursor support on all cards and all ramdacs.
     - cursor parameters controlable via ioctl()s.
     - guess PLL and MCLK based on the original PLL register values initial=
ized
=2D      by the BIOS or Open Firmware (if they are initialized).
+      by Open Firmware (if they are initialized). BIOS is done
=20
=2D    (Anyone to help with this?)
+    (Anyone with Mac to help with this?)
=20
 **************************************************************************=
****/
=20
=20
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -61,6 +63,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -101,33 +106,63 @@
 #define GUI_RESERVE	(1 * PAGE_SIZE)
=20
 /* FIXME: remove the FAIL definition */
=2D#define FAIL(msg) do { printk(KERN_CRIT msg "\n"); return -EINVAL; } whi=
le (0)
=2D#define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT ms=
g " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
+#define FAIL(msg) do { printk(KERN_CRIT "atyfb: " msg "\n"); return -EINVA=
L; } while (0)
+#define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT "aty=
fb: " msg " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "atyfb: " fmt, ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
+#define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
=20
 #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFI=
G_FB_ATY_GENERIC_LCD)
=2Dstatic void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
+static const u32 lt_lcd_regs[] =3D {
+	CONFIG_PANEL_LG,
+	LCD_GEN_CNTL_LG,
+	DSTN_CONTROL_LG,
+	HFB_PITCH_ADDR_LG,
+	HORZ_STRETCHING_LG,
+	VERT_STRETCHING_LG,
+	0, /* EXT_VERT_STRETCH */
+	LT_GIO_LG,
+	POWER_MANAGEMENT_LG
+};
+
+void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 {
=2D	unsigned long temp;
+	if (M64_HAS(LT_LCD_REGS)) {
+		aty_st_le32(lt_lcd_regs[index], val, par);
+	} else {
+		unsigned long temp;
=20
=2D	/* write addr byte */
=2D	temp =3D aty_ld_le32(LCD_INDEX, par);
=2D	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
=2D	/* write the register value */
=2D	aty_st_le32(LCD_DATA, val, par);
+		/* write addr byte */
+		temp =3D aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* write the register value */
+		aty_st_le32(LCD_DATA, val, par);
+	}
 }
=20
=2Dstatic u32 aty_ld_lcd(int index, const struct atyfb_par *par)
+u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 {
=2D	unsigned long temp;
+	if (M64_HAS(LT_LCD_REGS)) {
+		return aty_ld_le32(lt_lcd_regs[index], par);
+	} else {
+		unsigned long temp;
=20
=2D	/* write addr byte */
=2D	temp =3D aty_ld_le32(LCD_INDEX, par);
=2D	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
=2D	/* read the register value */
=2D	return aty_ld_le32(LCD_DATA, par);
+		/* write addr byte */
+		temp =3D aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* read the register value */
+		return aty_ld_le32(LCD_DATA, par);
+	}
 }
 #endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined =
(CONFIG_FB_ATY_GENERIC_LCD) */
=20
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*
  * ATIReduceRatio --
  *
@@ -150,7 +185,7 @@
     *Numerator /=3D Divider;
     *Denominator /=3D Divider;
 }
=2D
+#endif
     /*
      *  The Hardware parameters for each card
      */
@@ -209,11 +244,11 @@
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
=2D#if 0
+
 static struct crtc saved_crtc;
 static union aty_pll saved_pll;
 static void aty_get_crtc(const struct atyfb_par *par, struct crtc *crtc);
=2D#endif
+
 static void aty_set_crtc(const struct atyfb_par *par, const struct crtc *c=
rtc);
 static int aty_var_to_crtc(const struct fb_info *info, const struct fb_var=
_screeninfo *var, struct crtc *crtc);
 static int aty_crtc_to_var(const struct crtc *crtc, struct fb_var_screenin=
fo *var);
@@ -254,22 +289,19 @@
 	.fb_fillrect	=3D atyfb_fillrect,
 	.fb_copyarea	=3D atyfb_copyarea,
 	.fb_imageblit	=3D atyfb_imageblit,
=2D	.fb_cursor	=3D atyfb_cursor,
+	.fb_cursor	=3D soft_cursor,
 #ifdef __sparc__
 	.fb_mmap	=3D atyfb_mmap,
 #endif
 	.fb_sync	=3D atyfb_sync,
 };
=20
=2Dstatic char noaccel __initdata =3D 0;
=2Dstatic u32 default_vram __initdata =3D 0;
=2Dstatic int default_pll __initdata =3D 0;
=2Dstatic int default_mclk __initdata =3D 0;
=2Dstatic int default_xclk __initdata =3D 0;
=2D
=2D#ifndef MODULE
=2Dstatic char *mode_option __initdata =3D NULL;
=2D#endif
+static int noaccel;
+static int vram;
+static int pll;
+static int mclk;
+static int xclk;
+static char *mode;
=20
 #ifdef CONFIG_PPC
 static int default_vmode __initdata =3D VMODE_CHOOSE;
@@ -294,20 +326,20 @@
 #define ATI_CHIP_264GT     (M64F_GT | M64F_INTEGRATED               | M64F=
_MAGIC_FIFO | M64F_EXTRA_BRIGHT)
=20
 #define ATI_CHIP_264VTB    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F=
_GTB_DSP)
=2D#define ATI_CHIP_264VT3    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M6=
4F_GTB_DSP)
=2D#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M6=
4F_GTB_DSP | M64F_NO_EXT_PLL)
+#define ATI_CHIP_264VT3    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F=
_GTB_DSP | M64F_SDRAM_MAGIC_PLL)
+#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F=
_GTB_DSP)
=20
=2D#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M6=
4F_GTB_DSP | M64F_NO_EXT_PLL)
+#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F=
_GTB_DSP)
=20
 /* make sets shorter */
=2D#define ATI_MODERN_SET     (M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M=
64F_EXTRA_BRIGHT | M64F_NO_EXT_PLL)
+#define ATI_MODERN_SET     (M64F_GT | M64F_INTEGRATED               | M64F=
_GTB_DSP | M64F_EXTRA_BRIGHT)
=20
=2D#define ATI_CHIP_264GTB    (ATI_MODERN_SET)=20
+#define ATI_CHIP_264GTB    (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL)=20
 /*#define ATI_CHIP_264GTDVD  ?*/
=2D#define ATI_CHIP_264LTG    (ATI_MODERN_SET)
+#define ATI_CHIP_264LTG    (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL)
=20
=2D#define ATI_CHIP_264GT2C   (ATI_MODERN_SET | M64F_HW_TRIPLE)
=2D#define ATI_CHIP_264GTPRO  (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_=
32 | M64F_RESET_3D)
+#define ATI_CHIP_264GT2C   (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL | M64F_H=
W_TRIPLE)
+#define ATI_CHIP_264GTPRO  (ATI_MODERN_SET | M64F_SDRAM_MAGIC_PLL | M64F_H=
W_TRIPLE | M64F_FIFO_32 | M64F_RESET_3D)
 #define ATI_CHIP_264LTPRO  (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32=
 | M64F_RESET_3D)
=20
 #define ATI_CHIP_264XL     (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32=
 | M64F_RESET_3D | M64F_XL_DLL | M64F_MFB_FORCE_4)
@@ -336,7 +368,7 @@
=20
 	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, ATI_CHIP_264L=
T },
 	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
=2D	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_=
264LTG | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, ATI_CHIP_26=
4LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
=20
 	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, ATI_CHIP_264VT=
4 },
=20
@@ -365,19 +397,20 @@
 	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP=
_264XL },
=20
 	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83,=
 125, ATI_CHIP_MOBILITY },
=2D	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility (Mach64 LN, AGP 2x)", 230, 83, 1=
25, ATI_CHIP_MOBILITY },
=2D	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility (Mach64 LR, PCI)", 230, 83, 125,=
 ATI_CHIP_MOBILITY },
=2D	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility (Mach64 LS, PCI)", 230, 83, 125,=
 ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 1=
25, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 12=
5, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125,=
 ATI_CHIP_MOBILITY },
 #endif /* CONFIG_FB_ATY_CT */
 };
=20
+/* can not fail */
 static int __devinit correct_chipset(struct atyfb_par *par)
 {
=2D	const char *name;
=2D	int i, err =3D 0;
=2D	u32 chip_id;
=2D	u16 type;
 	u8 rev;
+	u16 type;
+	u32 chip_id;
+	const char *name;
+	int i;
=20
 	for (i =3D sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >=3D 0; i--)
 		if (par->pci_id =3D=3D aty_chips[i].pci_id)
@@ -396,12 +429,12 @@
 	switch(par->pci_id) {
 #ifdef CONFIG_FB_ATY_GX
 	case PCI_CHIP_MACH64GX:
=2D		if (type !=3D 0x00d7)
=2D			err =3D -ENXIO;=09
+		if(type !=3D 0x00d7);
+			return -ENODEV;
 		break;
 	case PCI_CHIP_MACH64CX:
=2D		if (type =3D=3D 0x0057)
=2D			err =3D -ENXIO;
+		if(type !=3D 0x0057);
+			return -ENODEV;
 		break;
 #endif
 #ifdef CONFIG_FB_ATY_CT
@@ -443,11 +476,9 @@
 		break;
 #endif
 	}
=2D	if (!err)
=2D		printk("atyfb: %s [0x%04x rev 0x%02x]\n", name, type, rev);
=2D	else
=2D		printk(KERN_INFO "atyfb: Unknown mach64 0x%04x rev 0x%04x\n", type, re=
v);=09
=2D	return err;		=09
+
+	PRINTKI("%s [0x%04x rev 0x%02x]\n", name, type, rev);
+	return 0;
 }
=20
 static char ram_dram[] __initdata =3D "DRAM";
@@ -457,9 +488,9 @@
 #endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
 static char ram_edo[] __initdata =3D "EDO";
=2Dstatic char ram_sdram[] __initdata =3D "SDRAM";
=2Dstatic char ram_sgram[] __initdata =3D "SGRAM";
=2Dstatic char ram_wram[] __initdata =3D "WRAM";
+static char ram_sdram[] __initdata =3D "SDRAM (1:1)";
+static char ram_sgram[] __initdata =3D "SGRAM (1:1)";
+static char ram_sdram32[] __initdata =3D "SDRAM (2:1) (32-bit)";
 static char ram_off[] __initdata =3D "OFF";
 #endif /* CONFIG_FB_ATY_CT */
=20
@@ -476,7 +507,7 @@
 #ifdef CONFIG_FB_ATY_CT
 static char *aty_ct_ram[8] __initdata =3D {
 	ram_off, ram_dram, ram_edo, ram_edo,
=2D	ram_sdram, ram_sgram, ram_wram, ram_resv
+	ram_sdram, ram_sgram, ram_sdram32, ram_resv
 };
 #endif /* CONFIG_FB_ATY_CT */
=20
@@ -543,9 +574,30 @@
 /*
  *  CRTC programming
  */
=2D#if 0
+
 static void aty_get_crtc(const struct atyfb_par *par, struct crtc *crtc)
 {
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	if (par->lcd_table !=3D 0) {
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    crtc->lcd_index =3D aty_ld_le32(LCD_INDEX, par);
+		    aty_st_le32(LCD_INDEX, crtc->lcd_index, par);
+		}
+		crtc->lcd_config_panel =3D aty_ld_lcd(CONFIG_PANEL, par);
+		crtc->lcd_gen_cntl =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+	=09
+
+		/* switch to non shadow registers */
+		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl &
+                    ~(CRTC_RW_SELECT | SHADOW_EN | SHADOW_RW_EN), par);
+
+		/* save stretching */
+		crtc->horz_stretching =3D aty_ld_lcd(HORZ_STRETCHING, par);
+		crtc->vert_stretching =3D aty_ld_lcd(VERT_STRETCHING, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par);
+	}
+#endif
 	crtc->h_tot_disp =3D aty_ld_le32(CRTC_H_TOTAL_DISP, par);
 	crtc->h_sync_strt_wid =3D aty_ld_le32(CRTC_H_SYNC_STRT_WID, par);
 	crtc->v_tot_disp =3D aty_ld_le32(CRTC_V_TOTAL_DISP, par);
@@ -555,51 +607,34 @@
 	crtc->gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par);
=20
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D
 	if (par->lcd_table !=3D 0) {
 		/* switch to shadow registers */
=2D		u32 temp =3D aty_ld_lcd(LCD_GEN_CNTL, par);
=2D		aty_st_lcd(LCD_GEN_CNTL, temp | SHADOW_EN | SHADOW_RW_EN, par);
+		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
+			SHADOW_EN | SHADOW_RW_EN, par);
=20
=2D		/* get shadow registers */
 		crtc->shadow_h_tot_disp =3D aty_ld_le32(CRTC_H_TOTAL_DISP, par);
 		crtc->shadow_h_sync_strt_wid =3D aty_ld_le32(CRTC_H_SYNC_STRT_WID, par);
 		crtc->shadow_v_tot_disp =3D aty_ld_le32(CRTC_V_TOTAL_DISP, par);
 		crtc->shadow_v_sync_strt_wid =3D aty_ld_le32(CRTC_V_SYNC_STRT_WID, par);
=20
=2D		aty_st_le32(LCD_GEN_CNTL, temp & ~(SHADOW_EN | SHADOW_RW_EN), par);
=2D
=2D		/* get stretching */
=2D		crtc->horz_stretching =3D aty_ld_lcd(HORZ_STRETCHING, par);
=2D		crtc->vert_stretching =3D aty_ld_lcd(VERT_STRETCHING, par);
=2D		crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par);
+		aty_st_le32(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);
 	}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
=2D#endif
+
 static void aty_set_crtc(const struct atyfb_par *par, const struct crtc *c=
rtc)
 {
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D	u32 temp;
=2D
=2D	/* Load LCD registers */
 	if (par->lcd_table !=3D 0) {
=2D		// Set the CRTC to primary, and make the registers writeable
=2D		temp =3D aty_ld_lcd(LCD_GEN_CNTL, par);
=2D		temp &=3D LCD_SET_PRIMARY_MASK;
=2D		temp |=3D DONT_SHADOW_VPAR;
=2D		aty_st_lcd(LCD_GEN_CNTL, temp, par);
=2D#if 0
=2D		/* Stop CRTC */
=2D		aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl &
=2D			~(CRTC_EXT_DISP_EN | CRTC_EN), par);
+		/* stop CRTC */
+		aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl & ~(CRTC_EXT_DISP_EN | CRTC_EN=
), par);
=20
=2D		/* Update non-shadow registers first */
=2D		/*aty_st_lcd(LCD_CONFIG_PANEL, pATIHW->config_panel);*/
+		/* update non-shadow registers first */
+		aty_st_lcd(CONFIG_PANEL, crtc->lcd_config_panel, par);
 		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl &
 			~(CRTC_RW_SELECT | SHADOW_EN | SHADOW_RW_EN), par);
=2D#endif
=2D		/* Temporarily disable stretching */
+
+		/* temporarily disable stretching */
 		aty_st_lcd(HORZ_STRETCHING,
 			crtc->horz_stretching &
 			~(HORZ_STRETCH_MODE | HORZ_STRETCH_EN), par);
@@ -609,55 +644,72 @@
 			VERT_STRETCH_USE0 | VERT_STRETCH_EN), par);
 	}
 #endif
+	/* turn off CRT */
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl & ~CRTC_EN, par);
+
+	DPRINTK("setting up CRTC\n");
+	PRINTKI("set primary CRT to %ix%i %c%c composite %c\n",
+	    ((((crtc->h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->v_tot_disp>>16) =
& 0x7ff) + 1),
+	    (crtc->h_sync_strt_wid & 0x200000)?'N':'P', (crtc->v_sync_strt_wid & =
0x200000)?'N':'P',
+	    (crtc->gen_cntl & CRTC_CSYNC_EN)?'P':'N');
+
+	DPRINTK("CRTC_H_TOTAL_DISP: %x\n",crtc->h_tot_disp);
+	DPRINTK("CRTC_H_SYNC_STRT_WID: %x\n",crtc->h_sync_strt_wid);
+	DPRINTK("CRTC_V_TOTAL_DISP: %x\n",crtc->v_tot_disp);
+	DPRINTK("CRTC_V_SYNC_STRT_WID: %x\n",crtc->v_sync_strt_wid);
+	DPRINTK("CRTC_OFF_PITCH: %x\n", crtc->off_pitch);
+	DPRINTK("CRTC_VLINE_CRNT_VLINE: %x\n", crtc->vline_crnt_vline);
+	DPRINTK("CRTC_GEN_CNTL: %x\n",crtc->gen_cntl);
+
 	aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, par);
 	aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, par);
 	aty_st_le32(CRTC_V_TOTAL_DISP, crtc->v_tot_disp, par);
 	aty_st_le32(CRTC_V_SYNC_STRT_WID, crtc->v_sync_strt_wid, par);
=2D	aty_st_le32(CRTC_VLINE_CRNT_VLINE, crtc->vline_crnt_vline, par);
 	aty_st_le32(CRTC_OFF_PITCH, crtc->off_pitch, par);
+	aty_st_le32(CRTC_VLINE_CRNT_VLINE, crtc->vline_crnt_vline, par);
+
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl, par);
=2D#ifdef DEBUG
=2D	printk(KERN_INFO "setting up CRTC\n");
=2D	printk(KERN_INFO "CRTC_GEN_CNTL: %x\n",crtc->gen_cntl);
=2D	printk(KERN_INFO "CRTC_H_TOTAL_DISP: %x\n",crtc->h_tot_disp);
=2D	printk(KERN_INFO "CRTC_H_SYNC_STRT_WID: %x\n",crtc->h_sync_strt_wid);
=2D	printk(KERN_INFO "CRTC_V_TOTAL_DISP: %x\n",crtc->v_tot_disp);
=2D	printk(KERN_INFO "CRTC_V_SYNC_STRT_WID: %x\n",crtc->v_sync_strt_wid);
+#if 0
+	FIXME
+	if (par->accel_flags & FB_ACCELF_TEXT)
+		aty_init_engine(par, info);
 #endif
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D	/* After setting the CRTC registers we should set the LCD
=2D	 * registers.
=2D	 */
+	/* after setting the CRTC registers we should set the LCD registers. */
 	if (par->lcd_table !=3D 0) {
 		/* switch to shadow registers */
=2D		temp =3D aty_ld_lcd(LCD_GEN_CNTL, par);
=2D		aty_st_lcd(LCD_GEN_CNTL, temp | SHADOW_EN | SHADOW_RW_EN, par);
+		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
+			(SHADOW_EN | SHADOW_RW_EN), par);
+
+		PRINTKI("set secondary CRT to %ix%i %c%c\n",
+		    ((((crtc->shadow_h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->shadow_v=
_tot_disp>>16) & 0x7ff) + 1),
+		    (crtc->shadow_h_sync_strt_wid & 0x200000)?'N':'P', (crtc->shadow_v_s=
ync_strt_wid & 0x200000)?'N':'P');=20
+
+		DPRINTK("SHADOW CRTC_H_TOTAL_DISP: %x\n", crtc->shadow_h_tot_disp);
+		DPRINTK("SHADOW CRTC_H_SYNC_STRT_WID: %x\n", crtc->shadow_h_sync_strt_wi=
d);
+		DPRINTK("SHADOW CRTC_V_TOTAL_DISP: %x\n", crtc->shadow_v_tot_disp);
+		DPRINTK("SHADOW CRTC_V_SYNC_STRT_WID: %x\n", crtc->shadow_v_sync_strt_wi=
d);
=20
=2D		/* set shadow registers */
 		aty_st_le32(CRTC_H_TOTAL_DISP, crtc->shadow_h_tot_disp, par);
 		aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->shadow_h_sync_strt_wid, par);
 		aty_st_le32(CRTC_V_TOTAL_DISP, crtc->shadow_v_tot_disp, par);
 		aty_st_le32(CRTC_V_SYNC_STRT_WID, crtc->shadow_v_sync_strt_wid, par);
=20
=2D		aty_st_lcd(LCD_GEN_CNTL, temp & ~(SHADOW_EN | SHADOW_RW_EN), par);
+		/* restore CRTC selection & shadow state and enable stretching */
+		DPRINTK("LCD_GEN_CNTL: %x\n", crtc->lcd_gen_cntl);
+		DPRINTK("HORZ_STRETCHING: %x\n", crtc->horz_stretching);
+		DPRINTK("VERT_STRETCHING: %x\n", crtc->vert_stretching);
+		if(!M64_HAS(LT_LCD_REGS))
+		    DPRINTK("EXT_VERT_STRETCH: %x\n", crtc->ext_vert_stretch);
=20
=2D#ifdef DEBUG
=2D		printk(KERN_INFO "LCD_GEN_CNTL: %x\n", temp);
=2D		printk(KERN_INFO "HORZ_STRETCHING: %x\n", crtc->horz_stretching);
=2D		printk(KERN_INFO "VERT_STRETCHING: %x\n", crtc->vert_stretching);
=2D		printk(KERN_INFO "EXT_VERT_STRETCH: %x\n", crtc->ext_vert_stretch);
=2D#endif
=2D		/* Restore CRTC selection & shadow state */
=2D		/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
=2D
=2D		/* Enable/disable stretching */
+		aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);
 		aty_st_lcd(HORZ_STRETCHING, crtc->horz_stretching, par);
 		aty_st_lcd(VERT_STRETCHING, crtc->vert_stretching, par);
=2D		aty_st_lcd(EXT_VERT_STRETCH, crtc->ext_vert_stretch, par);
=2D		/*
=2D		outr(LCD_INDEX, pATIHW->lcd_index);
=2D		*/
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    aty_st_lcd(EXT_VERT_STRETCH, crtc->ext_vert_stretch, par);
+		    aty_ld_le32(LCD_INDEX, par);
+		    aty_st_le32(LCD_INDEX, crtc->lcd_index, par);
+		}
 	}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
@@ -667,14 +719,11 @@
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
=2D	u32 sync, vmode;
+	u32 sync, vmode, vdisplay;
 	u32 h_total, h_disp, h_sync_strt, h_sync_end, h_sync_dly, h_sync_wid, h_s=
ync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_end, v_sync_wid, v_sync_pol, c_s=
ync;
 	u32 pix_width, dp_pix_width, dp_chain_mask;
=2D#ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D	int VScan =3D 1;
=2D	u32 lcd_on_off =3D 0;
=2D#endif
+
 	/* input */
 	xres =3D var->xres;
 	yres =3D var->yres;
@@ -683,6 +732,8 @@
 	xoffset =3D var->xoffset;
 	yoffset =3D var->yoffset;
 	bpp =3D var->bits_per_pixel;
+	if (bpp =3D=3D 16)
+		bpp =3D (var->green.length =3D=3D 5) ? 15 : 16;
 	sync =3D var->sync;
 	vmode =3D var->vmode;
=20
@@ -702,12 +753,18 @@
 		    HOST_8BPP | SRC_8BPP | DST_8BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
 		dp_chain_mask =3D DP_CHAIN_8BPP;
=2D	} else if (bpp <=3D 16) {
+	} else if (bpp <=3D 15) {
 		bpp =3D 16;
 		pix_width =3D CRTC_PIX_WIDTH_15BPP;
 		dp_pix_width =3D HOST_15BPP | SRC_15BPP | DST_15BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
 		dp_chain_mask =3D DP_CHAIN_15BPP;
+	} else if (bpp <=3D 16) {
+		bpp =3D 16;
+		pix_width =3D CRTC_PIX_WIDTH_16BPP;
+		dp_pix_width =3D HOST_16BPP | SRC_16BPP | DST_16BPP |
+		    BYTE_ORDER_LSB_TO_MSB;
+		dp_chain_mask =3D DP_CHAIN_16BPP;
 	} else if (bpp <=3D 24 && M64_HAS(INTEGRATED)) {
 		bpp =3D 24;
 		pix_width =3D CRTC_PIX_WIDTH_24BPP;
@@ -730,30 +787,59 @@
 	h_sync_pol =3D sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
 	v_sync_pol =3D sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
=20
+	if((xres > 1600) || (yres > 1200)) {
+		FAIL("MACH64 chips are designed for max 1600x1200\n"
+		"select anoter resolution.");
+	}
+	h_sync_strt =3D h_disp + var->right_margin;
+	h_sync_end =3D h_sync_strt + var->hsync_len;
+	h_sync_dly  =3D var->right_margin & 7;
+	h_total =3D h_sync_end + h_sync_dly + var->left_margin;
+
+	v_sync_strt =3D v_disp + var->lower_margin;
+	v_sync_end =3D v_sync_strt + var->vsync_len;
+	v_total =3D v_sync_end + var->upper_margin;
+
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table !=3D 0) {
=2D		u32 lcd_index =3D aty_ld_le32(LCD_INDEX, par);
=2D		lcd_on_off =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+		if(!M64_HAS(LT_LCD_REGS)) {
+		    u32 lcd_index =3D aty_ld_le32(LCD_INDEX, par);
+		    crtc->lcd_index =3D lcd_index &
+			~(LCD_INDEX_MASK | LCD_DISPLAY_DIS | LCD_SRC_SEL | CRTC2_DISPLAY_DIS);
+		    aty_st_le32(LCD_INDEX, lcd_index, par);
+		}
+	=09
+		if (!M64_HAS(MOBIL_BUS))
+			crtc->lcd_index |=3D CRTC2_DISPLAY_DIS;
=20
=2D		if((lcd_on_off & LCD_ON) &&
+		crtc->lcd_config_panel =3D aty_ld_lcd(CONFIG_PANEL, par) | 0x4000;
+		crtc->lcd_gen_cntl =3D aty_ld_lcd(LCD_GEN_CNTL, par) & ~CRTC_RW_SELECT;
+
+		crtc->lcd_gen_cntl &=3D
+			~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 | TVCLK_PM_EN |
+			/*VCLK_DAC_PM_EN | USE_SHADOWED_VEND |*/
+			USE_SHADOWED_ROWCUR | SHADOW_EN | SHADOW_RW_EN);
+		crtc->lcd_gen_cntl |=3D DONT_SHADOW_VPAR | LOCK_8DOT;
+=09
+		if((crtc->lcd_gen_cntl & LCD_ON) &&
 			((xres > par->lcd_width) || (yres > par->lcd_height))) {
 			/* We cannot display the mode on the LCD. If the CRT is enabled
 			   we can turn off the LCD.
 			   If the CRT is off, it isn't a good idea to switch it on; we don't
 			   know if one is connected. So it's better to fail then.
 			 */
=2D			if (lcd_on_off & CRT_ON) {
=2D				printk(KERN_INFO "Disable lcd panel, because video mode does not fit=
=2E\n");
=2D				lcd_on_off &=3D ~LCD_ON;
=2D				aty_st_lcd(LCD_GEN_CNTL, lcd_on_off, par);
+			if (crtc->lcd_gen_cntl & CRT_ON) {
+				PRINTKI("Disable lcd panel, because video mode does not fit.\n");
+				crtc->lcd_gen_cntl &=3D ~LCD_ON;
+				/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
 			} else {
 				FAIL("Video mode exceeds size of lcd panel.\nConnect this computer to =
a conventional monitor if you really need this mode.");
 			}
 		}
=2D		aty_st_le32(LCD_INDEX, lcd_index, par);
 	}
=20
=2D	if ((par->lcd_table !=3D 0) && (lcd_on_off & LCD_ON)) {
+	if ((par->lcd_table !=3D 0) && (crtc->lcd_gen_cntl & LCD_ON)) {
+		int VScan =3D 1;
 		/* bpp -> bytespp, 1,4 -> 0; 8 -> 2; 15,16 -> 1; 24 -> 6; 32 -> 5
 		const u8 DFP_h_sync_dly_LT[] =3D { 0, 2, 1, 6, 5 };
 		const u8 ADD_to_strt_wid_and_dly_LT_DAC[] =3D { 0, 5, 6, 9, 9, 12, 12 };=
  */
@@ -784,24 +870,9 @@
 		v_sync_strt =3D v_disp + par->lcd_lower_margin / VScan;
 		v_sync_end =3D v_sync_strt + par->lcd_vsync_len / VScan;
 		v_total =3D v_disp + par->lcd_vblank_len / VScan;
=2D	} else {
+	}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
=2D		if((xres > 1600) || (yres > 1200)) {
=2D		    FAIL("MACH64 chips are designed for max 1600x1200\n"
=2D			"select anoter resolution.");
=2D		}
=2D		h_sync_strt =3D h_disp + var->right_margin;
=2D		h_sync_end =3D h_sync_strt + var->hsync_len;
=2D		h_sync_dly  =3D var->right_margin & 7;
=2D		h_total =3D h_sync_end + h_sync_dly + var->left_margin;
=2D
=2D		v_sync_strt =3D v_disp + var->lower_margin;
=2D		v_sync_end =3D v_sync_strt + var->vsync_len;
=2D		v_total =3D v_sync_end + var->upper_margin;
=20
=2D#ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D	}
=2D#endif
 	h_disp =3D (h_disp >> 3) - 1;
 	h_sync_strt =3D (h_sync_strt >> 3) - 1;
 	h_sync_end =3D (h_sync_end >> 3) - 1;
@@ -810,7 +881,9 @@
=20
 	FAIL_MAX("h_disp too large", h_disp, 0xff);
 	FAIL_MAX("h_sync_strt too large", h_sync_strt, 0x1ff);
=2D	FAIL_MAX("h_sync_wid too large", h_sync_wid, 0x1f);
+	/*FAIL_MAX("h_sync_wid too large", h_sync_wid, 0x1f);*/
+	if(h_sync_wid > 0x1f)
+		h_sync_wid =3D 0x1f;
 	FAIL_MAX("h_total too large", h_total, 0x1ff);
=20
 	if (vmode & FB_VMODE_DOUBLE) {
@@ -820,26 +893,24 @@
 		v_total <<=3D 1;
 	}
=20
=2D	if(1) {
=2D		int VDisplay =3D yres;
+	vdisplay =3D yres;
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D		if ((par->lcd_table !=3D 0) && (lcd_on_off & LCD_ON))
=2D			VDisplay  =3D par->lcd_height;
+	if ((par->lcd_table !=3D 0) && (crtc->lcd_gen_cntl & LCD_ON))
+		vdisplay  =3D par->lcd_height;
 #endif
=20
=2D		if(VDisplay < 400) {
=2D			h_sync_pol =3D 1;
=2D			v_sync_pol =3D 0;
=2D		} else if(VDisplay < 480) {
=2D			h_sync_pol =3D 0;
=2D			v_sync_pol =3D 1;
=2D		} else if(VDisplay < 768) {
=2D			h_sync_pol =3D 0;
=2D			v_sync_pol =3D 0;
=2D		} else {
=2D			h_sync_pol =3D 1;
=2D			v_sync_pol =3D 1;
=2D		}
+	if(vdisplay < 400) {
+		h_sync_pol =3D 1;
+		v_sync_pol =3D 0;
+	} else if(vdisplay < 480) {
+		h_sync_pol =3D 0;
+		v_sync_pol =3D 1;
+	} else if(vdisplay < 768) {
+		h_sync_pol =3D 0;
+		v_sync_pol =3D 0;
+	} else {
+		h_sync_pol =3D 1;
+		v_sync_pol =3D 1;
 	}
=20
 	v_disp--;
@@ -850,7 +921,9 @@
=20
 	FAIL_MAX("v_disp too large", v_disp, 0x7ff);
 	FAIL_MAX("v_sync_stsrt too large", v_sync_strt, 0x7ff);
=2D	FAIL_MAX("v_sync_wid too large", v_sync_wid, 0x1f);
+	/*FAIL_MAX("v_sync_wid too large", v_sync_wid, 0x1f);*/
+	if(v_sync_wid > 0x1f)
+		v_sync_wid =3D 0x1f;
 	FAIL_MAX("v_total too large", v_total, 0x7ff);
=20
 	c_sync =3D sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
@@ -881,12 +954,12 @@
 	if (vmode & FB_VMODE_INTERLACED)
 		crtc->gen_cntl |=3D CRTC_INTERLACE_EN;
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
=2D	if ((par->lcd_table !=3D 0) && (lcd_on_off & LCD_ON)) {
=2D		int VDisplay =3D yres;
+	if (par->lcd_table !=3D 0) {
+		vdisplay =3D yres;
 		if(vmode & FB_VMODE_DOUBLE)
=2D			VDisplay <<=3D 1;
+			vdisplay <<=3D 1;
 		if(vmode & FB_VMODE_INTERLACED) {
=2D			VDisplay >>=3D 1;
+			vdisplay >>=3D 1;
=20
 			/* The prefered mode for the lcd is not interlaced, so disable it if
 			   it was enabled. For doublescan there is no problem, because we can
@@ -896,14 +969,16 @@
 			/*crtc->gen_cntl &=3D ~CRTC_INTERLACE_EN;*/
 		}
 		crtc->gen_cntl &=3D ~(CRTC2_EN | CRTC2_PIX_WIDTH);
=2D/*
=2D		crtc->lcd_gen_cntl &=3D ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 | SCLK_S=
EL | USE_SHADOWED_VEND | SHADOW_EN);
=2D		crtc->lcd_gen_cntl |=3D (DONT_SHADOW_VPAR);
=2D*/
+		crtc->lcd_gen_cntl &=3D ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 |
+			/*TVCLK_PM_EN | VCLK_DAC_PM_EN |*/
+			USE_SHADOWED_VEND | USE_SHADOWED_ROWCUR | SHADOW_EN | SHADOW_RW_EN);
+		crtc->lcd_gen_cntl |=3D (DONT_SHADOW_VPAR/* | LOCK_8DOT*/);
+
 		/* MOBILITY M1 tested, FIXME: LT */
 		crtc->horz_stretching =3D aty_ld_lcd(HORZ_STRETCHING, par);
=2D		crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par) &
=2D			~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch =3D aty_ld_lcd(EXT_VERT_STRETCH, par) &
+				~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
=20
 		crtc->horz_stretching &=3D
 			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
@@ -970,11 +1045,12 @@
 			} while (0);
 		}
=20
=2D		if (VDisplay < par->lcd_height) {
+		if (vdisplay < par->lcd_height) {
 			crtc->vert_stretching =3D (VERT_STRETCH_USE0 | VERT_STRETCH_EN |
=2D				(((VDisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_S=
TRETCH_RATIO0));
+				(((vdisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_STR=
ETCH_RATIO0));
=20
=2D			if (xres <=3D (M64_HAS(MOBIL_BUS)?1024:800))
+			if (!M64_HAS(LT_LCD_REGS) &&
+			    xres <=3D (M64_HAS(MOBIL_BUS)?1024:800))
 				crtc->ext_vert_stretch |=3D VERT_STRETCH_MODE;
 		} else {
 			/*
@@ -983,13 +1059,12 @@
 			 */
 			crtc->vert_stretching =3D 0;
 		}
+		/* copy to shadow crtc */
+		crtc->shadow_h_tot_disp =3D crtc->h_tot_disp;
+		crtc->shadow_h_sync_strt_wid =3D crtc->h_sync_strt_wid;
+		crtc->shadow_v_tot_disp =3D crtc->v_tot_disp;
+		crtc->shadow_v_sync_strt_wid =3D crtc->v_sync_strt_wid;
 	}
=2D
=2D	/* copy to shadow crtc */
=2D	crtc->shadow_h_tot_disp =3D crtc->h_tot_disp;
=2D	crtc->shadow_h_sync_strt_wid =3D crtc->h_sync_strt_wid;
=2D	crtc->shadow_v_tot_disp =3D crtc->v_tot_disp;
=2D	crtc->shadow_v_sync_strt_wid =3D crtc->v_sync_strt_wid;
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
=20
 	if (M64_HAS(MAGIC_FIFO)) {
@@ -1078,7 +1153,6 @@
 		var->transp.offset =3D 0;
 		var->transp.length =3D 0;
 		break;
=2D#if 0
 	case CRTC_PIX_WIDTH_16BPP:	/* RGB 565 */
 		bpp =3D 16;
 		var->red.offset =3D 11;
@@ -1090,7 +1164,6 @@
 		var->transp.offset =3D 0;
 		var->transp.length =3D 0;
 		break;
=2D#endif
 	case CRTC_PIX_WIDTH_24BPP:	/* RGB 888 */
 		bpp =3D 24;
 		var->red.offset =3D 16;
@@ -1183,7 +1256,6 @@
 		wait_for_idle(par);
=20
 	aty_set_crtc(par, &par->crtc);
=2D
 	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel, par->accel_fl=
ags);
 	par->pll_ops->set_pll(info, &par->pll);
=20
@@ -1194,7 +1266,7 @@
 		pixclock_in_ps =3D 0;
=20
 	if(0 =3D=3D pixclock_in_ps) {
=2D		printk(KERN_CRIT "ALERT ops->pll_to_var get 0\n");
+		PRINTKE("ALERT ops->pll_to_var get 0\n");
 		pixclock_in_ps =3D pixclock;
 	}
=20
@@ -1220,23 +1292,23 @@
         	if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
             	vRefresh /=3D 2;
=20
=2D		printk("atyfb: atyfb_set_par\n");
=2D		printk(" Set Visible Mode to %ix%i-%i\n", var->xres, var->yres, var->b=
its_per_pixel);
=2D		printk(" Virtual resolution %ix%i, pixclock_in_ps %i (calculated %i)\n=
",
+		DPRINTK("atyfb_set_par\n");
+		DPRINTK(" Set Visible Mode to %ix%i-%i\n", var->xres, var->yres, var->bi=
ts_per_pixel);
+		DPRINTK(" Virtual resolution %ix%i, pixclock_in_ps %i (calculated %i)\n",
 			var->xres_virtual, var->yres_virtual, pixclock, pixclock_in_ps);
=2D		printk(" Dot clock:           %i MHz\n", 1000000 / pixclock_in_ps);
=2D		printk(" Horizontal sync:     %i kHz\n", hSync);
=2D		printk(" Vertical refresh:    %i Hz\n", vRefresh);
=2D		printk(" x  style: %i.%03i %i %i %i %i   %i %i %i %i\n",
+		DPRINTK(" Dot clock:           %i MHz\n", 1000000 / pixclock_in_ps);
+		DPRINTK(" Horizontal sync:     %i kHz\n", hSync);
+		DPRINTK(" Vertical refresh:    %i Hz\n", vRefresh);
+		DPRINTK(" x  style: %i.%03i %i %i %i %i   %i %i %i %i\n",
 			1000000 / pixclock_in_ps, 1000000 % pixclock_in_ps,
 			h_disp, h_sync_strt, h_sync_end, h_total,
 			v_disp, v_sync_strt, v_sync_end, v_total);
=2D		printk( " fb style:%i  %i %i %i %i %i %i %i %i\n",
+		DPRINTK(" fb style: %i  %i %i %i %i %i %i %i %i\n",
 			pixclock_in_ps,
 			debug.left_margin, h_disp, debug.right_margin, debug.hsync_len,
 			debug.upper_margin, v_disp, debug.lower_margin, debug.vsync_len);
 	}
=2D#endif
+#endif /* DEBUG */
=20
 	if (!M64_HAS(INTEGRATED)) {
 		/* Don't forget MEM_CNTL */
@@ -1315,9 +1387,9 @@
=20
 	/* CRTC registers */
 	base =3D 0x2000;
=2D	printk("Mach64 non-shadow register values:");
+	printk("debug atyfb: Mach64 non-shadow register values:");
 	for (i =3D 0; i < 256; i =3D i+4) {
=2D		if(i%16 =3D=3D 0) printk("\n0x%04X: ", base + i);
+		if(i%16 =3D=3D 0) printk("\ndebug atyfb: 0x%04X: ", base + i);
 		printk(" %08X", aty_ld_le32(i, par));
 	}
 	printk("\n\n");
@@ -1325,9 +1397,9 @@
 #ifdef CONFIG_FB_ATY_CT=09
 	/* PLL registers */
 	base =3D 0x00;
=2D	printk("Mach64 PLL register values:");
+	printk("debug atyfb: Mach64 PLL register values:");
 	for (i =3D 0; i < 64; i++) {
=2D		if(i%16 =3D=3D 0) printk("\n0x%02X: ", base + i);
+		if(i%16 =3D=3D 0) printk("\ndebug atyfb: 0x%02X: ", base + i);
 		if(i%4 =3D=3D 0)  printk(" ");
 		printk("%02X", aty_ld_pll_ct(i, par));
 	}
@@ -1338,10 +1410,20 @@
 	if (par->lcd_table !=3D 0) {
 		/* LCD registers */
 		base =3D 0x00;
=2D		printk("LCD register values:");
=2D		for (i =3D 0; i < 64; i++) {
=2D			if(i%4 =3D=3D 0) printk("\n0x%02X: ", base + i);
+		printk("debug atyfb: LCD register values:");
+		if(M64_HAS(LT_LCD_REGS)) {
+		    for(i =3D 0; i <=3D POWER_MANAGEMENT; i++) {
+			if(i =3D=3D EXT_VERT_STRETCH)
+			    continue;
+			printk("\ndebug atyfb: 0x%04X: ", lt_lcd_regs[i]);
+			printk(" %08X", aty_ld_lcd(i, par));
+		    }
+		   =20
+		} else {
+		    for (i =3D 0; i < 64; i++) {
+			if(i%4 =3D=3D 0) printk("\ndebug atyfb: 0x%02X: ", base + i);
 			printk(" %08X", aty_ld_lcd(i, par));
+		    }
 		}
 		printk("\n\n");
 	}
@@ -1395,7 +1477,6 @@
 	u32 bpp =3D info->var.bits_per_pixel;
=20
 	par->crtc.off_pitch =3D ((yoffset * vxres + xoffset) * bpp / 64) | (vxres=
 << 19);
=2D	aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 }
=20
=20
@@ -1405,26 +1486,103 @@
=20
 static int atyfb_open(struct fb_info *info, int user)
 {
=2D#ifdef __sparc__
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=20
 	if (user) {
 		par->open++;
+#ifdef __sparc__
 		par->mmaped =3D 0;
=2D	}
 #endif
+	}
 	return (0);
 }
=20
+static irqreturn_t aty_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct atyfb_par *par =3D dev_id;
+	int handled =3D 0;
+	u32 int_cntl;
+
+	spin_lock(&par->int_lock);
+
+	int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par);
+
+	if (int_cntl & CRTC_VBLANK_INT) {
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, (int_cntl & CRTC_INT_EN_MASK) | CRTC_VBLANK_I=
NT_AK, par);
+		par->vblank.count++;
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display =3D 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		wake_up_interruptible(&par->vblank.wait);
+		handled =3D 1;
+	}
+
+	spin_unlock(&par->int_lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int aty_enable_irq(struct atyfb_par *par, int reenable)
+{
+	u32 int_cntl;
+
+	if (!test_and_set_bit(0, &par->irq_flags)) {
+		if (request_irq(par->irq, aty_irq, SA_SHIRQ, "atyfb", par)) {
+			clear_bit(0, &par->irq_flags);
+			return -EINVAL;
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* clear interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_AK, par);
+		/* enable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par);
+		spin_unlock_irq(&par->int_lock);
+	} else if (reenable) {
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
+			printk("atyfb: someone disabled IRQ [%08x]\n", int_cntl);
+			/* re-enable interrupt */
+			aty_st_le32(CRTC_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN, par );
+		}
+		spin_unlock_irq(&par->int_lock);
+	}
+
+	return 0;
+}
+
+static int aty_disable_irq(struct atyfb_par *par)
+{
+	u32 int_cntl;
+
+	if (test_and_clear_bit(0, &par->irq_flags)) {
+		if (par->vblank.pan_display) {
+			par->vblank.pan_display =3D 0;
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+		}
+		spin_lock_irq(&par->int_lock);
+		int_cntl =3D aty_ld_le32(CRTC_INT_CNTL, par) & CRTC_INT_EN_MASK;
+		/* disable interrupt */
+		aty_st_le32(CRTC_INT_CNTL, int_cntl & ~CRTC_VBLANK_INT_EN, par );
+		spin_unlock_irq(&par->int_lock);
+		free_irq(par->irq, par);
+	}
+
+	return 0;
+}
+
 static int atyfb_release(struct fb_info *info, int user)
 {
=2D#ifdef __sparc__
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	if (user) {
 		par->open--;
 		mdelay(1);
 		wait_for_idle(par);
 		if (!par->open) {
+#ifdef __sparc__
 			int was_mmaped =3D par->mmaped;
=20
 			par->mmaped =3D 0;
@@ -1443,15 +1601,16 @@
 				else
 					var.accel_flags |=3D FB_ACCELF_TEXT;
 				if (var.yres =3D=3D var.yres_virtual) {
=2D					u32 vram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
=2D					var.yres_virtual =3D ((vram * 8) / var.bits_per_pixel) / var.xres_v=
irtual;
+					u32 videoram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
+					var.yres_virtual =3D ((videoram * 8) / var.bits_per_pixel) / var.xres=
_virtual;
 					if (var.yres_virtual < var.yres)
 						var.yres_virtual =3D var.yres;
 				}
 			}
+#endif
+			aty_disable_irq(par);
 		}
 	}
=2D#endif
 	return (0);
 }
=20
@@ -1478,10 +1637,50 @@
 	info->var.yoffset =3D yoffset;
 	if (par->asleep)
 		return 0;
+
 	set_off_pitch(par, info);
+	if ((var->activate & FB_ACTIVATE_VBL) && !aty_enable_irq(par, 0)) {
+		par->vblank.pan_display =3D 1;
+	} else {
+		par->vblank.pan_display =3D 0;
+		aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
+	}
+
 	return 0;
 }
=20
+static int aty_waitforvblank(struct atyfb_par *par, u32 crtc)
+{
+	struct aty_interrupt *vbl;
+	unsigned int count;
+	int ret;
+
+	switch (crtc) {
+	case 0:
+		vbl =3D &par->vblank;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret =3D aty_enable_irq(par, 0);
+	if (ret)
+		return ret;
+
+	count =3D vbl->count;
+	ret =3D wait_event_interruptible_timeout(vbl->wait, count !=3D vbl->count=
, HZ/10);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret =3D=3D 0) {
+		aty_enable_irq(par, 1);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+
 #ifdef DEBUG
 #define ATYIO_CLKR		0x41545900	/* ATY\00 */
 #define ATYIO_CLKW		0x41545901	/* ATY\01 */
@@ -1506,12 +1705,14 @@
 #define ATYIO_FEATW		0x41545903	/* ATY\03 */
 #endif
=20
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 	u_long arg, struct fb_info *info)
 {
=2D#if defined(__sparc__) || (defined(DEBUG) && defined(CONFIG_FB_ATY_CT))
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D#endif /* __sparc__ || DEBUG */
 #ifdef __sparc__
 	struct fbtype fbtyp;
 #endif
@@ -1529,6 +1730,18 @@
 			return -EFAULT;
 		break;
 #endif /* __sparc__ */
+
+	case FBIO_WAITFORVSYNC:
+		{
+			u32 crtc;
+
+			if (get_user(crtc, (__u32 *) arg))
+				return -EFAULT;
+
+			return aty_waitforvblank(par, crtc);
+		}
+		break;
+
 #if defined(DEBUG) && defined(CONFIG_FB_ATY_CT)
 	case ATYIO_CLKR:
 		if (M64_HAS(INTEGRATED)) {
@@ -1725,6 +1938,7 @@
 				info->var.yoffset =3D atyfb_save.yoffset;
 				set_off_pitch(par, info);
 			}
+			aty_st_le32(CRTC_OFF_PITCH, par->crtc.off_pitch, par);
 			break;
 		}
 	}
@@ -1736,69 +1950,10 @@
 #if defined(CONFIG_PM) && defined(CONFIG_PCI)
=20
 /* Power management routines. Those are used for PowerBook sleep.
=2D *
=2D * It appears that Rage LT and Rage LT Pro have different power
=2D * management registers. There's is some confusion about which
=2D * chipID is a Rage LT or LT pro :(
  */
=2Dstatic int aty_power_mgmt_LT(int sleep, struct atyfb_par *par)
=2D{
=2D	unsigned int pm;
=2D	int timeout;
=2D
=2D	pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D	pm =3D (pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_REG;
=2D	aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D	pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D
=2D	timeout =3D 200000;
=2D	if (sleep) {
=2D		/* Sleep */
=2D		pm &=3D ~PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm &=3D ~(PWR_BLON | AUTO_PWR_UP);
=2D		pm |=3D SUSPEND_NOW;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		do {
=2D			pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D			udelay(10);
=2D			if ((--timeout) =3D=3D 0)
=2D				break;
=2D		} while ((pm & PWR_MGT_STATUS_MASK) !=3D PWR_MGT_STATUS_SUSPEND);
=2D	} else {
=2D		/* Wakeup */
=2D		pm &=3D ~PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D (PWR_BLON | AUTO_PWR_UP);
=2D		pm &=3D ~SUSPEND_NOW;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D		udelay(10);
=2D		pm |=3D PWR_MGT_ON;
=2D		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
=2D		do {
=2D			pm =3D aty_ld_le32(POWER_MANAGEMENT_LG, par);
=2D			udelay(10);
=2D			if ((--timeout) =3D=3D 0)
=2D				break;
=2D		} while ((pm & PWR_MGT_STATUS_MASK) !=3D 0);
=2D	}
=2D	mdelay(500);
=2D
=2D	return timeout ? -1 : 0;
=2D}
=2D
=2Dstatic int aty_power_mgmt_LTPro(int sleep, struct atyfb_par *par)
+static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 {
=2D	unsigned int pm;
+	u32 pm;
 	int timeout;
=20
 	pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
@@ -1806,7 +1961,7 @@
 	aty_st_lcd(POWER_MANAGEMENT, pm, par);
 	pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
=20
=2D	timeout =3D 200;
+	timeout =3D 2000;
 	if (sleep) {
 		/* Sleep */
 		pm &=3D ~PWR_MGT_ON;
@@ -1846,16 +2001,11 @@
 				break;
 		} while ((pm & PWR_MGT_STATUS_MASK) !=3D 0);
 	}
+	mdelay(500);
=20
 	return timeout ? -1 : 0;
 }
=20
=2Dstatic int aty_power_mgmt(int sleep, struct atyfb_par *par)
=2D{
=2D	return M64_HAS(LT_SLEEP) ? aty_power_mgmt_LT(sleep, par)
=2D	    : aty_power_mgmt_LTPro(sleep, par);
=2D}
=2D
 static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct fb_info *info =3D pci_get_drvdata(pdev);
@@ -1990,7 +2140,7 @@
 	const int *refresh_tbl;
 	int i, size;
=20
=2D	if (IS_XL(par->pci_id)) {
+	if (IS_XL(par->pci_id) || IS_MOBILITY(par->pci_id)) {
 		refresh_tbl =3D ragexl_tbl;
 		size =3D sizeof(ragexl_tbl)/sizeof(int);
 	} else {
@@ -2023,15 +2173,18 @@
 	int sense;
 #endif
=20
+	init_waitqueue_head(&par->vblank.wait);
+	spin_lock_init(&par->int_lock);
+
 	par->aty_cmap_regs =3D
 	    (struct aty_cmap_regs *) (par->ati_regbase + 0xc0);
=20
=2D	if (default_pll)
=2D		par->pll_limits.pll_max =3D default_pll;
=2D	if (default_mclk)
=2D		par->pll_limits.mclk =3D default_mclk;
=2D	if (default_xclk)
=2D		par->pll_limits.xclk =3D default_xclk;
+	if (pll)
+		par->pll_limits.pll_max =3D pll;
+	if (mclk)
+		par->pll_limits.mclk =3D mclk;
+	if (xclk)
+		par->pll_limits.xclk =3D xclk;
=20
 	aty_calc_mem_refresh(par, par->pll_limits.xclk);
 	par->pll_per =3D 1000000/par->pll_limits.pll_max;
@@ -2076,7 +2229,7 @@
 			par->dac_ops =3D &aty_dac_att21c498;
 			break;
 		default:
=2D			printk(" aty_init: DAC type not implemented yet!\n");
+			PRINTKI("aty_init: DAC type not implemented yet!\n");
 			par->dac_ops =3D &aty_dac_unsupported;
 			break;
 		}
@@ -2097,7 +2250,7 @@
 			par->pll_ops =3D &aty_pll_ibm514;
 			break;
 		default:
=2D			printk(" aty_init: CLK type not implemented yet!");
+			PRINTKI("aty_init: CLK type not implemented yet!");
 			par->pll_ops =3D &aty_pll_unsupported;
 			break;
 		}
@@ -2131,11 +2284,12 @@
 		}
 	}
 #endif /* CONFIG_FB_ATY_CT */
=2D#if 0
+
+	/* save previous video mode */
 	aty_get_crtc(par, &saved_crtc);
 	if(par->pll_ops->get_pll)
 		par->pll_ops->get_pll(info, &saved_pll);
=2D#endif
+
 	i =3D aty_ld_le32(MEM_CNTL, par);
 	gtb_memsize =3D M64_HAS(GTB_DSP);
 	if (gtb_memsize)
@@ -2189,8 +2343,8 @@
 			info->fix.smem_len +=3D 0x400000;
 	}
=20
=2D	if (default_vram) {
=2D		info->fix.smem_len =3D default_vram * 1024;
+	if (vram) {
+		info->fix.smem_len =3D vram * 1024;
 		i =3D i & ~(gtb_memsize ? 0xF : MEM_SIZE_ALIAS);
 		if (info->fix.smem_len <=3D 0x80000)
 			i |=3D MEM_SIZE_512K;
@@ -2218,16 +2372,16 @@
 		info->fix.mmio_len =3D 0x400;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64CT;
 	} else if (M64_HAS(VT)) {
=2D		info->fix.mmio_start =3D -0x400;
+		info->fix.mmio_start -=3D 0x400;
 		info->fix.mmio_len =3D 0x800;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64VT;
 	} else {/* GT */
=2D		info->fix.mmio_start =3D -0x400;
+		info->fix.mmio_start -=3D 0x400;
 		info->fix.mmio_len =3D 0x800;
 		info->fix.accel =3D FB_ACCEL_ATI_MACH64GT;
 	}
=20
=2D	printk("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d MHz XCLK\n",
+	PRINTKI("%d%c %s, %s MHz XTAL, %d MHz PLL, %d Mhz MCLK, %d MHz XCLK\n",
 	       info->fix.smem_len =3D=3D 0x80000 ? 512 : (info->fix.smem_len >> 2=
0),
 	       info->fix.smem_len =3D=3D 0x80000 ? 'K' : 'M', ramname, xtal, par-=
>pll_limits.pll_max,
 	       par->pll_limits.mclk, par->pll_limits.xclk);
@@ -2235,10 +2389,10 @@
 #if defined(DEBUG) && defined(CONFIG_ATY_CT)
 	if (M64_HAS(INTEGRATED)) {
 		int i;
=2D		printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
+		printk("debug atyfb: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CN=
TL "
 		       "DSP_CONFIG DSP_ON_OFF CLOCK_CNTL\n"
=2D		       "%08x %08x %08x %08x     %08x      %08x   %08x   %08x\n"
=2D		       "PLL",
+		       "debug atyfb: %08x %08x %08x %08x     %08x      %08x   %08x   %08=
x\n"
+		       "debug atyfb: PLL",
 			aty_ld_le32(BUS_CNTL, par), aty_ld_le32(DAC_CNTL, par),
 			aty_ld_le32(MEM_CNTL, par), aty_ld_le32(EXT_MEM_CNTL, par),
 			aty_ld_le32(CRTC_GEN_CNTL, par), aty_ld_le32(DSP_CONFIG, par),
@@ -2292,8 +2446,8 @@
 		 *  FIXME: The NVRAM stuff should be put in a Mac-specific file, as it
 		 *         applies to all Mac video cards
 		 */
=2D		if (mode_option) {
=2D			if (!mac_find_mode(&var, info, mode_option, 8))
+		if (mode) {
+			if (!mac_find_mode(&var, info, mode, 8))
 				var =3D default_var;
 		} else {
 			if (default_vmode =3D=3D VMODE_CHOOSE) {
@@ -2309,7 +2463,7 @@
 				else
 					default_vmode =3D VMODE_640_480_67;
 				sense =3D read_aty_sense(par);
=2D				printk(KERN_INFO "atyfb: monitor sense=3D%x, mode %d\n",
+				PRINTKI("monitor sense=3D%x, mode %d\n",
 					sense,  mac_map_monitor_sense(sense));
 			}
 			if (default_vmode <=3D 0 || default_vmode > VMODE_MAX)
@@ -2321,7 +2475,7 @@
 		}
 	} else
 #endif /* !CONFIG_PPC */
=2D	if (!fb_find_mode(&var, info, mode_option, NULL, 0, &defmode, 8))
+	if (!fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
 		var =3D default_var;
=20
 	if (noaccel)
@@ -2330,15 +2484,15 @@
 		var.accel_flags |=3D FB_ACCELF_TEXT;
=20
 	if (var.yres =3D=3D var.yres_virtual) {
=2D		u32 vram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
=2D		var.yres_virtual =3D ((vram * 8) / var.bits_per_pixel) / var.xres_virt=
ual;
+		u32 videoram =3D (info->fix.smem_len - (PAGE_SIZE << 2));
+		var.yres_virtual =3D ((videoram * 8) / var.bits_per_pixel) / var.xres_vi=
rtual;
 		if (var.yres_virtual < var.yres)
 			var.yres_virtual =3D var.yres;
 	}
=20
 	if (atyfb_check_var(&var, info)) {
=2D		printk(KERN_CRIT "atyfb: can't set default video mode\n");
=2D		return 0;
+		PRINTKE("can't set default video mode\n");
+		goto aty_init_exit;
 	}
=20
 #ifdef __sparc__
@@ -2346,7 +2500,7 @@
 #endif
=20
 #ifdef CONFIG_FB_ATY_CT
=2D	if (M64_HAS(INTEGRATED))
+	if (!noaccel && M64_HAS(INTEGRATED))
 		aty_init_cursor(info);
 #endif /* CONFIG_FB_ATY_CT */
 	info->var =3D var;
@@ -2354,85 +2508,21 @@
 	fb_alloc_cmap(&info->cmap, 256, 0);
=20
 	if (register_framebuffer(info) < 0)
=2D		return 0;
+		goto aty_init_exit;
=20
 	fb_list =3D info;
=20
=2D	printk("fb%d: %s frame buffer device on %s\n",
+	PRINTKI("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
 	return 1;
=2D}
=2D
=2D#ifndef MODULE
=2Dint __init atyfb_setup(char *options)
=2D{
=2D	char *this_opt;
=2D
=2D	if (!options || !*options)
=2D		return 0;
+=09
+aty_init_exit:
+	/* restore video mode */
+	aty_set_crtc(par, &saved_crtc);
+	par->pll_ops->set_pll(info, &saved_pll);
=20
=2D	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
=2D		if (!strncmp(this_opt, "noaccel", 7)) {
=2D			noaccel =3D 1;
=2D		} else if (!strncmp(this_opt, "vram:", 5))
=2D			default_vram =3D
=2D			    simple_strtoul(this_opt + 5, NULL, 0);
=2D		else if (!strncmp(this_opt, "pll:", 4))
=2D			default_pll =3D
=2D			    simple_strtoul(this_opt + 4, NULL, 0);
=2D		else if (!strncmp(this_opt, "mclk:", 5))
=2D			default_mclk =3D
=2D			    simple_strtoul(this_opt + 5, NULL, 0);
=2D		else if (!strncmp(this_opt, "xclk:", 5))
=2D			default_xclk =3D
=2D			simple_strtoul(this_opt+5, NULL, 0);
=2D#ifdef CONFIG_PPC
=2D		else if (!strncmp(this_opt, "vmode:", 6)) {
=2D			unsigned int vmode =3D
=2D			    simple_strtoul(this_opt + 6, NULL, 0);
=2D			if (vmode > 0 && vmode <=3D VMODE_MAX)
=2D				default_vmode =3D vmode;
=2D		} else if (!strncmp(this_opt, "cmode:", 6)) {
=2D			unsigned int cmode =3D
=2D			    simple_strtoul(this_opt + 6, NULL, 0);
=2D			switch (cmode) {
=2D			case 0:
=2D			case 8:
=2D				default_cmode =3D CMODE_8;
=2D				break;
=2D			case 15:
=2D			case 16:
=2D				default_cmode =3D CMODE_16;
=2D				break;
=2D			case 24:
=2D			case 32:
=2D				default_cmode =3D CMODE_32;
=2D				break;
=2D			}
=2D		}
=2D#endif
=2D#ifdef CONFIG_ATARI
=2D		/*
=2D		 * Why do we need this silly Mach64 argument?
=2D		 * We are already here because of mach64=3D so its redundant.
=2D		 */
=2D		else if (MACH_IS_ATARI
=2D			 && (!strncmp(this_opt, "Mach64:", 7))) {
=2D			static unsigned char m64_num;
=2D			static char mach64_str[80];
=2D			strlcpy(mach64_str, this_opt + 7, sizeof(mach64_str));
=2D			if (!store_video_par(mach64_str, m64_num)) {
=2D				m64_num++;
=2D				mach64_count =3D m64_num;
=2D			}
=2D		}
=2D#endif
=2D		else
=2D			mode_option =3D this_opt;
=2D	}
 	return 0;
 }
=2D#endif /* !MODULE */
=20
 #ifdef CONFIG_ATARI
 static int __init store_video_par(char *video_str, unsigned char m64_num)
@@ -2440,7 +2530,7 @@
 	char *p;
 	unsigned long vmembase, size, guiregbase;
=20
=2D	printk("store_video_par() '%s' \n", video_str);
+	PRINTKI("store_video_par() '%s' \n", video_str);
=20
 	if (!(p =3D strsep(&video_str, ";")) || !*p)
 		goto mach64_invalid;
@@ -2455,7 +2545,7 @@
 	phys_vmembase[m64_num] =3D vmembase;
 	phys_size[m64_num] =3D size;
 	phys_guiregbase[m64_num] =3D guiregbase;
=2D	printk(" stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
+	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
 	       guiregbase);
 	return 0;
=20
@@ -2480,7 +2570,14 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine =3D=3D _MACH_Pmac) && blank)
 		set_backlight_enable(0);
=2D#endif /* CONFIG_PMAC_BACKLIGHT */
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm &=3D ~PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
=20
 	gen_cntl =3D aty_ld_8(CRTC_GEN_CNTL, par);
 	if (blank > 0)
@@ -2504,52 +2601,76 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine =3D=3D _MACH_Pmac) && !blank)
 		set_backlight_enable(1);
=2D#endif /* CONFIG_PMAC_BACKLIGHT */
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && !blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm |=3D PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
+
 	return 0;
 }
=20
+static void aty_st_pal(u_int regno, u_int red, u_int green, u_int blue,
+		       const struct atyfb_par *par)
+{
+#ifdef CONFIG_ATARI
+	out_8(&par->aty_cmap_regs->windex, regno);
+	out_8(&par->aty_cmap_regs->lut, red);
+	out_8(&par->aty_cmap_regs->lut, green);
+	out_8(&par->aty_cmap_regs->lut, blue);
+#else
+	writeb(regno, &par->aty_cmap_regs->windex);
+	writeb(red, &par->aty_cmap_regs->lut);
+	writeb(green, &par->aty_cmap_regs->lut);
+	writeb(blue, &par->aty_cmap_regs->lut);
+#endif
+}
+
     /*
      *  Set a single color register. The values supplied are already
      *  rounded down to the hardware's capabilities (according to the
      *  entries in the var structure). Return !=3D 0 for invalid regno.
+     *  !! 4 & 8 =3D  PSEUDO, > 8 =3D DIRECTCOLOR
      */
=20
 static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u_int transp, struct fb_info *info)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=2D	int i, scale;
+	int i, depth;
 	u32 *pal =3D info->pseudo_palette;
=20
+	depth =3D info->var.bits_per_pixel;
+	if (depth =3D=3D 16)
+		depth =3D (info->var.green.length =3D=3D 5) ? 15 : 16;
+
 	if (par->asleep)
 		return 0;
=2D	if (regno > 255)
+
+	if (regno > 255 ||
+	    (depth =3D=3D 16 && regno > 63) ||
+	    (depth =3D=3D 15 && regno > 31))
 		return 1;
+
 	red >>=3D 8;
 	green >>=3D 8;
 	blue >>=3D 8;
=2D	i =3D aty_ld_8(DAC_CNTL, par) & 0xfc;
=2D	if (M64_HAS(EXTRA_BRIGHT))
=2D		i |=3D 0x2; /* DAC_CNTL | 0x2 turns off the extra brightness for gt */
=2D	aty_st_8(DAC_CNTL, i, par);
=2D	aty_st_8(DAC_MASK, 0xff, par);
=2D	scale =3D (M64_HAS(INTEGRATED) && info->var.bits_per_pixel =3D=3D 16) ?=
 3 : 0;
=2D#ifdef CONFIG_ATARI
=2D	out_8(&par->aty_cmap_regs->windex, regno << scale);
=2D	out_8(&par->aty_cmap_regs->lut, red);
=2D	out_8(&par->aty_cmap_regs->lut, green);
=2D	out_8(&par->aty_cmap_regs->lut, blue);
=2D#else
=2D	writeb(regno << scale, &par->aty_cmap_regs->windex);
=2D	writeb(red, &par->aty_cmap_regs->lut);
=2D	writeb(green, &par->aty_cmap_regs->lut);
=2D	writeb(blue, &par->aty_cmap_regs->lut);
=2D#endif
=2D	if (regno < 16)
=2D		switch (info->var.bits_per_pixel) {
=2D		case 16:
+
+	par->palette[regno].red =3D red;
+	par->palette[regno].green =3D green;
+	par->palette[regno].blue =3D blue;
+
+	if (regno < 16) {
+		switch (depth) {
+		case 15:
 			pal[regno] =3D (regno << 10) | (regno << 5) | regno;
 			break;
+		case 16:
+			pal[regno] =3D (regno << 11) | (regno << 5) | regno;
+			break;
 		case 24:
 			pal[regno] =3D (regno << 16) | (regno << 8) | regno;
 			break;
@@ -2558,6 +2679,32 @@
 			pal[regno] =3D (i << 16) | i;
 			break;
 		}
+	}
+
+	i =3D aty_ld_8(DAC_CNTL, par) & 0xfc;
+	if (M64_HAS(EXTRA_BRIGHT))
+		i |=3D 0x2; /* DAC_CNTL | 0x2 turns off the extra brightness for gt */
+	aty_st_8(DAC_CNTL, i, par);
+	aty_st_8(DAC_MASK, 0xff, par);
+
+	if (M64_HAS(INTEGRATED)) {
+		if (depth =3D=3D 16) {
+			if (regno < 32)
+				aty_st_pal(regno << 3, red,
+					   par->palette[regno<<1].green,
+					   blue, par);
+			red =3D par->palette[regno>>1].red;
+			blue =3D par->palette[regno>>1].blue;
+			regno <<=3D 2;
+		} else if (depth =3D=3D 15) {
+			regno <<=3D 3;
+			for(i =3D 0; i < 8; i++) {
+			    aty_st_pal(regno + i, red, green, blue, par);
+			}
+		}
+	}
+	aty_st_pal(regno, red, green, blue, par);
+
 	return 0;
 }
=20
@@ -2573,7 +2720,7 @@
 	struct atyfb_par *par =3D info->par;
 	struct pcidev_cookie *pcp;
 	char prop[128];
=2D	int node, len, i, j;
+	int node, len, i, j, ret;
 	u32 mem, chip_id;
=20
 	/* Do not attach when we have a serial console. */
@@ -2602,7 +2749,7 @@
=20
 	par->mmap_map =3D kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
 	if (!_par->mmap_map) {
=2D		printk(KERN_ERR "atyfb_init: can't alloc mmap_map\n");
+		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
 		return -ENOMEM;
 	}
 	memset(par->mmap_map, 0, j * sizeof(*par->mmap_map));
@@ -2661,7 +2808,8 @@
 		j++;
 	}
 =09
=2D	correct_chipset(par);
+	if((ret =3D correct_chipset(par)))
+		return ret;
=20
 	if (IS_XL(pdev->device)) {
 		/*
@@ -2735,7 +2883,7 @@
 		 * Read the PLL to figure actual Refresh Rate.
 		 */
 		clock_cntl =3D aty_ld_8(CLOCK_CNTL, par);
=2D		/* printk("atyfb: CLOCK_CNTL: %02x\n", clock_cntl); */
+		/* DPRINTK("CLOCK_CNTL %02x\n", clock_cntl); */
 		for (i =3D 0; i < 16; i++)
 			pll_regs[i] =3D aty_ld_pll_ct(i, par);
=20
@@ -2783,6 +2931,7 @@
=20
 #else /* __sparc__ */
=20
+#ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
@@ -2805,7 +2954,7 @@
 		(sig =3D=3D 0x544d5224) || /* Rage mobility */
 		(sig =3D=3D 0x54435824) || /* Rage XC */
 		(sig =3D=3D 0x544c5824)) { /* Rage XL */
=2D		printk(KERN_INFO "atyfb: BIOS contains driver information table.\n");
+		PRINTKI("BIOS contains driver information table.\n");
 		lcd_ofs =3D (*(u16 *)(driv_inf_tab + 10));
 		par->lcd_table =3D 0;
 		if (lcd_ofs !=3D 0) {
@@ -2904,8 +3053,10 @@
 				txtformat =3D "unkown format";
 			}
 		}
=2D		printk(KERN_INFO "atyfb: %s%s %s monitor detected: %s\n        id=3D%d=
, %dx%d pixels, %s\n",
=2D			txtdual ,txtcolour, txtmonitor, model, id, width, height, txtformat);
+		PRINTKI("%s%s %s monitor detected: %s\n",
+			txtdual ,txtcolour, txtmonitor, model);
+		PRINTKI("       id=3D%d, %dx%d pixels, %s\n",
+			id, width, height, txtformat);
 		refresh_rates_buf[0] =3D 0;
 		refresh_rates =3D *(u16 *)(par->lcd_table+62);
 		m =3D 1;
@@ -2923,7 +3074,7 @@
 			m =3D m << 1;
 		}
 		default_refresh_rate =3D (*(u8 *)(par->lcd_table+61) & 0xf0) >> 4;
=2D		printk(KERN_INFO "        supports refresh rates [%s], default %d Hz\n=
",
+		PRINTKI("       supports refresh rates [%s], default %d Hz\n",
 			refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
 		par->lcd_refreshrate =3D lcd_refresh_rates[default_refresh_rate];
 		/* We now need to determine the crtc parameters for the
@@ -2978,10 +3129,10 @@
 			lcdmodeptr++;
 		}
 		if (*lcdmodeptr =3D=3D 0) {
=2D			printk(KERN_WARNING "atyfb: LCD monitor CRTC parameters not found!!!\=
n");
+			PRINTKE("LCD monitor CRTC parameters not found!!!\n");
 			/* To do: Switch to CRT if possible. */
 		} else {
=2D			printk(KERN_INFO "        LCD CRTC parameters: %d.%d  %d %d %d %d  %d=
 %d %d %d\n",
+			PRINTKI("       LCD CRTC parameters: %d.%d  %d %d %d %d  %d %d %d %d\n",
 				1000000 / par->lcd_pixclock, 1000000 % par->lcd_pixclock,
 				par->lcd_hdisp,
 				par->lcd_hdisp + par->lcd_right_margin,
@@ -2992,7 +3143,7 @@
 				par->lcd_vdisp + par->lcd_lower_margin,
 				par->lcd_vdisp + par->lcd_lower_margin + par->lcd_vsync_len,
 				par->lcd_vtotal);
=2D			printk(KERN_INFO "                           : %d %d %d %d %d %d %d %=
d %d\n",
+			PRINTKI("                          : %d %d %d %d %d %d %d %d %d\n",
 				par->lcd_pixclock,
 				par->lcd_hblank_len - (par->lcd_right_margin +
 					par->lcd_hsync_dly + par->lcd_hsync_len),
@@ -3023,7 +3174,7 @@
 		u16 rom_table_offset, freq_table_offset;
 		PLL_BLOCK_MACH64 pll_block;
 	=09
=2D		printk(KERN_INFO "atyfb: Mach64 BIOS is located at %x, mapped at %x.\n=
", rom_addr, bios_base);
+		PRINTKI("Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_=
base);
=20
 		/* check for frequncy table */
 		bios_ptr =3D (u8*)bios_base;
@@ -3031,11 +3182,11 @@
 		freq_table_offset =3D bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_ta=
ble_offset + 17] << 8);
 		memcpy(&pll_block, bios_ptr + freq_table_offset, sizeof(PLL_BLOCK_MACH64=
));
=20
=2D		printk(KERN_INFO "atyfb: BIOS frequency table:\n");
=2D		printk(KERN_INFO " PCLK_min_freq %d, PCLK_max_freq %d, ref_freq %d, re=
f_divider %d\n",
+		PRINTKI("BIOS frequency table:\n");
+		PRINTKI("PCLK_min_freq %d, PCLK_max_freq %d, ref_freq %d, ref_divider %d=
\n",
 			pll_block.PCLK_min_freq, pll_block.PCLK_max_freq,
 			pll_block.ref_freq, pll_block.ref_divider);
=2D		printk(KERN_INFO " MCLK_pwd %d, MCLK_max_freq %d, XCLK_max_freq %d, SC=
LK_freq %d\n",
+		PRINTKI("MCLK_pwd %d, MCLK_max_freq %d, XCLK_max_freq %d, SCLK_freq %d\n=
",
 			pll_block.MCLK_pwd, pll_block.MCLK_max_freq,
 			pll_block.XCLK_max_freq, pll_block.SCLK_freq);
=20
@@ -3052,13 +3203,14 @@
 #endif
 		ret =3D 0;
 	} else {
=2D		printk(KERN_CRIT "atyfb: no BIOS frequency table found, use parameters=
\n");
+		PRINTKE("no BIOS frequency table found, use parameters\n");
 		ret =3D -ENXIO;
 	}
 	iounmap((void*)bios_base);
=20
 	return ret;
 }
+#endif /* __i386__ */
=20
 static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_i=
nfo *info, unsigned long addr)
 {
@@ -3066,6 +3218,7 @@
 	u16 tmp;
 	unsigned long raddr;
 	struct resource *rrp;
+	int ret =3D 0;
=20
 	raddr =3D addr + 0x7ff000UL;
 	rrp =3D &pdev->resource[2];
@@ -3073,7 +3226,7 @@
 		par->aux_start =3D rrp->start;
 		par->aux_size =3D rrp->end - rrp->start + 1;
 		raddr =3D rrp->start;
=2D		printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
+		PRINTKI("using auxiliary register aperture\n");
 	}
=20
 	info->fix.mmio_start =3D raddr;
@@ -3102,16 +3255,16 @@
 	info->fix.smem_start =3D addr;
 	info->screen_base =3D (char *)ioremap(addr, 0x800000);
 	if (info->screen_base =3D=3D NULL) {
=2D		iounmap((void *)par->ati_regbase);
=2D		par->ati_regbase =3D 0;
=2D		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto atyfb_setup_generic_fail;
 	}
=20
=2D	/* always succeeded ? */
=2D	if (correct_chipset(par) < 0)
=2D		return -ENXIO;
=2D	init_from_bios(par);
=2D
+	if((ret =3D correct_chipset(par)))
+		goto atyfb_setup_generic_fail;
+#ifdef __i386__
+	if((ret =3D init_from_bios(par)))
+		goto atyfb_setup_generic_fail;
+#endif	=09
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
 		par->clk_wr_offset =3D (inb(R_GENMO) & 0x0CU) >> 2;
 	else
@@ -3121,16 +3274,21 @@
 	par->clk_wr_offset =3D 3;
=20
 	return 0;
+=09
+atyfb_setup_generic_fail:
+	iounmap((void *)par->ati_regbase);
+	par->ati_regbase =3D 0;
+	return ret;
 }
=20
 #endif /* !__sparc__ */
=20
 static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
 {
=2D	unsigned long addr;
+	unsigned long addr, res_start, res_size;
 	struct fb_info *info;
 	struct resource *rp;
=2D	struct atyfb_par *par =3D info->par;
+	struct atyfb_par *par;
 	int i, rc =3D -ENOMEM;
=20
 	for (i =3D sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >=3D 0; i--)
@@ -3142,7 +3300,7 @@
=20
 	/* Enable device in PCI config */
 	if (pci_enable_device(pdev)) {
=2D		printk(KERN_ERR "atyfb: Cannot enable PCI device\n");
+		PRINTKE("Cannot enable PCI device\n");
 		return -ENXIO;
 	}
=20
@@ -3154,23 +3312,24 @@
 	if (!addr)
 		return -ENXIO;
=20
=2D	/* Allocate framebuffer */
+	/* Reserve space */
+	res_start =3D rp->start;
+	res_size =3D rp->end - rp->start + 1;
+	if (!request_mem_region (res_start, res_size, "atyfb"))
+		return -EBUSY;
+       =20
+        /* Allocate framebuffer */
 	info =3D framebuffer_alloc(sizeof(struct atyfb_par), &pdev->dev);
 	if (!info) {
=2D		printk(KERN_ERR "atyfb_init: can't alloc fb_info\n");
+		PRINTKE("atyfb_pci_probe() can't alloc fb_info\n");
 		return -ENOMEM;
 	}
 	par =3D info->par;
 	info->fix =3D atyfb_fix;
 	par->pci_id =3D aty_chips[i].pci_id;
=2D
=2D	/* Reserve space */
=2D	par->res_start =3D rp->start;
=2D	par->res_size =3D rp->end - rp->start + 1;
=2D	if (!request_mem_region (par->res_start, par->res_size, "atyfb")) {
=2D		rc =3D -EBUSY;
=2D		goto err_free;
=2D	}
+	par->res_start =3D res_start;
+	par->res_size =3D res_size;
+	par->irq =3D pdev->irq;
=20
 	/* Setup "info" structure */
 #ifdef __sparc__
@@ -3224,7 +3383,6 @@
 		release_mem_region(par->aux_start, par->aux_size);
=20
 	release_mem_region(par->res_start, par->res_size);
=2Derr_free:
 	framebuffer_release(info);
=20
 	return rc;
@@ -3244,19 +3402,21 @@
 	for (m64_num =3D 0; m64_num < mach64_count; m64_num++) {
 		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
 		    !phys_guiregbase[m64_num]) {
=2D			printk(" phys_*[%d] parameters not set =3D> returning early. \n", m64=
_num);
+		    PRINTKI("phys_*[%d] parameters not set =3D> returning early. \n", m6=
4_num);
 			continue;
 		}
=20
 		info =3D framebuffer_alloc(sizeof(struct atyfb_par), NULL);
 		if (!info) {
=2D			printk("atyfb_init: can't alloc fb_info\n");
+			PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
 			return -ENOMEM;
 		}
 		par =3D info->par;
=20
 		info->fix =3D atyfb_fix;
=20
+		par->irq =3D (unsigned int) -1; /* something invalid */
+
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
 		 *  kernel address space.
@@ -3298,6 +3458,10 @@
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
=20
+	/* restore video mode */
+	aty_set_crtc(par, &saved_crtc);
+	par->pll_ops->set_pll(info, &saved_pll);
+
 	unregister_framebuffer(info);
=20
 #ifndef __sparc__
@@ -3375,4 +3539,93 @@
 #endif
 }
=20
+int __init atyfb_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
+		if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel =3D 1;
+		} else if (!strncmp(this_opt, "vram:", 5))
+			vram =3D simple_strtoul(this_opt + 5, NULL, 0);
+		else if (!strncmp(this_opt, "pll:", 4))
+			pll =3D simple_strtoul(this_opt + 4, NULL, 0);
+		else if (!strncmp(this_opt, "mclk:", 5))
+			mclk =3D simple_strtoul(this_opt + 5, NULL, 0);
+		else if (!strncmp(this_opt, "xclk:", 5))
+			xclk =3D simple_strtoul(this_opt+5, NULL, 0);
+#ifdef CONFIG_PPC
+		else if (!strncmp(this_opt, "vmode:", 6)) {
+			unsigned int vmode =3D
+			    simple_strtoul(this_opt + 6, NULL, 0);
+			if (vmode > 0 && vmode <=3D VMODE_MAX)
+				default_vmode =3D vmode;
+		} else if (!strncmp(this_opt, "cmode:", 6)) {
+			unsigned int cmode =3D
+			    simple_strtoul(this_opt + 6, NULL, 0);
+			switch (cmode) {
+			case 0:
+			case 8:
+				default_cmode =3D CMODE_8;
+				break;
+			case 15:
+			case 16:
+				default_cmode =3D CMODE_16;
+				break;
+			case 24:
+			case 32:
+				default_cmode =3D CMODE_32;
+				break;
+			}
+		}
+#endif
+#ifdef CONFIG_ATARI
+		/*
+		 * Why do we need this silly Mach64 argument?
+		 * We are already here because of mach64=3D so its redundant.
+		 */
+		else if (MACH_IS_ATARI
+			 && (!strncmp(this_opt, "Mach64:", 7))) {
+			static unsigned char m64_num;
+			static char mach64_str[80];
+			strlcpy(mach64_str, this_opt + 7, sizeof(mach64_str));
+			if (!store_video_par(mach64_str, m64_num)) {
+				m64_num++;
+				mach64_count =3D m64_num;
+			}
+		}
+#endif
+		else
+			mode =3D this_opt;
+	}
+	return 0;
+}
+
+#ifdef MODULE
+module_init(atyfb_init);
+module_exit(atyfb_exit);
+#endif
+
+MODULE_DESCRIPTION("FBDev driver for ATI Mach64 cards");
 MODULE_LICENSE("GPL");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
+module_param(vram, int, 0);
+MODULE_PARM_DESC(vram, "int: override size of video ram");
+module_param(pll, int, 0);
+MODULE_PARM_DESC(pll, "int: override video clock");
+module_param(mclk, int, 0);
+MODULE_PARM_DESC(mclk, "int: override memory clock");
+module_param(xclk, int, 0);
+MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
+#ifdef CONFIG_PPC
+module_param(vmode, int, 0);
+MODULE_PARM_DESC(vmode, "int: video mode for mac");
+module_param(cmode, int, 0);
+MODULE_PARM_DESC(cmode, "int: color mode for mac");
+#endif
+module_param(mode, charp, 0);
+MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<re=
fresh>]\" ");
diff -ur -X patches/exclude linux-2.6.7.js3/drivers/video/aty/mach64_ct.c l=
inux-2.6.7.ak/drivers/video/aty/mach64_ct.c
=2D-- linux-2.6.7.js3/drivers/video/aty/mach64_ct.c	2004-06-27 01:35:27.000=
000000 +0200
+++ linux-2.6.7.ak/drivers/video/aty/mach64_ct.c	2004-08-04 22:32:10.000000=
000 +0200
@@ -115,7 +115,6 @@
=20
 static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *=
pll)
 {
=2D	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 dsp_off, dsp_on, dsp_xclks;
 	u32 multiplier, divider, ras_multiplier, ras_divider, tmp;
 	u8 vshift, xshift;
@@ -137,6 +136,8 @@
=20
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (pll->xres !=3D 0) {
+		struct atyfb_par *par =3D (struct atyfb_par *) info->par;
+
 		multiplier =3D multiplier * par->lcd_width;
 		divider =3D divider * pll->xres & ~7;
=20
@@ -281,8 +282,8 @@
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table !=3D 0) {
 		/* turn off LCD */
=2D		lcd_gen_cntrl =3D aty_ld_le32(LCD_GEN_CNTL, par);
=2D		aty_st_le32(LCD_GEN_CNTL, lcd_gen_cntrl & ~LCD_ON, par);
+		lcd_gen_cntrl =3D aty_ld_lcd(LCD_GEN_CNTL, par);
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl & ~LCD_ON, par);
 	}
 #endif
 	aty_st_8(CLOCK_CNTL, par->clk_wr_offset | CLOCK_STROBE, par);
@@ -351,12 +352,12 @@
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table !=3D 0) {
 		/* restore LCD */
=2D		aty_st_le32(LCD_GEN_CNTL, lcd_gen_cntrl, par);
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl, par);
 	}
 #endif
 }
=2D#if 0
=2Dvoid aty_get_pll_ct(const struct fb_info *info, union aty_pll *pll)
+
+void __init aty_get_pll_ct(const struct fb_info *info, union aty_pll *pll)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u8 tmp, clock;
@@ -378,7 +379,7 @@
 		pll->ct.dsp_on_off =3D aty_ld_le32(DSP_ON_OFF, par);
 	}
 }
=2D#endif
+
 int __init aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)=
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
@@ -526,10 +527,10 @@
 		__FUNCTION__, pllmclk, pllmclk / pll->ct.xclk_post_div_real);
 #endif
=20
=2D	pll->ct.pll_gen_cntl =3D OSC_EN;
=2D=09
=2D	if (M64_HAS(NO_EXT_PLL))
=2D		pll->ct.pll_gen_cntl |=3D (DLL_PWDN | FORCE_DCLK_TRI_STATE);
+	if (M64_HAS(SDRAM_MAGIC_PLL) && (par->ram_type >=3D SDRAM))
+		pll->ct.pll_gen_cntl =3D OSC_EN;
+	else
+		pll->ct.pll_gen_cntl =3D OSC_EN | DLL_PWDN /* | FORCE_DCLK_TRI_STATE */;
=20
 	if (M64_HAS(MAGIC_POSTDIV))
 		pll->ct.pll_ext_cntl =3D 0;
@@ -608,5 +609,6 @@
 	.var_to_pll	=3D aty_var_to_pll_ct,
 	.pll_to_var	=3D aty_pll_to_var_ct,
 	.set_pll	=3D aty_set_pll_ct,
+	.get_pll	=3D aty_get_pll_ct,
 	.init_pll       =3D aty_init_pll_ct
 };
diff -ur -X patches/exclude linux-2.6.7.js3/drivers/video/aty/mach64_cursor=
=2Ec linux-2.6.7.ak/drivers/video/aty/mach64_cursor.c
=2D-- linux-2.6.7.js3/drivers/video/aty/mach64_cursor.c	2004-06-27 01:35:27=
=2E000000000 +0200
+++ linux-2.6.7.ak/drivers/video/aty/mach64_cursor.c	2004-07-23 23:51:53.00=
0000000 +0200
@@ -71,26 +71,6 @@
 	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
 };	=09
=20
=2Dvoid aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsign=
ed int width)
=2D{
=2D	int i, j, offset =3D info->sprite.scan_align - width*2;
=2D	u8 *mask =3D info->cursor.mask, m, b;
=2D
=2D	for (i =3D 0; i < info->cursor.image.height; i++) {
=2D		for (j =3D 0; j < width; j++) {
=2D			b =3D *src++;
=2D			m =3D *mask++;
=2D			// Upper 4 bits of mask data
=2D			fb_writeb(cursor_mask_lookup[m >> 4 ] |
=2D				  cursor_bits_lookup[(b & m) >> 4], dst++);
=2D			// Lower 4 bits of mask
=2D			fb_writeb(cursor_mask_lookup[m & 0x0f ] |
=2D				  cursor_bits_lookup[(b & m) & 0x0f], dst++);
=2D		}
=2D		dst +=3D offset;
=2D	}
=2D}
=2D
 int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
@@ -176,9 +156,46 @@
 	}
 =09
 	if (cursor->set & FB_CUR_SETSHAPE) {
=2D		// Clear cursor image with 1010101010...=20
=2D		fb_memset(info->sprite.addr, 0xaa, 1024);
=2D		fb_load_cursor_image(info);
+	    u8 *src =3D (u8 *)cursor->image.data;
+	    u8 *msk =3D (u8 *)info->cursor.mask;
+	    u8 *dst =3D (u8 *)info->sprite.addr;
+	    unsigned int width =3D (info->cursor.image.width + 7) >> 3;
+	    unsigned int height =3D info->cursor.image.height;
+	    unsigned int align =3D info->sprite.scan_align;
+	   =20
+	    unsigned int i, j, offset;
+	    u8 m, b;
+
+	    // Clear cursor image with 1010101010...=20
+	    fb_memset(dst, 0xaa, 1024);
+
+	    offset =3D align - width*2;
+
+	    for (i =3D 0; i < height; i++) {
+		for (j =3D 0; j < width; j++) {
+			b =3D *src++;
+			m =3D *msk++;
+			switch (info->cursor.rop) {
+			case ROP_XOR:
+			    // Upper 4 bits of mask data
+			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
+				cursor_bits_lookup[(b ^ m) >> 4], dst++);
+			    // Lower 4 bits of mask
+			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
+				cursor_bits_lookup[(b ^ m) & 0x0f], dst++);
+			    break;
+			case ROP_COPY:
+			    // Upper 4 bits of mask data
+			    fb_writeb(cursor_mask_lookup[m >> 4 ] |
+				cursor_bits_lookup[(b & m) >> 4], dst++);
+			    // Lower 4 bits of mask
+			    fb_writeb(cursor_mask_lookup[m & 0x0f ] |
+				cursor_bits_lookup[(b & m) & 0x0f], dst++);
+			    break;
+			}
+		}
+		dst +=3D offset;
+	    }
 	}=09
 =09
 	if (cursor->enable) {
@@ -210,10 +227,12 @@
 	if (!info->sprite.addr)
 		return -ENXIO;
 	info->sprite.size =3D PAGE_SIZE;
=2D	info->sprite.scan_align =3D 16;	// Scratch pad 64 bytes wide
=2D	info->sprite.buf_align =3D 16; 	// *64;	// and 64 lines tall.
+	info->sprite.scan_align =3D 16;	/* Scratch pad 64 bytes wide */
+	info->sprite.buf_align =3D 16; 	/* and 64 lines tall. */
 	info->sprite.flags =3D FB_PIXMAP_IO;
=2D	info->sprite.outbuf =3D aty_set_cursor_shape;
+=09
+	info->fbops->fb_cursor =3D atyfb_cursor;
+
 	return 0;
 }
=20
diff -ur -X patches/exclude linux-2.6.7.js3/drivers/video/modedb.c linux-2.=
6.7.ak/drivers/video/modedb.c
=2D-- linux-2.6.7.js3/drivers/video/modedb.c	2004-06-16 07:19:22.000000000 =
+0200
+++ linux-2.6.7.ak/drivers/video/modedb.c	2004-07-21 22:05:06.000000000 +02=
00
@@ -16,12 +16,14 @@
 #include <linux/fb.h>
 #include <linux/sched.h>
=20
=2D#undef DEBUG
+#define DEBUG
=20
 #define name_matches(v, s, l) \
     ((v).name && !strncmp((s), (v).name, (l)) && strlen((v).name) =3D=3D (=
l))
 #define res_matches(v, x, y) \
     ((v).xres =3D=3D (x) && (v).yres =3D=3D (y))
+#define refresh_closest_to(v, x, y) \
+    ((!y || (abs((x)->refresh - (v)) < abs((y)->refresh - (v))))?x:y)
=20
 #ifdef DEBUG
 #define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ ,=
 ## args)
@@ -126,16 +128,16 @@
 	0, FB_VMODE_NONINTERLACED
     }, {
 	/* 1400x1050 @ 60Hz, 63.9 kHz hsync */
=2D	NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
=2D	0, FB_VMODE_NONINTERLACED   =09
+	NULL, 60, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
+	0, FB_VMODE_NONINTERLACED
     }, {
=2D	/* 1400x1050 @ 75,107 Hz, 82,392 kHz +hsync +vsync*/
=2D	NULL, 75, 1400, 1050, 9271, 120, 56, 13, 0, 112, 3,
=2D	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	/* 1400x1050 @ 64 Hz, 68.8 kHz */
+        NULL, 64, 1400, 1050, 8197, 184, 28, 10, 2, 152, 12,
+	0, FB_VMODE_NONINTERLACED
     }, {
=2D	/* 1400x1050 @ 60 Hz, ? kHz +hsync +vsync*/
=2D        NULL, 60, 1400, 1050, 9259, 128, 40, 12, 0, 112, 3,
=2D	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	/* 1400x1050 @ 75 Hz, 81,3 kHz */
+	NULL, 75, 1400, 1050, 6418, 128, 64, 26, 2, 320, 12,
+	0, FB_VMODE_NONINTERLACED
     }, {
 	/* 1024x768 @ 85 Hz, 70.24 kHz hsync */
 	NULL, 85, 1024, 768, 10111, 192, 32, 34, 14, 160, 6,
@@ -528,25 +530,44 @@
 	    res_specified =3D 1;
 	}
 done:
=2D	for (i =3D refresh_specified; i >=3D 0; i--) {
=2D	    DPRINTK("Trying specified video mode%s\n",
=2D		    i ? "" : " (ignoring refresh rate)");
=2D	    for (j =3D 0; j < dbsize; j++)
=2D		if ((name_matches(db[j], name, namelen) ||
=2D		     (res_specified && res_matches(db[j], xres, yres))) &&
=2D		    (!i || db[j].refresh =3D=3D refresh) &&
=2D		    !fb_try_mode(var, info, &db[j], bpp))
=2D		    return 2-i;
+	{
+	    if(refresh_specified) {
+		const struct fb_videomode *na =3D 0; /* nearest accepted with given refr=
eshrate */
+	       =20
+		DPRINTK("Trying all video modes with refresh rate %i\n", refresh);
+
+		for(j =3D 0; j < dbsize; j++) {
+		    if((name_matches(db[j], name, namelen) || (res_specified && res_matc=
hes(db[j], xres, yres)))) {
+			if(!fb_try_mode(var, info, &db[j], bpp)) {
+			    na =3D refresh_closest_to(refresh, &db[j], na);
+			}
+		    }
+		}
+		if(na) {
+		    DPRINTK("Try the winner %ix%i@%i one more time\n", na->xres, na->yre=
s, na->refresh);
+		    if(!fb_try_mode(var, info, na, bpp))
+	    	    	return 1;
+		}
+	    } else {
+		DPRINTK("Trying specified video mode(ignoring refresh rate), first win\n=
");
+		for(j =3D 0; j < dbsize; j++) {
+		    if((name_matches(db[j], name, namelen) || (res_specified && res_matc=
hes(db[j], xres, yres)))) {
+			if(!fb_try_mode(var, info, &db[j], bpp)) {
+			    return 2;
+			}
+		    }
+		}
+	    }
 	}
     }
=20
     DPRINTK("Trying default video mode\n");
=2D    if (!fb_try_mode(var, info, default_mode, default_bpp))
+    if(!fb_try_mode(var, info, default_mode, default_bpp))
 	return 3;
=20
     DPRINTK("Trying all modes\n");
=2D    for (i =3D 0; i < dbsize; i++)
=2D	if (!fb_try_mode(var, info, &db[i], default_bpp))
+    for(i =3D 0; i < dbsize; i++)
+	if(!fb_try_mode(var, info, &db[i], default_bpp))
 	    return 4;
=20
     DPRINTK("No valid mode found\n");

--Boundary-00=_hCyEBE65fg/efcr
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="mach64-js3-ak6b.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mach64-js3-ak6b.diff"

diff -ur -X patches/exclude linux-2.6.7.js3/include/video/mach64.h linux-2.=
6.7.ak/include/video/mach64.h
=2D-- linux-2.6.7.js3/include/video/mach64.h	2004-06-27 01:35:27.000000000 =
+0200
+++ linux-2.6.7.ak/include/video/mach64.h	2004-07-28 21:55:35.000000000 +02=
00
@@ -68,6 +68,8 @@
=20
 #define I2C_CNTL_0		0x003C	/* Dword offset 0_0F */
=20
+#define DSTN_CONTROL_LG		0x003C	/* Dword offset 0_0F (LG) */
+
 /* Overscan */
 #define OVR_CLR			0x0040	/* Dword offset 0_10 */
 #define OVR2_CLR		0x0040	/* Dword offset 0_10 */
@@ -101,7 +103,7 @@
 #define CUR_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
 #define CUR2_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
=20
=2D#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D */
+#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D (LG) */
=20
 /* General I/O Control */
 #define GP_IO			0x0078	/* Dword offset 0_1E */
@@ -153,6 +155,8 @@
 #define LCD_INDEX		0x00A4	/* Dword offset 0_29 */
 #define LCD_DATA		0x00A8	/* Dword offset 0_2A */
=20
+#define HFB_PITCH_ADDR_LG	0x00A8	/* Dword offset 0_2A (LG) */
+
 /* Memory Control */
 #define EXT_MEM_CNTL		0x00AC	/* Dword offset 0_2B */
 #define MEM_CNTL		0x00B0	/* Dword offset 0_2C */
@@ -161,6 +165,8 @@
=20
 #define I2C_CNTL_1		0x00BC	/* Dword offset 0_2F */
=20
+#define LT_GIO_LG		0x00BC	/* Dword offset 0_2F (LG) */
+
 /* DAC Control */
 #define DAC_REGS		0x00C0	/* Dword offset 0_30 */
 #define DAC_W_INDEX		0x00C0	/* Dword offset 0_30 */
@@ -171,14 +177,16 @@
=20
 #define EXT_DAC_REGS		0x00C8	/* Dword offset 0_32 */
=20
+#define HORZ_STRETCHING_LG	0x00C8	/* Dword offset 0_32 (LG) */
+#define VERT_STRETCHING_LG	0x00CC	/* Dword offset 0_33 (LG) */
+
 /* Test and Debug */
 #define GEN_TEST_CNTL		0x00D0	/* Dword offset 0_34 */
=20
 /* Custom Macros */
 #define CUSTOM_MACRO_CNTL	0x00D4	/* Dword offset 0_35 */
=20
=2D#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 */
=2D
+#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 (LG) */
 #define POWER_MANAGEMENT_LG	0x00D8	/* Dword offset 0_36 (LG) */
=20
 /* Configuration */
@@ -508,7 +516,7 @@
 #define SCALER_BUF0_OFFSET_V	0x05D8	/* Dword offset 1_76 */
 #define SCALER_BUF1_OFFSET_U	0x05DC	/* Dword offset 1_77 */
 #define SCALER_BUF1_OFFSET_V	0x05E0	/* Dword offset 1_78 */
=2D
+   =20
 /* Setup Engine */
 #define VERTEX_1_S		0x0640	/* Dword offset 1_90 */
 #define VERTEX_1_T		0x0644	/* Dword offset 1_91 */
@@ -622,10 +630,70 @@
 #define CRTC_CUR_B_TEST		0x80000000
=20
 #define CRTC_CRNT_VLINE		0x07f00000
=2D#define CRTC_VBLANK		0x00000001
=20
 #define CRTC_PRESERVED_MASK	0x0001f000
=20
+#define CRTC_VBLANK		0x00000001
+#define CRTC_VBLANK_INT_EN	0x00000002
+#define CRTC_VBLANK_INT		0x00000004
+#define CRTC_VBLANK_INT_AK	CRTC_VBLANK_INT
+#define CRTC_VLINE_INT_EN	0x00000008
+#define CRTC_VLINE_INT		0x00000010
+#define CRTC_VLINE_INT_AK	CRTC_VLINE_INT
+#define CRTC_VLINE_SYNC		0x00000020
+#define CRTC_FRAME		0x00000040
+#define SNAPSHOT_INT_EN		0x00000080
+#define SNAPSHOT_INT		0x00000100
+#define SNAPSHOT_INT_AK		SNAPSHOT_INT
+#define I2C_INT_EN		0x00000200
+#define I2C_INT			0x00000400
+#define I2C_INT_AK		I2C_INT
+#define CRTC2_VBLANK		0x00000800
+#define CRTC2_VBLANK_INT_EN	0x00001000
+#define CRTC2_VBLANK_INT	0x00002000
+#define CRTC2_VBLANK_INT_AK	CRTC2_VBLANK_INT
+#define CRTC2_VLINE_INT_EN	0x00004000
+#define CRTC2_VLINE_INT		0x00008000
+#define CRTC2_VLINE_INT_AK	CRTC2_VLINE_INT
+#define CAPBUF0_INT_EN		0x00010000
+#define CAPBUF0_INT		0x00020000
+#define CAPBUF0_INT_AK		CAPBUF0_INT
+#define CAPBUF1_INT_EN		0x00040000
+#define CAPBUF1_INT		0x00080000
+#define CAPBUF1_INT_AK		CAPBUF1_INT
+#define OVERLAY_EOF_INT_EN	0x00100000
+#define OVERLAY_EOF_INT		0x00200000
+#define OVERLAY_EOF_INT_AK	OVERLAY_EOF_INT
+#define ONESHOT_CAP_INT_EN	0x00400000
+#define ONESHOT_CAP_INT		0x00800000
+#define ONESHOT_CAP_INT_AK	ONESHOT_CAP_INT
+#define BUSMASTER_EOL_INT_EN	0x01000000
+#define BUSMASTER_EOL_INT	0x02000000
+#define BUSMASTER_EOL_INT_AK	BUSMASTER_EOL_INT
+#define GP_INT_EN		0x04000000
+#define GP_INT			0x08000000
+#define GP_INT_AK		GP_INT
+#define CRTC2_VLINE_SYNC	0x10000000
+#define SNAPSHOT2_INT_EN	0x20000000
+#define SNAPSHOT2_INT		0x40000000
+#define SNAPSHOT2_INT_AK	SNAPSHOT2_INT
+#define VBLANK_BIT2_INT		0x80000000
+#define VBLANK_BIT2_INT_AK	VBLANK_BIT2_INT
+
+#define CRTC_INT_EN_MASK	(CRTC_VBLANK_INT_EN |	\
+				 CRTC_VLINE_INT_EN |	\
+				 SNAPSHOT_INT_EN |	\
+				 I2C_INT_EN |		\
+				 CRTC2_VBLANK_INT_EN |	\
+				 CRTC2_VLINE_INT_EN |	\
+				 CAPBUF0_INT_EN |	\
+				 CAPBUF1_INT_EN |	\
+				 OVERLAY_EOF_INT_EN |	\
+				 ONESHOT_CAP_INT_EN |	\
+				 BUSMASTER_EOL_INT_EN |	\
+				 GP_INT_EN |		\
+				 SNAPSHOT2_INT_EN)
+
 /* DAC control values */
=20
 #define DAC_EXT_SEL_RS2		0x01
@@ -640,6 +708,24 @@
 #define DAC_BLANK_ADJ_1		0x00000800
 #define DAC_BLANK_ADJ_2		0x00001000
=20
+/* DAC control values (my source XL/XC Register reference) */
+#define DAC_OUTPUT_MASK         0x00000001  /* 0 - PAL, 1 - NTSC */
+#define DAC_MISTERY_BIT         0x00000002  /* PS2 ? RS343 ?, EXTRA_BRIGHT=
 for GT */
+#define DAC_BLANKING            0x00000004
+#define DAC_CMP_DISABLE         0x00000008
+#define DAC1_CLK_SEL            0x00000010
+#define PALETTE_ACCESS_CNTL     0x00000020
+#define PALETTE2_SNOOP_EN       0x00000040
+#define DAC_CMP_OUTPUT          0x00000080 /* read only */
+/* #define DAC_8BIT_EN is ok */
+#define CRT_SENSE               0x00000800 /* read only */
+#define CRT_DETECTION_ON        0x00001000
+#define DAC_VGA_ADR_EN          0x00002000
+#define DAC_FEA_CON_EN          0x00004000
+#define DAC_PDWN                0x00008000
+#define DAC_TYPE_MASK           0x00070000 /* read only */
+               =20
+
=20
 /* Mix control values */
=20
@@ -912,10 +998,14 @@
 #define GI_CHIP_ID	0x4749	/* RAGE PRO, BGA, PCI33 only */
 #define GP_CHIP_ID	0x4750	/* RAGE PRO, PQFP, PCI33, full 3D */
 #define GQ_CHIP_ID	0x4751	/* RAGE PRO, PQFP, PCI33, limited 3D */
=2D#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility PCI */
=2D#define LN_CHIP_ID	0x4c4e	/* RAGE Mobility AGP */
=20
+#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility AGP, full function */
+#define LN_CHIP_ID	0x4c4e	/* RAGE Mobility AGP */
+#define LR_CHIP_ID	0x4c52	/* RAGE Mobility PCI, full function */
+#define LS_CHIP_ID	0x4c53	/* RAGE Mobility PCI */
=20
+#define IS_MOBILITY(id) ((id)=3D=3DLM_CHIP_ID || (id)=3D=3DLN_CHIP_ID || \
+			(id)=3D=3DLR_CHIP_ID || (id)=3D=3DLS_CHIP_ID)
 /* Mach64 major ASIC revisions */
 #define MACH64_ASIC_NEC_VT_A3		0x08
 #define MACH64_ASIC_NEC_VT_A4		0x48

--Boundary-00=_hCyEBE65fg/efcr--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
