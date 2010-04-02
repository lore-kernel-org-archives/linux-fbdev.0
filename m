From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 02 Apr 2010 11:59:30 +0000
Subject: [PATCH v2 1/5] fbdev: section cleanup in arcfb
Message-Id: <1270209574-31890-1-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the sections in the arcfb driver, by moving:

*	the variables arcfb_fix and arcfb_var from .init.data to .devinit.data

*	arcfb_remove() from .text to .devexit.text

WARNING: drivers/video/built-in.o(.devinit.text+0x543): Section mismatch in reference from the function arcfb_probe() to the variable .init.data:arcfb_var
The function __devinit arcfb_probe() references
a variable __initdata arcfb_var.
If arcfb_var is only used by arcfb_probe then
annotate arcfb_var with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x558): Section mismatch in reference from the function arcfb_probe() to the variable .init.data:arcfb_fix
The function __devinit arcfb_probe() references
a variable __initdata arcfb_fix.
If arcfb_fix is only used by arcfb_probe then
annotate arcfb_fix with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/arcfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 01554d6..3d18039 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -81,7 +81,7 @@ struct arcfb_par {
 	spinlock_t lock;
 };
 
-static struct fb_fix_screeninfo arcfb_fix __initdata = {
+static struct fb_fix_screeninfo arcfb_fix __devinitdata = {
 	.id =		"arcfb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -91,7 +91,7 @@ static struct fb_fix_screeninfo arcfb_fix __initdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo arcfb_var __initdata = {
+static struct fb_var_screeninfo arcfb_var __devinitdata = {
 	.xres		= 128,
 	.yres		= 64,
 	.xres_virtual	= 128,
@@ -589,7 +589,7 @@ err:
 	return retval;
 }
 
-static int arcfb_remove(struct platform_device *dev)
+static int __devexit arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
@@ -603,7 +603,7 @@ static int arcfb_remove(struct platform_device *dev)
 
 static struct platform_driver arcfb_driver = {
 	.probe	= arcfb_probe,
-	.remove = arcfb_remove,
+	.remove = __devexit_p(arcfb_remove),
 	.driver	= {
 		.name	= "arcfb",
 	},
-- 
1.7.0

