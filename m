From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:07:19 +0000
Subject: [PATCH v2 06/57] fbdev: sh_mobile_hdmi: Don't access LCDC channel in notifier callback
Message-Id: <1330614490-14149-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of relying on info->par being a pointer to an LCDC channel, cast
the notifier block pointer to an sh_hdmi pointer.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 647ba98..a77bbc3 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -225,6 +225,8 @@ struct sh_hdmi {
 	struct notifier_block notifier;
 };
 
+#define notifier_to_hdmi(n)	container_of(n, struct sh_hdmi, notifier)
+
 static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
 {
 	iowrite8(data, hdmi->base + reg);
@@ -1204,11 +1206,9 @@ static int sh_hdmi_notify(struct notifier_block *nb,
 {
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
-	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
-	struct sh_hdmi *hdmi = board_cfg->board_data;
+	struct sh_hdmi *hdmi = notifier_to_hdmi(nb);
 
-	if (!hdmi || nb != &hdmi->notifier || hdmi->info != info)
+	if (hdmi->info != info)
 		return NOTIFY_DONE;
 
 	switch(action) {
-- 
1.7.3.4

