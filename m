From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 07 Jan 2011 11:58:03 +0000
Subject: [PATCH 3/3 v2] fbdev: sh_mobile_hdmi: simplify pointer handling
Message-Id: <Pine.LNX.4.64.1101071256520.32550@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 46ab355..e3eb77d 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -878,9 +878,9 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 	 * driver, and passing ->info with HDMI platform data.
 	 */
 	if (info && !found) {
-		modelist = hdmi->info->modelist.next &&
-			!list_empty(&hdmi->info->modelist) ?
-			list_entry(hdmi->info->modelist.next,
+		modelist = info->modelist.next &&
+			!list_empty(&info->modelist) ?
+			list_entry(info->modelist.next,
 				   struct fb_modelist, list) :
 			NULL;
 
@@ -1123,6 +1123,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 	mutex_lock(&hdmi->mutex);
 
 	if (hdmi->hp_state = HDMI_HOTPLUG_CONNECTED) {
+		struct fb_info *info = hdmi->info;
 		unsigned long parent_rate = 0, hdmi_rate;
 
 		/* A device has been plugged in */
@@ -1144,22 +1145,21 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		/* Switched to another (d) power-save mode */
 		msleep(10);
 
-		if (!hdmi->info)
+		if (!info)
 			goto out;
 
-		ch = hdmi->info->par;
+		ch = info->par;
 
 		acquire_console_sem();
 
 		/* HDMI plug in */
 		if (!sh_hdmi_must_reconfigure(hdmi) &&
-		    hdmi->info->state = FBINFO_STATE_RUNNING) {
+		    info->state = FBINFO_STATE_RUNNING) {
 			/*
 			 * First activation with the default monitor - just turn
 			 * on, if we run a resume here, the logo disappears
 			 */
-			if (lock_fb_info(hdmi->info)) {
-				struct fb_info *info = hdmi->info;
+			if (lock_fb_info(info)) {
 				info->var.width = hdmi->var.width;
 				info->var.height = hdmi->var.height;
 				sh_hdmi_display_on(hdmi, info);
@@ -1167,7 +1167,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 			}
 		} else {
 			/* New monitor or have to wake up */
-			fb_set_suspend(hdmi->info, 0);
+			fb_set_suspend(info, 0);
 		}
 
 		release_console_sem();
-- 
1.7.2.3

