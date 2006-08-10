From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/8] fbcon: Honor the return value of
	device_create_file
Date: Thu, 10 Aug 2006 19:49:58 +0800
Message-ID: <44DB1D66.7010402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9Ag-0003D6-Qx for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:55 -0700
Received: from nz-out-0102.google.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9Af-0002Y7-Id
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:54 -0700
Received: by nz-out-0102.google.com with SMTP id 9so129306nzo
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:57:52 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Check the return value of device_create_file(). If return is 'fail', remove
attributes by calling device_remove_file().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index cf4c999..b8c7724 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -133,6 +133,7 @@ static int info_idx = -1;
 
 /* console rotation */
 static int rotate;
+static int fbcon_has_sysfs;
 
 static const struct consw fb_con;
 
@@ -3166,11 +3167,26 @@ static struct class_device_attribute cla
 
 static int fbcon_init_class_device(void)
 {
-	int i;
+	int i, error = 0;
+
+	fbcon_has_sysfs = 1;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
+		error = class_device_create_file(fbcon_class_device,
+						 &class_device_attrs[i]);
+
+		if (error)
+			break;
+	}
+
+	if (error) {
+		while (--i >= 0)
+			class_device_remove_file(fbcon_class_device,
+						 &class_device_attrs[i]);
+
+		fbcon_has_sysfs = 0;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_create_file(fbcon_class_device,
-					 &class_device_attrs[i]);
 	return 0;
 }
 
@@ -3279,9 +3295,13 @@ static void __exit fbcon_deinit_class_de
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_remove_file(fbcon_class_device,
-					 &class_device_attrs[i]);
+	if (fbcon_has_sysfs) {
+		for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+			class_device_remove_file(fbcon_class_device,
+						 &class_device_attrs[i]);
+
+		fbcon_has_sysfs = 0;
+	}
 }
 
 static void __exit fb_console_exit(void)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
