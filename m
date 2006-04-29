From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/12] vesafb: Update platform code
Date: Sat, 29 Apr 2006 08:37:03 +0800
Message-ID: <4452B52F.4010807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdiL-0003oj-I5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:37 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiL-00017A-Np
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:37 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiL-0006gw-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:37 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:37 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>

Update platform code to dynamically allocate the platform device

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vesafb.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index b0b9acf..2fbaa84 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -460,9 +460,7 @@ static struct platform_driver vesafb_dri
 	},
 };
 
-static struct platform_device vesafb_device = {
-	.name	= "vesafb",
-};
+static struct platform_device *vesafb_device;
 
 static int __init vesafb_init(void)
 {
@@ -475,10 +473,19 @@ static int __init vesafb_init(void)
 	ret = platform_driver_register(&vesafb_driver);
 
 	if (!ret) {
-		ret = platform_device_register(&vesafb_device);
-		if (ret)
+		vesafb_device = platform_device_alloc("vesafb", 0);
+
+		if (vesafb_device)
+			ret = platform_device_add(vesafb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(vesafb_device);
 			platform_driver_unregister(&vesafb_driver);
+		}
 	}
+
 	return ret;
 }
 module_init(vesafb_init);



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
