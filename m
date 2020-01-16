From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:51:15 +0000
Subject: [PATCH 1/2] video: fbdev: sh_mobile_lcdcfb: fix sparse warnings about using incorrect types
Message-Id: <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/video/fbdev/sh_mobile_lcdcfb.c
=================================--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1572,7 +1572,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_overlay_ops;
 	info->device = priv->dev;
-	info->screen_base = ovl->fb_mem;
+	info->screen_buffer = ovl->fb_mem;
 	info->par = ovl;
 
 	/* Initialize fixed screen information. Restrict pan to 2 lines steps
@@ -2056,7 +2056,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_ops;
 	info->device = priv->dev;
-	info->screen_base = ch->fb_mem;
+	info->screen_buffer = ch->fb_mem;
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->par = ch;
 
