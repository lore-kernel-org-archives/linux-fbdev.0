From: "Dr. David Alan Gilbert" <linux@treblig.org>
Date: Tue, 05 Apr 2011 00:02:58 +0000
Subject: [PATCH] udlfb.c dlfb_ops_ioctl - missing copy_from_user's  - NEEDS
Message-Id: <20110405000258.GA30668@gallifrey>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

    Fix __user casting in dlfb_ops_ioctl and a missing copy_from_user, and a missing &

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---

NOTE! I don't have the hardware to test this; but Bernie suggested I put the
patch together anyway; build and Sparse tested only -**  don't **
merge without a test by a udl dev

Patch is against ecb78ab6f30106ab72a575a25b1cdfd1633b7ca2 on Linus's tree
a few days after 39-rc1

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 2c8364e..ef7801a 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -751,14 +751,13 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
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
@@ -766,6 +765,11 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 
 	/* TODO: Help propose a standard fb.h ioctl to report mmap damage */
 	if (cmd = DLFB_IOCTL_REPORT_DAMAGE) {
+		struct dloarea area;
+
+		if (copy_from_user(&area, (void __user *)arg,
+				   sizeof(struct dloarea)))
+			return -EFAULT;
 
 		/*
 		 * If we have a damage-aware client, turn fb_defio "off"
@@ -777,21 +781,19 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
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
 
@@ -839,7 +841,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 	 * preventing other clients (X) from working properly. Usually
 	 * not what the user wants. Fail by default with option to enable.
 	 */
-	if ((user = 0) & (!console))
+	if ((user = 0) && (!console))
 		return -EBUSY;
 
 	/* If the USB device is gone, we don't accept new opens */
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
