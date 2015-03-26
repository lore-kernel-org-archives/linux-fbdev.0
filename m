From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:26:23 +0000
Subject: [PATCH v2 08/12] staging: sm750: 80 characters per line
Message-Id: <b370d95b76f3ebf7a24f91eb44cacb81358ed282.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch inserts line breaks to make lines fit into 80 characters and increase readability.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 110 ++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index e4cf08c..6887926 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -60,54 +60,66 @@ static char *g_option = NULL;
 static const struct fb_videomode lynx750_ext[] = {
 	/*	1024x600-60 VESA	[1.71:1] */
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1024x600-70 VESA */
 	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1024x600-75 VESA */
 	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1024x600-85 VESA */
 	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	720x480	*/
 	{NULL, 60,  720,  480,  37427, 88,   16, 13, 1,   72,  3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1280x720		[1.78:1]	*/
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1280x768@60 */
 	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
 	 FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
 
 	/*	1360 x 768	[1.77083:1]	*/
 	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1368 x 768      [1.78:1]	*/
 	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
-	 FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1440x960		[15:10]	*/
 	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1920x1080	[16:9]	*/
 	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
-	 FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+	 FB_SYNC_VERT_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 };
 
 
@@ -132,12 +144,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	cursor->disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		cursor->setSize(cursor, fbcursor->image.width, fbcursor->image.height);
+		cursor->setSize(cursor,
+				fbcursor->image.width,
+				fbcursor->image.height);
 
-	if (fbcursor->set & FB_CUR_SETPOS) {
-		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
+	if (fbcursor->set & FB_CUR_SETPOS)
+		cursor->setPos(cursor,
+			       fbcursor->image.dx - info->var.xoffset,
 			       fbcursor->image.dy - info->var.yoffset);
-	}
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
@@ -167,7 +181,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	return 0;
 }
 
-static void lynxfb_ops_fillrect(struct fb_info *info, const struct fb_fillrect *region)
+static void lynxfb_ops_fillrect(struct fb_info *info,
+				const struct fb_fillrect *region)
 {
 	struct lynxfb_par *par;
 	struct lynx_share *share;
@@ -205,7 +220,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info, const struct fb_fillrect *
 		spin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_copyarea(struct fb_info *info, const struct fb_copyarea *region)
+static void lynxfb_ops_copyarea(struct fb_info *info,
+				const struct fb_copyarea *region)
 {
 	struct lynxfb_par *par;
 	struct lynx_share *share;
@@ -235,7 +251,8 @@ static void lynxfb_ops_copyarea(struct fb_info *info, const struct fb_copyarea *
 		spin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_imageblit(struct fb_info *info, const struct fb_image *image)
+static void lynxfb_ops_imageblit(struct fb_info *info,
+				 const struct fb_image *image)
 {
 	unsigned int base, pitch, Bpp;
 	unsigned int fgcol, bgcol;
@@ -381,7 +398,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	return ret;
 }
 
-static inline unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
+static inline unsigned int chan_to_field(unsigned int chan,
+					 struct fb_bitfield *bf)
 {
 	chan &= 0xffff;
 	chan >>= 16 - bf->length;
@@ -508,7 +526,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 }
 #endif
 
-static int lynxfb_ops_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
+				struct fb_info *info)
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
@@ -582,7 +601,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var, struct fb_info *i
 	var->height = var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
-	/* check if current fb's video memory big enought to hold the onscreen */
+	/* check if current fb's video memory big enought to hold the onscreen*/
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
 	/* defaulty crtc->channel go with par->index */
 
@@ -623,7 +642,8 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	if (info->var.grayscale)
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 
-	if (var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
+	if (var->bits_per_pixel = 8 &&
+	    info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
@@ -865,22 +885,30 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		} else if (ret = 4) {
 			pr_warn("fall back to any valid mode\n");
 		} else {
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n", ret, mdb_desc[i]);
+			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
+				ret,
+				mdb_desc[i]);
 		}
 	}
 
 	/* some member of info->var had been set by fb_find_mode */
 
 	pr_info("Member of info->var is :\n\
-			xres=%d\n\
-			yres=%d\n\
-			xres_virtual=%d\n\
-			yres_virtual=%d\n\
-			xoffset=%d\n\
-			yoffset=%d\n\
-			bits_per_pixel=%d\n \
-			...\n", var->xres, var->yres, var->xres_virtual, var->yres_virtual,
-			var->xoffset, var->yoffset, var->bits_per_pixel);
+		xres=%d\n\
+		yres=%d\n\
+		xres_virtual=%d\n\
+		yres_virtual=%d\n\
+		xoffset=%d\n\
+		yoffset=%d\n\
+		bits_per_pixel=%d\n \
+		...\n",
+		var->xres,
+		var->yres,
+		var->xres_virtual,
+		var->yres_virtual,
+		var->xoffset,
+		var->yoffset,
+		var->bits_per_pixel);
 
 	/* set par */
 	par->info = info;
@@ -1026,7 +1054,9 @@ static void sm750fb_setup(struct lynx_share *share, char *src)
 		}
 	}
 #ifdef CAP_EXPANSION
-	if (getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD)) {
+	if (getExpRes(exp_res,
+		      &spec_share->state.xLCD,
+		      &spec_share->state.yLCD)) {
 		/* seems exp_res is not valid */
 		spec_share->state.xLCD = spec_share->state.yLCD = 0;
 	}
@@ -1100,8 +1130,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!share->accel_off) {
 		/* hook deInit and 2d routines, notes that below hw_xxx
 		 * routine can work on most of lynx chips
-		 * if some chip need specific function,please hook it in smXXX_set_drv
-		 * routine */
+		 * if some chip need specific function,
+		 * please hook it in smXXX_set_drv routine */
 		share->accel.de_init = hw_de_init;
 		share->accel.de_fillrect = hw_fillrect;
 		share->accel.de_copyarea = hw_copyarea;
@@ -1177,7 +1207,9 @@ ALLOC_FB:
 		pr_info("Ready to register framebuffer #%d.\n", fbidx);
 		errno = register_framebuffer(info[fbidx]);
 		if (errno < 0) {
-			pr_err("Failed to register fb_info #%d. err %d\n", fbidx, errno);
+			pr_err("Failed to register fb_info #%d. err %d\n",
+				fbidx,
+				errno);
 			if (fbidx = 0)
 				goto err_register0;
 			else
@@ -1235,7 +1267,9 @@ static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
 	}
 #ifdef CONFIG_MTRR
 	if (share->mtrr.vram_added)
-		mtrr_del(share->mtrr.vram, share->vidmem_start, share->vidmem_size);
+		mtrr_del(share->mtrr.vram,
+			 share->vidmem_start,
+			 share->vidmem_size);
 #endif
 
 	iounmap(share->pvReg);
-- 
2.3.3

