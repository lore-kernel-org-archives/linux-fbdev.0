From: David Vrabel <dvrabel@arcom.com>
Subject: Re: Geode now shows up in sysfs.
Date: Mon, 04 Jul 2005 11:09:51 +0100
Message-ID: <42C90AEF.4030601@arcom.com>
References: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070202000301050308090206"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DpNu6-0005cF-Bi
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Jul 2005 03:10:18 -0700
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DpNtq-00057u-Gz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Jul 2005 03:10:04 -0700
In-Reply-To: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, nat.ersoz@myrio.com, jsimmons@www.infradead.org

This is a multi-part message in MIME format.
--------------070202000301050308090206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

James Simmons wrote:
> Going through the drivers I noticed two drivers using framebuffer_alloc 
> without a sturct device, Mach64 for atari and geode. Here is a patch for 
> geode.

Thanks. It looks fine.

I've merged this patch with some other updates I had.  Please apply.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------070202000301050308090206
Content-Type: text/plain;
 name="geodefb-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="geodefb-fixes"

Geode framebuffer driver updates:
  - Local mode list (taken from modedb.c) containing only relevant modes. This
    also makes the driver work as a module.
  - Use pci_enable_device()/pci_disable_device().
  - Request resources.
  - Make it a platform_device and device_driver (from James Simmons
    <jsimmons@infradead.org>).
  - A few other minor, cosmetic bits and pieces.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-working/drivers/video/geode/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/Kconfig	2005-07-04 10:38:17.000000000 +0100
+++ linux-2.6-working/drivers/video/geode/Kconfig	2005-07-04 10:38:56.000000000 +0100
@@ -21,9 +21,7 @@
 	  Framebuffer driver for the display controller integrated into the
 	  AMD Geode GX1 processor.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted and removed from the running kernel whenever you want). The
-	  module will be called gx1fb. If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the module will be
+	  called gx1fb.
 
 	  If unsure, say N.
Index: linux-2.6-working/drivers/video/geode/gx1fb_core.c
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/gx1fb_core.c	2005-07-04 10:38:17.000000000 +0100
+++ linux-2.6-working/drivers/video/geode/gx1fb_core.c	2005-07-04 10:39:01.000000000 +0100
@@ -30,6 +30,62 @@
 static int  crt_option = 1;
 static char panel_option[32] = "";
 
