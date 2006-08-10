From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/8] vt: Honor the return value of
	device_create_file
Date: Thu, 10 Aug 2006 19:48:12 +0800
Message-ID: <44DB1CFC.8030008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9AT-0003Cp-Qn for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:42 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9AR-0006Ho-Hd
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:41 -0700
Received: by nz-out-0102.google.com with SMTP id m22so116768nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:57:39 -0700 (PDT)
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

 drivers/char/vt.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 587aa9f..2470331 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -106,7 +106,8 @@ #include <asm/uaccess.h>
 #define MAX_NR_CON_DRIVER 16
 
 #define CON_DRIVER_FLAG_MODULE 1
-#define CON_DRIVER_FLAG_INIT 2
+#define CON_DRIVER_FLAG_INIT   2
+#define CON_DRIVER_FLAG_ATTR   4
 
 struct con_driver {
 	const struct consw *con;
@@ -3060,21 +3061,39 @@ static struct device_attribute device_at
 
 static int vtconsole_init_device(struct con_driver *con)
 {
-	int i;
+	int i, error = 0;
 
 	dev_set_drvdata(con->dev, con);
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-		device_create_file(con->dev, &device_attrs[i]);
 
-	return 0;
+	con->flag |= CON_DRIVER_FLAG_ATTR;
+
+	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
+		error = device_create_file(con->dev, &device_attrs[i]);
+
+		if (error)
+			break;
+	}
+
+	if (error) {
+		while (--i >= 0)
+			device_remove_file(con->dev, &device_attrs[i]);
+
+		con->flag &= ~CON_DRIVER_FLAG_ATTR;
+	}
+
+	return error;
 }
 
 static void vtconsole_deinit_device(struct con_driver *con)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-		device_remove_file(con->dev, &device_attrs[i]);
+	if (con->flag & CON_DRIVER_FLAG_ATTR) {
+		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
+			device_remove_file(con->dev, &device_attrs[i]);
+
+		con->flag &= ~CON_DRIVER_FLAG_ATTR;
+	}
 }
 
 /**
@@ -3172,6 +3191,7 @@ int register_con_driver(const struct con
 	} else {
 		vtconsole_init_device(con_driver);
 	}
+
 err:
 	release_console_sem();
 	module_put(owner);


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
