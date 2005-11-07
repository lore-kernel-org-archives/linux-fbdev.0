From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/8] fbcon: Console Rotation - Add ability to control rotation
 via sysfs
Date: Mon, 07 Nov 2005 19:09:22 +0800
Message-ID: <436F35E2.4060201@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5BH-0004Tl-EN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:55 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5BG-0006Hq-Uc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:55 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:28:54 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add ability to set rotation via sysfs.  The attributes are located in
/sys/class/graphics/fb[n] and accepts 0 - unrotated; 1 - clockwise; 2 -
upside down; 3 - counterclockwise.

The attributes are:

con_rotate (r/w) -   set rotation of the active console
con_rotate_all (w) - set rotation of all consoles
rotate (r/w) -       set rotation of the framebuffer, if supported.
Currently, none of the drivers support this.

This is probably temporary, since con_rotate and con_rotate_all are
console-specific and has no business being under the fb device.  However,
until the console layer acquires it's own sysfs class, these attributes
will temporarily reside here.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 drivers/video/console/fbcon.c |   72 ++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c         |   22 ++++++++++++
 drivers/video/fbsysfs.c       |   67 +++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h            |    7 ++++
 4 files changed, 168 insertions(+)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index e829ba1..e7802ff 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -193,6 +193,8 @@ static void fbcon_preset_disp(struct fb_
 			      int unit);
 static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 			      int line, int count, int dy);
+static void fbcon_modechanged(struct fb_info *info);
+static void fbcon_set_all_vcs(struct fb_info *info);
 
 #ifdef CONFIG_MAC
 /*
@@ -218,6 +220,51 @@ static inline void fbcon_set_rotation(st
 	else
 		ops->rotate = 0;
 }
+
+static void fbcon_rotate(struct fb_info *info, u32 rotate)
+{
+	struct fbcon_ops *ops= info->fbcon_par;
+	struct fb_info *fb_info;
+
+	if (!ops || ops->currcon == -1)
+		return;
+
+	fb_info = registered_fb[con2fb_map[ops->currcon]];
+
+	if (info == fb_info) {
+		struct display *p = &fb_display[ops->currcon];
+
+		if (rotate < 4)
+			p->con_rotate = rotate;
+		else
+			p->con_rotate = 0;
+
+		fbcon_modechanged(info);
+	}
+}
+
+static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct vc_data *vc;
+	struct display *p;
+	int i;
+
+	if (!ops || ops->currcon < 0 || rotate > 3)
+		return;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		vc = vc_cons[i].d;
+		if (!vc || vc->vc_mode != KD_TEXT ||
+		    registered_fb[con2fb_map[i]] != info)
+			continue;
+
+		p = &fb_display[vc->vc_num];
+		p->con_rotate = rotate;
+	}
+
+	fbcon_set_all_vcs(info);
+}
 #else
 static inline void fbcon_set_rotation(struct fb_info *info, struct display *p)
 {
@@ -225,8 +272,25 @@ static inline void fbcon_set_rotation(st
 
 	ops->rotate = FB_ROTATE_UR;
 }
+
+static void fbcon_rotate(struct fb_info *info, u32 rotate)
+{
+	return;
+}
+
+static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
+{
+	return;
+}
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
 
+static int fbcon_get_rotate(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	return (ops) ? ops->rotate : 0;
+}
+
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2864,6 +2928,14 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_NEW_MODELIST:
 		fbcon_new_modelist(info);
 		break;
+	case FB_EVENT_SET_CON_ROTATE:
+		fbcon_rotate(info, *(int *)event->data);
+		break;
+	case FB_EVENT_GET_CON_ROTATE:
+		ret = fbcon_get_rotate(info);
+		break;
+	case FB_EVENT_SET_CON_ROTATE_ALL:
+		fbcon_rotate_all(info, *(int *)event->data);
 	}
 
 	return ret;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7a2a8fa..81b6cd2 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1319,6 +1319,28 @@ int fb_new_modelist(struct fb_info *info
 	return err;
 }
 
+/**
+ * fb_con_duit - user<->fbcon passthrough
+ * @info: struct fb_info
+ * @event: notification event to be passed to fbcon
+ * @data: private data
+ *
+ * DESCRIPTION
+ * This function is an fbcon-user event passing channel
+ * which bypasses fbdev.  This is hopefully temporary
+ * until a user interface for fbcon is created
+ */
+int fb_con_duit(struct fb_info *info, int event, void *data)
+{
+	struct fb_event evnt;
+
+	evnt.info = info;
+	evnt.data = data;
+
+	return notifier_call_chain(&fb_notifier_list, event, &evnt);
+}
+EXPORT_SYMBOL(fb_con_duit);
+
 static char *video_options[FB_MAX];
 static int ofonly;
 
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 007c8e9..ea395aa 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -213,6 +213,70 @@ static ssize_t show_bpp(struct class_dev
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
 }
 
