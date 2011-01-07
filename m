From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 07 Jan 2011 11:57:59 +0000
Subject: [PATCH 2/3 v2] fbdev: sh_mobile_hdmi: framebuffer notifiers have to
Message-Id: <Pine.LNX.4.64.1101071256300.32550@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A previous patch added a framebuffer notifier to sh_mobile_hdmi.c,
but did not register it with the framebuffer core. This patch adds
such a registration and moves the notifier block into dynamically
allocated per-device private data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 571bd9f..46ab355 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -221,6 +221,7 @@ struct sh_hdmi {
 	struct delayed_work edid_work;
 	struct fb_var_screeninfo var;
 	struct fb_monspecs monspec;
+	struct notifier_block notifier;
 };
 
 static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
@@ -1197,13 +1198,6 @@ out:
 }
 
 static int sh_hdmi_notify(struct notifier_block *nb,
-			  unsigned long action, void *data);
-
-static struct notifier_block sh_hdmi_notifier = {
-	.notifier_call = sh_hdmi_notify,
-};
-
-static int sh_hdmi_notify(struct notifier_block *nb,
 			  unsigned long action, void *data)
 {
 	struct fb_event *event = data;
@@ -1212,7 +1206,7 @@ static int sh_hdmi_notify(struct notifier_block *nb,
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
 	struct sh_hdmi *hdmi = board_cfg->board_data;
 
-	if (nb != &sh_hdmi_notifier || !hdmi || hdmi->info != info)
+	if (!hdmi || nb != &hdmi->notifier || hdmi->info != info)
 		return NOTIFY_DONE;
 
 	switch(action) {
@@ -1231,11 +1225,11 @@ static int sh_hdmi_notify(struct notifier_block *nb,
 		 * temporarily, synchronise with the work queue and re-acquire
 		 * the info->lock.
 		 */
-		unlock_fb_info(hdmi->info);
+		unlock_fb_info(info);
 		mutex_lock(&hdmi->mutex);
 		hdmi->info = NULL;
 		mutex_unlock(&hdmi->mutex);
-		lock_fb_info(hdmi->info);
+		lock_fb_info(info);
 		return NOTIFY_OK;
 	}
 	return NOTIFY_DONE;
@@ -1333,6 +1327,9 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto ecodec;
 	}
 
+	hdmi->notifier.notifier_call = sh_hdmi_notify;
+	fb_register_client(&hdmi->notifier);
+
 	return 0;
 
 ecodec:
@@ -1363,6 +1360,8 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_codec(&pdev->dev);
 
+	fb_unregister_client(&hdmi->notifier);
+
 	board_cfg->display_on = NULL;
 	board_cfg->display_off = NULL;
 	board_cfg->board_data = NULL;
-- 
1.7.2.3

