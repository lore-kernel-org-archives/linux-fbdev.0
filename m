From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Jul 2012 00:39:19 +0000
Subject: [PATCH 6/9] fbdev: sh_mobile_lcdc: Use channel configuration to initialize fb device
Message-Id: <1342658362-19491-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Copy the x and y virtual resolutions from the channel information
instead of recomputing them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 67877cc..68011b5 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -2214,14 +2214,14 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 		info->fix.ypanstep = 2;
 
 	/* Initialize variable screen information using the first mode as
-	 * default. The default Y virtual resolution is twice the panel size to
-	 * allow for double-buffering.
+	 * default.
 	 */
 	var = &info->var;
 	fb_videomode_to_var(var, mode);
 	var->width = ch->cfg->panel_cfg.width;
 	var->height = ch->cfg->panel_cfg.height;
-	var->yres_virtual = var->yres * 2;
+	var->xres_virtual = ch->xres_virtual;
+	var->yres_virtual = ch->yres_virtual;
 	var->activate = FB_ACTIVATE_NOW;
 
 	/* Use the legacy API by default for RGB formats, and the FOURCC API
@@ -2619,7 +2619,9 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 		num_modes = cfg->num_modes;
 	}
 
-	/* Use the first mode as default. */
+	/* Use the first mode as default. The default Y virtual resolution is
+	 * twice the panel size to allow for double-buffering.
+	 */
 	ch->format = format;
 	ch->xres = mode->xres;
 	ch->xres_virtual = mode->xres;
-- 
1.7.8.6

