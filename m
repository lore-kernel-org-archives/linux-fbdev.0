From: Alexander Kern <alex.kern@gmx.de>
Subject: addition to mach64.diff
Date: Sat, 13 Mar 2004 20:46:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403132046.56579.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wU2UAyM4mIhOZPo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2F6N-0001wX-G1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Mar 2004 11:47:19 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B2F6K-00030b-Vg
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Mar 2004 11:47:17 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--Boundary-00=_wU2UAyM4mIhOZPo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello James,

here two additions from me,

first, one more define in include/video/mach64.h

second, improvements in code, tested with mach64 Mobility on my ARMADA.

P.S. Changes proposed by BenH are not here, wait_for_idle on the end of each 
accelerated function, causes a freeze by me ;-( 

--Boundary-00=_wU2UAyM4mIhOZPo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mach64-include.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mach64-include.diff"

--- linux-2.6.4/include/video/mach64.h	2004-03-11 16:47:33.000000000 +0100
+++ linux-2.6.js/include/video/mach64.h	2004-03-05 22:55:02.000000000 +0100
@@ -669,6 +669,7 @@
 /* Mach64 engine bit constants - these are typically ORed together */
 
 /* BUS_CNTL register constants */
+#define BUS_APER_REG_DIS	0x00000010
 #define BUS_FIFO_ERR_ACK	0x00200000
 #define BUS_HOST_ERR_ACK	0x00800000
 

--Boundary-00=_wU2UAyM4mIhOZPo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mach64-add.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mach64-add.diff"

diff -U 3 -H -d -p -r -N -- linux-2.6.4/drivers/video/aty/atyfb.h linux-2.6.alex/drivers/video/aty/atyfb.h
--- linux-2.6.4/drivers/video/aty/atyfb.h	2004-03-11 16:47:33.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb.h	2004-03-13 21:27:34.000000000 +0100
@@ -168,6 +168,7 @@ struct atyfb_par {
 #define M64F_LT_SLEEP		0x00040000
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
+#define M64F_NO_HW_TRIPLE	0x00200000
 
     /*
      *  Register access
diff -U 3 -H -d -p -r -N -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-11 16:47:33.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-13 21:23:57.000000000 +0100
@@ -125,6 +125,7 @@ static u32 aty_ld_lcd(int index, const s
 	/* read the register value */
 	return aty_ld_le32(LCD_DATA, par);
 }
+#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
 
 /*
  * ATIReduceRatio --
@@ -149,8 +150,6 @@ static void ATIReduceRatio(int *Numerato
     *Denominator /= Divider;
 }
 
-#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
-
     /*
      *  The Hardware parameters for each card
      */
@@ -235,6 +234,12 @@ struct fb_var_screeninfo default_var = {
 	0, FB_VMODE_NONINTERLACED
 };
 
+static struct fb_videomode defmode = {
+	/* 640x480 @ 60 Hz, 31.5 kHz hsync */
+	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
+	0, FB_VMODE_NONINTERLACED
+};
+
 static struct fb_ops atyfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= atyfb_open,
@@ -316,36 +321,38 @@ static struct {
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
-	{ 0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX },
-	{ 0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX },
+	{ 0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
+	{ 0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
 	/* Mach64 CT */
-	{ 0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
-	{ 0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+	{ 0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
+	{ 0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
 
 	/* Mach64 VT */
-	{ 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
-	{ 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
-	{ 0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
-	{ 0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
-	{ 0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
+	{ 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+	{ 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_MAGIC_POSTDIV },
+	{ 0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+	{ 0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_SDRAM_MAGIC_PLL },
+	{ 0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+
+	/* Mach64 LT */
+	{ 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+	{ 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 | M64F_NO_HW_TRIPLE },
 
 	/* Mach64 GT (3D RAGE) */
-	{ 0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
-	{ 0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+	{ 0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+
+	/* Mach64 RAGE 3D IIc, first chip with hardware tripple */
 	{ 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x4759, 0x4759, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
-	/* Mach64 LT */
-	{ 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
-	{ 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
-
 	/* Mach64 GTC (3D RAGE PRO) */
 	{ 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x4744, 0x4744, 0x00, 0x00, m64n_gtc_ba1, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
@@ -404,6 +411,22 @@ static char *aty_ct_ram[8] __initdata = 
 };
 #endif /* CONFIG_FB_ATY_CT */
 
+static u32 atyfb_get_pixclock(struct fb_var_screeninfo *var, struct atyfb_par *par)
+{
+	u32 pixclock = var->pixclock;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 lcd_on_off;
+	par->pll.ct.xres = 0;
+	if (par->lcd_table != 0) {
+		lcd_on_off = aty_ld_lcd(LCD_GEN_CNTL, par);
+		if(lcd_on_off & LCD_ON) {
+			par->pll.ct.xres = var->xres;
+			pixclock = par->lcd_pixclock;
+		}
+	}
+#endif
+	return pixclock;
+}
 
 #if defined(CONFIG_PPC)
 
@@ -578,9 +601,11 @@ static int aty_var_to_crtc(const struct 
 	u32 sync, vmode;
 	u32 h_total, h_disp, h_sync_strt, h_sync_end, h_sync_dly, h_sync_wid, h_sync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_end, v_sync_wid, v_sync_pol, c_sync;
-	u32 pix_width, dp_pix_width, dp_chain_mask, lcd_on_off = 0;
-	int VScan = 1, VScanmode = 0;
-
+	u32 pix_width, dp_pix_width, dp_chain_mask;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	int VScan = 1;
+	u32 lcd_on_off = 0;
+#endif
 	/* input */
 	xres = var->xres;
 	yres = var->yres;
@@ -691,7 +716,11 @@ static int aty_var_to_crtc(const struct 
 		v_sync_end = v_sync_strt + par->lcd_vsync_len / VScan;
 		v_total = v_disp + par->lcd_vblank_len / VScan;
 	} else {
-#endif
+#endif /* CONFIG_FB_ATY_GENERIC_LCD */
+		if((xres > 1600) || (yres > 1200)) {
+		    FAIL("MACH64 chips are designed for max 1600x1200\n"
+			"select anoter resolution.");
+		}
 		h_sync_strt = h_disp + var->right_margin;
 		h_sync_end = h_sync_strt + var->hsync_len;
 		h_sync_dly  = var->right_margin & 7;
@@ -715,7 +744,7 @@ static int aty_var_to_crtc(const struct 
 	FAIL_MAX("h_sync_wid too large", h_sync_wid, 0x1f);
 	FAIL_MAX("h_total too large", h_total, 0x1ff);
 
-	if (vmode & FB_VMODE_DOUBLE || VScanmode > 1) {
+	if (vmode & FB_VMODE_DOUBLE) {
 		v_disp <<= 1;
 		v_sync_strt <<= 1;
 		v_sync_end <<= 1;
@@ -777,7 +806,7 @@ static int aty_var_to_crtc(const struct 
 	crtc->gen_cntl |= CRTC_VGA_LINEAR;
 
 	/* Enable doublescan mode if requested */
-	if (vmode & FB_VMODE_DOUBLE || VScanmode > 1)
+	if (vmode & FB_VMODE_DOUBLE)
 		crtc->gen_cntl |= CRTC_DBL_SCAN_EN;
 	/* Enable interlaced mode if requested */
 	if (vmode & FB_VMODE_INTERLACED)
@@ -787,8 +816,6 @@ static int aty_var_to_crtc(const struct 
 		int VDisplay = yres;
 		if(vmode & FB_VMODE_DOUBLE)
 			VDisplay <<= 1;
-		if(VScanmode > 1)
-			VDisplay *= VScanmode;
 		if(vmode & FB_VMODE_INTERLACED) {
 			VDisplay >>= 1;
 
@@ -804,14 +831,10 @@ static int aty_var_to_crtc(const struct 
 		crtc->lcd_gen_cntl &= ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 | SCLK_SEL | USE_SHADOWED_VEND | SHADOW_EN);
 		crtc->lcd_gen_cntl |= (DONT_SHADOW_VPAR);
 */
-		if(1) { /* only LT PRO and newer */
-			crtc->horz_stretching = aty_ld_lcd(HORZ_STRETCHING, par);
-			crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par) &
-				~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
-		} else { /* LT*/
-			/* crtc->horz_stretching = aty_ld_le32(LCD_HORZ_STRETCHING, par); */
-			FAIL("LT unsupported");
-		}
+		/* MOBILITY M1 tested, FIXME: LT */
+		crtc->horz_stretching = aty_ld_lcd(HORZ_STRETCHING, par);
+		crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par) &
+			~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
 
 		crtc->horz_stretching &=
 			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
@@ -1076,17 +1099,8 @@ static int atyfb_set_par(struct fb_info 
 	if ((err = aty_var_to_crtc(info, var, &par->crtc)))
 		return err;
 
-	pixclock = var->pixclock;
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
-	par->pll.ct.xres = 0;
-	if (par->lcd_table != 0) {
-		tmp = aty_ld_lcd(LCD_GEN_CNTL, par);
-		if(tmp & LCD_ON) {
-			par->pll.ct.xres = var->xres;
-			pixclock = par->lcd_pixclock;
-		}
-	}
-#endif
+	pixclock = atyfb_get_pixclock(var, par);
+
 	if (pixclock == 0) {
 		FAIL("Invalid pixclock");
 	} else {
@@ -1111,7 +1125,7 @@ static int atyfb_set_par(struct fb_info 
 		pixclock_in_ps = 0;
 
 	if(0 == pixclock_in_ps) {
-		printk("ALERT ops->pll_to_var get 0\n");
+		printk(KERN_CRIT "ALERT ops->pll_to_var get 0\n");
 		pixclock_in_ps = pixclock;
 	}
 
@@ -1274,24 +1288,15 @@ static int atyfb_check_var(struct fb_var
 	int err;
 	struct crtc crtc;
 	union aty_pll pll;
-	u32 pixclock, lcd_on_off;
+	u32 pixclock;
 
 	memcpy(&pll, &(par->pll), sizeof(pll));
 
 	if((err = aty_var_to_crtc(info, var, &crtc)))
 		return err;
 
-	pixclock = var->pixclock;
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
-	pll.ct.xres = 0;
-	if (par->lcd_table != 0) {
-		lcd_on_off = aty_ld_lcd(LCD_GEN_CNTL, par);
-		if(lcd_on_off & LCD_ON) {
-			pll.ct.xres = var->xres;
-			pixclock = par->lcd_pixclock;
-		}
-	}
-#endif
+	pixclock = atyfb_get_pixclock(var, par);
+
 	if (pixclock == 0) {
 		FAIL("Invalid pixclock");
 	} else {
@@ -1394,6 +1399,8 @@ static int atyfb_pan_display(struct fb_v
 
 	xres = (((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8;
 	yres = ((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1;
+	if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+		yres >>= 1;
 	xoffset = (var->xoffset + 7) & ~7;
 	yoffset = var->yoffset;
 	if (xoffset + xres > par->crtc.vxres || yoffset + yres > par->crtc.vyres)
@@ -2168,8 +2175,7 @@ static int __init aty_init(struct fb_inf
 		info->fix.mmio_start = -0x400;
 		info->fix.mmio_len = 0x800;
 		info->fix.accel = FB_ACCEL_ATI_MACH64VT;
-	} else {		/* if (M64_HAS(GT)) */
-
+	} else {/* GT */
 		info->fix.mmio_start = -0x400;
 		info->fix.mmio_len = 0x800;
 		info->fix.accel = FB_ACCEL_ATI_MACH64GT;
@@ -2180,8 +2186,7 @@ static int __init aty_init(struct fb_inf
 	       info->fix.smem_len == 0x80000 ? 'K' : 'M', ramname, xtal, pll,
 	       mclk, xclk);
 
-#ifdef DEBUG
-#ifdef CONFIG_ATY_CT	
+#if defined(DEBUG) && defined(CONFIG_ATY_CT)
 	if (M64_HAS(INTEGRATED)) {
 		int i;
 		printk("BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL "
@@ -2197,7 +2202,6 @@ static int __init aty_init(struct fb_inf
 		printk("\n");
 	}
 #endif
-#endif	
 	if(par->pll_ops->init_pll)
 		par->pll_ops->init_pll(info, &par->pll);
 
@@ -2224,14 +2228,10 @@ static int __init aty_init(struct fb_inf
 		aty_st_lcd(POWER_MANAGEMENT,
 			   aty_ld_lcd(POWER_MANAGEMENT, par)
 			   | (USE_F32KHZ | TRISTATE_MEM_EN), par);
-	}
-	if (M64_HAS(MOBIL_BUS))
+	} else if (M64_HAS(MOBIL_BUS))
 		register_backlight_controller(&aty_backlight_controller, info, "ati");
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-#ifdef MODULE
-	var = default_var;
-#else /* !MODULE */
 	memset(&var, 0, sizeof(var));
 #ifdef CONFIG_PPC
 	if (_machine == _MACH_Pmac) {
@@ -2240,8 +2240,7 @@ static int __init aty_init(struct fb_inf
 		 *         applies to all Mac video cards
 		 */
 		if (mode_option) {
-			if (!mac_find_mode
-			    (&var, info, mode_option, 8))
+			if (!mac_find_mode(&var, info, mode_option, 8))
 				var = default_var;
 		} else {
 			if (default_vmode == VMODE_CHOOSE) {
@@ -2257,38 +2256,21 @@ static int __init aty_init(struct fb_inf
 				else
 					default_vmode = VMODE_640_480_67;
 				sense = read_aty_sense(par);
-				printk(KERN_INFO
-				       "atyfb: monitor sense=%x, mode %d\n",
-				       sense,
-				       mac_map_monitor_sense(sense));
+				printk(KERN_INFO "atyfb: monitor sense=%x, mode %d\n",
+					sense,  mac_map_monitor_sense(sense));
 			}
-			if (default_vmode <= 0
-			    || default_vmode > VMODE_MAX)
+			if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 				default_vmode = VMODE_640_480_60;
-			if (default_cmode < CMODE_8
-			    || default_cmode > CMODE_32)
+			if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 				default_cmode = CMODE_8;
-			if (mac_vmode_to_var
-			    (default_vmode, default_cmode, &var))
+			if (mac_vmode_to_var(default_vmode, default_cmode, &var))
 				var = default_var;
 		}
 	} else
-	    if (!fb_find_mode
-		(&var, info, mode_option, NULL, 0, NULL, 8))
-		var = default_var;
-#else /* !CONFIG_PPC */
-#ifdef __sparc__
-	if (mode_option) {
-		if (!fb_find_mode(&var, info, mode_option, NULL, 0, NULL, 8))
-			var = default_var;
-	} else
-		var = default_var;
-#else
-	if (!fb_find_mode(&var, info, mode_option, NULL, 0, NULL, 8))
-		var = default_var;
-#endif /* !__sparc__ */
 #endif /* !CONFIG_PPC */
-#endif /* !MODULE */
+	if (!fb_find_mode(&var, info, mode_option, NULL, 0, &defmode, 8))
+		var = default_var;
+
 	if (noaccel)
 		var.accel_flags &= ~FB_ACCELF_TEXT;
 	else
@@ -2296,14 +2278,13 @@ static int __init aty_init(struct fb_inf
 
 	if (var.yres == var.yres_virtual) {
 		u32 vram = (info->fix.smem_len - (PAGE_SIZE << 2));
-		var.yres_virtual =
-		    ((vram * 8) / var.bits_per_pixel) / var.xres_virtual;
+		var.yres_virtual = ((vram * 8) / var.bits_per_pixel) / var.xres_virtual;
 		if (var.yres_virtual < var.yres)
 			var.yres_virtual = var.yres;
 	}
 
 	if (atyfb_check_var(&var, info)) {
-		printk("atyfb: can't set default video mode\n");
+		printk(KERN_CRIT "atyfb: can't set default video mode\n");
 		return 0;
 	}
 
diff -U 3 -H -d -p -r -N -- linux-2.6.4/drivers/video/aty/mach64_accel.c linux-2.6.alex/drivers/video/aty/mach64_accel.c
--- linux-2.6.4/drivers/video/aty/mach64_accel.c	2004-03-11 16:47:33.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/mach64_accel.c	2004-03-13 19:12:50.000000000 +0100
@@ -13,7 +13,7 @@
      *  Generic Mach64 routines
      */
      
-/* this is for DMA GUI engine! work to be continue */
+/* this is for DMA GUI engine! work in progress */
 typedef struct {
 	u32 frame_buf_offset;
 	u32 system_mem_addr;
@@ -279,7 +279,7 @@ void atyfb_fillrect(struct fb_info *info
 void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 dwords, dx = image->dx, dy = image->dy, width = image->width;
+	u32 src_bytes, dx = image->dx, dy = image->dy, width = image->width;
 	u32 pix_width_save, pix_width, host_cntl, rotation = 0, src, mix;
 
 	if (par->asleep)
@@ -341,15 +341,15 @@ void atyfb_imageblit(struct fb_info *inf
 		pix_width &= ~DST_MASK;
 		pix_width |= DST_8BPP;
 
-		/* ab IIC we have DP_HOST_TRIPLE_EN bit */
-		/* FIXME: 24bpp + SUN12x22 corruption
-		if (image->width % 8 == 0) */
+		/* 
+		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
+		 * this hwaccelerated triple has an issue with not aligned data
+		 */
+		if (!M64_HAS(NO_HW_TRIPLE) && image->width % 8 == 0)
 			pix_width |= DP_HOST_TRIPLE_EN;
 	}
 
-	dwords = (((((image->width * image->depth) + 7) / 8) * image->height * image->depth)+ 3) / 4 ;
-
-	if(image->depth == 1) {
+	if (image->depth == 1) {
 		u32 fg, bg;
 		if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
 		    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
@@ -379,20 +379,19 @@ void atyfb_imageblit(struct fb_info *inf
 	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rotation, par);
 
 	draw_rect(dx, dy, width, image->height, par);
+	src_bytes = (((image->width * image->depth) + 7) / 8) * image->height;
 
-	/* manual triple each pixel, freezes the box */
-	if (0 && info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+	/* manual triple each pixel */
+	if (info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
 		int inbit, outbit, mult24, byte_id_in_dword, width;
-		u8 *pbitmapin, *pbitmapout;
+		u8 *pbitmapin = (u8*)image->data, *pbitmapout;
 		u32 hostdword;
 
-		pbitmapin = (u8*)image->data;
-
-		for(width = image->width, inbit = 7, mult24 = 0; dwords; dwords--) {
-			for(hostdword = 0, pbitmapout = (u8*)&hostdword, byte_id_in_dword = 0;
-				byte_id_in_dword < 4;
+		for (width = image->width, inbit = 7, mult24 = 0; src_bytes; ) {
+			for (hostdword = 0, pbitmapout = (u8*)&hostdword, byte_id_in_dword = 0;
+				byte_id_in_dword < 4 && src_bytes;
 				byte_id_in_dword++, pbitmapout++) {
-				for(outbit = 7; outbit >= 0; outbit--) {
+				for (outbit = 7; outbit >= 0; outbit--) {
 					*pbitmapout |= (((*pbitmapin >> inbit) & 1) << outbit);
 					mult24++;
 					/* next bit */
@@ -404,10 +403,11 @@ void atyfb_imageblit(struct fb_info *inf
 
 					/* next byte */
 					if (inbit < 0 || width == 0) {
+						src_bytes--;	
 						pbitmapin++;
 						inbit = 7;
 
-						if(width == 0) {
+						if (width == 0) {
 						    width = image->width;
 						    outbit = 0;
 						}
@@ -418,10 +418,10 @@ void atyfb_imageblit(struct fb_info *inf
 			aty_st_le32(HOST_DATA0, hostdword, par);
 		}
 	} else {
-		u32 *pbitmap;
-		for(pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
+		u32 *pbitmap, dwords = (src_bytes + 3) / 4;
+		for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, *pbitmap, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
 		}
 	}
 
diff -U 3 -H -d -p -r -N -- linux-2.6.4/drivers/video/aty/mach64_ct.c linux-2.6.alex/drivers/video/aty/mach64_ct.c
--- linux-2.6.4/drivers/video/aty/mach64_ct.c	2004-03-11 16:47:33.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/mach64_ct.c	2004-03-13 17:23:47.000000000 +0100
@@ -477,18 +477,17 @@ int __init aty_init_pll_ct(const struct 
 		pll->ct.dsp_loop_latency = (dsp_config & DSP_LOOP_LATENCY) >> 16;
 #if 0
 	FIXME: is it relevant for us?
-	if ((!dsp_on_off && (Chip < ATI_CHIP_264GTPRO)) ||
+	if ((!dsp_on_off && !M64_HAS(RESET_3D)) ||
 		((dsp_on_off == vga_dsp_on_off) &&
 		(!dsp_config || !((dsp_config ^ vga_dsp_config) & DSP_XCLKS_PER_QW)))) {
-		if (ATIDivide(GetBits(vga_dsp_on_off, VGA_DSP_OFF),
-			GetBits(vga_dsp_config, VGA_DSP_XCLKS_PER_QW), 5, 1) > 24)
+		vga_dsp_on_off &= VGA_DSP_OFF;
+		vga_dsp_config &= VGA_DSP_XCLKS_PER_QW;
+		if (ATIDivide(vga_dsp_on_off, vga_dsp_config, 5, 1) > 24)
 			pll->ct.fifo_size = 32;
 		else
 			pll->ct.fifo_size = 24;
 	}
 #endif
-	/* end BIOS */
-
 	/* Exit if the user does not want us to tamper with the clock
 	rates of her chip. */
 	if (par->mclk_per == 0) {
@@ -549,7 +548,7 @@ int __init aty_init_pll_ct(const struct 
 		* The chip clock is not equal to the memory clock.
 		* Therefore we will use sclk to clock the chip.
 		*/
-		pll->ct.pll_gen_cntl |= (6 << 4); /* mclk == sclk*/
+		pll->ct.pll_gen_cntl |= (6 << 4); /* mclk == sclk */
 
 		q = par->ref_clk_per * pll->ct.pll_ref_div * 4 / par->mclk_per;
 		if (q < 16*8 || q > 255*8) {

--Boundary-00=_wU2UAyM4mIhOZPo--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
