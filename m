From: James Simmons <jsimmons@infradead.org>
Subject: vfb updates.
Date: Thu, 22 Apr 2004 19:16:23 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404221915320.24337-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGikT-0001io-KF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 11:16:33 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGikP-00047z-LH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 11:16:30 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch updates the Virtual framebuffer to use the 
frmaebuffer_alloc/release functions.

--- linus-2.6/drivers/video/vfb.c	2004-02-12 18:31:45.000000000 -0800
+++ fbdev-2.6/drivers/video/vfb.c	2004-04-21 17:46:38.000000000 -0700
@@ -37,9 +37,6 @@
 static u_long videomemorysize = VIDEOMEMSIZE;
 MODULE_PARM(videomemorysize, "l");
 
-static struct fb_info fb_info;
-static u32 vfb_pseudo_palette[17];
-
 static struct fb_var_screeninfo vfb_default __initdata = {
 	.xres =		640,
 	.yres =		480,
@@ -72,7 +69,7 @@
 	.accel =	FB_ACCEL_NONE,
 };
 
-static int vfb_enable __initdata = 0;	/* disabled by default */
+static int vfb_enable __initdata = 1;	/* disabled by default */
 MODULE_PARM(vfb_enable, "i");
 
     /*
@@ -404,18 +401,22 @@
      *  Initialisation
      */
 
-int __init vfb_init(void)
+static void vfb_platform_release(struct device *device)
 {
-	int retval;
+	// This is called when the reference count goes to zero.
+}
 
-	if (!vfb_enable)
-		return -ENXIO;
+static int __init vfb_probe(struct device *device)
+{
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	int retval = -ENOMEM;
 
 	/*
 	 * For real video cards we use ioremap.
 	 */
 	if (!(videomemory = vmalloc(videomemorysize)))
-		return -ENOMEM;
+		return retval;
 
 	/*
 	 * VFB must clear memory to prevent kernel info
@@ -425,41 +426,98 @@
 	 */
 	memset(videomemory, 0, videomemorysize);
 
-	fb_info.screen_base = videomemory;
-	fb_info.fbops = &vfb_ops;
-
-	retval = fb_find_mode(&fb_info.var, &fb_info, NULL,
+	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
+	if (!info)
+		goto err;
+
+	info->screen_base = videomemory;
+	info->fbops = &vfb_ops;
+	
+	retval = fb_find_mode(&info->var, info, NULL,
 			      NULL, 0, NULL, 8);
 
 	if (!retval || (retval == 4))
-		fb_info.var = vfb_default;
-	fb_info.fix = vfb_fix;
-	fb_info.pseudo_palette = &vfb_pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+		info->var = vfb_default;
+	info->fix = vfb_fix;
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	retval = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (retval < 0)
+		goto err1;
+		
+	retval = register_framebuffer(info);
+	if (retval < 0)
+		goto err2;
+	dev_set_drvdata(&dev->dev, info);
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	printk(KERN_INFO
+	       "fb%d: Virtual frame buffer device, using %ldK of video memory\n",
+	       info->node, videomemorysize >> 10);
+	return 0;
+err2:
+	fb_dealloc_cmap(&info->cmap);
+err1:
+	framebuffer_release(info);
+err:
+	vfree(videomemory);
+	return retval;
+}
 
-	if (register_framebuffer(&fb_info) < 0) {
+static int vfb_remove(struct device *device)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+	
+	if (info) {	
+		unregister_framebuffer(info);
 		vfree(videomemory);
-		return -EINVAL;
+		framebuffer_release(info);
 	}
-
-	printk(KERN_INFO
-	       "fb%d: Virtual frame buffer device, using %ldK of video memory\n",
-	       fb_info.node, videomemorysize >> 10);
 	return 0;
 }
+	
+static struct device_driver vfb_driver = {
+	.name	= "vfb",
+	.bus	= &platform_bus_type,
+	.probe	= vfb_probe,
+	.remove = vfb_remove,
+};
 
-#ifdef MODULE
+static struct platform_device vfb_device = {
+	.name	= "vfb",
+	.id	= 0,
+	.dev	= {
+		.release = vfb_platform_release,
+	}	
+};
 
-static void __exit vfb_cleanup(void)
+int __init vfb_init(void)
 {
-	unregister_framebuffer(&fb_info);
-	vfree(videomemory);
+	int ret = 0;
+
+	if (!vfb_enable)
+		return -ENXIO;
+
+	ret = driver_register(&vfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&vfb_device);
+		if (ret)
+			driver_unregister(&vfb_driver);
+	}
+	return ret;
+}
+
+#ifdef MODULE
+static void __exit vfb_exit(void)
+{
+	platform_device_unregister(&vfb_device);
+	driver_unregister(&vfb_driver);
 }
 
 module_init(vfb_init);
-module_exit(vfb_cleanup);
+module_exit(vfb_exit);
 
 MODULE_LICENSE("GPL");
 #endif				/* MODULE */



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
