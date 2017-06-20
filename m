From: Dhananjay Balan <mail@dbalan.in>
Date: Tue, 20 Jun 2017 16:50:13 +0000
Subject: [PATCH] staging: sm750fb: move common locking code to a macro
Message-Id: <20170620165013.11013-1-mail@dbalan.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dhananjay Balan <mail@dbalan.in>

The locking and unlocking code used by copy routines is common, so
moved it to a macro.

Signed-off-by: Dhananjay Balan <mail@dbalan.in>
---
 drivers/staging/sm750fb/sm750.c | 81 ++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 386d4adcd91d..d8ab83aea46d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -156,12 +156,25 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	return 0;
 }
 
+/*
+ * If not using spin_lock, system will die if user frequently loads and
+ * immediately unloads driver (dual)
+ */
+#define dual_safe_call(func, ...)					\
+	do {								\
+		if (sm750_dev->fb_count > 1)				\
+			spin_lock(&sm750_dev->slock);			\
+		func(__VA_ARGS__);					\
+		if (sm750_dev->fb_count > 1)				\
+			spin_unlock(&sm750_dev->slock);			\
+	} while (0)
+
 static void lynxfb_ops_fillrect(struct fb_info *info,
 				const struct fb_fillrect *region)
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp, rop;
+	unsigned int base, pitch, bit_pp, rop;
 	u32 color;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -176,26 +189,15 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bit_pp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp = 1) ? region->color :
+	color = (bit_pp = 1) ? region->color :
 		((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
-	/*
-	 * If not use spin_lock,system will die if user load driver
-	 * and immediately unload driver frequently (dual)
-	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
-
-	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, Bpp,
-				     region->dx, region->dy,
-				     region->width, region->height,
-				     color, rop);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	dual_safe_call(sm750_dev->accel.de_fillrect, &sm750_dev->accel,
+		       base, pitch, bit_pp, region->dx, region->dy,
+		       region->width, region->height, color, rop);
 }
 
 static void lynxfb_ops_copyarea(struct fb_info *info,
@@ -203,7 +205,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bit_pp;
 
 	par = info->par;
 	sm750_dev = par->dev;
@@ -214,28 +216,18 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bit_pp = info->var.bits_per_pixel >> 3;
 
-	/*
-	 * If not use spin_lock, system will die if user load driver
-	 * and immediately unload driver frequently (dual)
-	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
-
-	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
-				     base, pitch, region->sx, region->sy,
-				     base, pitch, Bpp, region->dx, region->dy,
-				     region->width, region->height,
-				     HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	dual_safe_call(sm750_dev->accel.de_copyarea, &sm750_dev->accel,
+		       base, pitch, region->sx, region->sy,
+		       base, pitch, bit_pp, region->dx, region->dy,
+		       region->width, region->height, HW_ROP2_COPY);
 }
 
 static void lynxfb_ops_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bit_pp;
 	unsigned int fgcol, bgcol;
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
@@ -248,7 +240,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bit_pp = info->var.bits_per_pixel >> 3;
 
 	/* TODO: Implement hardware acceleration for image->depth > 1 */
 	if (image->depth != 1) {
@@ -265,21 +257,10 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 		bgcol = image->bg_color;
 	}
 
-	/*
-	 * If not use spin_lock, system will die if user load driver
-	 * and immediately unload driver frequently (dual)
-	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
-
-	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
-				      base, pitch, Bpp,
-				      image->dx, image->dy,
-				      image->width, image->height,
-				      fgcol, bgcol, HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	dual_safe_call(sm750_dev->accel.de_imageblit, &sm750_dev->accel,
+		       image->data, image->width >> 3, 0, base, pitch,
+		       bit_pp, image->dx, image->dy, image->width,
+		       image->height, fgcol, bgcol, HW_ROP2_COPY);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
2.13.1

