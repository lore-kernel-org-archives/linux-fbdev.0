From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 5/3] fb accel capabilities (aty/aty*, aty/mach64*)
Date: Thu, 13 May 2004 13:39:38 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405131334330.22615@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130149210.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085052904.6f0d5d@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOEUX-0000Pm-NA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:35:09 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOEUX-00013y-2m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:35:09 -0700
In-Reply-To: <Pine.LNX.4.58.0405130149210.2282@rosencrantz.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org


This patch (dependent on patches 3 and 4) updates the ATI drivers aside from
radeon to the new fix.hwaccel semantics.  Please test.

-dte

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 13:25:46+02:00 eger@rosencrantz.theboonies.us 
#   ATI drivers: convert from var.accel_flags to new fix.hwaccel semantics
# 
# drivers/video/aty/mach64_gx.c
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +5 -8
#   mach64: convert from var.accel_flags to fix.hwaccel semantics
# 
# drivers/video/aty/mach64_accel.c
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +3 -3
#   mach64: convert from var.accel_flags to fix.hwaccel semantics
# 
# drivers/video/aty/atyfb_base.c
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +8 -18
#   atyfb: convert from var.accel_flags to fix.hwaccel semantics
# 
# drivers/video/aty/atyfb.h
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +1 -2
#   atyfb: convert from var.accel_flags to fix.hwaccel semantics
# 
# drivers/video/aty/aty128fb.c
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +3 -8
#   atyfb: convert from var.accel_flags to fix.hwaccel semantics
# 
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Thu May 13 13:28:07 2004
+++ b/drivers/video/aty/aty128fb.c	Thu May 13 13:28:07 2004
@@ -339,6 +339,7 @@
 	.ypanstep	= 1,
 	.mmio_len	= 0x2000,
 	.accel		= FB_ACCEL_ATI_RAGE128,
+	.hwaccel	= FB_HWACCEL_DISABLED,
 };
 
 static char *mode_option __initdata = NULL;
@@ -395,7 +396,6 @@
 	struct aty128_crtc crtc;
 	struct aty128_pll pll;
 	struct aty128_ddafifo fifo_reg;
-	u32 accel_flags;
 	struct aty128_constants constants;  /* PLL and others      */
 	void *regbase;                      /* remapped mmio       */
 	u32 vram_size;                      /* onboard video ram   */
@@ -1532,8 +1532,8 @@
 		aty128_set_lcd_enable(par, par->lcd_on);
 	}
 #endif
-	if (par->accel_flags & FB_ACCELF_TEXT)
-		aty128_init_engine(par);
+
+	aty128_init_engine(par);
 
 #ifdef CONFIG_BOOTX_TEXT
 	btext_update_display(info->fix.smem_start,
@@ -1569,7 +1569,6 @@
 	par->crtc = crtc;
 	par->pll = pll;
 	par->fifo_reg = fifo_reg;
-	par->accel_flags = var->accel_flags;
 
 	return 0;
 }
@@ -1591,7 +1590,6 @@
 
 	var->height = -1;
 	var->width = -1;
-	var->accel_flags = par->accel_flags;
 
 	return 0;
 }           
@@ -1829,9 +1827,6 @@
 					 0, &defaultmode, 8) == 0)
 				var = default_var;
 	}
-
-	var.accel_flags &= ~FB_ACCELF_TEXT;
-//	var.accel_flags |= FB_ACCELF_TEXT;/* FIXME Will add accel later */
 
 	if (aty128fb_check_var(&var, info)) {
 		printk(KERN_ERR "aty128fb: Cannot set default mode.\n");
diff -Nru a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
--- a/drivers/video/aty/atyfb.h	Thu May 13 13:28:07 2004
+++ b/drivers/video/aty/atyfb.h	Thu May 13 13:28:07 2004
@@ -108,7 +108,6 @@
 	u8 bus_type;
 	u8 ram_type;
 	u8 mem_refresh_rate;
-	u32 accel_flags;
 	int blitter_may_be_busy;
 	int asleep;
 	int lock_blank;
@@ -231,7 +230,7 @@
 
 struct aty_dac_ops {
 	int (*set_dac) (const struct fb_info * info,
-		const union aty_pll * pll, u32 bpp, u32 accel);
+		const union aty_pll * pll, u32 bpp);
 };
 
 extern const struct aty_dac_ops aty_dac_ibm514; /* IBM RGB514 */
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	Thu May 13 13:28:07 2004
+++ b/drivers/video/aty/atyfb_base.c	Thu May 13 13:28:07 2004
@@ -1108,14 +1108,12 @@
 			return err;
 	}
 
-	par->accel_flags = var->accel_flags; /* hack */
-
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
 
 	aty_set_crtc(par, &par->crtc);
 
-	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel, par->accel_flags);
+	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel);
 	par->pll_ops->set_pll(info, &par->pll);
 
 #ifdef DEBUG
