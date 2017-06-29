From: Dhananjay Balan <mail@dbalan.in>
Date: Thu, 29 Jun 2017 11:24:35 +0000
Subject: [PATCH] drivers: staging: sm750: Hold lock irrespective of fb numbers.
Message-Id: <20170629112435.30376-1-mail@dbalan.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dhananjay Balan <mail@dbalan.in>

Start holding the lock for all cases irrespective of number of fb,
there could be a deadlock since this number could change in the
lifetime of this lock

Signed-off-by: Dhananjay Balan <mail@dbalan.in>
---
 drivers/staging/sm750fb/sm750.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d5934f372387..af5c3c93a077 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -183,19 +183,19 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
 	/*
-	 * If not use spin_lock,system will die if user load driver
+	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
+	 * since they fb_count could change during the lifetime of
+	 * this lock, we are holding it for all cases.
 	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
+	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
 				     base, pitch, Bpp,
 				     region->dx, region->dy,
 				     region->width, region->height,
 				     color, rop);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	spin_unlock(&sm750_dev->slock);
 }
 
 static void lynxfb_ops_copyarea(struct fb_info *info,
@@ -219,17 +219,17 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	/*
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
+	 * since they fb_count could change during the lifetime of
+	 * this lock, we are holding it for all cases.
 	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
+	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
 				     base, pitch, region->sx, region->sy,
 				     base, pitch, Bpp, region->dx, region->dy,
 				     region->width, region->height,
 				     HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	spin_unlock(&sm750_dev->slock);
 }
 
 static void lynxfb_ops_imageblit(struct fb_info *info,
@@ -268,9 +268,10 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	/*
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
+	 * since they fb_count could change during the lifetime of
+	 * this lock, we are holding it for all cases.
 	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
+	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
 				      image->data, image->width >> 3, 0,
@@ -278,8 +279,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 				      image->dx, image->dy,
 				      image->width, image->height,
 				      fgcol, bgcol, HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	spin_unlock(&sm750_dev->slock);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
2.13.2

