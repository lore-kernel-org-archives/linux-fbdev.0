From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/8] fbdev: fbcon: Console
	unregistration from unregister_framebuffer
Date: Thu, 31 May 2007 21:02:47 +0800
Message-ID: <465EC777.8070209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQS-0001Ig-IE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:48 -0700
Received: from wr-out-0506.google.com ([64.233.184.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQS-0005Jc-2i
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:48 -0700
Received: by wr-out-0506.google.com with SMTP id 76so143940wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:47 -0700 (PDT)
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Jesse Barnes <jesse.barnes@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jesse Barnes <jesse.barnes@intel.com>

This allows for proper console unregistration via the VT layer, and updates
the FB layer to use it.  This makes debugging new console drivers much easier,
since you can properly clean them up before unloading.

[adaplas]
unregister_framebuffer() is typically called as part of the driver's
module_exit(). Doing so otherwise will freeze the machine as the VT layer is
holding reference counts on fbcon, and fbcon on the driver.  With this change,
it allows unregister_framebuffer() to be called safely anywhere as needed.

Additions from the original:  If multiple drivers are used by fbcon, and if
one of them unregisters, a driver will take over the consoles vacated by the
outgoing one (via set_con2fb_map).   Once only the outgoing driver remains,
then fbcon will unbind from the VT layer (if CONFIG_HW_CONSOLE_UNBINDING is
set to y).

It is important that these drivers implement fb_open() and fb_release()
just to ensure that no other process is using the driver. Likewise, these
drivers _must_ check the return value of unregister_framebuffer().

Signed-off-by: Jesse Barnes <jesse.barnes@intel.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Geert,

Is this patch suitable for your needs?

Tony

 drivers/video/console/fbcon.c |   42 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c         |   26 +++++++++++++++++++++----
 include/linux/fb.h            |    2 ++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 51bd430..1cbfeda 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3003,6 +3003,45 @@ static int fbcon_mode_deleted(struct fb_
 	return found;
 }
 
+#ifdef CONFIG_VT_HW_CONSOLE_BINDING
+static int fbcon_unbind(void)
+{
+	int ret;
+
+	ret = unbind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
+				fbcon_is_default);
+	return ret;
+}
+#else
+static int fbcon_unbind(void)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_VT_HW_CONSOLE_BINDING */
+
+static int fbcon_fb_unbind(int idx)
+{
+	int i, new_idx = -1, ret = 0;
+
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		if (con2fb_map[i] != idx &&
+		    con2fb_map[i] != -1) {
+			new_idx = i;
+			break;
+		}
+	}
+
+	if (new_idx != -1) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+			if (con2fb_map[i] == idx)
+				set_con2fb_map(i, idx, 0);
+		}
+	} else
+		ret = fbcon_unbind();
+
+	return ret;
+}
+
 static int fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx = info->node;
@@ -3210,6 +3249,9 @@ static int fbcon_event_notify(struct not
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
+	case FB_EVENT_FB_UNBIND:
+		ret = fbcon_fb_unbind(info->node);
+		break;
 	case FB_EVENT_FB_REGISTERED:
 		ret = fbcon_fb_registered(info);
 		break;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 8d6dbe8..7f3a0cc 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1334,17 +1334,34 @@ register_framebuffer(struct fb_info *fb_
  *
  *	Returns negative errno on error, or zero for success.
  *
+ *      This function will also notify the framebuffer console
+ *      to release the driver.
+ *
+ *      This is meant to be called within a driver's module_exit()
+ *      function. If this is called outside module_exit(), ensure
+ *      that the driver implements fb_open() and fb_release() to
+ *      check that no processes are using the device.
  */
 
 int
 unregister_framebuffer(struct fb_info *fb_info)
 {
 	struct fb_event event;
-	int i;
+	int i, ret = 0;
 
 	i = fb_info->node;
-	if (!registered_fb[i])
-		return -EINVAL;
+	if (!registered_fb[i]) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	event.info = fb_info;
+	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto done;
+	}
 
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
@@ -1356,7 +1373,8 @@ unregister_framebuffer(struct fb_info *f
 	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
-	return 0;
+done:
+	return ret;
 }
 
 /**
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6622682..8628423 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -529,6 +529,8 @@ #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 #define FB_EVENT_CONBLANK               0x0C
 /*      Get drawing requirements        */
 #define FB_EVENT_GET_REQ                0x0D
+/*      Unbind from the console if possible */
+#define FB_EVENT_FB_UNBIND              0x0E
 
 struct fb_event {
 	struct fb_info *info;





-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
