From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/12] epson1355fb: Update platform code
Date: Sat, 29 Apr 2006 08:35:34 +0800
Message-ID: <4452B4D6.7020105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdiH-0003oW-Gm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:33 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiH-000174-Lx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:33 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiH-0006gw-Do
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:33 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:33 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Christopher Hoover <ch@hpl.hp.com>

Update platform code to dynamically allocate the platform device

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/epson1355fb.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 0827594..f0a621e 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -605,11 +605,6 @@ static void clearfb16(struct fb_info *in
 		fb_writeb(0, dst);
 }
 
-static void epson1355fb_platform_release(struct device *device)
-{
-	dev_err(device, "This driver is broken, please bug the authors so they will fix it.\n");
-}
-
 static int epson1355fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
@@ -733,13 +728,7 @@ static struct platform_driver epson1355f
 	},
 };
 
-static struct platform_device epson1355fb_device = {
-	.name	= "epson1355fb",
-	.id	= 0,
-	.dev	= {
-		.release = epson1355fb_platform_release,
-	}
-};
+static struct platform_device *epson1355fb_device;
 
 int __init epson1355fb_init(void)
 {
@@ -749,11 +738,21 @@ int __init epson1355fb_init(void)
 		return -ENODEV;
 
 	ret = platform_driver_register(&epson1355fb_driver);
+
 	if (!ret) {
-		ret = platform_device_register(&epson1355fb_device);
-		if (ret)
+		epson1355fb_device = platform_device_alloc("epson1355fb", 0);
+
+		if (epson1355fb_device)
+			ret = platform_device_add(epson1355fb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(epson1355fb_device);
 			platform_driver_unregister(&epson1355fb_driver);
+		}
 	}
+
 	return ret;
 }
 
@@ -762,7 +761,7 @@ module_init(epson1355fb_init);
 #ifdef MODULE
 static void __exit epson1355fb_exit(void)
 {
-	platform_device_unregister(&epson1355fb_device);
+	platform_device_unregister(epson1355fb_device);
 	platform_driver_unregister(&epson1355fb_driver);
 }
 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
