From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:38:25 +0000
Subject: [PATCH 01/13] FB: sa1100: avoid section mismatch warnings
Message-Id: <E1Rtc4f-0000aE-Cz@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

WARNING: drivers/video/built-in.o(.devinit.text+0x58): Section mismatch in reference from the function sa1100fb_probe() to the function .init.text:sa1100fb_init_fbinfo()
The function __devinit sa1100fb_probe() references
a function __init sa1100fb_init_fbinfo().
If sa1100fb_init_fbinfo is only used by sa1100fb_probe then
annotate sa1100fb_init_fbinfo with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x258): Section mismatch in reference from the function sa1100fb_init_fbinfo() to the (unknown reference) .init.data:(unknown)
The function __devinit sa1100fb_init_fbinfo() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sa1100fb_init_fbinfo then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x26c): Section mismatch in reference from the function sa1100fb_init_fbinfo() to the (unknown reference) .init.data:(unknown)
The function __devinit sa1100fb_init_fbinfo() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sa1100fb_init_fbinfo then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x270): Section mismatch in reference from the function sa1100fb_init_fbinfo() to the (unknown reference) .init.data:(unknown)
The function __devinit sa1100fb_init_fbinfo() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sa1100fb_init_fbinfo then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x278): Section mismatch in reference from the function sa1100fb_init_fbinfo() to the (unknown reference) .init.data:(unknown)
The function __devinit sa1100fb_init_fbinfo() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sa1100fb_init_fbinfo then
annotate (unknown) with a matching annotation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 98d55d0..2cc268c 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -227,7 +227,7 @@ static struct sa1100fb_rgb def_rgb_16 = {
  * takes an RGB666 signal, but we provide it with an RGB565 signal
  * instead (def_rgb_16).
  */
-static struct sa1100fb_mach_info lq039q2ds54_info __initdata = {
+static struct sa1100fb_mach_info lq039q2ds54_info __devinitdata = {
 	.pixclock	= 171521,	.bpp		= 16,
 	.xres		= 320,		.yres		= 240,
 
@@ -241,7 +241,7 @@ static struct sa1100fb_mach_info lq039q2ds54_info __initdata = {
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
 };
 #else
-static struct sa1100fb_mach_info pal_info __initdata = {
+static struct sa1100fb_mach_info pal_info __devinitdata = {
 	.pixclock	= 67797,	.bpp		= 16,
 	.xres		= 640,		.yres		= 512,
 
@@ -256,7 +256,7 @@ static struct sa1100fb_mach_info pal_info __initdata = {
 #endif
 
 #ifdef CONFIG_SA1100_H3600
-static struct sa1100fb_mach_info h3600_info __initdata = {
+static struct sa1100fb_mach_info h3600_info __devinitdata = {
 	.pixclock	= 174757, 	.bpp		= 16,
 	.xres		= 320,		.yres		= 240,
 
@@ -279,7 +279,7 @@ static struct sa1100fb_rgb h3600_rgb_16 = {
 #endif
 
 #ifdef CONFIG_SA1100_H3100
-static struct sa1100fb_mach_info h3100_info __initdata = {
+static struct sa1100fb_mach_info h3100_info __devinitdata = {
 	.pixclock	= 406977, 	.bpp		= 4,
 	.xres		= 320,		.yres		= 240,
 
@@ -297,7 +297,7 @@ static struct sa1100fb_mach_info h3100_info __initdata = {
 #endif
 
 #ifdef CONFIG_SA1100_COLLIE
-static struct sa1100fb_mach_info collie_info __initdata = {
+static struct sa1100fb_mach_info collie_info __devinitdata = {
 	.pixclock	= 171521,	.bpp		= 16,
 	.xres		= 320,		.yres		= 240,
 
@@ -313,7 +313,7 @@ static struct sa1100fb_mach_info collie_info __initdata = {
 #endif
 
 #ifdef LART_GREY_LCD
-static struct sa1100fb_mach_info lart_grey_info __initdata = {
+static struct sa1100fb_mach_info lart_grey_info __devinitdata = {
 	.pixclock	= 150000,	.bpp		= 4,
 	.xres		= 320,		.yres		= 240,
 
@@ -329,7 +329,7 @@ static struct sa1100fb_mach_info lart_grey_info __initdata = {
 };
 #endif
 #ifdef LART_COLOR_LCD
-static struct sa1100fb_mach_info lart_color_info __initdata = {
+static struct sa1100fb_mach_info lart_color_info __devinitdata = {
 	.pixclock	= 150000,	.bpp		= 16,
 	.xres		= 320,		.yres		= 240,
 
@@ -342,7 +342,7 @@ static struct sa1100fb_mach_info lart_color_info __initdata = {
 };
 #endif
 #ifdef LART_VIDEO_OUT
-static struct sa1100fb_mach_info lart_video_info __initdata = {
+static struct sa1100fb_mach_info lart_video_info __devinitdata = {
 	.pixclock	= 39721,	.bpp		= 16,
 	.xres		= 640,		.yres		= 480,
 
@@ -358,7 +358,7 @@ static struct sa1100fb_mach_info lart_video_info __initdata = {
 #endif
 
 #ifdef LART_KIT01_LCD
-static struct sa1100fb_mach_info lart_kit01_info __initdata = {
+static struct sa1100fb_mach_info lart_kit01_info __devinitdata = {
 	.pixclock	= 63291,	.bpp		= 16,
 	.xres		= 640,		.yres		= 480,
 
@@ -372,7 +372,7 @@ static struct sa1100fb_mach_info lart_kit01_info __initdata = {
 #endif
 
 #ifdef CONFIG_SA1100_SHANNON
-static struct sa1100fb_mach_info shannon_info __initdata = {
+static struct sa1100fb_mach_info shannon_info __devinitdata = {
 	.pixclock	= 152500,	.bpp		= 8,
 	.xres		= 640,		.yres		= 480,
 
@@ -389,7 +389,7 @@ static struct sa1100fb_mach_info shannon_info __initdata = {
 
 
 
-static struct sa1100fb_mach_info * __init
+static struct sa1100fb_mach_info * __devinit
 sa1100fb_get_machine_info(struct sa1100fb_info *fbi)
 {
 	struct sa1100fb_mach_info *inf = NULL;
@@ -1318,7 +1318,7 @@ static int sa1100fb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __init sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
+static int __devinit sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 {
 	/*
 	 * We reserve one page for the palette, plus the size
@@ -1344,7 +1344,7 @@ static int __init sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 }
 
 /* Fake monspecs to fill in fbinfo structure */
-static struct fb_monspecs monspecs __initdata = {
+static struct fb_monspecs monspecs __devinitdata = {
 	.hfmin	= 30000,
 	.hfmax	= 70000,
 	.vfmin	= 50,
@@ -1352,7 +1352,7 @@ static struct fb_monspecs monspecs __initdata = {
 };
 
 
-static struct sa1100fb_info * __init sa1100fb_init_fbinfo(struct device *dev)
+static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 {
 	struct sa1100fb_mach_info *inf;
 	struct sa1100fb_info *fbi;
-- 
1.7.4.4

