From: Liu Ying <Ying.Liu@freescale.com>
Date: Fri, 24 Jan 2014 06:04:35 +0000
Subject: [PATCH v4 1/2] backlight: update bd state & fb_blank properties when necessary
Message-Id: <1390543476-13499-2-git-send-email-Ying.Liu@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390543476-13499-1-git-send-email-Ying.Liu@freescale.com>
In-Reply-To: <1390543476-13499-1-git-send-email-Ying.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, plagnioj@jcrosoft.com

We don't have to update the state and fb_blank properties of
a backlight device every time a blanking or unblanking event
comes because they may have already been what we want. Another
thought is that one backlight device may be shared by multiple
framebuffers. The backlight driver should take the backlight
device as a resource shared by all the associated framebuffers.
This patch adds some logics to record each framebuffer's backlight
usage to determine the backlight device use count and whether
the two properties should be updated or not. To be more specific,
only one unblank operation on a certain blanked framebuffer may
increase the backlight device's use count by one, while one blank
operation on a certain unblanked framebuffer may decrease the use
count by one, because the userspace is likely to unblank an
unblanked framebuffer or blank a blanked framebuffer.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/video/backlight/backlight.c |   23 ++++++++++++++++++-----
 include/linux/backlight.h           |    6 ++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 5d05555..efc9a2d 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -41,6 +41,8 @@ static int fb_notifier_callback(struct notifier_block *self,
 {
 	struct backlight_device *bd;
 	struct fb_event *evdata = data;
+	int node = evdata->info->node;
+	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
 	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
@@ -51,11 +53,22 @@ static int fb_notifier_callback(struct notifier_block *self,
 	if (bd->ops)
 		if (!bd->ops->check_fb ||
 		    bd->ops->check_fb(bd, evdata->info)) {
-			bd->props.fb_blank = *(int *)evdata->data;
-			if (bd->props.fb_blank = FB_BLANK_UNBLANK)
-				bd->props.state &= ~BL_CORE_FBBLANK;
-			else
-				bd->props.state |= BL_CORE_FBBLANK;
+			fb_blank = *(int *)evdata->data;
+			if (fb_blank = FB_BLANK_UNBLANK &&
+			    !bd->fb_bl_on[node]) {
+				bd->fb_bl_on[node] = true;
+				if (!bd->use_count++) {
+					bd->props.state &= ~BL_CORE_FBBLANK;
+					bd->props.fb_blank = FB_BLANK_UNBLANK;
+				}
+			} else if (fb_blank != FB_BLANK_UNBLANK &&
+				   bd->fb_bl_on[node]) {
+				bd->fb_bl_on[node] = false;
+				if (!(--bd->use_count)) {
+					bd->props.state |= BL_CORE_FBBLANK;
+					bd->props.fb_blank = fb_blank;
+				}
+			}
 			backlight_update_status(bd);
 		}
 	mutex_unlock(&bd->ops_lock);
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 5f9cd96..7264742 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -9,6 +9,7 @@
 #define _LINUX_BACKLIGHT_H
 
 #include <linux/device.h>
+#include <linux/fb.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
@@ -104,6 +105,11 @@ struct backlight_device {
 	struct list_head entry;
 
 	struct device dev;
+
+	/* Multiple framebuffers may share one backlight device */
+	bool fb_bl_on[FB_MAX];
+
+	int use_count;
 };
 
 static inline void backlight_update_status(struct backlight_device *bd)
-- 
1.7.9.5


