From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Fri, 22 Jul 2016 13:54:55 +0000
Subject: [PATCH 2/3] fbdev: vfb: add option for video mode
Message-Id: <1469195696-14753-3-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make vfb a bit more flexible in sense what it can represent and allow
the end user to specify video mode parameters via newly introduced module
option "mode". Since it is test module it is still up to the end user
to make sure there is enough memory to satisfy video mode settings.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/video/fbdev/vfb.c |   43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index e9ecae2..2645875 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -37,6 +37,10 @@ static u_long videomemorysize = VIDEOMEMSIZE;
 module_param(videomemorysize, ulong, 0);
 MODULE_PARM_DESC(videomemorysize, "RAM available to frame buffer (in bytes)");
 
+static char *mode_option;
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Preferred video mode (e.g. 640x480-8@60)");
+
 /**********************************************************************
  *
  * Memory management
@@ -86,26 +90,17 @@ static void rvfree(void *mem, unsigned long size)
 	vfree(mem);
 }
 
-static struct fb_var_screeninfo vfb_default = {
+static struct fb_videomode vfb_default = {
 	.xres =		640,
 	.yres =		480,
-	.xres_virtual =	640,
-	.yres_virtual =	480,
-	.bits_per_pixel = 8,
-	.red =		{ 0, 8, 0 },
-      	.green =	{ 0, 8, 0 },
-      	.blue =		{ 0, 8, 0 },
-      	.activate =	FB_ACTIVATE_TEST,
-      	.height =	-1,
-      	.width =	-1,
-      	.pixclock =	20000,
-      	.left_margin =	64,
-      	.right_margin =	64,
-      	.upper_margin =	32,
-      	.lower_margin =	32,
-      	.hsync_len =	64,
-      	.vsync_len =	2,
-      	.vmode =	FB_VMODE_NONINTERLACED,
+	.pixclock =	20000,
+	.left_margin =	64,
+	.right_margin =	64,
+	.upper_margin =	32,
+	.lower_margin =	32,
+	.hsync_len =	64,
+	.vsync_len =	2,
+	.vmode =	FB_VMODE_NONINTERLACED,
 };
 
 static struct fb_fix_screeninfo vfb_fix = {
@@ -479,6 +474,8 @@ static int __init vfb_setup(char *options)
 		/* Test disable for backwards compatibility */
 		if (!strcmp(this_opt, "disable"))
 			vfb_enable = 0;
+		else
+			mode_option = this_opt;
 	}
 	return 1;
 }
@@ -506,11 +503,13 @@ static int vfb_probe(struct platform_device *dev)
 	info->screen_base = (char __iomem *)videomemory;
 	info->fbops = &vfb_ops;
 
-	retval = fb_find_mode(&info->var, info, NULL,
-			      NULL, 0, NULL, 8);
+	if (!fb_find_mode(&info->var, info, mode_option,
+			  NULL, 0, &vfb_default, 8)){
+		fb_err(info, "Unable to find usable video mode.\n");
+		retval = -EINVAL;
+		goto err1;
+	}
 
-	if (!retval || (retval = 4))
-		info->var = vfb_default;
 	vfb_fix.smem_start = (unsigned long) videomemory;
 	vfb_fix.smem_len = videomemorysize;
 	info->fix = vfb_fix;
-- 
1.7.9.5

