From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:58:59 +0000
Subject: [PATCH 2/4] fbdev: atafb: Remove obsolete module support
Message-Id: <20190215085901.21479-3-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190215085901.21479-1-geert@linux-m68k.org>
In-Reply-To: <20190215085901.21479-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Schmitz <schmitzmic@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

CONFIG_FB_ATARI is bool, hence the Atari frame buffer driver cannot be
built as a module.  In addition, the module support code refers to a
function atafb_deinit(), which never existed.

Replace module_init() by device_initcall().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c          | 16 +---------------
 drivers/video/fbdev/atafb_iplan2p2.c | 23 -----------------------
 drivers/video/fbdev/atafb_iplan2p4.c | 23 -----------------------
 drivers/video/fbdev/atafb_iplan2p8.c | 23 -----------------------
 drivers/video/fbdev/atafb_mfb.c      | 23 -----------------------
 5 files changed, 1 insertion(+), 107 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index e9d31a4299ee9901..d82007c113e6303c 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -47,7 +47,6 @@
 #define ATAFB_EXT
 #define ATAFB_FALCON
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -3078,14 +3077,11 @@ int __init atafb_init(void)
 	int pad, detected_mode, error;
 	unsigned int defmode = 0;
 	unsigned long mem_req;
-
-#ifndef MODULE
 	char *option = NULL;
 
 	if (fb_get_options("atafb", &option))
 		return -ENODEV;
 	atafb_setup(option);
-#endif
 	printk("atafb_init: start\n");
 
 	if (!MACH_IS_ATARI)
@@ -3251,14 +3247,4 @@ int __init atafb_init(void)
 	return 0;
 }
 
-module_init(atafb_init);
-
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int cleanup_module(void)
-{
-	unregister_framebuffer(&fb_info);
-	return atafb_deinit();
-}
-#endif /* MODULE */
+device_initcall(atafb_init);
diff --git a/drivers/video/fbdev/atafb_iplan2p2.c b/drivers/video/fbdev/atafb_iplan2p2.c
index 8cc9c50379d0f036..a1660c24bf3629a5 100644
--- a/drivers/video/fbdev/atafb_iplan2p2.c
+++ b/drivers/video/fbdev/atafb_iplan2p2.c
@@ -10,7 +10,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 
@@ -269,25 +268,3 @@ void atafb_iplan2p2_linefill(struct fb_info *info, u_long next_line,
 	if (width)
 		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
 }
-
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-#endif /* MODULE */
-
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(atafb_iplan2p2_copyarea);
-EXPORT_SYMBOL(atafb_iplan2p2_fillrect);
-EXPORT_SYMBOL(atafb_iplan2p2_linefill);
diff --git a/drivers/video/fbdev/atafb_iplan2p4.c b/drivers/video/fbdev/atafb_iplan2p4.c
index bee0d89463f755a4..663d66582d791c03 100644
--- a/drivers/video/fbdev/atafb_iplan2p4.c
+++ b/drivers/video/fbdev/atafb_iplan2p4.c
@@ -10,7 +10,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 
@@ -284,25 +283,3 @@ void atafb_iplan2p4_linefill(struct fb_info *info, u_long next_line,
 	if (width)
 		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
 }
-
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-#endif /* MODULE */
-
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(atafb_iplan2p4_copyarea);
-EXPORT_SYMBOL(atafb_iplan2p4_fillrect);
-EXPORT_SYMBOL(atafb_iplan2p4_linefill);
diff --git a/drivers/video/fbdev/atafb_iplan2p8.c b/drivers/video/fbdev/atafb_iplan2p8.c
index 356fb52ce4430741..39a6cbbb6ca39db0 100644
--- a/drivers/video/fbdev/atafb_iplan2p8.c
+++ b/drivers/video/fbdev/atafb_iplan2p8.c
@@ -10,7 +10,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 
@@ -321,25 +320,3 @@ void atafb_iplan2p8_linefill(struct fb_info *info, u_long next_line,
 	if (width)
 		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
 }
-
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-#endif /* MODULE */
-
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(atafb_iplan2p8_copyarea);
-EXPORT_SYMBOL(atafb_iplan2p8_fillrect);
-EXPORT_SYMBOL(atafb_iplan2p8_linefill);
diff --git a/drivers/video/fbdev/atafb_mfb.c b/drivers/video/fbdev/atafb_mfb.c
index 6a352d62eecf2b73..384fd3e4d3e13935 100644
--- a/drivers/video/fbdev/atafb_mfb.c
+++ b/drivers/video/fbdev/atafb_mfb.c
@@ -9,7 +9,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 
@@ -88,25 +87,3 @@ void atafb_mfb_linefill(struct fb_info *info, u_long next_line,
 		*dest++ = *data++;
 	}
 }
-
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-#endif /* MODULE */
-
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(atafb_mfb_copyarea);
-EXPORT_SYMBOL(atafb_mfb_fillrect);
-EXPORT_SYMBOL(atafb_mfb_linefill);
-- 
2.17.1
