From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: Cleanup Coding style
Date: Tue, 19 Aug 2008 17:06:42 +0200
Message-ID: <1219158403-5180-4-git-send-email-s.hauer@pengutronix.de>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVSoP-0000me-Ae for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:07:57 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVSoO-0007lf-44
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:07:56 -0700
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

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |   78 +++++++++++++++++++++++++------------------------
 1 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 0622589..e450e6b 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/video/imxfb.c
- *
  *  Freescale i.MX Frame Buffer device driver
  *
  *  Copyright (C) 2004 Sascha Hauer, Pengutronix
@@ -161,20 +159,21 @@
 #define LCDISR_BOF	(1<<0)
 
 static struct imxfb_rgb def_rgb_16 = {
-	.red	= { .offset = 8,  .length = 4, },
-	.green	= { .offset = 4,  .length = 4, },
-	.blue	= { .offset = 0,  .length = 4, },
-	.transp = { .offset = 0,  .length = 0, },
+	.red	= {.offset = 8, .length = 4,},
+	.green	= {.offset = 4, .length = 4,},
+	.blue	= {.offset = 0, .length = 4,},
+	.transp = {.offset = 0, .length = 0,},
 };
 
 static struct imxfb_rgb def_rgb_8 = {
-	.red	= { .offset = 0,  .length = 8, },
-	.green	= { .offset = 0,  .length = 8, },
-	.blue	= { .offset = 0,  .length = 8, },
-	.transp = { .offset = 0,  .length = 0, },
+	.red	= {.offset = 0, .length = 8,},
+	.green	= {.offset = 0, .length = 8,},
+	.blue	= {.offset = 0, .length = 8,},
+	.transp = {.offset = 0, .length = 0,},
 };
 
-static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *info);
+static int imxfb_activate_var(struct fb_var_screeninfo *var,
+		struct fb_info *info);
 
 static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 {
@@ -185,7 +184,7 @@ static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 
 static int
 imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
-		       u_int trans, struct fb_info *info)
+		u_int trans, struct fb_info *info)
 {
 	struct imxfb_info *fbi = info->par;
 	u_int val, ret = 1;
@@ -250,7 +249,8 @@ imxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 	case FB_VISUAL_STATIC_PSEUDOCOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
-		ret = imxfb_setpalettereg(regno, red, green, blue, trans, info);
+		ret = imxfb_setpalettereg(regno, red, green, blue, trans,
+				info);
 		break;
 	}
 
@@ -336,8 +336,7 @@ static int imxfb_set_par(struct fb_info *info)
 		info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
 	}
 
-	info->fix.line_length = var->xres_virtual *
-				  var->bits_per_pixel / 8;
+	info->fix.line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	fbi->palette_size = var->bits_per_pixel == 8 ? 256 : 16;
 
 	imxfb_activate_var(var, info);
@@ -368,9 +367,9 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 
 	iowrite32(RMCR_LCDC_EN, fbi->regs + LCDC_RMCR);
 
-	if(fbi->backlight_power)
+	if (fbi->backlight_power)
 		fbi->backlight_power(1);
-	if(fbi->lcd_power)
+	if (fbi->lcd_power)
 		fbi->lcd_power(1);
 }
 
@@ -378,9 +377,9 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
 	pr_debug("Disabling LCD controller\n");
 
-	if(fbi->backlight_power)
+	if (fbi->backlight_power)
 		fbi->backlight_power(0);
-	if(fbi->lcd_power)
+	if (fbi->lcd_power)
 		fbi->lcd_power(0);
 
 	iowrite32(0, fbi->regs + LCDC_RMCR);
@@ -488,7 +487,8 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct imxfb_info *fbi = platform_get_drvdata(dev);
-	pr_debug("%s\n",__func__);
+
+	pr_debug("%s\n", __func__);
 
 	imxfb_disable_controller(fbi);
 	return 0;
