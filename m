From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:37 +0000
Subject: [PATCH 02/19] fbdev: sh_mobile_lcdc: Rename mode argument to modes
Message-Id: <1345122054-16013-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The sh_mobile_lcdc_channel_fb_init() mode argument is used to pass a
list of modes, rename it to modes.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7375dbf..82b53f7 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -2187,7 +2187,7 @@ sh_mobile_lcdc_channel_fb_cleanup(struct sh_mobile_lcdc_chan *ch)
 
 static int __devinit
 sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
-			       const struct fb_videomode *mode,
+			       const struct fb_videomode *modes,
 			       unsigned int num_modes)
 {
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
@@ -2213,7 +2213,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->par = ch;
 
-	fb_videomode_to_modelist(mode, num_modes, &info->modelist);
+	fb_videomode_to_modelist(modes, num_modes, &info->modelist);
 
 	ret = fb_alloc_cmap(&info->cmap, PALETTE_NR, 0);
 	if (ret < 0) {
@@ -2247,7 +2247,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	 * default.
 	 */
 	var = &info->var;
-	fb_videomode_to_var(var, mode);
+	fb_videomode_to_var(var, modes);
 	var->width = ch->display.width;
 	var->height = ch->display.height;
 	var->xres_virtual = ch->xres_virtual;
-- 
1.7.8.6

