From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] geode updates.
Date: Fri, 12 Aug 2005 01:06:49 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508120103420.13219@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3N4c-0005Zs-M9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 17:06:58 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E3N4a-00045I-JS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 17:06:58 -0700
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
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Okay I see what you meant. So what I did was create two hardware devices. 
One a pci device for the Cyrix video so it will show up in the sysfs pci 
tree. A second platform device for the embedded geode GX processsor. The 
framebuffer device is uses both devices but considered itself attached to 
the embedded core. Try it out!


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/display_gx1.c fbdev-2.6/drivers/video/geode/display_gx1.c
--- linus-2.6/drivers/video/geode/display_gx1.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/display_gx1.c	2005-08-11 16:40:57.000000000 -0700
@@ -61,7 +61,6 @@
 	if (!mc_regs)
 		return -ENOMEM;
 
-
 	/* Calculate the total size of both DIMM0 and DIMM1. */
 	bank_cfg = readl(mc_regs + MC_BANK_CFG);
 
@@ -72,9 +71,7 @@
 	}
 
 	fb_base = (readl(mc_regs + MC_GBASE_ADD) & MC_GADD_GBADD_MASK) << 19;
-
 	iounmap(mc_regs);
-
 	return dram_size - fb_base;
 }
 
@@ -86,32 +83,32 @@
 	int vactive, vblankstart, vsyncstart, vsyncend, vblankend, vtotal;
 
 	/* Unlock the display controller registers. */
-	readl(par->dc_regs + DC_UNLOCK);
-	writel(DC_UNLOCK_CODE, par->dc_regs + DC_UNLOCK);
+	readl(par->dc_ops->dc_regs + DC_UNLOCK);
+	writel(DC_UNLOCK_CODE, par->dc_ops->dc_regs + DC_UNLOCK);
 
-	gcfg = readl(par->dc_regs + DC_GENERAL_CFG);
-	tcfg = readl(par->dc_regs + DC_TIMING_CFG);
+	gcfg = readl(par->dc_ops->dc_regs + DC_GENERAL_CFG);
+	tcfg = readl(par->dc_ops->dc_regs + DC_TIMING_CFG);
 
 	/* Blank the display and disable the timing generator. */
 	tcfg &= ~(DC_TCFG_BLKE | DC_TCFG_TGEN);
-	writel(tcfg, par->dc_regs + DC_TIMING_CFG);
+	writel(tcfg, par->dc_ops->dc_regs + DC_TIMING_CFG);
 
 	/* Wait for pending memory requests before disabling the FIFO load. */
 	udelay(100);
 
 	/* Disable FIFO load and compression. */
 	gcfg &= ~(DC_GCFG_DFLE | DC_GCFG_CMPE | DC_GCFG_DECE);
-	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+	writel(gcfg, par->dc_ops->dc_regs + DC_GENERAL_CFG);
 
 	/* Setup DCLK and its divisor. */
 	gcfg &= ~DC_GCFG_DCLK_MASK;
-	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+	writel(gcfg, par->dc_ops->dc_regs + DC_GENERAL_CFG);
 
-	par->vid_ops->set_dclk(info);
+	par->vid_ops->set_dclk(par->vid_ops, info->var.pixclock);
 
 	dclk_div = DC_GCFG_DCLK_DIV_1; /* FIXME: may need to divide DCLK by 2 sometimes? */
 	gcfg |= dclk_div;
-	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+	writel(gcfg, par->dc_ops->dc_regs + DC_GENERAL_CFG);
 
 	/* Wait for the clock generatation to settle.  This is needed since
 	 * some of the register writes that follow require that clock to be
@@ -132,12 +129,12 @@
 	/* FIXME: Set pixel and line double bits if necessary. */
 
 	/* Framebuffer start offset. */
-	writel(0, par->dc_regs + DC_FB_ST_OFFSET);
+	writel(0, par->dc_ops->dc_regs + DC_FB_ST_OFFSET);
 
 	/* Line delta and line buffer length. */
-	writel(info->fix.line_length >> 2, par->dc_regs + DC_LINE_DELTA);
+	writel(info->fix.line_length >> 2, par->dc_ops->dc_regs + DC_LINE_DELTA);
 	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
-	       par->dc_regs + DC_BUF_SIZE);
+	       par->dc_ops->dc_regs + DC_BUF_SIZE);
 
 	/* Output configuration. Enable panel data, set pixel format. */
 	ocfg = DC_OCFG_PCKE | DC_OCFG_PDEL | DC_OCFG_PDEH;
