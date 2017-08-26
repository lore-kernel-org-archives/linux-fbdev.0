From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 26 Aug 2017 15:37:37 +0000
Subject: [PATCH] video: fbdev: make fb_videomode const
Message-Id: <1503761137-25263-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Make these const as they are only passed to a const argument of the
function fb_find_mode.
Done using Coccinelle.

@match disable optional_qualifier@
identifier s;
@@
static struct fb_videomode s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
identifier match.s;
expression list[5] es;
position ref.p;
@@
fb_find_mode(es,&s@p,...)

@bad depends on  !good1@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct fb_videomode s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c         | 2 +-
 drivers/video/fbdev/aty/atyfb_base.c       | 2 +-
 drivers/video/fbdev/cyber2000fb.c          | 2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 drivers/video/fbdev/sm501fb.c              | 2 +-
 drivers/video/fbdev/vermilion/vermilion.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index ba64e26..db18474 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -116,7 +116,7 @@
 
 /* default modedb mode */
 /* 640x480, 60 Hz, Non-Interlaced (25.172 MHz dotclock) */
-static struct fb_videomode defaultmode = {
+static const struct fb_videomode defaultmode = {
 	.refresh =	60,
 	.xres =		640,
 	.yres =		480,
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 1681d2d..f49efb2 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -274,7 +274,7 @@ static int aty_crtc_to_var(const struct crtc *crtc,
 	0, FB_VMODE_NONINTERLACED
 };
 
-static struct fb_videomode defmode = {
+static const struct fb_videomode defmode = {
 	/* 640x480 @ 60 Hz, 31.5 kHz hsync */
 	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
 	0, FB_VMODE_NONINTERLACED
diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 99acf53..9a5751c 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1336,7 +1336,7 @@ static void cyber2000fb_i2c_unregister(struct cfb_info *cfb)
  * These parameters give
  * 640x480, hsync 31.5kHz, vsync 60Hz
  */
-static struct fb_videomode cyber2000fb_default_mode = {
+static const struct fb_videomode cyber2000fb_default_mode = {
 	.refresh	= 60,
 	.xres		= 640,
 	.yres		= 480,
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 49ef48d..b9b284d7 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1573,7 +1573,7 @@ struct video_board {
 		NULL}};
 
 #ifndef MODULE
-static struct fb_videomode defaultmode = {
+static const struct fb_videomode defaultmode = {
 	/* 640x480 @ 60Hz, 31.5 kHz */
 	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
 	0, FB_VMODE_NONINTERLACED
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 67e314f..076dd27 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -46,7 +46,7 @@
 static char *fb_mode = "640x480-16@60";
 static unsigned long default_bpp = 16;
 
-static struct fb_videomode sm501_default_mode = {
+static const struct fb_videomode sm501_default_mode = {
 	.refresh	= 60,
 	.xres		= 640,
 	.yres		= 480,
diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 3fde493..6f8d444 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -55,7 +55,7 @@
 static struct fb_ops vmlfb_ops;
 static struct vml_sys *subsys = NULL;
 static char *vml_default_mode = "1024x768@60";
-static struct fb_videomode defaultmode = {
+static const struct fb_videomode defaultmode = {
 	NULL, 60, 1024, 768, 12896, 144, 24, 29, 3, 136, 6,
 	0, FB_VMODE_NONINTERLACED
 };
-- 
1.9.1