@@ -1224,7 +1222,7 @@
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 	/* Initialize the graphics engine */
-	if (par->accel_flags & FB_ACCELF_TEXT)
+	if (info->fix.hwaccel != FB_HWACCEL_DISABLED)
 		aty_init_engine(par, info);
 
 #ifdef CONFIG_BOOTX_TEXT
@@ -1304,11 +1302,6 @@
 			return err;
 	}
 
-	if (var->accel_flags & FB_ACCELF_TEXT)
-		info->var.accel_flags = FB_ACCELF_TEXT;
-	else
-		info->var.accel_flags = 0;
-
 #if 0 /* fbmon is not done. uncomment for 2.5.x -brad */
 	if (!fbmon_valid_timings(pixclock, htotal, vtotal, info))
 		return -EINVAL;
@@ -1369,10 +1362,6 @@
 				 * correctly.
 				 */
 				var = default_var;
-				if (noaccel)
-					var.accel_flags &= ~FB_ACCELF_TEXT;
-				else
-					var.accel_flags |= FB_ACCELF_TEXT;
 				if (var.yres == var.yres_virtual) {
 					u32 vram = (info->fix.smem_len - (PAGE_SIZE << 2));
 					var.yres_virtual = ((vram * 8) / var.bits_per_pixel) / var.xres_virtual;
@@ -2163,6 +2152,12 @@
 		aty_st_le32(MEM_CNTL, i, par);
 	}
 
+	if (noaccel)
+		info->fix.hwaccel = FB_HWACCEL_DISABLED;
+	else
+		info->fix.hwaccel = FB_HWACCEL_COPYAREA 
+				| FB_HWACCEL_FILLRECT 
+				| FB_HWACCEL_IMAGEBLIT ;
 	/*
 	 *  Reg Block 0 (CT-compatible block) is at mmio_start
 	 *  Reg Block 1 (multimedia extensions) is at mmio_start - 0x400
@@ -2272,11 +2267,6 @@
 #endif /* !CONFIG_PPC */
 	if (!fb_find_mode(&var, info, mode_option, NULL, 0, &defmode, 8))
 		var = default_var;
-
-	if (noaccel)
-		var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
-		var.accel_flags |= FB_ACCELF_TEXT;
 
 	if (var.yres == var.yres_virtual) {
 		u32 vram = (info->fix.smem_len - (PAGE_SIZE << 2));
diff -Nru a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_accel.c
--- a/drivers/video/aty/mach64_accel.c	Thu May 13 13:28:07 2004
+++ b/drivers/video/aty/mach64_accel.c	Thu May 13 13:28:07 2004
@@ -199,7 +199,7 @@
 		return;
 	if (!area->width || !area->height)
 		return;
-	if (!par->accel_flags) {
+	if (!(info->fix.hwaccel & FB_HWACCEL_COPYAREA)) {
 		if (par->blitter_may_be_busy)
 			wait_for_idle(par);
 		cfb_copyarea(info, area);
@@ -249,7 +249,7 @@
 		return;
 	if (!rect->width || !rect->height)
 		return;
-	if (!par->accel_flags) {
+	if (!(info->fix.hwaccel & FB_HWACCEL_FILLRECT)) {
 		if (par->blitter_may_be_busy)
 			wait_for_idle(par);
 		cfb_fillrect(info, rect);
@@ -290,7 +290,7 @@
 		return;
 	if (!image->width || !image->height)
 		return;
-	if (!par->accel_flags ||
+	if (!(info->fix.hwaccel & FB_HWACCEL_IMAGEBLIT) ||
 	    (image->depth != 1 && info->var.bits_per_pixel != image->depth)) {
 		if (par->blitter_may_be_busy)
 			wait_for_idle(par);
diff -Nru a/drivers/video/aty/mach64_gx.c b/drivers/video/aty/mach64_gx.c
--- a/drivers/video/aty/mach64_gx.c	Thu May 13 13:28:07 2004
+++ b/drivers/video/aty/mach64_gx.c	Thu May 13 13:28:07 2004
@@ -78,7 +78,7 @@
 }
 
 static int aty_set_dac_514(const struct fb_info *info,
-			   const union aty_pll *pll, u32 bpp, u32 accel)
+			   const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	static struct {
@@ -204,8 +204,7 @@
      */
 
 static int aty_set_dac_ATI68860_B(const struct fb_info *info,
-				  const union aty_pll *pll, u32 bpp,
-				  u32 accel)
+				  const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 gModeReg, devSetupRegA, temp, mask;
@@ -237,7 +236,7 @@
 		break;
 	}
 
-	if (!accel) {
+	if (info->fix.hwaccel != FB_HWACCEL_DISABLED) {
 		gModeReg = 0x80;
 		devSetupRegA = 0x61;
 	}
@@ -287,8 +286,7 @@
      */
 
 static int aty_set_dac_ATT21C498(const struct fb_info *info,
-				 const union aty_pll *pll, u32 bpp,
-				 u32 accel)
+				 const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 dotClock;
@@ -883,8 +881,7 @@
      */
 
 static int aty_set_dac_unsupported(const struct fb_info *info,
-				   const union aty_pll *pll, u32 bpp,
-				   u32 accel)
+				   const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
