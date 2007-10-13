From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 15/15] fbdev: Move and rename extern
	declaration for global_mode_option
Date: Sat, 13 Oct 2007 08:33:24 +0800
Message-ID: <47101254.6010307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgVoT-0001jp-CS for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 18:29:09 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUz5-0002xt-ML
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:36:03 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:36:03 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Move the extern declaration for global_mode_option to <linux/fb.h> and rename
the variable to fb_mode_option.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmem.c  |    4 +---
 drivers/video/modedb.c |    4 ++--
 include/linux/fb.h     |    1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index db0c348..1194f5e 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1567,8 +1567,6 @@ int fb_new_modelist(struct fb_info *info
 static char *video_options[FB_MAX] __read_mostly;
 static int ofonly __read_mostly;
 
-extern const char *global_mode_option;
-
 /**
  * fb_get_options - get kernel boot parameters
  * @name:   framebuffer name as it would appear in
@@ -1636,7 +1634,7 @@ static int __init video_setup(char *opti
  	}
 
  	if (!global && !strstr(options, "fb:")) {
- 		global_mode_option = options;
+ 		fb_mode_option = options;
  		global = 1;
  	}
 
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 03b06aa..42f5d76 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -27,7 +27,7 @@ #else
 #define DPRINTK(fmt, args...)
 #endif
 
-const char *global_mode_option;
+const char *fb_mode_option;
 
     /*
      *  Standard video mode definitions (taken from XFree86)
@@ -510,7 +510,7 @@ int fb_find_mode(struct fb_var_screeninf
 	default_bpp = 8;
 
     /* Did the user specify a video mode? */
-    if (mode_option || (mode_option = global_mode_option)) {
+    if (mode_option || (mode_option = fb_mode_option)) {
 	const char *name = mode_option;
 	unsigned int namelen = strlen(name);
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6729272..58c57a3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1056,6 +1056,7 @@ struct fb_videomode {
 	u32 flag;
 };
 
+extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 
 struct fb_modelist {


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
