From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 08 Aug 2012 12:06:26 +0000
Subject: [PATCH] video: move CNVT_TOHW to a common place
Message-Id: <1344426866-8789-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace macro "CNVT_TOHW" by inline function. Also moving it to a
common place linux/fb.h so that it can be accessed from all framebuffer
drivers.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Applies on top of fbdev tree[1].

[1] git://github.com/schandinat/linux-2.6.git fbdev-next

 drivers/video/68328fb.c              |    2 --
 drivers/video/fb-puv3.c              |    2 --
 drivers/video/fsl-diu-fb.c           |    5 -----
 drivers/video/grvga.c                |    6 ------
 drivers/video/imxfb.c                |    1 -
 drivers/video/matrox/matroxfb_base.h |    2 --
 drivers/video/pm2fb.c                |    2 --
 drivers/video/pm3fb.c                |    2 --
 drivers/video/skeletonfb.c           |    2 --
 drivers/video/tdfxfb.c               |    3 ---
 drivers/video/vfb.c                  |    2 --
 drivers/video/xen-fbfront.c          |    2 --
 include/linux/fb.h                   |    5 +++++
 13 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
index a425d65..5a1f360 100644
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -318,7 +318,6 @@ static int mc68x328fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	 *                      (blue << blue.offset) | (transp << transp.offset)
 	 *    RAMDAC does not exist
 	 */
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
@@ -335,7 +334,6 @@ static int mc68x328fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		transp = CNVT_TOHW(transp, 8);
 		break;
 	}
-#undef CNVT_TOHW
 	/* Truecolor has hardware independent palette */
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
 		u32 v;
diff --git a/drivers/video/fb-puv3.c b/drivers/video/fb-puv3.c
index 60a787f..c84a907 100644
--- a/drivers/video/fb-puv3.c
+++ b/drivers/video/fb-puv3.c
@@ -565,7 +565,6 @@ static int unifb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		    (red * 77 + green * 151 + blue * 28) >> 8;
 	}
 
-#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
@@ -582,7 +581,6 @@ static int unifb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		transp = CNVT_TOHW(transp, 8);
 		break;
 	}
-#undef CNVT_TOHW
 	/* Truecolor has hardware independent palette */
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
 		u32 v;
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 458c006..878c588 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1008,11 +1008,6 @@ static int fsl_diu_set_par(struct fb_info *info)
 	return 0;
 }
 
-static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
-{
-	return ((val << width) + 0x7FFF - val) >> 16;
-}
-
 /*
  * Set a single color register. The values supplied have a 16 bit magnitude
  * which needs to be scaled in this function for the hardware. Things to take
diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 5245f9a..452038f 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -203,17 +203,11 @@ static int grvga_setcolreg(unsigned regno, unsigned red, unsigned green, unsigne
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 	}
 
-
-
-#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
-
 	red    = CNVT_TOHW(red,   info->var.red.length);
 	green  = CNVT_TOHW(green, info->var.green.length);
 	blue   = CNVT_TOHW(blue,  info->var.blue.length);
 	transp = CNVT_TOHW(transp, info->var.transp.length);
 
-#undef CNVT_TOHW
-
 	/* In PSEUDOCOLOR we use the hardware CLUT */
 	if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR)
 		__raw_writel((regno << 24) | (red << 16) | (green << 8) | blue,
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index caad368..b008fde 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -224,7 +224,6 @@ static int imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
 	struct imxfb_info *fbi = info->par;
 	u_int val, ret = 1;
 
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	if (regno < fbi->palette_size) {
 		val = (CNVT_TOHW(red, 4) << 8) |
 		      (CNVT_TOHW(green,4) << 4) |
diff --git a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
index 11ed57b..ace1e12 100644
--- a/drivers/video/matrox/matroxfb_base.h
+++ b/drivers/video/matrox/matroxfb_base.h
@@ -116,8 +116,6 @@
 #define MX_VISUAL_DIRECTCOLOR	FB_VISUAL_TRUECOLOR
 #define MX_VISUAL_PSEUDOCOLOR	FB_VISUAL_PSEUDOCOLOR
 
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
-
 /* G-series and Mystique have (almost) same DAC */
 #undef NEED_DAC1064
 #if defined(CONFIG_FB_MATROX_MYSTIQUE) || defined(CONFIG_FB_MATROX_G)
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index df31a24..85e810c 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -908,7 +908,6 @@ static int pm2fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	 *    (blue << blue.offset) | (transp << transp.offset)
 	 *    RAMDAC does not exist
 	 */
-#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF -(val)) >> 16)
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
@@ -927,7 +926,6 @@ static int pm2fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 		transp = CNVT_TOHW(transp, 8);
 		break;
 	}
-#undef CNVT_TOHW
 	/* Truecolor has hardware independent palette */
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
 		u32 v;
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 055e527..8cb30f8 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1109,12 +1109,10 @@ static int pm3fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	 * This is the point where the color is converted to something that
 	 * is acceptable by the hardware.
 	 */
-#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
 	red = CNVT_TOHW(red, info->var.red.length);
 	green = CNVT_TOHW(green, info->var.green.length);
 	blue = CNVT_TOHW(blue, info->var.blue.length);
 	transp = CNVT_TOHW(transp, info->var.transp.length);
-#undef CNVT_TOHW
 
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
 	info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 5b6abc6..fbf8b75 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -359,12 +359,10 @@ static int xxxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
      * This is the point where the color is converted to something that
      * is acceptable by the hardware.
      */
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
     red = CNVT_TOHW(red, info->var.red.length);
     green = CNVT_TOHW(green, info->var.green.length);
     blue = CNVT_TOHW(blue, info->var.blue.length);
     transp = CNVT_TOHW(transp, info->var.transp.length);
-#undef CNVT_TOHW
     /*
      * This is the point where the function feeds the color to the hardware
      * palette after converting the colors to something acceptable by
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index e026724..2eb6c63 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -752,9 +752,6 @@ static int tdfxfb_set_par(struct fb_info *info)
 	return 0;
 }
 
-/* A handy macro shamelessly pinched from matroxfb */
-#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
-
 static int tdfxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp,
 			    struct fb_info *info)
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 501a922..bec437c 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -335,7 +335,6 @@ static int vfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	 *                      (blue << blue.offset) | (transp << transp.offset)
 	 *    RAMDAC does not exist
 	 */
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
@@ -352,7 +351,6 @@ static int vfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		transp = CNVT_TOHW(transp, 8);
 		break;
 	}
-#undef CNVT_TOHW
 	/* Truecolor has hardware independent palette */
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
 		u32 v;
diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index b7f5173..6896744 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -217,12 +217,10 @@ static int xenfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (regno > info->cmap.len)
 		return 1;
 
-#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	red = CNVT_TOHW(red, info->var.red.length);
 	green = CNVT_TOHW(green, info->var.green.length);
 	blue = CNVT_TOHW(blue, info->var.blue.length);
 	transp = CNVT_TOHW(transp, info->var.transp.length);
-#undef CNVT_TOHW
 
 	v = (red << info->var.red.offset) |
 	    (green << info->var.green.offset) |
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ac3f1c6..8a2b3ca 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -397,6 +397,11 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
+static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
+{
+	return ((val << width) + 0x7FFF - val) >> 16;
+}
+
 #ifdef CONFIG_FB_BACKLIGHT
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
-- 
1.7.1

