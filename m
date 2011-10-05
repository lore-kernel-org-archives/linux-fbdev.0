From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:47 +0000
Subject: [PATCH 4/9] drivers/video: fsl-diu-fb: add several new video modes
Message-Id: <1317775012-9797-4-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-4-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-4-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add the following new video modes to the Freescale DIU framebuffer driver:

640x480x60
640x480x72
640x480x75
640x480x90
640x480x100
800x480x60
800x600x60
854x480x60
1280x480x60
1280x720x60
1920x1080x60

Also add margin data to the 320x240 video mode.  This mode was originally
intended only for the AOIs (overlays) used on planes two and three, but with
real margin data, it can now be used as an actual video mode.

Video mode data is from earlier work done by Jerry Huang
<Chang-Ming.Huang@freescale.com>.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  200 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 167 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4dc65c9..29652ab 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -77,11 +77,12 @@ struct diu_pool {
 /*
  * List of supported video modes
  *
- * The first entry is the default video mode
+ * The first entry is the default video mode.  The remain entries are in
+ * order if increasing resolution and frequency.  The 320x240-60 mode is
+ * the initial AOI for the second and third planes.
  */
 static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 	{
-		.name		= "1024x768-60",
 		.refresh	= 60,
 		.xres		= 1024,
 		.yres		= 768,
@@ -96,7 +97,132 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "1024x768-70",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= 79440,
+		.left_margin	= 16,
+		.right_margin	= 16,
+		.upper_margin	= 16,
+		.lower_margin	= 5,
+		.hsync_len	= 48,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 60,
+		.xres           = 640,
+		.yres           = 480,
+		.pixclock       = 39722,
+		.left_margin    = 48,
+		.right_margin   = 16,
+		.upper_margin   = 33,
+		.lower_margin   = 10,
+		.hsync_len      = 96,
+		.vsync_len      = 2,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 72,
+		.xres           = 640,
+		.yres           = 480,
+		.pixclock       = 32052,
+		.left_margin    = 128,
+		.right_margin   = 24,
+		.upper_margin   = 28,
+		.lower_margin   = 9,
+		.hsync_len      = 40,
+		.vsync_len      = 3,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 75,
+		.xres           = 640,
+		.yres           = 480,
+		.pixclock       = 31747,
+		.left_margin    = 120,
+		.right_margin   = 16,
+		.upper_margin   = 16,
+		.lower_margin   = 1,
+		.hsync_len      = 64,
+		.vsync_len      = 3,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 90,
+		.xres           = 640,
+		.yres           = 480,
+		.pixclock       = 25057,
+		.left_margin    = 120,
+		.right_margin   = 32,
+		.upper_margin   = 14,
+		.lower_margin   = 25,
+		.hsync_len      = 40,
+		.vsync_len      = 14,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 100,
+		.xres           = 640,
+		.yres           = 480,
+		.pixclock       = 22272,
+		.left_margin    = 48,
+		.right_margin   = 32,
+		.upper_margin   = 17,
+		.lower_margin   = 22,
+		.hsync_len      = 128,
+		.vsync_len      = 12,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= 33805,
+		.left_margin	= 96,
+		.right_margin	= 24,
+		.upper_margin	= 10,
+		.lower_margin	= 3,
+		.hsync_len	= 72,
+		.vsync_len	= 7,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh        = 60,
+		.xres           = 800,
+		.yres           = 600,
+		.pixclock       = 25000,
+		.left_margin    = 88,
+		.right_margin   = 40,
+		.upper_margin   = 23,
+		.lower_margin   = 1,
+		.hsync_len      = 128,
+		.vsync_len      = 4,
+		.sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh	= 60,
+		.xres		= 854,
+		.yres		= 480,
+		.pixclock	= 31518,
+		.left_margin	= 104,
+		.right_margin	= 16,
+		.upper_margin	= 13,
+		.lower_margin	= 1,
+		.hsync_len	= 88,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED
+	},
+	{
 		.refresh	= 70,
 		.xres		= 1024,
 		.yres		= 768,
@@ -111,7 +237,6 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "1024x768-75",
 		.refresh	= 75,
 		.xres		= 1024,
 		.yres		= 768,
@@ -126,7 +251,34 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "1280x1024-60",
+		.refresh	= 60,
+		.xres		= 1280,
+		.yres		= 480,
+		.pixclock	= 18939,
+		.left_margin	= 353,
+		.right_margin	= 47,
+		.upper_margin	= 39,
+		.lower_margin	= 4,
+		.hsync_len	= 8,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED
+	},
+	{
+		.refresh	= 60,
+		.xres		= 1280,
+		.yres		= 720,
+		.pixclock	= 13426,
+		.left_margin	= 192,
+		.right_margin	= 64,
+		.upper_margin	= 22,
+		.lower_margin	= 1,
+		.hsync_len	= 136,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED
+	},
+	{
 		.refresh	= 60,
 		.xres		= 1280,
 		.yres		= 1024,
@@ -141,7 +293,6 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "1280x1024-70",
 		.refresh	= 70,
 		.xres		= 1280,
 		.yres		= 1024,
@@ -156,7 +307,6 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "1280x1024-75",
 		.refresh	= 75,
 		.xres		= 1280,
 		.yres		= 1024,
@@ -171,38 +321,22 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 	{
-		.name		= "320x240",		/* for AOI only */
 		.refresh	= 60,
-		.xres		= 320,
-		.yres		= 240,
-		.pixclock	= 15385,
-		.left_margin	= 0,
-		.right_margin	= 0,
-		.upper_margin	= 0,
-		.lower_margin	= 0,
-		.hsync_len	= 0,
-		.vsync_len	= 0,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1280x480-60",
-		.refresh	= 60,
-		.xres		= 1280,
-		.yres		= 480,
-		.pixclock	= 18939,
-		.left_margin	= 353,
-		.right_margin	= 47,
-		.upper_margin	= 39,
-		.lower_margin	= 4,
-		.hsync_len	= 8,
-		.vsync_len	= 2,
+		.xres		= 1920,
+		.yres		= 1080,
+		.pixclock	= 5787,
+		.left_margin	= 328,
+		.right_margin	= 120,
+		.upper_margin	= 34,
+		.lower_margin	= 1,
+		.hsync_len	= 208,
+		.vsync_len	= 3,
 		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		.vmode		= FB_VMODE_NONINTERLACED
 	},
 };
 
-static char *fb_mode = "1024x768-32@60";
+static char *fb_mode;
 static unsigned long default_bpp = 32;
 static enum fsl_diu_monitor_port monitor_port;
 static char *monitor_string;
-- 
1.7.4.4