@@ -163,31 +160,31 @@
 	vtotal = vblankend;
 
 	val = (hactive - 1) | ((htotal - 1) << 16);
-	writel(val, par->dc_regs + DC_H_TIMING_1);
+	writel(val, par->dc_ops->dc_regs + DC_H_TIMING_1);
 	val = (hblankstart - 1) | ((hblankend - 1) << 16);
-	writel(val, par->dc_regs + DC_H_TIMING_2);
+	writel(val, par->dc_ops->dc_regs + DC_H_TIMING_2);
 	val = (hsyncstart - 1) | ((hsyncend - 1) << 16);
-	writel(val, par->dc_regs + DC_H_TIMING_3);
-	writel(val, par->dc_regs + DC_FP_H_TIMING);
+	writel(val, par->dc_ops->dc_regs + DC_H_TIMING_3);
+	writel(val, par->dc_ops->dc_regs + DC_FP_H_TIMING);
 	val = (vactive - 1) | ((vtotal - 1) << 16);
-	writel(val, par->dc_regs + DC_V_TIMING_1);
+	writel(val, par->dc_ops->dc_regs + DC_V_TIMING_1);
 	val = (vblankstart - 1) | ((vblankend - 1) << 16);
-	writel(val, par->dc_regs + DC_V_TIMING_2);
+	writel(val, par->dc_ops->dc_regs + DC_V_TIMING_2);
 	val = (vsyncstart - 1) | ((vsyncend - 1) << 16);
-	writel(val, par->dc_regs + DC_V_TIMING_3);
+	writel(val, par->dc_ops->dc_regs + DC_V_TIMING_3);
 	val = (vsyncstart - 2) | ((vsyncend - 2) << 16);
-	writel(val, par->dc_regs + DC_FP_V_TIMING);
+	writel(val, par->dc_ops->dc_regs + DC_FP_V_TIMING);
 
 	/* Write final register values. */
-	writel(ocfg, par->dc_regs + DC_OUTPUT_CFG);
-	writel(tcfg, par->dc_regs + DC_TIMING_CFG);
+	writel(ocfg, par->dc_ops->dc_regs + DC_OUTPUT_CFG);
+	writel(tcfg, par->dc_ops->dc_regs + DC_TIMING_CFG);
 	udelay(1000); /* delay after TIMING_CFG. FIXME: perhaps a little long */
-	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+	writel(gcfg, par->dc_ops->dc_regs + DC_GENERAL_CFG);
 
-	par->vid_ops->configure_display(info);
+	par->vid_ops->configure_display(par->vid_ops, info);
 
 	/* Relock display controller registers */
-	writel(0, par->dc_regs + DC_UNLOCK);
+	writel(0, par->dc_ops->dc_regs + DC_UNLOCK);
 
 	/* FIXME: write line_length and bpp to Graphics Pipeline GP_BLT_STATUS
 	 * register. */
@@ -204,11 +201,12 @@
 	val |= (green >>  4) & 0x00fc0;
 	val |= (blue  >> 10) & 0x0003f;
 
-	writel(regno, par->dc_regs + DC_PAL_ADDRESS);
-	writel(val, par->dc_regs + DC_PAL_DATA);
+	writel(regno, par->dc_ops->dc_regs + DC_PAL_ADDRESS);
+	writel(val, par->dc_ops->dc_regs + DC_PAL_DATA);
 }
 
 struct geode_dc_ops gx1_dc_ops = {
 	.set_mode	 = gx1_set_mode,
 	.set_palette_reg = gx1_set_hw_palette_reg,
 };
+
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/geodefb.h fbdev-2.6/drivers/video/geode/geodefb.h
--- linus-2.6/drivers/video/geode/geodefb.h	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/geodefb.h	2005-08-11 16:35:34.000000000 -0700
@@ -17,21 +17,20 @@
 struct geode_dc_ops {
 	void (*set_mode)(struct fb_info *);
 	void (*set_palette_reg)(struct fb_info *, unsigned, unsigned, unsigned, unsigned);
+	void __iomem *dc_regs;
 };
 
 struct geode_vid_ops {
-	void (*set_dclk)(struct fb_info *);
-	void (*configure_display)(struct fb_info *);
-	int  (*blank_display)(struct fb_info *, int blank_mode);
+	void (*set_dclk)(struct geode_vid_ops *ops, u32 pixclock);
+	void (*configure_display)(struct geode_vid_ops *ops, struct fb_info *);
+	int  (*blank_display)(struct geode_vid_ops *ops, struct fb_info *, int blank_mode);
+	void __iomem *vid_regs;
 };
 
 struct geodefb_par {
 	int enable_crt;
 	int panel_x; /* dimensions of an attached flat panel, non-zero => enable panel */
 	int panel_y;
-	struct pci_dev *vid_dev;
-	void __iomem *dc_regs;
-	void __iomem *vid_regs;
 	struct geode_dc_ops  *dc_ops;
 	struct geode_vid_ops *vid_ops;
 };
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/gx1fb_core.c fbdev-2.6/drivers/video/geode/gx1fb_core.c
--- linus-2.6/drivers/video/geode/gx1fb_core.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/gx1fb_core.c	2005-08-11 16:36:35.000000000 -0700
@@ -26,10 +26,68 @@
 #include "display_gx1.h"
 #include "video_cs5530.h"
 