+static ssize_t store_rotate(struct class_device *class_device, const char *buf,
+			    size_t count)
+{
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char **last = NULL;
+	int err;
+
+	var = fb_info->var;
+	var.rotate = simple_strtoul(buf, last, 0);
+
+	if ((err = activate(fb_info, &var)))
+		return err;
+
+	return count;
+}
+
+
+static ssize_t show_rotate(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = class_get_devdata(class_device);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.rotate);
+}
+
+static ssize_t store_con_rotate(struct class_device *class_device,
+				const char *buf, size_t count)
+{
+        struct fb_info *fb_info = class_get_devdata(class_device);
+	int rotate;
+	char **last = NULL;
+
+	acquire_console_sem();
+	rotate = simple_strtoul(buf, last, 0);
+	fb_con_duit(fb_info, FB_EVENT_SET_CON_ROTATE, &rotate);
+	release_console_sem();
+	return count;
+}
+
+static ssize_t store_con_rotate_all(struct class_device *class_device,
+				const char *buf, size_t count)
+{
+        struct fb_info *fb_info = class_get_devdata(class_device);
+	int rotate;
+	char **last = NULL;
+
+	acquire_console_sem();
+	rotate = simple_strtoul(buf, last, 0);
+	fb_con_duit(fb_info, FB_EVENT_SET_CON_ROTATE_ALL, &rotate);
+	release_console_sem();
+	return count;
+}
+
+static ssize_t show_con_rotate(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	int rotate;
+
+	acquire_console_sem();
+	rotate = fb_con_duit(fb_info, FB_EVENT_GET_CON_ROTATE, NULL);
+	release_console_sem();
+	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
+}
+
 static ssize_t store_virtual(struct class_device *class_device,
 			     const char * buf, size_t count)
 {
@@ -440,6 +504,9 @@ static struct class_device_attribute cla
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
 	__ATTR(name, S_IRUGO, show_name, NULL),
 	__ATTR(stride, S_IRUGO, show_stride, NULL),
+	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
+	__ATTR(con_rotate, S_IRUGO|S_IWUSR, show_con_rotate, store_con_rotate),
+	__ATTR(con_rotate_all, S_IWUSR, NULL, store_con_rotate_all),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 357dd3a..04a58f3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -508,6 +508,12 @@ struct fb_cursor_user {
 /*	The resolution of the passed in fb_info about to change and
         all vc's should be changed         */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0A
+/*      CONSOLE-SPECIFIC: set console rotation */
+#define FB_EVENT_SET_CON_ROTATE         0x0B
+/*      CONSOLE-SPECIFIC: get console rotation */
+#define FB_EVENT_GET_CON_ROTATE         0x0C
+/*      CONSOLE-SPECIFIC: rotate all consoles */
+#define FB_EVENT_SET_CON_ROTATE_ALL     0x0D
 
 struct fb_event {
 	struct fb_info *info;
@@ -836,6 +842,7 @@ extern int fb_get_color_depth(struct fb_
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
+extern int fb_con_duit(struct fb_info *info, int event, void *data);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
