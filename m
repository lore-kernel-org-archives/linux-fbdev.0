From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] atoi: Drop custom atoi from drivers/video/modedb.c
Date: Thu, 29 Oct 2009 16:54:43 +0200
Message-ID: <1256828083-19002-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754952AbZJ2Oz0@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Kernel has simple_strtol() implementation which could be used as atoi().

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/video/modedb.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 34e4e79..0129f1b 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/fb.h>
+#include <linux/kernel.h>
 
 #undef DEBUG
 
@@ -402,21 +403,6 @@ const struct fb_videomode vesa_modes[] = {
 EXPORT_SYMBOL(vesa_modes);
 #endif /* CONFIG_FB_MODE_HELPERS */
 
-static int my_atoi(const char *name)
-{
-    int val = 0;
-
-    for (;; name++) {
-	switch (*name) {
-	    case '0' ... '9':
-		val = 10*val+(*name-'0');
-		break;
-	    default:
-		return val;
-	}
-    }
-}
-
 /**
  *	fb_try_mode - test a video mode
  *	@var: frame buffer user defined part of display
@@ -539,7 +525,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		    namelen = i;
 		    if (!refresh_specified && !bpp_specified &&
 			!yres_specified) {
-			refresh = my_atoi(&name[i+1]);
+			refresh = simple_strtol(&name[i+1], NULL, 10);
 			refresh_specified = 1;
 			if (cvt || rb)
 			    cvt = 0;
@@ -549,7 +535,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		case '-':
 		    namelen = i;
 		    if (!bpp_specified && !yres_specified) {
-			bpp = my_atoi(&name[i+1]);
+			bpp = simple_strtol(&name[i+1], NULL, 10);
 			bpp_specified = 1;
 			if (cvt || rb)
 			    cvt = 0;
@@ -558,7 +544,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		    break;
 		case 'x':
 		    if (!yres_specified) {
-			yres = my_atoi(&name[i+1]);
+			yres = simple_strtol(&name[i+1], NULL, 10);
 			yres_specified = 1;
 		    } else
 			goto done;
@@ -586,7 +572,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 	    }
 	}
 	if (i < 0 && yres_specified) {
-	    xres = my_atoi(name);
+	    xres = simple_strtol(name, NULL, 10);
 	    res_specified = 1;
 	}
 done:
-- 
1.5.6.5
