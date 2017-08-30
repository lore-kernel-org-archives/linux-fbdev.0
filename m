From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 30 Aug 2017 11:52:28 +0000
Subject: [PATCH] video: fbdev: make fb_var_screeninfo const
Message-Id: <1504093228-7439-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, gxt@mprc.pku.edu.cn, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const as they are not modified anywhere.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Could not cross compile fb-puv3.o file.

 drivers/video/fbdev/fb-puv3.c    | 2 +-
 drivers/video/fbdev/maxinefb.c   | 2 +-
 drivers/video/fbdev/pmag-aa-fb.c | 2 +-
 drivers/video/fbdev/pmag-ba-fb.c | 2 +-
 drivers/video/fbdev/pmagb-b-fb.c | 2 +-
 drivers/video/fbdev/pvr2fb.c     | 2 +-
 drivers/video/fbdev/q40fb.c      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/fb-puv3.c b/drivers/video/fbdev/fb-puv3.c
index 88fa2e7..d9e816d 100644
--- a/drivers/video/fbdev/fb-puv3.c
+++ b/drivers/video/fbdev/fb-puv3.c
@@ -69,7 +69,7 @@
 	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 
-static struct fb_var_screeninfo unifb_default = {
+static const struct fb_var_screeninfo unifb_default = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
index cab7333..5bb1b5c 100644
--- a/drivers/video/fbdev/maxinefb.c
+++ b/drivers/video/fbdev/maxinefb.c
@@ -39,7 +39,7 @@
 
 static struct fb_info fb_info;
 
-static struct fb_var_screeninfo maxinefb_defined = {
+static const struct fb_var_screeninfo maxinefb_defined = {
 	.xres =		1024,
 	.yres =		768,
 	.xres_virtual =	1024,
diff --git a/drivers/video/fbdev/pmag-aa-fb.c b/drivers/video/fbdev/pmag-aa-fb.c
index 39922f0..8cbb1d2 100644
--- a/drivers/video/fbdev/pmag-aa-fb.c
+++ b/drivers/video/fbdev/pmag-aa-fb.c
@@ -67,7 +67,7 @@ struct aafb_par {
 	struct bt431_regs __iomem *bt431;
 };
 
-static struct fb_var_screeninfo aafb_defined = {
+static const struct fb_var_screeninfo aafb_defined = {
 	.xres		= 1280,
 	.yres		= 1024,
 	.xres_virtual	= 2048,
diff --git a/drivers/video/fbdev/pmag-ba-fb.c b/drivers/video/fbdev/pmag-ba-fb.c
index 1fd02f4..d88ca10 100644
--- a/drivers/video/fbdev/pmag-ba-fb.c
+++ b/drivers/video/fbdev/pmag-ba-fb.c
@@ -43,7 +43,7 @@ struct pmagbafb_par {
 };
 
 
-static struct fb_var_screeninfo pmagbafb_defined = {
+static const struct fb_var_screeninfo pmagbafb_defined = {
 	.xres		= 1024,
 	.yres		= 864,
 	.xres_virtual	= 1024,
diff --git a/drivers/video/fbdev/pmagb-b-fb.c b/drivers/video/fbdev/pmagb-b-fb.c
index 46e96c4..d3849cd 100644
--- a/drivers/video/fbdev/pmagb-b-fb.c
+++ b/drivers/video/fbdev/pmagb-b-fb.c
@@ -44,7 +44,7 @@ struct pmagbbfb_par {
 };
 
 
-static struct fb_var_screeninfo pmagbbfb_defined = {
+static const struct fb_var_screeninfo pmagbbfb_defined = {
 	.bits_per_pixel	= 8,
 	.red.length	= 8,
 	.green.length	= 8,
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index c6212ab..867c521 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -154,7 +154,7 @@
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo pvr2_var = {
+static const struct fb_var_screeninfo pvr2_var = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 04ea330..0b93aa9 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -36,7 +36,7 @@
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo q40fb_var = {
+static const struct fb_var_screeninfo q40fb_var = {
 	.xres		= 1024,
 	.yres		= 512,
 	.xres_virtual	= 1024,
-- 
1.9.1

