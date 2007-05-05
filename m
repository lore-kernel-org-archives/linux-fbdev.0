From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/20] fbdev: Clean up exit patch of
	fb_set_var
Date: Sat, 05 May 2007 22:42:02 +0800
Message-ID: <463C97BA.2030604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMD7-0008UI-N1 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:13 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMD7-0008EN-4E
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:13 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:12 -0700 (PDT)
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

Clean up exit patch of fb_set_var():

- consolidate all return values into a single local variable
- ensure that return values are valid error codes
- fix fb_set_var() returning success when fb_check_caps() failed

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmem.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 354711c..08d4e11 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -799,11 +799,11 @@ static int fb_check_caps(struct fb_info 
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
-	int err, flags = info->flags;
+	int flags = info->flags;
+	int ret = 0;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
-		int ret = 0;
 
 		fb_var_to_videomode(&mode1, var);
 		fb_var_to_videomode(&mode2, &info->var);
@@ -821,7 +821,9 @@ fb_set_var(struct fb_info *info, struct 
 		if (!ret)
 		    fb_delete_videomode(&mode1, &info->modelist);
 
-		return ret;
+
+		ret = (ret) ? -EINVAL : 0;
+		goto done;
 	}
 
 	if ((var->activate & FB_ACTIVATE_FORCE) ||
@@ -830,20 +832,21 @@ fb_set_var(struct fb_info *info, struct 
 
 		if (!info->fbops->fb_check_var) {
 			*var = info->var;
-			return 0;
+			goto done;
 		}
 
-		if ((err = info->fbops->fb_check_var(var, info)))
-			return err;
+		ret = info->fbops->fb_check_var(var, info);
+
+		if (ret)
+			goto done;
 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;
-			int err = 0;
 
 			if (info->fbops->fb_get_caps) {
-				err = fb_check_caps(info, var, activate);
+				ret = fb_check_caps(info, var, activate);
 
-				if (err)
+				if (ret)
 					goto done;
 			}
 
@@ -853,16 +856,14 @@ fb_set_var(struct fb_info *info, struct 
 				info->fbops->fb_set_par(info);
 
 			fb_pan_display(info, &info->var);
-
 			fb_set_cmap(&info->cmap, info);
-
 			fb_var_to_videomode(&mode, &info->var);
 
 			if (info->modelist.prev && info->modelist.next &&
 			    !list_empty(&info->modelist))
-				err = fb_add_videomode(&mode, &info->modelist);
+				ret = fb_add_videomode(&mode, &info->modelist);
 
-			if (!err && (flags & FBINFO_MISC_USEREVENT)) {
+			if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
 				struct fb_event event;
 				int evnt = (activate & FB_ACTIVATE_ALL) ?
 					FB_EVENT_MODE_CHANGE_ALL :
@@ -876,7 +877,7 @@ fb_set_var(struct fb_info *info, struct 
 	}
 
  done:
-	return 0;
+	return ret;
 }
 
 int


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
