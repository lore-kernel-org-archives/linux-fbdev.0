From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 11:06:11 +0000
Subject: [PATCH 4/5] fbdev: sh_mobile_lcdc: use correct number of modes, when
Message-Id: <Pine.LNX.4.64.1011041200340.13123@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix zero mode number, when using the default 720p mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8e8d698..993be38 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1188,6 +1188,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		const struct fb_videomode *mode = cfg->lcd_cfg;
 		unsigned long max_size = 0;
 		int k;
+		int num_cfg;
 
 		ch->info = framebuffer_alloc(0, &pdev->dev);
 		if (!ch->info) {
@@ -1223,8 +1224,14 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info->fix = sh_mobile_lcdc_fix;
 		info->fix.smem_len = max_size * (cfg->bpp / 8) * 2;
 
-		if (!mode)
+		if (!mode) {
 			mode = &default_720p;
+			num_cfg = 1;
+		} else {
+			num_cfg = ch->cfg.num_cfg;
+		}
+
+		fb_videomode_to_modelist(mode, num_cfg, &info->modelist);
 
 		fb_videomode_to_var(var, mode);
 		/* Default Y virtual resolution is 2x panel size */
@@ -1272,10 +1279,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < j; i++) {
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
-		const struct fb_videomode *mode = ch->cfg.lcd_cfg;
-
-		if (!mode)
-			mode = &default_720p;
 
 		info = ch->info;
 
@@ -1288,7 +1291,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
-		fb_videomode_to_modelist(mode, ch->cfg.num_cfg, &info->modelist);
 		error = register_framebuffer(info);
 		if (error < 0)
 			goto err1;
-- 
1.7.2.3

