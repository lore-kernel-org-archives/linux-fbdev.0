From: syrjala@sci.fi
Subject: [PATCH 8/8] atyfb: Resume chip
Date: Thu, 17 Mar 2005 08:31:05 +0200 (EET)
Message-ID: <20050317063105.5853B7A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXD-0006Fp-Ge
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXC-00049g-7I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de

This patch makes suspend-to-ram work on my HP OmniBook 6000 laptop when 
used with the acpi_sleep=s3_bios kernel option.

Some register were only set in aty_init() so I added the aty_resume_chip() 
function to reset those registers on resume.

Calling aty_power_mgmt() makes the suspend fail so I moved those calls 
under CONFIG_PMAC_PPC.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb.h      |    2 ++
 atyfb_base.c |   56 +++++++++++++++++++++++++++++++++++++++++++-------------
 mach64_ct.c  |   49 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 77 insertions(+), 30 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:37:14.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 20:02:44.000000000 +0200
@@ -253,6 +253,7 @@
      */
 
 static int aty_init(struct fb_info *info, const char *name);
+static int aty_resume_chip(struct fb_info *info);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -1992,6 +1993,7 @@
 
 #if defined(CONFIG_PM) && defined(CONFIG_PCI)
 
+#ifdef CONFIG_PPC_PMAC
 /* Power management routines. Those are used for PowerBook sleep.
  */
 static int aty_power_mgmt(int sleep, struct atyfb_par *par)
@@ -2048,6 +2050,7 @@
 
 	return timeout ? 0 : -EIO;
 }
+#endif
 
 static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
@@ -2062,9 +2065,12 @@
 	 */
 	if (state >= 3)
 		state = 2;
+
+	if (state != 2)
+		return 0;
 #endif /* CONFIG_PPC_PMAC */
 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state == pdev->dev.power.power_state)
 		return 0;
 
 	acquire_console_sem();
@@ -2081,6 +2087,7 @@
 	par->asleep = 1;
 	par->lock_blank = 1;
 
+#ifdef CONFIG_PPC_PMAC
 	/* Set chip to "suspend" mode */
 	if (aty_power_mgmt(1, par)) {
 		par->asleep = 0;
@@ -2090,6 +2097,7 @@
 		release_console_sem();
 		return -EIO;
 	}
+#endif
 
 	release_console_sem();
 
@@ -2108,8 +2116,12 @@
 
 	acquire_console_sem();
 
+#ifdef CONFIG_PPC_PMAC
 	if (pdev->dev.power.power_state == 2)
 		aty_power_mgmt(0, par);
+#else
+	aty_resume_chip(info);
+#endif
 	par->asleep = 0;
 
 	/* Restore display */
@@ -2211,7 +2223,6 @@
 	int gtb_memsize;
 	struct fb_var_screeninfo var;
 	u8 pll_ref_div;
-	u32 i;
 #if defined(CONFIG_PPC)
 	int sense;
 #endif
@@ -2344,10 +2355,10 @@
 	if(par->pll_ops->get_pll)
 		par->pll_ops->get_pll(info, &saved_pll);
 
-	i = aty_ld_le32(MEM_CNTL, par);
+	par->mem_cntl = aty_ld_le32(MEM_CNTL, par);
 	gtb_memsize = M64_HAS(GTB_DSP);
 	if (gtb_memsize)
