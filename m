From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/9] fbcon: Use struct device instead of
	struct class_device
Date: Sun, 27 May 2007 08:50:56 +0800
Message-ID: <4658D5F0.5050300@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPn-0001vj-TU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:56 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPn-0003fW-Hj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:55 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:55 -0700 (PDT)
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

Port fbcon.c to use struct device from using struct class_device

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   57 +++++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index b7e143e..7f4ed79 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -198,7 +198,7 @@ static void fbcon_modechanged(struct fb_
 static void fbcon_set_all_vcs(struct fb_info *info);
 static void fbcon_start(void);
 static void fbcon_exit(void);
-static struct class_device *fbcon_class_device;
+static struct device *fbcon_device;
 
 #ifdef CONFIG_MAC
 /*
@@ -3246,8 +3246,9 @@ static struct notifier_block fbcon_event
 	.notifier_call	= fbcon_event_notify,
 };
 
-static ssize_t store_rotate(struct class_device *class_device,
-			    const char *buf, size_t count)
+static ssize_t store_rotate(struct device *device,
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
 {
 	struct fb_info *info;
 	int rotate, idx;
@@ -3270,8 +3271,9 @@ err:
 	return count;
 }
 
-static ssize_t store_rotate_all(struct class_device *class_device,
-				const char *buf, size_t count)
+static ssize_t store_rotate_all(struct device *device,
+				struct device_attribute *attr,const char *buf,
+				size_t count)
 {
 	struct fb_info *info;
 	int rotate, idx;
@@ -3294,7 +3296,8 @@ err:
 	return count;
 }
 
-static ssize_t show_rotate(struct class_device *class_device, char *buf)
+static ssize_t show_rotate(struct device *device,
+			   struct device_attribute *attr,char *buf)
 {
 	struct fb_info *info;
 	int rotate = 0, idx;
@@ -3315,7 +3318,8 @@ err:
 	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
-static ssize_t show_cursor_blink(struct class_device *class_device, char *buf)
+static ssize_t show_cursor_blink(struct device *device,
+				 struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info;
 	struct fbcon_ops *ops;
@@ -3342,7 +3346,8 @@ err:
 	return snprintf(buf, PAGE_SIZE, "%d\n", blink);
 }
 
-static ssize_t store_cursor_blink(struct class_device *clas_device,
+static ssize_t store_cursor_blink(struct device *device,
+				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
 	struct fb_info *info;
@@ -3378,22 +3383,21 @@ err:
 	return count;
 }
 
-static struct class_device_attribute class_device_attrs[] = {
+static struct device_attribute device_attrs[] = {
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
 	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
 	       store_cursor_blink),
 };
 
-static int fbcon_init_class_device(void)
+static int fbcon_init_device(void)
 {
 	int i, error = 0;
 
 	fbcon_has_sysfs = 1;
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
-		error = class_device_create_file(fbcon_class_device,
-						 &class_device_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
+		error = device_create_file(fbcon_device, &device_attrs[i]);
 
 		if (error)
 			break;
@@ -3401,8 +3405,7 @@ static int fbcon_init_class_device(void)
 
 	if (error) {
 		while (--i >= 0)
-			class_device_remove_file(fbcon_class_device,
-						 &class_device_attrs[i]);
+			device_remove_file(fbcon_device, &device_attrs[i]);
 
 		fbcon_has_sysfs = 0;
 	}
@@ -3488,16 +3491,15 @@ static int __init fb_console_init(void)
 
 	acquire_console_sem();
 	fb_register_client(&fbcon_event_notifier);
-	fbcon_class_device =
-	    class_device_create(fb_class, NULL, MKDEV(0, 0), NULL, "fbcon");
+	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), "fbcon");
 
-	if (IS_ERR(fbcon_class_device)) {
-		printk(KERN_WARNING "Unable to create class_device "
+	if (IS_ERR(fbcon_device)) {
+		printk(KERN_WARNING "Unable to create device "
 		       "for fbcon; errno = %ld\n",
-		       PTR_ERR(fbcon_class_device));
-		fbcon_class_device = NULL;
+		       PTR_ERR(fbcon_device));
+		fbcon_device = NULL;
 	} else
-		fbcon_init_class_device();
+		fbcon_init_device();
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
@@ -3511,14 +3513,13 @@ module_init(fb_console_init);
 
 #ifdef MODULE
 
-static void __exit fbcon_deinit_class_device(void)
+static void __exit fbcon_deinit_device(void)
 {
 	int i;
 
 	if (fbcon_has_sysfs) {
-		for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-			class_device_remove_file(fbcon_class_device,
-						 &class_device_attrs[i]);
+		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
+			device_remove_file(fbcon_device, &device_attrs[i]);
 
 		fbcon_has_sysfs = 0;
 	}
@@ -3528,8 +3529,8 @@ static void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
-	fbcon_deinit_class_device();
-	class_device_destroy(fb_class, MKDEV(0, 0));
+	fbcon_deinit_device();
+	device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
 	release_console_sem();
 	unregister_con_driver(&fb_con);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
