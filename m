From: James Simmons <jsimmons@www.infradead.org>
Subject: Geode now shows up in sysfs.
Date: Sat, 2 Jul 2005 00:37:27 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoV4g-00082S-48
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:37:34 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DoV4f-0008EA-B8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:37:34 -0700
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


Going through the drivers I noticed two drivers using framebuffer_alloc 
without a sturct device, Mach64 for atari and geode. Here is a patch for 
geode. The mach64 will take a bit longer to figure. Please test. Thank 
you.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/geode/gx1fb_core.c fbdev-2.6/drivers/video/geode/gx1fb_core.c
--- linus-2.6/drivers/video/geode/gx1fb_core.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/geode/gx1fb_core.c	2005-07-01 09:18:25.000000000 -0700
@@ -216,13 +216,13 @@
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
 
@@ -263,25 +263,16 @@
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
@@ -310,6 +301,7 @@
 		ret = -EINVAL;
 		goto err;
 	}
+	dev_set_drvdata(&dev->dev, info);
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;
 
@@ -327,10 +319,10 @@
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
 
@@ -341,6 +333,40 @@
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


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
