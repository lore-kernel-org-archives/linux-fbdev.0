From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 02 Apr 2010 11:59:33 +0000
Subject: [PATCH v2 4/5] fbdev: section cleanup in vga16fb
Message-Id: <1270209574-31890-4-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch cleans up the sections in the vga16fb driver, by moving:

*	the variables vga16_defined and vga16fb
	from .init.data to .devinit.data

*	vga16fb_setup() from .text to .init.text

*	vga16fb_remove() from .text. to .devexit.text

WARNING: drivers/video/built-in.o(.devinit.text+0x1a420): Section mismatch in re
ference from the function vga16fb_probe() to the (unknown reference) .init.data:
(unknown)
The function __devinit vga16fb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by vga16fb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1a437): Section mismatch in reference from the function vga16fb_probe() to the variable .init.data:vga16fb_defined
The function __devinit vga16fb_probe() references
a variable __initdata vga16fb_defined.
If vga16fb_defined is only used by vga16fb_probe then
annotate vga16fb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1a457): Section mismatch in reference from the function vga16fb_probe() to the variable .init.data:vga16fb_fix
The function __devinit vga16fb_probe() references
a variable __initdata vga16fb_fix.
If vga16fb_fix is only used by vga16fb_probe then
annotate vga16fb_fix with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/vga16fb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 76d8dae..b06ea7c 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -66,7 +66,7 @@ struct vga16fb_par {
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo vga16fb_defined __initdata = {
+static struct fb_var_screeninfo vga16fb_defined __devinitdata = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
@@ -86,7 +86,7 @@ static struct fb_var_screeninfo vga16fb_defined __initdata = {
 };
 
 /* name should not depend on EGA/VGA */
-static struct fb_fix_screeninfo vga16fb_fix __initdata = {
+static struct fb_fix_screeninfo vga16fb_fix __devinitdata = {
 	.id		= "VGA16 VGA",
 	.smem_start	= VGA_FB_PHYS,
 	.smem_len	= VGA_FB_PHYS_LEN,
@@ -1279,7 +1279,7 @@ static struct fb_ops vga16fb_ops = {
 };
 
 #ifndef MODULE
-static int vga16fb_setup(char *options)
+static int __init vga16fb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -1377,7 +1377,7 @@ static int __devinit vga16fb_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int vga16fb_remove(struct platform_device *dev)
+static int __devexit vga16fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
@@ -1394,7 +1394,7 @@ static int vga16fb_remove(struct platform_device *dev)
 
 static struct platform_driver vga16fb_driver = {
 	.probe = vga16fb_probe,
-	.remove = vga16fb_remove,
+	.remove = __devexit_p(vga16fb_remove),
 	.driver = {
 		.name = "vga16fb",
 	},
-- 
1.7.0