+extern struct pci_driver cs5530_driver;
+
 static char mode_option[32] = "640x480-16@60";
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
@@ -47,8 +105,6 @@
 {
 	struct geodefb_par *par = info->par;
 
-	printk(KERN_DEBUG "%s()\n", __FUNCTION__);
-
 	/* Maximum resolution is 1280x1024. */
 	if (var->xres > 1280 || var->yres > 1024)
 		return -EINVAL;
@@ -143,44 +199,26 @@
 {
 	struct geodefb_par *par = info->par;
 
-	return par->vid_ops->blank_display(info, blank_mode);
+	return par->vid_ops->blank_display(par->vid_ops, info, blank_mode);
 }
 
-static int __init gx1fb_map_video_memory(struct fb_info *info)
+static int __init gx1fb_map_video_memory(struct fb_info *info, struct platform_device *dev)
 {
 	struct geodefb_par *par = info->par;
-	unsigned gx_base;
-	int fb_len;
-
-	gx_base = gx1_gx_base();
-	if (!gx_base)
-		return -ENODEV;
-
-	par->vid_dev = pci_get_device(PCI_VENDOR_ID_CYRIX,
-				      PCI_DEVICE_ID_CYRIX_5530_VIDEO, NULL);
-	if (!par->vid_dev)
-		return -ENODEV;
-
-	par->vid_regs = ioremap(pci_resource_start(par->vid_dev, 1),
-				pci_resource_len(par->vid_dev, 1));
-	if (!par->vid_regs)
-		return -ENOMEM;
 
-	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
-	if (!par->dc_regs)
+	if (dev->num_resources != 2)
+                return -EBUSY;
+	par->dc_ops->dc_regs = ioremap(dev->resource[0].start, 0x100);
+	if (!par->dc_ops->dc_regs)
 		return -ENOMEM;
 
-	info->fix.smem_start = gx_base + 0x800000;
-	if ((fb_len = gx1_frame_buffer_size()) < 0)
-		return -ENOMEM;
-	info->fix.smem_len = fb_len;
+	info->fix.smem_len = dev->resource[1].end - dev->resource[1].start;
+	info->fix.smem_start = dev->resource[1].start;
 	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (!info->screen_base)
 		return -ENOMEM;
-
 	printk(KERN_INFO "%s: %d Kibyte of video memory at 0x%lx\n",
 	       info->fix.id, info->fix.smem_len / 1024, info->fix.smem_start);
-
 	return 0;
 }
 
@@ -216,13 +254,13 @@
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
 
@@ -263,37 +301,29 @@
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
 	par->dc_ops  = &gx1_dc_ops;
 	par->vid_ops = &cs5530_vid_ops;
 
-	if ((ret = gx1fb_map_video_memory(info)) < 0) {
+	if ((ret = gx1fb_map_video_memory(info, dev)) < 0) {
 		printk(KERN_ERR "%s: gx1fb_map_video_memory() failed\n", info->fix.id);
 		goto err;
 	}
 
-	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 16);
+	ret = fb_find_mode(&info->var, info, mode_option,
+			   gx1_modedb, ARRAY_SIZE(gx1_modedb), NULL, 16);
 	if (ret == 0 || ret == 4) {
 		printk(KERN_ERR "%s: could not find valid video mode\n", info->fix.id);
 		ret = -EINVAL;
@@ -310,37 +340,104 @@
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
-		iounmap(par->vid_regs);
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (par->vid_dev)
-		pci_dev_put(par->vid_dev);
+	if (par->dc_ops->dc_regs)
+		iounmap(par->dc_ops->dc_regs);
 	if (info)
 		framebuffer_release(info);
 	return ret;
 }
 
-static void __exit gx1fb_cleanup(void)
+static int __exit gx1fb_remove(struct device *dev)
 {
-	struct fb_info *info = gx1fb_info;
-	struct geodefb_par *par = gx1fb_info->par;
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct geodefb_par *par = info->par;
 
 	unregister_framebuffer(info);
 
 	iounmap((void __iomem *)info->screen_base);
-	iounmap(par->vid_regs);
-	iounmap(par->dc_regs);
+	iounmap(par->dc_ops->dc_regs);
+	dev_set_drvdata(dev, NULL);
+	framebuffer_release(info);
+	return 0;
+}
 
-	pci_dev_put(par->vid_dev);
+static struct platform_device *gx1fb_device;
 
-	framebuffer_release(info);
+static struct device_driver gx1fb_driver = {
+	.name		= "geodefb",
+	.bus		= &platform_bus_type,
+	.probe		= gx1fb_probe,
+	.remove		= gx1fb_remove,
+};
+
+static int __init gx1fb_init(void)
+{
+	struct resource *gx1_resource = NULL, *gx2_resource = NULL;
+	unsigned gx_base;
+	int len, ret;
+
+#ifndef MODULE
+	if (fb_get_options("gx1fb", NULL))
+		return -ENODEV;
+#endif
+	gx_base = gx1_gx_base();
+	if (!gx_base)
+		return -ENODEV;
+
+	if ((len = gx1_frame_buffer_size()) < 0)
+		return -ENOMEM;
+
+	ret = pci_register_driver(&cs5530_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = driver_register(&gx1fb_driver);
+	if (ret < 0) {
+		pci_unregister_driver(&cs5530_driver);
+		return ret;
+	}
+
+        gx1_resource = request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)");
+	if (!gx1_resource) {
+		driver_unregister(&gx1fb_driver);	
+		pci_unregister_driver(&cs5530_driver);
+		return -EBUSY;
+	}
+
+        gx2_resource = request_mem_region(gx_base + 0x800000, len, "gx1fb frame buffer");
+	if (!gx1_resource) {
+		release_resource(gx1_resource);
+		driver_unregister(&gx1fb_driver);
+		pci_unregister_driver(&cs5530_driver);
+		return -EBUSY;
+	}
+
+	gx1fb_device = platform_device_register_simple("geodefb", -1, gx1_resource, 2);
+	if (IS_ERR(gx1fb_device)) {
+		release_resource(gx2_resource);
+		release_resource(gx1_resource);
+		driver_unregister(&gx1fb_driver);
+		pci_unregister_driver(&cs5530_driver);
+		return PTR_ERR(gx1fb_device);
+	}
+	return ret;
+}
+
+static void __exit gx1fb_cleanup(void)
+{
+	// unregister the Cyrix video component.
+	pci_unregister_driver(&cs5530_driver);
+
+	// unregister the embedded graphics core.
+	platform_device_unregister(gx1fb_device);
+	driver_unregister(&gx1fb_driver);
 }
 
 module_init(gx1fb_init);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/Kconfig fbdev-2.6/drivers/video/geode/Kconfig
--- linus-2.6/drivers/video/geode/Kconfig	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/Kconfig	2005-08-11 13:34:58.000000000 -0700
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
--- linus-2.6/drivers/video/geode/video_cs5530.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/video_cs5530.c	2005-08-11 13:34:58.000000000 -0700
@@ -14,6 +14,7 @@
  */
 #include <linux/fb.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <asm/delay.h>
 
@@ -69,21 +70,18 @@
 	{  4310, 0x2FB1B802, }, /* 232.0000 */
 };
 
