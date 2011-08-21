From: bernie@plugable.com
Date: Sun, 21 Aug 2011 20:34:15 +0000
Subject: [PATCH 3/6] udlfb: fix issues found with Sparse static analysis
Message-Id: <1313958862-5640-5-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Dr. David Alan Gilbert <linux@treblig.org>

Add __user casting, a missing copy_from_user, and proper boolean

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index bdd21de..f5df3d3 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -786,14 +786,13 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 {
 
 	struct dlfb_data *dev = info->par;
-	struct dloarea *area = NULL;
 
 	if (!atomic_read(&dev->usb_active))
 		return 0;
 
 	/* TODO: Update X server to get this from sysfs instead */
 	if (cmd = DLFB_IOCTL_RETURN_EDID) {
-		char *edid = (char *)arg;
+		void __user *edid = (void __user *)arg;
 		if (copy_to_user(edid, dev->edid, dev->edid_size))
 			return -EFAULT;
 		return 0;
@@ -801,6 +800,11 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 
 	/* TODO: Help propose a standard fb.h ioctl to report mmap damage */
 	if (cmd = DLFB_IOCTL_REPORT_DAMAGE) {
+		struct dloarea area;
+
+		if (copy_from_user(&area, (void __user *)arg,
+				  sizeof(struct dloarea)))
+			return -EFAULT;
 
 		/*
 		 * If we have a damage-aware client, turn fb_defio "off"
@@ -812,21 +816,19 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 		if (info->fbdefio)
 			info->fbdefio->delay = DL_DEFIO_WRITE_DISABLE;
 
-		area = (struct dloarea *)arg;
-
-		if (area->x < 0)
-			area->x = 0;
+		if (area.x < 0)
+			area.x = 0;
 
-		if (area->x > info->var.xres)
-			area->x = info->var.xres;
+		if (area.x > info->var.xres)
+			area.x = info->var.xres;
 
-		if (area->y < 0)
-			area->y = 0;
+		if (area.y < 0)
+			area.y = 0;
 
-		if (area->y > info->var.yres)
-			area->y = info->var.yres;
+		if (area.y > info->var.yres)
+			area.y = info->var.yres;
 
-		dlfb_handle_damage(dev, area->x, area->y, area->w, area->h,
+		dlfb_handle_damage(dev, area.x, area.y, area.w, area.h,
 			   info->screen_base);
 	}
 
@@ -874,7 +876,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 	 * preventing other clients (X) from working properly. Usually
 	 * not what the user wants. Fail by default with option to enable.
 	 */
-	if ((user = 0) & (!console))
+	if ((user = 0) && (!console))
 		return -EBUSY;
 
 	/* If the USB device is gone, we don't accept new opens */
-- 
1.7.4.1

