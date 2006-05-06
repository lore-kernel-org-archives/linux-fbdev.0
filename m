From: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] Backlight/LCD Class: Fix sysfs _store error handling
Date: Sat, 06 May 2006 12:12:28 +0100
Message-ID: <1146913948.6237.50.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FcKiG-0002OO-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 May 2006 04:12:40 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FcKiG-0005az-NJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 May 2006 04:12:40 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FcKiF-0001bz-QN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 May 2006 04:12:40 -0700
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, FB-Dev <linux-fbdev-devel@lists.sourceforge.net>

The backlight and LCD class _store functions currently accept values
like "34 some random strings" without error. This corrects them to
return -EINVAL if the value is not numeric with an optional byte of
trailing whitespace.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/video/backlight/backlight.c
===================================================================
--- git.orig/drivers/video/backlight/backlight.c	2006-05-06 11:31:48.000000000 +0100
+++ git/drivers/video/backlight/backlight.c	2006-05-06 11:31:52.000000000 +0100
@@ -29,12 +29,15 @@
 
 static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO, power;
+	int rc = -ENXIO;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
+	int power = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
 
-	power = simple_strtoul(buf, &endp, 0);
-	if (*endp && !isspace(*endp))
+	if (*endp && isspace(*endp))
+		size++;
+	if (size != count)
 		return -EINVAL;
 
 	down(&bd->sem);
@@ -65,12 +68,15 @@
 
 static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO, brightness;
+	int rc = -ENXIO;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
+	int brightness = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
 
-	brightness = simple_strtoul(buf, &endp, 0);
-	if (*endp && !isspace(*endp))
+	if (*endp && isspace(*endp))
+		size++;
+	if (size != count)
 		return -EINVAL;
 
 	down(&bd->sem);
Index: git/drivers/video/backlight/lcd.c
===================================================================
--- git.orig/drivers/video/backlight/lcd.c	2006-05-04 23:13:05.000000000 +0100
+++ git/drivers/video/backlight/lcd.c	2006-05-06 11:35:29.000000000 +0100
@@ -31,12 +31,15 @@
 
 static ssize_t lcd_store_power(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc, power;
+	int rc = -ENXIO;
 	char *endp;
 	struct lcd_device *ld = to_lcd_device(cdev);
+	int power = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
 
-	power = simple_strtoul(buf, &endp, 0);
-	if (*endp && !isspace(*endp))
+	if (*endp && isspace(*endp))
+		size++;
+	if (size != count)
 		return -EINVAL;
 
 	down(&ld->sem);
@@ -44,8 +47,7 @@
 		pr_debug("lcd: set power to %d\n", power);
 		ld->props->set_power(ld, power);
 		rc = count;
-	} else
-		rc = -ENXIO;
+	}
 	up(&ld->sem);
 
 	return rc;
@@ -53,14 +55,12 @@
 
 static ssize_t lcd_show_contrast(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
 	down(&ld->sem);
 	if (likely(ld->props && ld->props->get_contrast))
 		rc = sprintf(buf, "%d\n", ld->props->get_contrast(ld));
-	else
-		rc = -ENXIO;
 	up(&ld->sem);
 
 	return rc;
@@ -68,12 +68,15 @@
 
 static ssize_t lcd_store_contrast(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc, contrast;
+	int rc = -ENXIO;
 	char *endp;
 	struct lcd_device *ld = to_lcd_device(cdev);
+	int contrast = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
 
-	contrast = simple_strtoul(buf, &endp, 0);
-	if (*endp && !isspace(*endp))
+	if (*endp && isspace(*endp))
+		size++;
+	if (size != count)
 		return -EINVAL;
 
 	down(&ld->sem);
@@ -81,8 +84,7 @@
 		pr_debug("lcd: set contrast to %d\n", contrast);
 		ld->props->set_contrast(ld, contrast);
 		rc = count;
-	} else
-		rc = -ENXIO;
+	}
 	up(&ld->sem);
 
 	return rc;
@@ -90,14 +92,12 @@
 
 static ssize_t lcd_show_max_contrast(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
 	down(&ld->sem);
 	if (likely(ld->props))
 		rc = sprintf(buf, "%d\n", ld->props->max_contrast);
-	else
-		rc = -ENXIO;
 	up(&ld->sem);
 
 	return rc;




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
