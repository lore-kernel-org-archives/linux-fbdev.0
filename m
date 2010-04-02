From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 02 Apr 2010 11:59:32 +0000
Subject: [PATCH v2 3/5] fbdev: section cleanup in vfb
Message-Id: <1270209574-31890-3-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch cleans up the section in the vfb driver, by moving
the variables vfb_default and vfb_fix from .init.data to .devinit.data

WARNING: drivers/video/vfb.o(.devinit.text+0xf8): Section mismatch in reference from the function vfb_probe() to the variable .init.data:vfb_default
The function __devinit vfb_probe() references
a variable __initdata vfb_default.
If vfb_default is only used by vfb_probe then
annotate vfb_default with a matching annotation.

WARNING: drivers/video/vfb.o(.devinit.text+0x114): Section mismatch in reference from the function vfb_probe() to the variable .init.data:vfb_fix
The function __devinit vfb_probe() references
a variable __initdata vfb_fix.
If vfb_fix is only used by vfb_probe then
annotate vfb_fix with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/vfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index b8ab995..488520b 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -79,7 +79,7 @@ static void rvfree(void *mem, unsigned long size)
 	vfree(mem);
 }
 
-static struct fb_var_screeninfo vfb_default __initdata = {
+static struct fb_var_screeninfo vfb_default __devinitdata = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
@@ -101,7 +101,7 @@ static struct fb_var_screeninfo vfb_default __initdata = {
       	.vmode =	FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo vfb_fix __initdata = {
+static struct fb_fix_screeninfo vfb_fix __devinitdata = {
 	.id =		"Virtual FB",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
-- 
1.7.0

