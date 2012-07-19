From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Jul 2012 00:39:18 +0000
Subject: [PATCH 5/9] fbdev: sh_mobile_lcdc: Fix line pitch computation
Message-Id: <1342658362-19491-6-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Line pitch depends on the virtual horizontal resolution, compute it
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 644c230..67877cc 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1580,9 +1580,9 @@ static int sh_mobile_lcdc_overlay_set_par(struct fb_info *info)
 	ovl->yres_virtual = info->var.yres_virtual;
 
 	if (ovl->format->yuv)
-		ovl->pitch = info->var.xres;
+		ovl->pitch = info->var.xres_virtual;
 	else
-		ovl->pitch = info->var.xres * ovl->format->bpp / 8;
+		ovl->pitch = info->var.xres_virtual * ovl->format->bpp / 8;
 
 	sh_mobile_lcdc_overlay_setup(ovl);
 
@@ -2024,9 +2024,9 @@ static int sh_mobile_lcdc_set_par(struct fb_info *info)
 	ch->yres_virtual = info->var.yres_virtual;
 
 	if (ch->format->yuv)
-		ch->pitch = info->var.xres;
+		ch->pitch = info->var.xres_virtual;
 	else
-		ch->pitch = info->var.xres * ch->format->bpp / 8;
+		ch->pitch = info->var.xres_virtual * ch->format->bpp / 8;
 
 	ret = sh_mobile_lcdc_start(ch->lcdc);
 	if (ret < 0)
@@ -2539,9 +2539,9 @@ sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 	ovl->yres_virtual = ovl->yres * 2;
 
 	if (!format->yuv)
-		ovl->pitch = ovl->xres * format->bpp / 8;
+		ovl->pitch = ovl->xres_virtual * format->bpp / 8;
 	else
-		ovl->pitch = ovl->xres;
+		ovl->pitch = ovl->xres_virtual;
 
 	/* Allocate frame buffer memory. */
 	ovl->fb_size = ovl->cfg->max_xres * ovl->cfg->max_yres
@@ -2628,10 +2628,10 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 
 	if (!format->yuv) {
 		ch->colorspace = V4L2_COLORSPACE_SRGB;
-		ch->pitch = ch->xres * format->bpp / 8;
+		ch->pitch = ch->xres_virtual * format->bpp / 8;
 	} else {
 		ch->colorspace = V4L2_COLORSPACE_REC709;
-		ch->pitch = ch->xres;
+		ch->pitch = ch->xres_virtual;
 	}
 
 	ch->display.width = cfg->panel_cfg.width;
-- 
1.7.8.6