-#define NUM_CS5530_FREQUENCIES sizeof(cs5530_pll_table)/sizeof(struct cs5530_pll_entry)
-
-static void cs5530_set_dclk_frequency(struct fb_info *info)
+static void cs5530_set_dclk_frequency(struct geode_vid_ops *ops, u32 pixclock)
 {
-	struct geodefb_par *par = info->par;
-	int i;
-	u32 value;
 	long min, diff;
+	u32 value;
+	int i;
 
 	/* Search the table for the closest pixclock. */
 	value = cs5530_pll_table[0].pll_value;
-	min = cs5530_pll_table[0].pixclock - info->var.pixclock;
+	min = cs5530_pll_table[0].pixclock - pixclock;
 	if (min < 0) min = -min;
-	for (i = 1; i < NUM_CS5530_FREQUENCIES; i++) {
-		diff = cs5530_pll_table[i].pixclock - info->var.pixclock;
+	for (i = 1; i < ARRAY_SIZE(cs5530_pll_table); i++) {
+		diff = cs5530_pll_table[i].pixclock - pixclock;
 		if (diff < 0L) diff = -diff;
 		if (diff < min) {
 			min = diff;
@@ -91,19 +89,19 @@
 		}
 	}
 
-	writel(value, par->vid_regs + CS5530_DOT_CLK_CONFIG);
-	writel(value | 0x80000100, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* set reset and bypass */
+	writel(value, ops->vid_regs + CS5530_DOT_CLK_CONFIG);
+	writel(value | 0x80000100, ops->vid_regs + CS5530_DOT_CLK_CONFIG); /* set reset and bypass */
 	udelay(500); /* wait for PLL to settle */
-	writel(value & 0x7FFFFFFF, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear reset */
-	writel(value & 0x7FFFFEFF, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear bypass */
+	writel(value & 0x7FFFFFFF, ops->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear reset */
+	writel(value & 0x7FFFFEFF, ops->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear bypass */
 }
 
-static void cs5530_configure_display(struct fb_info *info)
+static void cs5530_configure_display(struct geode_vid_ops *ops, struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
 	u32 dcfg;
 
-	dcfg = readl(par->vid_regs + CS5530_DISPLAY_CONFIG);
+	dcfg = readl(ops->vid_regs + CS5530_DISPLAY_CONFIG);
 
 	/* Clear bits from existing mode. */
 	dcfg &= ~(CS5530_DCFG_CRT_SYNC_SKW_MASK | CS5530_DCFG_PWR_SEQ_DLY_MASK
@@ -133,10 +131,10 @@
 	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		dcfg |= CS5530_DCFG_CRT_VSYNC_POL;
 
-	writel(dcfg, par->vid_regs + CS5530_DISPLAY_CONFIG);
+	writel(dcfg, ops->vid_regs + CS5530_DISPLAY_CONFIG);
 }
 
-static int cs5530_blank_display(struct fb_info *info, int blank_mode)
+static int cs5530_blank_display(struct geode_vid_ops *ops, struct fb_info *info, int blank_mode)
 {
 	struct geodefb_par *par = info->par;
 	u32 dcfg;
@@ -162,7 +160,7 @@
 		return -EINVAL;
 	}
 
-	dcfg = readl(par->vid_regs + CS5530_DISPLAY_CONFIG);
+	dcfg = readl(ops->vid_regs + CS5530_DISPLAY_CONFIG);
 
 	dcfg &= ~(CS5530_DCFG_DAC_BL_EN | CS5530_DCFG_DAC_PWR_EN
 		  | CS5530_DCFG_HSYNC_EN | CS5530_DCFG_VSYNC_EN
@@ -182,9 +180,7 @@
 		if (hsync && vsync)
 			dcfg |= CS5530_DCFG_FP_PWR_EN;
 	}
-
-	writel(dcfg, par->vid_regs + CS5530_DISPLAY_CONFIG);
-
+	writel(dcfg, ops->vid_regs + CS5530_DISPLAY_CONFIG);
 	return 0;
 }
 
@@ -193,3 +189,59 @@
 	.configure_display = cs5530_configure_display,
 	.blank_display     = cs5530_blank_display,
 };
+
+static int __init cs5530_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret = 0;
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		goto err;
+
+	ret = pci_request_region(pdev, 1, "Cyrix 5530 (video)");
+	if (ret < 0)
+		goto err;
+
+	cs5530_vid_ops.vid_regs = ioremap(pci_resource_start(pdev, 1),
+					  pci_resource_len(pdev, 1));
+	if (!cs5530_vid_ops.vid_regs) {
+		pci_release_region(pdev, 1);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	pci_set_drvdata(pdev, &cs5530_vid_ops);
+	return 0;
+err:
+	pci_disable_device(pdev);
+	pci_dev_put(pdev);
+	return ret;
+}
+
+static void cs5530_remove(struct pci_dev *pdev)
+{
+	struct geode_vid_ops *vid_ops = pci_get_drvdata(pdev);
+
+	iounmap(vid_ops->vid_regs);
+	pci_release_region(pdev, 1);
+	pci_set_drvdata(pdev, NULL);
+	pci_disable_device(pdev);
+	pci_dev_put(pdev);
+}
+
+static struct pci_device_id cs5530_id_table[] = {
+	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, cs5530_id_table);
+
+struct pci_driver cs5530_driver = {
+	.name		= "Cyrix 5530 video",
+	.id_table	= cs5530_id_table,
+	.probe		= cs5530_probe,
+	.remove		= cs5530_remove,
+};
+


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