-		switch (i & 0xF) {	/* 0xF used instead of MEM_SIZE_ALIAS */
+		switch (par->mem_cntl & 0xF) {	/* 0xF used instead of MEM_SIZE_ALIAS */
 		case MEM_SIZE_512K:
 			info->fix.smem_len = 0x80000;
 			break;
@@ -2369,7 +2380,7 @@
 		default:
 			info->fix.smem_len = 0x80000;
 	} else
-		switch (i & MEM_SIZE_ALIAS) {
+		switch (par->mem_cntl & MEM_SIZE_ALIAS) {
 		case MEM_SIZE_512K:
 			info->fix.smem_len = 0x80000;
 			break;
@@ -2399,20 +2410,20 @@
 
 	if (vram) {
 		info->fix.smem_len = vram * 1024;
-		i = i & ~(gtb_memsize ? 0xF : MEM_SIZE_ALIAS);
+		par->mem_cntl = par->mem_cntl & ~(gtb_memsize ? 0xF : MEM_SIZE_ALIAS);
 		if (info->fix.smem_len <= 0x80000)
-			i |= MEM_SIZE_512K;
+			par->mem_cntl |= MEM_SIZE_512K;
 		else if (info->fix.smem_len <= 0x100000)
-			i |= MEM_SIZE_1M;
+			par->mem_cntl |= MEM_SIZE_1M;
 		else if (info->fix.smem_len <= 0x200000)
-			i |= gtb_memsize ? MEM_SIZE_2M_GTB : MEM_SIZE_2M;
+			par->mem_cntl |= gtb_memsize ? MEM_SIZE_2M_GTB : MEM_SIZE_2M;
 		else if (info->fix.smem_len <= 0x400000)
-			i |= gtb_memsize ? MEM_SIZE_4M_GTB : MEM_SIZE_4M;
+			par->mem_cntl |= gtb_memsize ? MEM_SIZE_4M_GTB : MEM_SIZE_4M;
 		else if (info->fix.smem_len <= 0x600000)
-			i |= gtb_memsize ? MEM_SIZE_6M_GTB : MEM_SIZE_6M;
+			par->mem_cntl |= gtb_memsize ? MEM_SIZE_6M_GTB : MEM_SIZE_6M;
 		else
-			i |= gtb_memsize ? MEM_SIZE_8M_GTB : MEM_SIZE_8M;
-		aty_st_le32(MEM_CNTL, i, par);
+			par->mem_cntl |= gtb_memsize ? MEM_SIZE_8M_GTB : MEM_SIZE_8M;
+		aty_st_le32(MEM_CNTL, par->mem_cntl, par);
 	}
 
 	/*
@@ -2458,6 +2469,8 @@
 #endif
 	if(par->pll_ops->init_pll)
 		par->pll_ops->init_pll(info, &par->pll);
+	if(par->pll_ops->resume_pll)
+		par->pll_ops->resume_pll(info, &par->pll);
 
 	/*
 	 *  Last page of 8 MB (4 MB on ISA) aperture is MMIO
@@ -2611,6 +2624,23 @@
 	return -1;
 }
 
+static int aty_resume_chip(struct fb_info *info)
+{
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+	int gtb_memsize;
+	u32 i;
+
+	aty_st_le32(MEM_CNTL, par->mem_cntl, par);
+
+	if(par->pll_ops->resume_pll)
+		par->pll_ops->resume_pll(info, &par->pll);
+
+	if (par->aux_start)
+		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
+
+	return 0;
+}
+
 #ifdef CONFIG_ATARI
 static int __init store_video_par(char *video_str, unsigned char m64_num)
 {
diff -urN linux/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux/drivers/video/aty/atyfb.h	2005-03-16 19:27:41.000000000 +0200
+++ linux/drivers/video/aty/atyfb.h	2005-03-16 19:51:24.000000000 +0200
@@ -186,6 +186,7 @@
 	int mtrr_aper;
 	int mtrr_reg;
 #endif
+	u32 mem_cntl;
 };
 
     /*
@@ -315,6 +316,7 @@
 	void (*set_pll)   (const struct fb_info * info, const union aty_pll * pll);
 	void (*get_pll)   (const struct fb_info *info, union aty_pll * pll);
 	int (*init_pll)   (const struct fb_info * info, union aty_pll * pll);
+	int (*resume_pll) (const struct fb_info * info, union aty_pll * pll);
 };
 
 extern const struct aty_pll_ops aty_pll_ati18818_1; /* ATI 18818 */
diff -urN linux/drivers/video/aty/mach64_ct.c linux/drivers/video/aty/mach64_ct.c
--- linux/drivers/video/aty/mach64_ct.c	2005-03-16 19:42:53.000000000 +0200
+++ linux/drivers/video/aty/mach64_ct.c	2005-03-16 19:56:49.000000000 +0200
@@ -398,8 +398,8 @@
 				 union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
-	u32 q, i, memcntl, trp;
+	u8 mpost_div, xpost_div, sclk_post_div_real;
+	u32 q, memcntl, trp;
 	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
 #ifdef DEBUG
 	int pllmclk, pllsclk;
@@ -575,23 +575,39 @@
 			mpost_div += (q <  32*8);
 		}
 		sclk_post_div_real = postdividers[mpost_div];
-		sclk_fb_div = q * sclk_post_div_real / 8;
-		spll_cntl2 = mpost_div << 4;
+		pll->ct.sclk_fb_div = q * sclk_post_div_real / 8;
+		pll->ct.spll_cntl2 = mpost_div << 4;
 #ifdef DEBUG
-		pllsclk = (1000000 * 2 * sclk_fb_div) /
+		pllsclk = (1000000 * 2 * pll->ct.sclk_fb_div) /
 			(par->ref_clk_per * pll->ct.pll_ref_div);
 		printk("atyfb(%s): use sclk, pllsclk=%d MHz, sclk=mclk=%d MHz\n",
 			__FUNCTION__, pllsclk, pllsclk / sclk_post_div_real);
 #endif
+	}
+
+	/* Disable the extra precision pixel clock controls since we do not use them. */
+	pll->ct.ext_vpll_cntl = aty_ld_pll_ct(EXT_VPLL_CNTL, par);
+	pll->ct.ext_vpll_cntl &= ~(EXT_VPLL_EN | EXT_VPLL_VGA_EN | EXT_VPLL_INSYNC);
+
+	return 0;
+}
+
+static int __init aty_resume_pll_ct(const struct fb_info *info,
+				    union aty_pll *pll)
+{
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+
+	if (par->mclk_per != par->xclk_per) {
+		int i;
 		/*
-		* This disables the sclk, crashes the computer as reported:
-		* aty_st_pll_ct(SPLL_CNTL2, 3, info);
-		*
-		* So it seems the sclk must be enabled before it is used;
-		* so PLL_GEN_CNTL must be programmed *after* the sclk.
-		*/
-		aty_st_pll_ct(SCLK_FB_DIV, sclk_fb_div, par);
-		aty_st_pll_ct(SPLL_CNTL2, spll_cntl2, par);
+		 * This disables the sclk, crashes the computer as reported:
+		 * aty_st_pll_ct(SPLL_CNTL2, 3, info);
+		 *
+		 * So it seems the sclk must be enabled before it is used;
+		 * so PLL_GEN_CNTL must be programmed *after* the sclk.
+		 */
+		aty_st_pll_ct(SCLK_FB_DIV, pll->ct.sclk_fb_div, par);
+		aty_st_pll_ct(SPLL_CNTL2, pll->ct.spll_cntl2, par);
 		/*
 		 * The sclk has been started. However, I believe the first clock
 		 * ticks it generates are not very stable. Hope this primitive loop
@@ -605,9 +621,7 @@
 	aty_st_pll_ct(PLL_GEN_CNTL, pll->ct.pll_gen_cntl, par);
 	aty_st_pll_ct(MCLK_FB_DIV, pll->ct.mclk_fb_div, par);
 	aty_st_pll_ct(PLL_EXT_CNTL, pll->ct.pll_ext_cntl, par);
-	/* Disable the extra precision pixel clock controls since we do not use them. */
-	aty_st_pll_ct(EXT_VPLL_CNTL, aty_ld_pll_ct(EXT_VPLL_CNTL, par) &
-		~(EXT_VPLL_EN | EXT_VPLL_VGA_EN | EXT_VPLL_INSYNC), par);
+	aty_st_pll_ct(EXT_VPLL_CNTL, pll->ct.ext_vpll_cntl, par);
 
 	return 0;
 }
@@ -626,5 +640,6 @@
 	.pll_to_var	= aty_pll_to_var_ct,
 	.set_pll	= aty_set_pll_ct,
 	.get_pll	= aty_get_pll_ct,
-	.init_pll       = aty_init_pll_ct
+	.init_pll	= aty_init_pll_ct,
+	.resume_pll	= aty_resume_pll_ct,
 };



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
