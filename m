From: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
Date: Mon, 26 Jun 2017 17:26:19 +0000
Subject: [PATCH v2] staging: sm750fb: always take the lock
Message-Id: <1498497981-3240-1-git-send-email-abdallah.meziti.pro@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: AbdAllah MEZITI <abdallah.meziti.pro@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch
- Always take the lock:
The current code only takes the lock if multiple instances are in use.
This is error-prone, and confuses static analyzers.
As taking the lock in case of a single instance is harmless and cheap,
change the code to always take the lock.
- That also fix the sparse warning:
drivers/staging/sm750fb/sm750.c:159:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:231:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:235:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block

Signed-off-by: AbdAllah MEZITI <abdallah.meziti.pro@gmail.com>

v2:
 - add and fix the changelog text.
---
 drivers/staging/sm750fb/sm750.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 386d4ad..4a22190 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -186,16 +186,14 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 * If not use spin_lock,system will die if user load driver
 	 * and immediately unload driver frequently (dual)
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
@@ -220,16 +218,14 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
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
@@ -269,8 +265,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
-		spin_lock(&sm750_dev->slock);
+	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
 				      image->data, image->width >> 3, 0,
@@ -278,8 +273,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 				      image->dx, image->dy,
 				      image->width, image->height,
 				      fgcol, bgcol, HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
-		spin_unlock(&sm750_dev->slock);
+	spin_unlock(&sm750_dev->slock);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
2.7.4

