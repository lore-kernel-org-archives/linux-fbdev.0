From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: rename
	imxfb_mach_info to imx_fb_platform_data
Date: Tue, 19 Aug 2008 17:06:43 +0200
Message-ID: <1219158403-5180-5-git-send-email-s.hauer@pengutronix.de>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVSo1-0000k0-Lq for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:07:33 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVSnz-0005gJ-55
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:07:33 -0700
In-Reply-To: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

rename imxfb_mach_info to a name more common to kernel hackers

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/include/mach/imxfb.h |    5 +-
 drivers/video/imxfb.c                  |   68 ++++++++++++++++----------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-imx/include/mach/imxfb.h b/arch/arm/mach-imx/include/mach/imxfb.h
index 3ed9ec8..ffcff5a 100644
--- a/arch/arm/mach-imx/include/mach/imxfb.h
+++ b/arch/arm/mach-imx/include/mach/imxfb.h
@@ -1,7 +1,7 @@
 /*
  * This structure describes the machine which we are running on.
  */
-struct imxfb_mach_info {
+struct imx_fb_platform_data {
 	u_long		pixclock;
 
 	u_short		xres;
@@ -34,4 +34,5 @@ struct imxfb_mach_info {
 	void (*lcd_power)(int);
 	void (*backlight_power)(int);
 };
-void set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info);
+
+void set_imx_fb_info(struct imx_fb_platform_data *);
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index e450e6b..a4a4940 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -510,7 +510,7 @@ static int imxfb_resume(struct platform_device *dev)
 
 static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 {
-	struct imxfb_mach_info *inf = pdev->dev.platform_data;
+	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
 	struct fb_info *info = dev_get_drvdata(&pdev->dev);
 	struct imxfb_info *fbi = info->par;
 
@@ -546,32 +546,32 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 	fbi->rgb[RGB_16]		= &def_rgb_16;
 	fbi->rgb[RGB_8]			= &def_rgb_8;
 
-	fbi->max_xres			= inf->xres;
-	info->var.xres			= inf->xres;
-	info->var.xres_virtual		= inf->xres;
-	fbi->max_yres			= inf->yres;
-	info->var.yres			= inf->yres;
-	info->var.yres_virtual		= inf->yres;
-	fbi->max_bpp			= inf->bpp;
-	info->var.bits_per_pixel	= inf->bpp;
-	info->var.nonstd		= inf->nonstd;
-	info->var.pixclock		= inf->pixclock;
-	info->var.hsync_len		= inf->hsync_len;
-	info->var.left_margin		= inf->left_margin;
-	info->var.right_margin		= inf->right_margin;
-	info->var.vsync_len		= inf->vsync_len;
-	info->var.upper_margin		= inf->upper_margin;
-	info->var.lower_margin		= inf->lower_margin;
-	info->var.sync			= inf->sync;
-	info->var.grayscale		= inf->cmap_greyscale;
-	fbi->cmap_inverse		= inf->cmap_inverse;
-	fbi->cmap_static		= inf->cmap_static;
-	fbi->pcr			= inf->pcr;
-	fbi->lscr1			= inf->lscr1;
-	fbi->dmacr			= inf->dmacr;
-	fbi->pwmr			= inf->pwmr;
-	fbi->lcd_power			= inf->lcd_power;
-	fbi->backlight_power		= inf->backlight_power;
+	fbi->max_xres			= pdata->xres;
+	info->var.xres			= pdata->xres;
+	info->var.xres_virtual		= pdata->xres;
+	fbi->max_yres			= pdata->yres;
+	info->var.yres			= pdata->yres;
+	info->var.yres_virtual		= pdata->yres;
+	fbi->max_bpp			= pdata->bpp;
+	info->var.bits_per_pixel	= pdata->bpp;
+	info->var.nonstd		= pdata->nonstd;
+	info->var.pixclock		= pdata->pixclock;
+	info->var.hsync_len		= pdata->hsync_len;
+	info->var.left_margin		= pdata->left_margin;
+	info->var.right_margin		= pdata->right_margin;
+	info->var.vsync_len		= pdata->vsync_len;
+	info->var.upper_margin		= pdata->upper_margin;
+	info->var.lower_margin		= pdata->lower_margin;
+	info->var.sync			= pdata->sync;
+	info->var.grayscale		= pdata->cmap_greyscale;
+	fbi->cmap_inverse		= pdata->cmap_inverse;
+	fbi->cmap_static		= pdata->cmap_static;
+	fbi->pcr			= pdata->pcr;
+	fbi->lscr1			= pdata->lscr1;
+	fbi->dmacr			= pdata->dmacr;
+	fbi->pwmr			= pdata->pwmr;
+	fbi->lcd_power			= pdata->lcd_power;
+	fbi->backlight_power		= pdata->backlight_power;
 	info->fix.smem_len		= fbi->max_xres * fbi->max_yres *
 					  fbi->max_bpp / 8;
 
@@ -607,7 +607,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 {
 	struct imxfb_info *fbi;
 	struct fb_info *info;
-	struct imxfb_mach_info *inf;
+	struct imx_fb_platform_data *pdata;
 	struct resource *res;
 	int ret;
 
@@ -617,8 +617,8 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	inf = pdev->dev.platform_data;
-	if (!inf) {
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
 		dev_err(&pdev->dev,"No platform_data available\n");
 		return -ENOMEM;
 	}
@@ -648,7 +648,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 		goto failed_ioremap;
 	}
 
-	if (!inf->fixed_screen_cpu) {
+	if (!pdata->fixed_screen_cpu) {
 		ret = imxfb_map_video_memory(info);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
@@ -657,8 +657,8 @@ static int __init imxfb_probe(struct platform_device *pdev)
 		}
 	} else {
 		/* Fixed framebuffer mapping enables location of the screen in eSRAM */
-		fbi->map_cpu = inf->fixed_screen_cpu;
-		fbi->map_dma = inf->fixed_screen_dma;
+		fbi->map_cpu = pdata->fixed_screen_cpu;
+		fbi->map_dma = pdata->fixed_screen_dma;
 		info->screen_base = fbi->map_cpu;
 		fbi->screen_cpu = fbi->map_cpu;
 		fbi->screen_dma = fbi->map_dma;
@@ -689,7 +689,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 failed_register:
 	fb_dealloc_cmap(&info->cmap);
 failed_cmap:
-	if (!inf->fixed_screen_cpu)
+	if (!pdata->fixed_screen_cpu)
 		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
 			fbi->map_dma);
 failed_map:
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
