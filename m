From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/8] fbdev: Honor the return value of
	device_create_file
Date: Thu, 10 Aug 2006 19:49:09 +0800
Message-ID: <44DB1D35.6040901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9AZ-0003Cw-CS for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:47 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9AY-0006Ho-46
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:47 -0700
Received: by nz-out-0102.google.com with SMTP id m22so116768nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:57:45 -0700 (PDT)
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

 drivers/video/fbsysfs.c |   35 ++++++++++++++++++++++++++++-------
 include/linux/fb.h      |    1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 4f78f23..60e69e3 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -20,6 +20,8 @@ #include <linux/fb.h>
 #include <linux/console.h>
 #include <linux/module.h>
 
+#define FB_SYSFS_FLAG_ATTR 1
+
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
  *
@@ -471,12 +473,27 @@ #endif
 
 int fb_init_class_device(struct fb_info *fb_info)
 {
-	unsigned int i;
+	int i, error = 0;
+
 	class_set_devdata(fb_info->class_device, fb_info);
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_create_file(fb_info->class_device,
-					 &class_device_attrs[i]);
+	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
+		error = class_device_create_file(fb_info->class_device,
+						 &class_device_attrs[i]);
+
+		if (error)
+			break;
+	}
+
+	if (error) {
+		while (--i >= 0)
+			class_device_remove_file(fb_info->class_device,
+						 &class_device_attrs[i]);
+		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+	}
+
 	return 0;
 }
 
@@ -484,9 +501,13 @@ void fb_cleanup_class_device(struct fb_i
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_remove_file(fb_info->class_device,
-					 &class_device_attrs[i]);
+	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
+		for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+			class_device_remove_file(fb_info->class_device,
+						 &class_device_attrs[i]);
+
+		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+	}
 }
 
 #ifdef CONFIG_FB_BACKLIGHT
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a49ba06..10838d3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -776,6 +776,7 @@ #endif
 	struct fb_ops *fbops;
 	struct device *device;
 	struct class_device *class_device; /* sysfs per device attrs */
+	int class_flag;                    /* private sysfs flags */
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
