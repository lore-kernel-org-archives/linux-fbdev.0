From: Liu Ying <Ying.Liu@freescale.com>
Date: Thu, 30 May 2013 08:13:53 +0000
Subject: [PATCH] backlight: Turn backlight on/off when necessary
Message-Id: <1369901633-31561-1-git-send-email-Ying.Liu@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, liu.y.victor@gmail.com, Liu Ying <Ying.Liu@freescale.com>

We don't have to turn backlight on/off everytime a blanking
or unblanking event comes because the backlight status may have
already been what we want. Another thought is that one backlight
device may be shared by multiple framebuffers. We don't hope that
blanking one of the framebuffers would turn the backlight off for
all the other framebuffers, since they are likely active to show
display content. This patch adds logic to record each framebuffer's
backlight status to determine the backlight device use count and
whether the backlight should be turned on or off.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/video/backlight/backlight.c |   23 +++++++++++++++++------
 include/linux/backlight.h           |    6 ++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index c74e7aa..97ea2b8 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -31,13 +31,14 @@ static const char *const backlight_types[] = {
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /* This callback gets called when something important happens inside a
  * framebuffer driver. We're looking if that important event is blanking,
- * and if it is, we're switching backlight power as well ...
+ * and if it is and necessary, we're switching backlight power as well ...
  */
 static int fb_notifier_callback(struct notifier_block *self,
 				unsigned long event, void *data)
 {
 	struct backlight_device *bd;
 	struct fb_event *evdata = data;
+	int node = evdata->info->node;
 
 	/* If we aren't interested in this event, skip it immediately ... */
 	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
@@ -49,11 +50,21 @@ static int fb_notifier_callback(struct notifier_block *self,
 		if (!bd->ops->check_fb ||
 		    bd->ops->check_fb(bd, evdata->info)) {
 			bd->props.fb_blank = *(int *)evdata->data;
-			if (bd->props.fb_blank = FB_BLANK_UNBLANK)
-				bd->props.state &= ~BL_CORE_FBBLANK;
-			else
-				bd->props.state |= BL_CORE_FBBLANK;
-			backlight_update_status(bd);
+			if (bd->props.fb_blank = FB_BLANK_UNBLANK &&
+			    !bd->fb_bl_on[node]) {
+				bd->fb_bl_on[node] = true;
+				if (!bd->use_count++) {
+					bd->props.state &= ~BL_CORE_FBBLANK;
+					backlight_update_status(bd);
+				}
+			} else if (bd->props.fb_blank != FB_BLANK_UNBLANK &&
+				   bd->fb_bl_on[node]) {
+				bd->fb_bl_on[node] = false;
+				if (!(--bd->use_count)) {
+					bd->props.state |= BL_CORE_FBBLANK;
+					backlight_update_status(bd);
+				}
+			}
 		}
 	mutex_unlock(&bd->ops_lock);
 	return 0;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index da9a082..5de71a0 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -9,6 +9,7 @@
 #define _LINUX_BACKLIGHT_H
 
 #include <linux/device.h>
+#include <linux/fb.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
@@ -101,6 +102,11 @@ struct backlight_device {
 	struct notifier_block fb_notif;
 
 	struct device dev;
+
+	/* Multiple framebuffers may share one backlight device */
+	bool fb_bl_on[FB_MAX];
+
+	int use_count;
 };
 
 static inline void backlight_update_status(struct backlight_device *bd)
-- 
1.7.1


