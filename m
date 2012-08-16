From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:36 +0000
Subject: [PATCH 01/19] fbdev: sh_mobile_lcdc: Get display dimensions from the channel structure
Message-Id: <1345122054-16013-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Get the display dimensions directly from the channel structure instead
of recomputing them from the monitor specs or accessing the platform
data.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bccfd7e..7375dbf 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -586,8 +586,8 @@ static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
 				 * Just turn on, if we run a resume here, the
 				 * logo disappears.
 				 */
-				info->var.width = monspec->max_x * 10;
-				info->var.height = monspec->max_y * 10;
+				info->var.width = ch->display.width;
+				info->var.height = ch->display.height;
 				sh_mobile_lcdc_display_on(ch);
 			} else {
 				/* New monitor or have to wake up */
@@ -2248,8 +2248,8 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	 */
 	var = &info->var;
 	fb_videomode_to_var(var, mode);
-	var->width = ch->cfg->panel_cfg.width;
-	var->height = ch->cfg->panel_cfg.height;
+	var->width = ch->display.width;
+	var->height = ch->display.height;
 	var->xres_virtual = ch->xres_virtual;
 	var->yres_virtual = ch->yres_virtual;
 	var->activate = FB_ACTIVATE_NOW;
-- 
1.7.8.6

