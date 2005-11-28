From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/16] fbdev: Cleanup
Date: Mon, 28 Nov 2005 23:46:54 +0800
Message-ID: <438B266E.1060801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGpb-0002Uz-5i
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:23 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGpa-00035W-P8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:23 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537654nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:32:21 -0800 (PST)
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

- remove unneeded casts

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbsysfs.c |   53 ++++++++++++++++++-----------------------------
 1 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 1f7302e..15707e4 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -106,8 +106,7 @@ static int mode_string(char *buf, unsign
 static ssize_t store_mode(struct class_device *class_device, const char * buf,
 			  size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	char mstr[100];
 	struct fb_var_screeninfo var;
 	struct fb_modelist *modelist;
@@ -137,8 +136,7 @@ static ssize_t store_mode(struct class_d
 
 static ssize_t show_mode(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 
 	if (!fb_info->mode)
 		return 0;
@@ -149,8 +147,7 @@ static ssize_t show_mode(struct class_de
 static ssize_t store_modes(struct class_device *class_device, const char * buf,
 			   size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	LIST_HEAD(old_list);
 	int i = count / sizeof(struct fb_videomode);
 
@@ -174,8 +171,7 @@ static ssize_t store_modes(struct class_
 
 static ssize_t show_modes(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	unsigned int i;
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -193,8 +189,7 @@ static ssize_t show_modes(struct class_d
 static ssize_t store_bpp(struct class_device *class_device, const char * buf,
 			 size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	struct fb_var_screeninfo var;
 	char ** last = NULL;
 	int err;
@@ -208,8 +203,7 @@ static ssize_t store_bpp(struct class_de
 
 static ssize_t show_bpp(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
 }
 
@@ -280,8 +274,7 @@ static ssize_t show_con_rotate(struct cl
 static ssize_t store_virtual(struct class_device *class_device,
 			     const char * buf, size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	struct fb_var_screeninfo var;
 	char *last = NULL;
 	int err;
@@ -300,16 +293,14 @@ static ssize_t store_virtual(struct clas
 
 static ssize_t show_virtual(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual,
 			fb_info->var.yres_virtual);
 }
 
 static ssize_t show_stride(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
 }
 
@@ -320,7 +311,7 @@ static ssize_t show_stride(struct class_
 static ssize_t store_cmap(struct class_device *class_device, const char *buf,
 			  size_t count)
 {
-	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	int rc, i, start, length, transp = 0;
 
 	if ((count > PAGE_SIZE) || ((count % 16) != 0))
@@ -380,8 +371,7 @@ static ssize_t store_cmap(struct class_d
 
 static ssize_t show_cmap(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	unsigned int i;
 
 	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
@@ -405,8 +395,7 @@ static ssize_t show_cmap(struct class_de
 static ssize_t store_blank(struct class_device *class_device, const char * buf,
 			   size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	char *last = NULL;
 	int err;
 
@@ -422,41 +411,40 @@ static ssize_t store_blank(struct class_
 
 static ssize_t show_blank(struct class_device *class_device, char *buf)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+//	struct fb_info *fb_info = class_get_devdata(class_device);
 	return 0;
 }
 
 static ssize_t store_console(struct class_device *class_device,
 			     const char * buf, size_t count)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+//	struct fb_info *fb_info = class_get_devdata(class_device);
 	return 0;
 }
 
 static ssize_t show_console(struct class_device *class_device, char *buf)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+//	struct fb_info *fb_info = class_get_devdata(class_device);
 	return 0;
 }
 
 static ssize_t store_cursor(struct class_device *class_device,
 			    const char * buf, size_t count)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+//	struct fb_info *fb_info = class_get_devdata(class_device);
 	return 0;
 }
 
 static ssize_t show_cursor(struct class_device *class_device, char *buf)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+//	struct fb_info *fb_info = class_get_devdata(class_device);
 	return 0;
 }
 
 static ssize_t store_pan(struct class_device *class_device, const char * buf,
 			 size_t count)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	struct fb_var_screeninfo var;
 	char *last = NULL;
 	int err;
@@ -479,15 +467,14 @@ static ssize_t store_pan(struct class_de
 
 static ssize_t show_pan(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset,
 			fb_info->var.xoffset);
 }
 
 static ssize_t show_name(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = class_get_devdata(class_device);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
 }



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