@@ -497,7 +497,8 @@ static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
 static int imxfb_resume(struct platform_device *dev)
 {
 	struct imxfb_info *fbi = platform_get_drvdata(dev);
-	pr_debug("%s\n",__func__);
+
+	pr_debug("%s\n", __func__);
 
 	imxfb_enable_controller(fbi);
 	return 0;
@@ -515,31 +516,32 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 
 	pr_debug("%s\n",__func__);
 
-	info->pseudo_palette = kmalloc( sizeof(u32) * 16, GFP_KERNEL);
+	info->pseudo_palette = kmalloc(sizeof (u32) * 16, GFP_KERNEL);
 	if (!info->pseudo_palette)
 		return -ENOMEM;
 
-	memset(fbi, 0, sizeof(struct imxfb_info));
+	memset(fbi, 0, sizeof (struct imxfb_info));
 	fbi->pdev = pdev;
 
-	strlcpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
+	strlcpy(info->fix.id, IMX_NAME, sizeof (info->fix.id));
 
-	info->fix.type	= FB_TYPE_PACKED_PIXELS;
+	info->fix.type			= FB_TYPE_PACKED_PIXELS;
 	info->fix.type_aux		= 0;
 	info->fix.xpanstep		= 0;
 	info->fix.ypanstep		= 0;
 	info->fix.ywrapstep		= 0;
-	info->fix.accel	= FB_ACCEL_NONE;
+	info->fix.accel			= FB_ACCEL_NONE;
 
 	info->var.nonstd		= 0;
 	info->var.activate		= FB_ACTIVATE_NOW;
 	info->var.height		= -1;
 	info->var.width	= -1;
 	info->var.accel_flags		= 0;
-	info->var.vmode	= FB_VMODE_NONINTERLACED;
+	info->var.vmode			= FB_VMODE_NONINTERLACED;
 
 	info->fbops			= &imxfb_ops;
-	info->flags			= FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST;
+	info->flags			= FBINFO_FLAG_DEFAULT |
+					  FBINFO_READS_FAST;
 
 	fbi->rgb[RGB_16]		= &def_rgb_16;
 	fbi->rgb[RGB_8]			= &def_rgb_8;
@@ -577,11 +579,11 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 }
 
 /*
- *      Allocates the DRAM memory for the frame buffer.  This buffer is
- *	remapped into a non-cached, non-buffered, memory region to
- *      allow pixel writes to occur without flushing the cache.
- *      Once this area is remapped, all virtual memory access to the
- *      video memory should occur at the new region.
+ * Allocates the DRAM memory for the frame buffer.  This buffer is
+ * remapped into a non-cached, non-buffered, memory region to
+ * allow pixel writes to occur without flushing the cache.
+ * Once this area is remapped, all virtual memory access to the
+ * video memory should occur at the new region.
  */
 static int __init imxfb_map_video_memory(struct fb_info *info)
 {
@@ -612,17 +614,17 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	printk("i.MX Framebuffer driver\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if(!res)
+	if (!res)
 		return -ENODEV;
 
 	inf = pdev->dev.platform_data;
-	if(!inf) {
+	if (!inf) {
 		dev_err(&pdev->dev,"No platform_data available\n");
 		return -ENOMEM;
 	}
 
 	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
-	if(!info)
+	if (!info)
 		return -ENOMEM;
 
 	fbi = info->par;
@@ -630,7 +632,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 
 	ret = imxfb_init_fbinfo(pdev);
-	if( ret < 0 )
+	if (ret < 0)
 		goto failed_init;
 
 	res = request_mem_region(res->start, res->end - res->start + 1,
@@ -669,7 +671,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	 */
 	imxfb_check_var(&info->var, info);
 
-	ret = fb_alloc_cmap(&info->cmap, 1<<info->var.bits_per_pixel, 0);
+	ret = fb_alloc_cmap(&info->cmap, 1 << info->var.bits_per_pixel, 0);
 	if (ret < 0)
 		goto failed_cmap;
 
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
