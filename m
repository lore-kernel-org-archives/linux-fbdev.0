From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 26 Jul 2018 23:59:53 +0000
Subject: [PATCH] fb: amifb: fix build warnings when not builtin
Message-Id: <cda83e71-7bfc-5997-a271-0362a7ac0354@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warning when built as a loadable module.
amifb_setup() and amifb_setup_mcap() are only needed when the driver
is builtin.
This matches how the functions are called (using #ifndef MODULE).

../drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
 static int __init amifb_setup(char *options)

../drivers/video/fbdev/amifb.c:2307:20: warning: 'amifb_setup_mcap' defined but not used [-Wunused-function]
 static void __init amifb_setup_mcap(char *spec)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/amifb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20180717.orig/drivers/video/fbdev/amifb.c
+++ linux-next-20180717/drivers/video/fbdev/amifb.c
@@ -2303,7 +2303,7 @@ static void ami_build_copper(struct fb_i
 	ami_rebuild_copper(info->par);
 }
 
-
+#ifndef MODULE
 static void __init amifb_setup_mcap(char *spec)
 {
 	char *p;
@@ -2368,7 +2368,7 @@ static int __init amifb_setup(char *opti
 
 	return 0;
 }
-
+#endif
 
 static int amifb_check_var(struct fb_var_screeninfo *var,
 			   struct fb_info *info)


