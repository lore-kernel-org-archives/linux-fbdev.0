From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:23 +0000
Subject: [PATCH 28/57] fbdev: sh_mobile_hdmi: Don't set sh_hdmi::mode in the display on handler
Message-Id: <1323784972-24205-29-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The struct sh_hdmi mode field is only used after being assigned by the
EDID read code. There is thus no need to initialize it from the LCDC
display var in the display on handler.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 2617609..37f935f 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -995,7 +995,6 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
-	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
 
 	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi,
 		hdmi->hp_state);
@@ -1006,15 +1005,10 @@ static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 	 * HDMI_HOTPLUG_CONNECTED:	on monitor plug-in
 	 * HDMI_HOTPLUG_EDID_DONE:	on EDID read completion
 	 */
-	switch (hdmi->hp_state) {
-	case HDMI_HOTPLUG_EDID_DONE:
+	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
 		/* PS mode d->e. All functions are active */
 		hdmi_write(hdmi, 0x80, HDMI_SYSTEM_CTRL);
 		dev_dbg(hdmi->dev, "HDMI running\n");
-		break;
-	default:
-		fb_var_to_videomode(&hdmi->mode, &ch->display_var);
-		break;
 	}
 
 	return hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED
-- 
1.7.3.4

