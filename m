From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/12] vga16fb: Update platform code
Date: Sat, 29 Apr 2006 08:40:14 +0800
Message-ID: <4452B5EE.9020002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdiV-0003ps-FZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:47 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiV-00017Y-KC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:47 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiV-0006gw-BQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:47 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:47 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Petr Vandrovec <vandrove@vc.cvut.cz>

Update platform code to dynamically allocate the platform device

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vga16fb.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 4fd2a27..3c404c9 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1334,9 +1334,8 @@ static int vga16fb_setup(char *options)
 }
 #endif
 
-static int __init vga16fb_probe(struct device *device)
+static int __init vga16fb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	struct vga16fb_par *par;
 	int i;
@@ -1403,7 +1402,7 @@ static int __init vga16fb_probe(struct d
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       info->node, info->fix.id);
-	dev_set_drvdata(device, info);
+	platform_set_drvdata(dev, info);
 
 	return 0;
 
@@ -1417,9 +1416,9 @@ static int __init vga16fb_probe(struct d
 	return ret;
 }
 
-static int vga16fb_remove(struct device *device)
+static int vga16fb_remove(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(dev);
 
 	if (info) {
 		unregister_framebuffer(info);
@@ -1432,16 +1431,15 @@ static int vga16fb_remove(struct device 
 	return 0;
 }
 
-static struct device_driver vga16fb_driver = {
-	.name = "vga16fb",
-	.bus  = &platform_bus_type,
+static struct platform_driver vga16fb_driver = {
 	.probe = vga16fb_probe,
 	.remove = vga16fb_remove,
+	.driver = {
+		.name = "vga16fb",
+	},
 };
 
-static struct platform_device vga16fb_device = {
-	.name = "vga16fb",
-};
+static struct platform_device *vga16fb_device;
 
 static int __init vga16fb_init(void)
 {
@@ -1454,12 +1452,20 @@ static int __init vga16fb_init(void)
 
 	vga16fb_setup(option);
 #endif
-	ret = driver_register(&vga16fb_driver);
+	ret = platform_driver_register(&vga16fb_driver);
 
 	if (!ret) {
-		ret = platform_device_register(&vga16fb_device);
-		if (ret)
-			driver_unregister(&vga16fb_driver);
+		vga16fb_device = platform_device_alloc("vga16fb", 0);
+
+		if (vga16fb_device)
+			ret = platform_device_add(vga16fb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(vga16fb_device);
+			platform_driver_unregister(&vga16fb_driver);
+		}
 	}
 
 	return ret;
@@ -1467,8 +1473,8 @@ static int __init vga16fb_init(void)
 
 static void __exit vga16fb_exit(void)
 {
-	platform_device_unregister(&vga16fb_device);
-	driver_unregister(&vga16fb_driver);
+	platform_device_unregister(vga16fb_device);
+	platform_driver_unregister(&vga16fb_driver);
 }
 
 MODULE_LICENSE("GPL");



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
