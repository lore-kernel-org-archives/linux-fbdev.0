From: Alex Briskin <br.shurik@gmail.com>
Date: Sun, 23 Oct 2016 12:37:57 +0000
Subject: [PATCH] staging: sm750fb: Fix lock context error
Message-Id: <d825266ad9ed386b54656605fe1f805c576ebf42.1477226129.git.br.shurik@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sparse error fix - different lock contexts for basic block.
Acquirement and release of spin lock was dependent on two separate
unprotected variable evaluations. Instead the condition evaluation result
is stored in a local boolean variable to make sure that the same context
that called the spin_lock will evoke spin_unlock.

Signed-off-by: Alex Briskin <br.shurik@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 0663ec0..4f0f98e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -164,6 +164,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	struct sm750_dev *sm750_dev;
 	unsigned int base, pitch, Bpp, rop;
 	u32 color;
+	bool lock_in_this_context = false;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
@@ -187,7 +188,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 * If not use spin_lock,system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
+	lock_in_this_context = sm750_dev->fb_count > 1;
+	if (lock_in_this_context)
 		spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
@@ -195,7 +197,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 				     region->dx, region->dy,
 				     region->width, region->height,
 				     color, rop);
-	if (sm750_dev->fb_count > 1)
+	if (lock_in_this_context)
 		spin_unlock(&sm750_dev->slock);
 }
 
@@ -205,6 +207,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
 	unsigned int base, pitch, Bpp;
+	bool lock_in_this_context = false;
 
 	par = info->par;
 	sm750_dev = par->dev;
@@ -221,7 +224,8 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
 	 */
-	if (sm750_dev->fb_count > 1)
+	lock_in_this_context = sm750_dev->fb_count > 1;
+	if (lock_in_this_context)
 		spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
@@ -229,7 +233,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 				     base, pitch, Bpp, region->dx, region->dy,
 				     region->width, region->height,
 				     HW_ROP2_COPY);
-	if (sm750_dev->fb_count > 1)
+	if (lock_in_this_context)
 		spin_unlock(&sm750_dev->slock);
 }
 
-- 
2.7.4

