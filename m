From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 14:02:42 +0000
Subject: [PATCH] video: fbdev: atafb: remove superfluous function prototypes
Message-Id: <50411fd1-9da0-aab6-709e-749d5e0ce509@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

No need for them.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/atafb.c |   21 ---------------------
 1 file changed, 21 deletions(-)

Index: b/drivers/video/fbdev/atafb.c
=================================--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -77,29 +77,8 @@
 #define SWITCH_SND7 0x80
 #define SWITCH_NONE 0x00
 
-
 #define up(x, r) (((x) + (r) - 1) & ~((r)-1))
 
-	/*
-	 * Interface to the world
-	 */
-
-static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
-static int atafb_set_par(struct fb_info *info);
-static int atafb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-			   unsigned int blue, unsigned int transp,
-			   struct fb_info *info);
-static int atafb_blank(int blank, struct fb_info *info);
-static int atafb_pan_display(struct fb_var_screeninfo *var,
-			     struct fb_info *info);
-static void atafb_fillrect(struct fb_info *info,
-			   const struct fb_fillrect *rect);
-static void atafb_copyarea(struct fb_info *info,
-			   const struct fb_copyarea *region);
-static void atafb_imageblit(struct fb_info *info, const struct fb_image *image);
-static int atafb_ioctl(struct fb_info *info, unsigned int cmd,
-		       unsigned long arg);
-
 
 static int default_par;		/* default resolution (0=none) */
 
