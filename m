From: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
Date: Sun, 25 Jun 2017 19:10:36 +0000
Subject: [PATCH] staging: sm750fb: fix sparce warning.
Message-Id: <1498417843-12060-1-git-send-email-abdallah.meziti.pro@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the following sparce warnings: different lock contexts for basic block.

drivers/staging/sm750fb//sm750.c:159:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
drivers/staging/sm750fb//sm750.c:231:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
drivers/staging/sm750fb//sm750.c:235:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block

Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 69 ++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 664c220..5494a29 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -186,16 +186,24 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 * If not use spin_lock,system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
+	if (sm750_dev->fb_count > 1) {
 		spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, Bpp,
-				     region->dx, region->dy,
-				     region->width, region->height,
-				     color, rop);
-	if (sm750_dev->fb_count > 1)
+		sm750_dev->accel.de_fillrect(&sm750_dev->accel,
+					     base, pitch, Bpp,
+					     region->dx, region->dy,
+					     region->width, region->height,
+					     color, rop);
+
 		spin_unlock(&sm750_dev->slock);
+	} else {
+		sm750_dev->accel.de_fillrect(&sm750_dev->accel,
+					     base, pitch, Bpp,
+					     region->dx, region->dy,
+					     region->width, region->height,
+					     color, rop);
+	}
+
 }
 
 static void lynxfb_ops_copyarea(struct fb_info *info,
@@ -220,16 +228,24 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
+	if (sm750_dev->fb_count > 1) {
 		spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
-				     base, pitch, region->sx, region->sy,
-				     base, pitch, Bpp, region->dx, region->dy,
-				     region->width, region->height,
-				     HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
+		sm750_dev->accel.de_copyarea(&sm750_dev->accel,
+					     base, pitch, region->sx, region->sy,
+					     base, pitch, Bpp, region->dx, region->dy,
+					     region->width, region->height,
+					     HW_ROP2_COPY);
+
 		spin_unlock(&sm750_dev->slock);
+	} else {
+		sm750_dev->accel.de_copyarea(&sm750_dev->accel,
+					     base, pitch, region->sx, region->sy,
+					     base, pitch, Bpp, region->dx, region->dy,
+					     region->width, region->height,
+					     HW_ROP2_COPY);
+	}
+
 }
 
 static void lynxfb_ops_imageblit(struct fb_info *info,
@@ -269,17 +285,26 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
+	if (sm750_dev->fb_count > 1) {
 		spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
-				      base, pitch, Bpp,
-				      image->dx, image->dy,
-				      image->width, image->height,
-				      fgcol, bgcol, HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
+		sm750_dev->accel.de_imageblit(&sm750_dev->accel,
+					      image->data, image->width >> 3, 0,
+					      base, pitch, Bpp,
+					      image->dx, image->dy,
+					      image->width, image->height,
+					      fgcol, bgcol, HW_ROP2_COPY);
+
 		spin_unlock(&sm750_dev->slock);
+	} else {
+		sm750_dev->accel.de_imageblit(&sm750_dev->accel,
+					      image->data, image->width >> 3, 0,
+					      base, pitch, Bpp,
+					      image->dx, image->dy,
+					      image->width, image->height,
+					      fgcol, bgcol, HW_ROP2_COPY);
+	}
+
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
2.7.4

