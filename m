From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/9][RIVAFB]: Directcolor mode and miscellaneous fixes
Date: Sat, 21 Aug 2004 21:24:50 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212109.56006.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW0C-00085s-Df
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:48 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW0B-00059J-Da
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:48 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 21D0C7A713D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:33:37 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Although the rivafb advertises its capability as DirectColor, the hardware is
actually set in Truecolor (CLUT cannot be altered).  This mismatch occasionally
produces wrong colors, such as wrong logo colors at 32bpp and gamma utilities
(such as xgamma) does not work at all.

Changes:

1. Fixes the above problems by setting the hardware to accept changing of the
CLUT.

2. Fixes color problems for NV_ARCH_03 (Riva128)

3. Build a private modelist from the EDID (for use by fbcon)

4. Mark several functions/data as __devinit/__initdata

5. Remove unused fields from struct riva_par 

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 fbdev.c      |  200 ++++++++++++++++++++++++++---------------------------------
 riva_hw.c    |    7 +-
 rivafb-i2c.c |    5 -
 rivafb.h     |    5 -
 4 files changed, 98 insertions(+), 119 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/riva/fbdev.c linux-2.6.8.1-mm3/drivers/video/riva/fbdev.c
--- linux-2.6.8.1-mm3-orig/drivers/video/riva/fbdev.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/riva/fbdev.c	2004-08-21 18:58:58.788528072 +0800
@@ -203,7 +203,6 @@ MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl)
  * ------------------------------------------------------------------------- */
 
 /* command line data, set in rivafb_setup() */
-static u32 pseudo_palette[17];
 static int flatpanel __initdata = -1; /* Autodetect later */
 static int forceCRTC __initdata = -1;
 #ifdef CONFIG_MTRR
@@ -213,13 +212,13 @@ static int nomtrr __initdata = 0;
 static char *mode_option __initdata = NULL;
 static int  strictmode       = 0;
 
