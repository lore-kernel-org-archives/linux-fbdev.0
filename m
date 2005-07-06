From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Geode now shows up in sysfs.
Date: Thu, 7 Jul 2005 00:04:58 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507070004100.9719@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
 <42C90AEF.4030601@arcom.com> <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqIx0-0000FV-IF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 16:05:06 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqIwx-0001AS-Mz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 16:05:06 -0700
In-Reply-To: <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, nat.ersoz@myrio.com


Can you try this? If it works I will send it to Andrew ASAP.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/geodefb.h fbdev-2.6/drivers/video/geode/geodefb.h
--- linus-2.6/drivers/video/geode/geodefb.h	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/geodefb.h	2005-07-06 15:50:37.000000000 -0700
@@ -29,7 +29,6 @@
 	int enable_crt;
 	int panel_x; /* dimensions of an attached flat panel, non-zero => enable panel */
 	int panel_y;
-	struct pci_dev *vid_dev;
 	void __iomem *dc_regs;
 	void __iomem *vid_regs;
 	struct geode_dc_ops  *dc_ops;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/gx1fb_core.c fbdev-2.6/drivers/video/geode/gx1fb_core.c
--- linus-2.6/drivers/video/geode/gx1fb_core.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/gx1fb_core.c	2005-07-06 15:55:58.000000000 -0700
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
@@ -146,26 +200,31 @@
 	return par->vid_ops->blank_display(info, blank_mode);
 }
 
-static int __init gx1fb_map_video_memory(struct fb_info *info)
+static int __init gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 {
 	struct geodefb_par *par = info->par;
 	unsigned gx_base;
 	int fb_len;
+	int ret;
 
 	gx_base = gx1_gx_base();
 	if (!gx_base)
 		return -ENODEV;
 
-	par->vid_dev = pci_get_device(PCI_VENDOR_ID_CYRIX,
-				      PCI_DEVICE_ID_CYRIX_5530_VIDEO, NULL);
-	if (!par->vid_dev)
-		return -ENODEV;
-
-	par->vid_regs = ioremap(pci_resource_start(par->vid_dev, 1),
-				pci_resource_len(par->vid_dev, 1));
+	ret = pci_enable_device(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_request_region(dev, 1, "gx1fb (video)");
+	if (ret < 0)
+		return ret;
+	par->vid_regs = ioremap(pci_resource_start(dev, 1),
+				pci_resource_len(dev, 1));
 	if (!par->vid_regs)
 		return -ENOMEM;
 
+        if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
+                return -EBUSY;
 	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
 	if (!par->dc_regs)
 		return -ENOMEM;
@@ -216,13 +275,13 @@
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
 
@@ -263,37 +322,28 @@
 	return info;
 }
 
-
-static struct fb_info *gx1fb_info;
-
-static int __init gx1fb_init(void)
+static int __init gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
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
+	info = gx1fb_init_fbinfo(&pdev->dev);
 	if (!info)
 		return -ENOMEM;
-	gx1fb_info = info;
-
 	par = info->par;
 
 	/* GX1 display controller and CS5530 video device */
 	par->dc_ops  = &gx1_dc_ops;
 	par->vid_ops = &cs5530_vid_ops;
 
-	if ((ret = gx1fb_map_video_memory(info)) < 0) {
+	if ((ret = gx1fb_map_video_memory(info, pdev)) < 0) {
 		printk(KERN_ERR "%s: gx1fb_map_video_memory() failed\n", info->fix.id);
 		goto err;
 	}
 
-	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 16);
+	ret = fb_find_mode(&info->var, info, mode_option,
+			   gx1_modedb, ARRAY_SIZE(gx1_modedb), NULL, 16);
 	if (ret == 0 || ret == 4) {
 		printk(KERN_ERR "%s: could not find valid video mode\n", info->fix.id);
 		ret = -EINVAL;
@@ -310,37 +360,76 @@
 		ret = -EINVAL;
 		goto err;
 	}
+	pci_set_drvdata(pdev, info);
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;
 
   err:
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	if (par->vid_regs)
+	if (par->vid_regs) {
 		iounmap(par->vid_regs);
-	if (par->dc_regs)
+		pci_release_region(pdev, 1);
+	}
+	if (par->dc_regs) {
 		iounmap(par->dc_regs);
-	if (par->vid_dev)
-		pci_dev_put(par->vid_dev);
+		release_mem_region(gx1_gx_base() + 0x8300, 0x100);
+	}
+
+	pci_disable_device(pdev);
+	pci_dev_put(pdev);
+	
 	if (info)
 		framebuffer_release(info);
 	return ret;
 }
 
-static void __exit gx1fb_cleanup(void)
+static void gx1fb_remove(struct pci_dev *pdev)
 {
-	struct fb_info *info = gx1fb_info;
-	struct geodefb_par *par = gx1fb_info->par;
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct geodefb_par *par = info->par;
 
 	unregister_framebuffer(info);
 
 	iounmap((void __iomem *)info->screen_base);
 	iounmap(par->vid_regs);
+	pci_release_region(pdev, 1);
 	iounmap(par->dc_regs);
+	release_mem_region(gx1_gx_base() + 0x8300, 0x100);
+	pci_set_drvdata(pdev, NULL);
+	pci_disable_device(pdev);
+	pci_dev_put(pdev);
+	framebuffer_release(info);
+}
 
-	pci_dev_put(par->vid_dev);
+static struct pci_device_id gx1fb_id_table[] = {
+	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ 0, }
+};
 
-	framebuffer_release(info);
+MODULE_DEVICE_TABLE(pci, geodefb_id_table);
+
+static struct pci_driver gx1fb_driver = {
+	.name		= "geodefb",
+	.id_table	= gx1fb_id_table,
+	.probe		= gx1fb_probe,
+	.remove		= gx1fb_remove,
+};
+
+static int __init gx1fb_init(void)
+{
+#ifndef MODULE
+	if (fb_get_options("gx1fb", NULL))
+		return -ENODEV;
+#endif
+	return pci_register_driver(&gx1fb_driver);
+}
+
+static void __exit gx1fb_cleanup(void)
+{
+	pci_unregister_driver(&gx1fb_driver);
 }
 
 module_init(gx1fb_init);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/Kconfig fbdev-2.6/drivers/video/geode/Kconfig
--- linus-2.6/drivers/video/geode/Kconfig	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/Kconfig	2005-07-06 15:33:32.000000000 -0700
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
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/video_cs5530.c fbdev-2.6/drivers/video/geode/video_cs5530.c
--- linus-2.6/drivers/video/geode/video_cs5530.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/video_cs5530.c	2005-07-06 15:33:32.000000000 -0700
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


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
