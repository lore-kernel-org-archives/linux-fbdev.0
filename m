From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/12] vfb: Update platform code
Date: Sat, 29 Apr 2006 08:38:46 +0800
Message-ID: <4452B596.5010106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdiP-0003pO-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:41 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiQ-00017M-1g
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:42 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiP-0006gw-Pu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:42 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:41 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

Update platform code to dynamically allocate the platform device

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vfb.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 77eed1f..d073ffb 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -398,12 +398,6 @@ static int __init vfb_setup(char *option
      *  Initialisation
      */
 
-static void vfb_platform_release(struct device *device)
-{
-	// This is called when the reference count goes to zero.
-	dev_err(device, "This driver is broken, please bug the authors so they will fix it.\n");
-}
-
 static int __init vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
@@ -482,13 +476,7 @@ static struct platform_driver vfb_driver
 	},
 };
 
-static struct platform_device vfb_device = {
-	.name	= "vfb",
-	.id	= 0,
-	.dev	= {
-		.release = vfb_platform_release,
-	}
-};
+static struct platform_device *vfb_device;
 
 static int __init vfb_init(void)
 {
@@ -508,10 +496,19 @@ static int __init vfb_init(void)
 	ret = platform_driver_register(&vfb_driver);
 
 	if (!ret) {
-		ret = platform_device_register(&vfb_device);
-		if (ret)
+		vfb_device = platform_device_alloc("vfb", 0);
+
+		if (vfb_device)
+			ret = platform_device_add(vfb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(vfb_device);
 			platform_driver_unregister(&vfb_driver);
+		}
 	}
+
 	return ret;
 }
 
@@ -520,7 +517,7 @@ module_init(vfb_init);
 #ifdef MODULE
 static void __exit vfb_exit(void)
 {
-	platform_device_unregister(&vfb_device);
+	platform_device_unregister(vfb_device);
 	platform_driver_unregister(&vfb_driver);
 }
 





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