-static struct fb_fix_screeninfo rivafb_fix = {
+static struct fb_fix_screeninfo __initdata rivafb_fix = {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.xpanstep	= 1,
 	.ypanstep	= 1,
 };
 
-static struct fb_var_screeninfo rivafb_default_var = {
+static struct fb_var_screeninfo __initdata rivafb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
@@ -515,7 +514,7 @@ static void riva_rclut(RIVA_HW_INST *chi
 		       unsigned char *green, unsigned char *blue)
 {
 	
-	VGA_WR08(chip->PDIO, 0x3c8, regnum);
+	VGA_WR08(chip->PDIO, 0x3c7, regnum);
 	*red = VGA_RD08(chip->PDIO, 0x3c9);
 	*green = VGA_RD08(chip->PDIO, 0x3c9);
 	*blue = VGA_RD08(chip->PDIO, 0x3c9);
@@ -1007,6 +1006,7 @@ static int rivafb_open(struct fb_info *i
 			par->state.flags |= VGA_SAVE_CMAP;
 		save_vga(&par->state);
 #endif
+		riva_common_setup(par);
 		RivaGetConfig(&par->riva, par->Chipset);
 		/* vgaHWunlock() + riva unlock (0x7F) */
 		CRTCout(par, 0x11, 0xFF);
@@ -1043,7 +1043,8 @@ static int rivafb_release(struct fb_info
 
 static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct fb_monspecs *specs = &info->monspecs;
+	struct fb_videomode *mode;
+	struct riva_par *par = (struct riva_par *) info->par;
 	int nom, den;		/* translating from pixels->bytes */
 	int mode_valid = 0;
 	
@@ -1060,6 +1061,9 @@ static int rivafb_check_var(struct fb_va
 		/* fall through */
 	case 16:
 		var->bits_per_pixel = 16;
+		/* The Riva128 supports RGB555 only */
+		if (par->riva.Architecture == NV_ARCH_03)
+			var->green.length = 5;
 		if (var->green.length == 5) {
 			/* 0rrrrrgg gggbbbbb */
 			var->red.offset = 10;
@@ -1102,62 +1106,21 @@ static int rivafb_check_var(struct fb_va
 			mode_valid = 1;
 	}
 
-	/* find best mode from modedb */
-	if (!mode_valid && specs->modedb_len) {
-		int i, best, best_refresh, best_x, best_y, diff_x, diff_y;
-
-		best_refresh = best = best_x = best_y = 0;
-		diff_x = diff_y = -1;
-
-		for (i = 0; i < specs->modedb_len; i++) {
-			if (var->xres <= specs->modedb[i].xres &&
-			    !(specs->modedb[i].flag & FB_MODE_IS_CALCULATED) &&
-			    specs->modedb[i].xres - var->xres < diff_x) {
-				best_x = specs->modedb[i].xres;
-				diff_x = best_x - var->xres;
-			}
-			if (!diff_x) break;
-		}
-
-		if (diff_x != -1) {
-			for (i = 0; i < specs->modedb_len; i++) {
-				if (best_x == specs->modedb[i].xres &&
-				    var->yres <= specs->modedb[i].yres &&
-				    !(specs->modedb[i].flag &
-				      FB_MODE_IS_CALCULATED) &&
-				    specs->modedb[i].yres-var->yres < diff_y) {
-					best_y = specs->modedb[i].yres;
-					diff_y = best_y - var->yres;
-				}
-				if (!diff_y) break;
-			}
-		}
-
-		if (diff_y != -1) {
-			for (i = 0; i < specs->modedb_len; i++) {
-				if (best_x == specs->modedb[i].xres &&
-				    best_y == specs->modedb[i].yres &&
-				    !(specs->modedb[i].flag &
-				      FB_MODE_IS_CALCULATED) &&
-				    specs->modedb[i].refresh > best_refresh) {
-					best_refresh=specs->modedb[i].refresh;
-					best = i;
-				}
-			}
-		}
-
-		if (best_refresh) {
-			riva_update_var(var, &specs->modedb[best]);
-			mode_valid = 1;
-		}
-	}
-
 	/* calculate modeline if supported by monitor */
 	if (!mode_valid && info->monspecs.gtf) {
 		if (!fb_get_mode(FB_MAXTIMINGS, 0, var, info))
 			mode_valid = 1;
 	}
-	if (!mode_valid && info->monspecs.modedb_len)
+
+	if (!mode_valid) {
+		mode = fb_find_best_mode(var, &info->monspecs.modelist);
+		if (mode) {
+			riva_update_var(var, mode);
+			mode_valid = 1;
+		}
+	}
+
+	if (!mode_valid && !list_empty(&info->monspecs.modelist))
 		return -EINVAL;
 
 	if (var->xres_virtual < var->xres)
@@ -1192,12 +1155,6 @@ static int rivafb_set_par(struct fb_info
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
-	riva_common_setup(par);
-	RivaGetConfig(&par->riva, par->Chipset);
-	/* vgaHWunlock() + riva unlock (0x7F) */
-	CRTCout(par, 0x11, 0xFF);
-	par->riva.LockUnlock(&par->riva, 0);
-
 	riva_load_video_mode(info);
 	riva_setup_accel(info);
 	
@@ -1205,6 +1162,7 @@ static int rivafb_set_par(struct fb_info
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+
 	NVTRACE_LEAVE();
 	return 0;
 }
@@ -1325,7 +1283,7 @@ static int rivafb_setcolreg(unsigned reg
 	int i;
 
 	if (regno >= riva_get_cmap_len(&info->var))
-		return -EINVAL;
+			return -EINVAL;
 
 	if (info->var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
@@ -1333,6 +1291,31 @@ static int rivafb_setcolreg(unsigned reg
 		    (red * 77 + green * 151 + blue * 28) >> 8;
 	}
 
+	if (regno < 16 && info->fix.visual == FB_VISUAL_DIRECTCOLOR) { 
+		((u32 *) info->pseudo_palette)[regno] = 
+			(regno << info->var.red.offset) |
+			(regno << info->var.green.offset) |
+			(regno << info->var.blue.offset);
+		/* 
+		 * The Riva128 2D engine requires color information in
+		 * TrueColor format even if framebuffer is in DirectColor 
+		 */
+		if (par->riva.Architecture == NV_ARCH_03) {
+			switch (info->var.bits_per_pixel) {
+			case 16:
+				par->palette[regno] = ((red & 0xf800) >> 1) |
+					((green & 0xf800) >> 6) |
+					((blue & 0xf800) >> 11);
+				break;
+			case 32:
+				par->palette[regno] = ((red & 0xff00) << 8) |
+					((green & 0xff00)) | 
+					((blue & 0xff00) >> 8);
+				break;
+			}
+		}
+	}
+
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		/* "transparent" stuff is completely ignored. */
@@ -1340,45 +1323,27 @@ static int rivafb_setcolreg(unsigned reg
 		break;
 	case 16:
 		if (info->var.green.length == 5) {
-			if (regno < 16) {
-				/* 0rrrrrgg gggbbbbb */
-				((u32 *)info->pseudo_palette)[regno] =
-					((red & 0xf800) >> 1) |
-					((green & 0xf800) >> 6) |
-					((blue & 0xf800) >> 11);
-			}
-			for (i = 0; i < 8; i++) 
+			for (i = 0; i < 8; i++) {
 				riva_wclut(chip, regno*8+i, red >> 8,
 					   green >> 8, blue >> 8);
+			}
 		} else {
 			u8 r, g, b;
-
-			if (regno < 16) {
-				/* rrrrrggg gggbbbbb */
-				((u32 *)info->pseudo_palette)[regno] =
-					((red & 0xf800) >> 0) |
-					((green & 0xf800) >> 5) |
-					((blue & 0xf800) >> 11);
-			}
-			if (regno < 32) {
+			
+			if (regno < 32) { 
 				for (i = 0; i < 8; i++) {
-					riva_wclut(chip, regno*8+i, red >> 8, 
-						   green >> 8, blue >> 8);
+					riva_wclut(chip, regno*8+i,
+						   red >> 8, green >> 8,
+						   blue >> 8);
 				}
 			}
-			for (i = 0; i < 4; i++) {
-				riva_rclut(chip, regno*2+i, &r, &g, &b);
-				riva_wclut(chip, regno*4+i, r, green >> 8, b);
-			}
+			riva_rclut(chip, regno*4, &r, &g, &b);
+			for (i = 0; i < 4; i++) 
+				riva_wclut(chip, regno*4+i, r,
+					   green >> 8, b);
 		}
 		break;
 	case 32:
-		if (regno < 16) {
-			((u32 *)info->pseudo_palette)[regno] =
-				((red & 0xff00) << 8) |
-				((green & 0xff00)) | ((blue & 0xff00) >> 8);
-			
-		}
 		riva_wclut(chip, regno, red >> 8, green >> 8, blue >> 8);
 		break;
 	default:
@@ -1407,9 +1372,13 @@ static void rivafb_fillrect(struct fb_in
 
 	if (info->var.bits_per_pixel == 8)
 		color = rect->color;
-	else
-		color = ((u32 *)info->pseudo_palette)[rect->color];
-
+	else {
+		if (par->riva.Architecture != NV_ARCH_03) 
+			color = ((u32 *)info->pseudo_palette)[rect->color];
+		else 
+			color = par->palette[rect->color];
+	}
+		
 	switch (rect->rop) {
 	case ROP_XOR:
 		rop = 0x66;
@@ -1504,15 +1473,17 @@ static void rivafb_imageblit(struct fb_i
 		bgx = image->bg_color;
 		break;
 	case 16:
-		fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
-		bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
+	case 32:
+		if (par->riva.Architecture != NV_ARCH_03) {
+			fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
+			bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
+		} else {
+			fgx = par->palette[image->fg_color];
+			bgx = par->palette[image->bg_color];
+		}
 		if (info->var.green.length == 6)
 			convert_bgcolor_16(&bgx);	
 		break;
-	case 32:
-		fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
-		bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
-		break;
 	}
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 7);
@@ -1681,6 +1652,7 @@ static struct fb_ops riva_fb_ops = {
 static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
 	unsigned int cmap_len;
+	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
 	info->flags = FBINFO_DEFAULT
@@ -1693,7 +1665,8 @@ static int __devinit riva_set_fbinfo(str
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-	info->pseudo_palette = pseudo_palette;
+
+	info->pseudo_palette = par->pseudo_palette;
 
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
@@ -1708,7 +1681,7 @@ static int __devinit riva_set_fbinfo(str
 }
 
 #ifdef CONFIG_PPC_OF
-static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
+static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	struct device_node *dp;
@@ -1741,7 +1714,7 @@ static int riva_get_EDID_OF(struct fb_in
 #endif /* CONFIG_PPC_OF */
 
 #ifdef CONFIG_FB_RIVA_I2C
-static int riva_get_EDID_i2c(struct fb_info *info)
+static int __devinit riva_get_EDID_i2c(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	int i;
@@ -1760,7 +1733,8 @@ static int riva_get_EDID_i2c(struct fb_i
 }
 #endif /* CONFIG_FB_RIVA_I2C */
 
-static void riva_update_default_var(struct fb_var_screeninfo *var, struct fb_info *info)
+static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
+					      struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
 	struct fb_videomode modedb;
@@ -1794,7 +1768,7 @@ static void riva_update_default_var(stru
 }
 
 
-static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
+static void __devinit riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
@@ -1808,12 +1782,14 @@ static void riva_get_EDID(struct fb_info
 }
 
 
-static void riva_get_edidinfo(struct fb_info *info)
+static void __devinit riva_get_edidinfo(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &rivafb_default_var;
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	fb_edid_to_monspecs(par->EDID, &info->monspecs);
+	fb_videomode_to_modelist(info->monspecs.modedb, info->monspecs.modedb_len,
+				 &info->monspecs.modelist);
 	riva_update_default_var(var, info);
 
 	/* if user specified flatpanel, we respect that */
@@ -1827,7 +1803,7 @@ static void riva_get_edidinfo(struct fb_
  *
  * ------------------------------------------------------------------------- */
 
-static u32 riva_get_arch(struct pci_dev *pd)
+static u32 __devinit riva_get_arch(struct pci_dev *pd)
 {
     	u32 arch = 0;
 
@@ -1983,7 +1959,6 @@ static int __devinit rivafb_probe(struct
 
 	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
 	default_par->dclk_max = riva_get_maxdclk(default_par) * 1000;
-
 	info->screen_base = ioremap(rivafb_fix.smem_start,
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
@@ -2016,6 +1991,10 @@ static int __devinit rivafb_probe(struct
 		goto err_out_iounmap_fb;
 	}
 
+	fb_destroy_modedb(info->monspecs.modedb);
+	info->monspecs.modedb_len = 0;
+	info->monspecs.modedb = NULL;
+
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
@@ -2090,7 +2069,6 @@ static void __exit rivafb_remove(struct 
 		iounmap((caddr_t)par->riva.PRAMIN);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
-	fb_destroy_modedb(info->monspecs.modedb);
 	kfree(info->pixmap.addr);
 	kfree(par);
 	kfree(info);
@@ -2153,7 +2131,7 @@ static struct pci_driver rivafb_driver =
  *
  * ------------------------------------------------------------------------- */
 
-int __init rivafb_init(void)
+int __devinit rivafb_init(void)
 {
 	if (pci_register_driver(&rivafb_driver) > 0)
 		return 0;
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/riva/rivafb.h linux-2.6.8.1-mm3/drivers/video/riva/rivafb.h
--- linux-2.6.8.1-mm3-orig/drivers/video/riva/rivafb.h	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/riva/rivafb.h	2004-08-21 18:58:58.790527768 +0800
@@ -44,7 +44,8 @@ struct riva_i2c_chan {
 
 struct riva_par {
 	RIVA_HW_INST riva;	/* interface to riva_hw.c */
-
+	u32 pseudo_palette[16]; /* default palette */
+	u32 palette[16];        /* for Riva128 */
 	caddr_t ctrl_base;	/* virtual control register base addr */
 	unsigned dclk_max;	/* max DCLK */
 
@@ -54,8 +55,6 @@ struct riva_par {
 	struct vgastate state;
 #endif
 	atomic_t ref_count;
-	u32 cursor_data[32 * 32/4];
-	int cursor_reset;
 	unsigned char *EDID;
 	unsigned int Chipset;
 	int forceCRTC;
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/riva/rivafb-i2c.c linux-2.6.8.1-mm3/drivers/video/riva/rivafb-i2c.c
--- linux-2.6.8.1-mm3-orig/drivers/video/riva/rivafb-i2c.c	2004-08-17 21:51:39.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/riva/rivafb-i2c.c	2004-08-21 18:58:58.791527616 +0800
@@ -105,8 +105,9 @@ static int riva_setup_i2c_bus(struct riv
 	chan->algo.setscl		= riva_gpio_setscl;
 	chan->algo.getsda		= riva_gpio_getsda;
 	chan->algo.getscl		= riva_gpio_getscl;
-	chan->algo.udelay		= 40;
-	chan->algo.timeout		= 20;
+	chan->algo.udelay		= 5;
+	chan->algo.mdelay               = 5;
+	chan->algo.timeout		= 10;
 	chan->algo.data 		= chan;
 
 	i2c_set_adapdata(&chan->adapter, chan);
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/riva/riva_hw.c linux-2.6.8.1-mm3/drivers/video/riva/riva_hw.c
--- linux-2.6.8.1-mm3-orig/drivers/video/riva/riva_hw.c	2004-08-17 21:51:39.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/riva/riva_hw.c	2004-08-21 18:58:58.793527312 +0800
@@ -1299,9 +1299,10 @@ static void CalcStateExt
             break;
     }
 
-    /* Paul Richards: below if block borks things in kernel for some reason */
-    /* if((bpp != 8) && (chip->Architecture != NV_ARCH_03))
-    state->general |= 0x00000030; */
+     /* Paul Richards: below if block borks things in kernel for some reason */
+     /* Tony: Below is needed to set hardware in DirectColor */
+    if((bpp != 8) && (chip->Architecture != NV_ARCH_03))
+	    state->general |= 0x00000030;
 
     state->vpll     = (p << 16) | (n << 8) | m;
     state->repaint0 = (((width/8)*pixelDepth) & 0x700) >> 3;




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
