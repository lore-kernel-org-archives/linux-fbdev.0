From: James Simmons <jsimmons@infradead.org>
Subject: Re: Apollo framebuffer sysfs
Date: Mon, 23 Feb 2004 22:16:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402232216120.11599-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0402201402080.23753@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvOVf-0003fs-LT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 14:25:07 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AvONp-0001yD-0e
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 14:17:01 -0800
In-Reply-To: <Pine.GSO.4.58.0402201402080.23753@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Wow, the first platform_device on m68k ;-)

:-)

Merged with my patch. This patch is against linus tree. Please test.


--- linus-2.6/drivers/video/dnfb.c	2004-02-18 20:59:07.000000000 -0800
+++ fbdev-2.6/drivers/video/dnfb.c	2004-02-22 21:17:16.000000000 -0800
@@ -103,8 +103,6 @@
 
 #define SWAP(A) ((A>>8) | ((A&0xff) <<8))
 
-static struct fb_info fb_info;
-
 /* frame buffer operations */
 
 static int dnfb_blank(int blank, struct fb_info *info);
@@ -119,7 +117,7 @@
 	.fb_cursor	= soft_cursor,
 };
 
-struct fb_var_screeninfo dnfb_var __initdata = {
+struct fb_var_screeninfo dnfb_var __devinitdata = {
 	.xres		1280,
 	.yres		1024,
 	.xres_virtual	2048,
@@ -130,7 +128,7 @@
 	.vmode		FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo dnfb_fix __initdata = {
+static struct fb_fix_screeninfo dnfb_fix __devinitdata = {
 	.id		"Apollo Mono",
 	.smem_start	(FRAME_BUFFER_START + IO_BASE),
 	.smem_len	FRAME_BUFFER_LEN,
@@ -148,7 +146,7 @@
 	return 0;
 }
 
-static 
+static
 void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 
@@ -224,21 +222,38 @@
 	out_8(AP_CONTROL_0, NORMAL_MODE);
 }
 
+/*
+ * Initialization
+ */
 
-unsigned long __init dnfb_init(unsigned long mem_start)
+static int __devinit dnfb_probe(struct device *device)
 {
-	int err;
-
-	fb_info.fbops = &dn_fb_ops;
-	fb_info.fix = dnfb_fix;
-	fb_info.var = dnfb_var;
-	fb_info.screen_base = (u_char *) fb_info.fix.smem_start;
-
-	fb_alloc_cmap(&fb_info.cmap, 2, 0);
-
-	err = register_framebuffer(&fb_info);
-	if (err < 0)
-		panic("unable to register apollo frame buffer\n");
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	int err = 0;
+
+	info = framebuffer_alloc(0, &dev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	info->fbops = &dn_fb_ops;
+	info->fix = dnfb_fix;
+	info->var = dnfb_var;
+	info->screen_base = (u_char *) info->fix.smem_start;
+
+	err = fb_alloc_cmap(&info->cmap, 2, 0);
+	if (err < 0) {
+		framebuffer_release(info);
+		return err;
+	}
+	
+	err = register_framebuffer(info);
+	if (err < 0) {
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		return err;
+	}
+	dev_set_drvdata(&dev->dev, info);
 
 	/* now we have registered we can safely setup the hardware */
 	out_8(AP_CONTROL_3A, RESET_CREG);
@@ -249,7 +264,32 @@
 	out_be16(AP_ROP_1, SWAP(0x3));
 
 	printk("apollo frame buffer alive and kicking !\n");
-	return mem_start;
+	return err;
+}
+
+static struct device_driver dnfb_driver = {
+	.name	= "dnfb",
+	.bus	= &platform_bus_type,
+	.probe	= dnfb_probe,
+};
+
+static struct platform_device dnfb_device = {
+	.name	= "dnfb",
+	.id	= 0,
+};
+
+int __init dnfb_init(void)
+{
+	int ret;
+
+	ret = driver_register(&dnfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&dnfb_device);
+		if (ret)
+			driver_unregister(&dnfb_driver);
+	}
+	return ret;
 }
 
 MODULE_LICENSE("GPL");



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
