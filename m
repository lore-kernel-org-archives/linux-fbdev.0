From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/9] fbcon: Cursor blink control
Date: Sun, 27 May 2007 08:50:12 +0800
Message-ID: <4658D5C4.2080105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPi-0001ve-L7 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:53 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPi-0003fW-9a
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:50 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:50 -0700 (PDT)
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

Add sysfs attribute to enable or disable cursor blinking. This will also
disable cursor blinking if the VT layer's softcursor is active. These
changes are required to enable some machines to enter low-power states properly.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   74 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 7888e31..b7e143e 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -152,6 +152,7 @@ #define MAC_CURSOR_BLINK_RATE		(32)
 #define DEFAULT_CURSOR_BLINK_RATE	(20)
 
 static int vbl_cursor_cnt;
+static int fbcon_cursor_noblink;
 
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
@@ -441,7 +442,8 @@ static void fbcon_add_cursor_timer(struc
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if ((!info->queue.func || info->queue.func == fb_flashcursor) &&
-	    !(ops->flags & FBCON_FLAGS_CURSOR_TIMER)) {
+	    !(ops->flags & FBCON_FLAGS_CURSOR_TIMER) &&
+	    !fbcon_cursor_noblink) {
 		if (!info->queue.func)
 			INIT_WORK(&info->queue, fb_flashcursor);
 
@@ -1349,6 +1351,11 @@ static void fbcon_cursor(struct vc_data 
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;
 
+	if (vc->vc_cursor_type & 0x10)
+		fbcon_del_cursor_timer(info);
+	else
+		fbcon_add_cursor_timer(info);
+
 	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
@@ -3308,9 +3315,74 @@ err:
 	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
+static ssize_t show_cursor_blink(struct class_device *class_device, char *buf)
+{
+	struct fb_info *info;
+	struct fbcon_ops *ops;
+	int idx, blink = -1;
+
+	if (fbcon_has_exited)
+		return 0;
+
+	acquire_console_sem();
+	idx = con2fb_map[fg_console];
+
+	if (idx == -1 || registered_fb[idx] == NULL)
+		goto err;
+
+	info = registered_fb[idx];
+	ops = info->fbcon_par;
+
+	if (!ops)
+		goto err;
+
+	blink = (ops->flags & FBCON_FLAGS_CURSOR_TIMER) ? 1 : 0;
+err:
+	release_console_sem();
+	return snprintf(buf, PAGE_SIZE, "%d\n", blink);
+}
+
+static ssize_t store_cursor_blink(struct class_device *clas_device,
+				  const char *buf, size_t count)
+{
+	struct fb_info *info;
+	int blink, idx;
+	char **last = NULL;
+
+	if (fbcon_has_exited)
+		return count;
+
+	acquire_console_sem();
+	idx = con2fb_map[fg_console];
+
+	if (idx == -1 || registered_fb[idx] == NULL)
+		goto err;
+
+	info = registered_fb[idx];
+
+	if (!info->fbcon_par)
+		goto err;
+
+	blink = simple_strtoul(buf, last, 0);
+
+	if (blink) {
+		fbcon_cursor_noblink = 0;
+		fbcon_add_cursor_timer(info);
+	} else {
+		fbcon_cursor_noblink = 1;
+		fbcon_del_cursor_timer(info);
+	}
+
+err:
+	release_console_sem();
+	return count;
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
+	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
+	       store_cursor_blink),
 };
 
 static int fbcon_init_class_device(void)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
