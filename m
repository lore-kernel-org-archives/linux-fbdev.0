From: Liu Ying <Ying.Liu@freescale.com>
Date: Fri, 24 Jan 2014 06:04:36 +0000
Subject: [PATCH v4 2/2] backlight: update backlight status when necessary
Message-Id: <1390543476-13499-3-git-send-email-Ying.Liu@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390543476-13499-1-git-send-email-Ying.Liu@freescale.com>
In-Reply-To: <1390543476-13499-1-git-send-email-Ying.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, plagnioj@jcrosoft.com

We don't have to update a backlight status every time a
blanking or unblanking event comes because the backlight
status may have already been what we want. Another thought
is that one backlight device may be shared by multiple
framebuffers. We don't hope blanking one of the framebuffers
may turn the backlight off for all the other framebuffers,
since they are likely being active to display something.
This patch makes the backlight status be updated only when
the relevant backlight device's use count changes from zero
to one or from one to zero.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/video/backlight/backlight.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index efc9a2d..27d3cf2 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -34,7 +34,7 @@ static const char *const backlight_types[] = {
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /* This callback gets called when something important happens inside a
  * framebuffer driver. We're looking if that important event is blanking,
- * and if it is, we're switching backlight power as well ...
+ * and if it is and necessary, we're switching backlight power as well ...
  */
 static int fb_notifier_callback(struct notifier_block *self,
 				unsigned long event, void *data)
@@ -60,6 +60,7 @@ static int fb_notifier_callback(struct notifier_block *self,
 				if (!bd->use_count++) {
 					bd->props.state &= ~BL_CORE_FBBLANK;
 					bd->props.fb_blank = FB_BLANK_UNBLANK;
+					backlight_update_status(bd);
 				}
 			} else if (fb_blank != FB_BLANK_UNBLANK &&
 				   bd->fb_bl_on[node]) {
@@ -67,9 +68,9 @@ static int fb_notifier_callback(struct notifier_block *self,
 				if (!(--bd->use_count)) {
 					bd->props.state |= BL_CORE_FBBLANK;
 					bd->props.fb_blank = fb_blank;
+					backlight_update_status(bd);
 				}
 			}
-			backlight_update_status(bd);
 		}
 	mutex_unlock(&bd->ops_lock);
 	return 0;
-- 
1.7.9.5


