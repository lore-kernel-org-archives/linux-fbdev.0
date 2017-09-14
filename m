From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 14 Sep 2017 12:44:14 +0000
Subject: [PATCH] video: fbdev: make fb_var_screeninfo static, const and __initconst
Message-Id: <1505392334-8001-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1504093228-7439-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1504093228-7439-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these structures static as they are not referenced in any other
file. Make them const as they are used only during a copy operation.
Replace __initdata with __initconst in file igafb.c to avoid section
conflict error.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
The changes are not compile tested as I could not find the right 
architecture to cross compile the files.

 drivers/video/fbdev/dnfb.c  | 2 +-
 drivers/video/fbdev/igafb.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index 7b1492d..0941500 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -115,7 +115,7 @@
 	.fb_imageblit	= cfb_imageblit,
 };
 
-struct fb_var_screeninfo dnfb_var = {
+static const struct fb_var_screeninfo dnfb_var = {
 	.xres		= 1280,
 	.yres		= 1024,
 	.xres_virtual	= 2048,
diff --git a/drivers/video/fbdev/igafb.c b/drivers/video/fbdev/igafb.c
index 486f188..607b6c0 100644
--- a/drivers/video/fbdev/igafb.c
+++ b/drivers/video/fbdev/igafb.c
@@ -97,7 +97,7 @@ struct fb_var_screeninfo default_var = {
 };
 
 #ifdef CONFIG_SPARC
-struct fb_var_screeninfo default_var_1024x768 __initdata = {
+static const struct fb_var_screeninfo default_var_1024x768 __initconst = {
 	/* 1024x768, 75 Hz, Non-Interlaced (78.75 MHz dotclock) */
 	.xres		= 1024,
 	.yres		= 768,
@@ -120,7 +120,7 @@ struct fb_var_screeninfo default_var_1024x768 __initdata = {
 	.vmode		= FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
 };
 
-struct fb_var_screeninfo default_var_1152x900 __initdata = {
+static const struct fb_var_screeninfo default_var_1152x900 __initconst = {
 	/* 1152x900, 76 Hz, Non-Interlaced (110.0 MHz dotclock) */
 	.xres		= 1152,
 	.yres		= 900,
@@ -143,7 +143,7 @@ struct fb_var_screeninfo default_var_1152x900 __initdata = {
 	.vmode		= FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
 };
 
-struct fb_var_screeninfo default_var_1280x1024 __initdata = {
+static const struct fb_var_screeninfo default_var_1280x1024 __initconst = {
 	/* 1280x1024, 75 Hz, Non-Interlaced (135.00 MHz dotclock) */
 	.xres		= 1280,
 	.yres		= 1024,
-- 
1.9.1