+/* Modes relevant to the GX1 (taken from modedb.c) */
+static const struct fb_videomode __initdata gx1_modedb[] = {
+	/* 640x480-60 VESA */
+	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 640x480-75 VESA */
+	{ NULL, 75, 640, 480, 31746, 120, 16, 16, 01, 64, 3,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 640x480-85 VESA */
+	{ NULL, 85, 640, 480, 27777, 80, 56, 25, 01, 56, 3,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-60 VESA */
+	{ NULL, 60, 800, 600, 25000, 88, 40, 23, 01, 128, 4,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-75 VESA */
+	{ NULL, 75, 800, 600, 20202, 160, 16, 21, 01, 80, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-85 VESA */
+	{ NULL, 85, 800, 600, 17761, 152, 32, 27, 01, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-60 VESA */
+	{ NULL, 60, 1024, 768, 15384, 160, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-75 VESA */
+	{ NULL, 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-85 VESA */
+	{ NULL, 85, 1024, 768, 10582, 208, 48, 36, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x960-60 VESA */
+	{ NULL, 60, 1280, 960, 9259, 312, 96, 36, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x960-85 VESA */
+	{ NULL, 85, 1280, 960, 6734, 224, 64, 47, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-60 VESA */
+	{ NULL, 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-75 VESA */
+	{ NULL, 75, 1280, 1024, 7407, 248, 16, 38, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-85 VESA */
+	{ NULL, 85, 1280, 1024, 6349, 224, 64, 44, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+};
+
 static int gx1_line_delta(int xres, int bpp)
 {
 	int line_delta = xres * (bpp >> 3);
@@ -47,8 +103,6 @@
 {
 	struct geodefb_par *par = info->par;
 
-	printk(KERN_DEBUG "%s()\n", __FUNCTION__);
-
 	/* Maximum resolution is 1280x1024. */
 	if (var->xres > 1280 || var->yres > 1024)
 		return -EINVAL;
@@ -151,6 +205,7 @@
 	struct geodefb_par *par = info->par;
 	unsigned gx_base;
 	int fb_len;
+	int ret;
 
 	gx_base = gx1_gx_base();
 	if (!gx_base)
@@ -161,11 +216,20 @@
 	if (!par->vid_dev)
 		return -ENODEV;
 
+	ret = pci_enable_device(par->vid_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_request_region(par->vid_dev, 1, "gx1fb (video)");
+	if (ret < 0)
+		return ret;
 	par->vid_regs = ioremap(pci_resource_start(par->vid_dev, 1),
 				pci_resource_len(par->vid_dev, 1));
 	if (!par->vid_regs)
 		return -ENOMEM;
 
+        if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
+                return -EBUSY;
 	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
 	if (!par->dc_regs)
 		return -ENOMEM;
@@ -216,13 +280,13 @@
 	.fb_cursor	= soft_cursor,
 };
 
-static struct fb_info * __init gx1fb_init_fbinfo(void)
+static struct fb_info * __init gx1fb_init_fbinfo(struct device *dev)
 {
-	struct fb_info *info;
 	struct geodefb_par *par;
-
+	struct fb_info *info;
+	
 	/* Alloc enough space for the pseudo palette. */
-	info = framebuffer_alloc(sizeof(struct geodefb_par) + sizeof(u32) * 16, NULL);
+	info = framebuffer_alloc(sizeof(struct geodefb_par) + sizeof(u32) * 16, dev);
 	if (!info)
 		return NULL;
 
@@ -263,25 +327,16 @@
 	return info;
 }
 
-
-static struct fb_info *gx1fb_info;
-
-static int __init gx1fb_init(void)
+static int __init gx1fb_probe(struct device *device)
 {
+	struct platform_device *dev = to_platform_device(device);
+	struct geodefb_par *par;
 	struct fb_info *info;
-        struct geodefb_par *par;
 	int ret;
 
-#ifndef MODULE
-	if (fb_get_options("gx1fb", NULL))
-		return -ENODEV;
-#endif
-
-	info = gx1fb_init_fbinfo();
+	info = gx1fb_init_fbinfo(&dev->dev);
 	if (!info)
 		return -ENOMEM;
-	gx1fb_info = info;
-
 	par = info->par;
 
 	/* GX1 display controller and CS5530 video device */
@@ -293,7 +348,8 @@
 		goto err;
 	}
 
-	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 16);
+	ret = fb_find_mode(&info->var, info, mode_option,
+			   gx1_modedb, ARRAY_SIZE(gx1_modedb), NULL, 16);
 	if (ret == 0 || ret == 4) {
 		printk(KERN_ERR "%s: could not find valid video mode\n", info->fix.id);
 		ret = -EINVAL;
@@ -310,37 +366,81 @@
 		ret = -EINVAL;
 		goto err;
 	}
+	dev_set_drvdata(&dev->dev, info);
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;
 
   err:
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	if (par->vid_regs)
+	if (par->vid_regs) {
 		iounmap(par->vid_regs);
-	if (par->dc_regs)
+		pci_release_region(par->vid_dev, 1);
+	}
+	if (par->dc_regs) {
 		iounmap(par->dc_regs);
-	if (par->vid_dev)
+		release_mem_region(gx1_gx_base() + 0x8300, 0x100);
+	}
+	if (par->vid_dev) {
+		pci_disable_device(par->vid_dev);
 		pci_dev_put(par->vid_dev);
+	}
 	if (info)
 		framebuffer_release(info);
 	return ret;
 }
 
-static void __exit gx1fb_cleanup(void)
+static int gx1fb_remove(struct device *device)
 {
-	struct fb_info *info = gx1fb_info;
-	struct geodefb_par *par = gx1fb_info->par;
+	struct fb_info *info = dev_get_drvdata(device);
+	struct geodefb_par *par = info->par;
 
 	unregister_framebuffer(info);
 
 	iounmap((void __iomem *)info->screen_base);
 	iounmap(par->vid_regs);
+	pci_release_region(par->vid_dev, 1);
 	iounmap(par->dc_regs);
+	release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 
+	pci_disable_device(par->vid_dev);
 	pci_dev_put(par->vid_dev);
 
 	framebuffer_release(info);
+	return 0;
+}
+
+static struct platform_device *gx1fb_device;
+
+static struct device_driver gx1fb_driver = {
+	.name	= "geodefb",
+	.bus	= &platform_bus_type,
+	.probe	= gx1fb_probe,
+	.remove = gx1fb_remove,
+};
+
+static int __init gx1fb_init(void)
+{
+	int ret = 0;
+
+#ifndef MODULE
+	if (fb_get_options("gx1fb", NULL))
+		return -ENODEV;
+#endif
+	gx1fb_device = platform_device_register_simple("geodefb", -1, NULL, 0);
+	if (IS_ERR(gx1fb_device))
+		return PTR_ERR(gx1fb_device);
+
+	ret = driver_register(&gx1fb_driver);
+	if (ret < 0)
+		platform_device_unregister(gx1fb_device);
+	return ret;
+}
+
+static void __exit gx1fb_cleanup(void)
+{
+	platform_device_unregister(gx1fb_device);
+	driver_unregister(&gx1fb_driver);
 }
 
 module_init(gx1fb_init);
Index: linux-2.6-working/drivers/video/geode/video_cs5530.c
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/video_cs5530.c	2005-07-04 10:38:17.000000000 +0100
+++ linux-2.6-working/drivers/video/geode/video_cs5530.c	2005-07-04 10:38:56.000000000 +0100
@@ -69,8 +69,6 @@
 	{  4310, 0x2FB1B802, }, /* 232.0000 */
 };
 
-#define NUM_CS5530_FREQUENCIES sizeof(cs5530_pll_table)/sizeof(struct cs5530_pll_entry)
-
 static void cs5530_set_dclk_frequency(struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
@@ -82,7 +80,7 @@
 	value = cs5530_pll_table[0].pll_value;
 	min = cs5530_pll_table[0].pixclock - info->var.pixclock;
 	if (min < 0) min = -min;
-	for (i = 1; i < NUM_CS5530_FREQUENCIES; i++) {
+	for (i = 1; i < ARRAY_SIZE(cs5530_pll_table); i++) {
 		diff = cs5530_pll_table[i].pixclock - info->var.pixclock;
 		if (diff < 0L) diff = -diff;
 		if (diff < min) {

--------------070202000301050308090206--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
