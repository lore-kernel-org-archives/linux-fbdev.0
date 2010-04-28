From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Wed, 28 Apr 2010 10:25:05 +0000
Subject: [PATCH 4/4] sgivwfb: correct sections
Message-Id: <1272450305-7284-4-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: ralf@linux-mips.org, arnaud.patard@rtp-net.org, jayakumar.lkml@gmail.com, gregkh@suse.de, yuasa@linux-mips.org, lethal@linux-sh.org, akpm@linux-foundation.org, adobriyan@gmail.com, support@simtec.co.uk, ben@simtec.co.uk, linux@simtec.co.uk, jkosina@suse.cz, pjones@redhat.com, linux-kernel@vger.kernel.org, Henrik Kretzschmar <henne@nachtwindheim.de>

Since the drivers probe call was changed from .init.text
to .devinit.text in commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b
the fb_fix_screeninfo and fb_var_screeninfo structures must be
changed from .init.data to .devinit.data, too.

Also the drivers remove routine should be moved from .text to .devexit.text

It removes these 7 section mismatch warnings from modpost:

WARNING: vmlinux.o(.devinit.text+0x1e28): Section mismatch in reference from the function sgivwfb_probe() to the variable .init.data:sgivwfb_fix
The function __devinit sgivwfb_probe() references
a variable __initdata sgivwfb_fix.
If sgivwfb_fix is only used by sgivwfb_probe then
annotate sgivwfb_fix with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e50): Section mismatch in reference from the function sgivwfb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit sgivwfb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sgivwfb_probe then
annotate (unknown) with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e59): Section mismatch in reference from the function sgivwfb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit sgivwfb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sgivwfb_probe then
annotate (unknown) with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e60): Section mismatch in reference from the function sgivwfb_probe() to the variable .init.data:sgivwfb_fix
The function __devinit sgivwfb_probe() references
a variable __initdata sgivwfb_fix.
If sgivwfb_fix is only used by sgivwfb_probe then
annotate sgivwfb_fix with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e6a): Section mismatch in reference from the function sgivwfb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit sgivwfb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by sgivwfb_probe then
annotate (unknown) with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e7f): Section mismatch in reference from the function sgivwfb_probe() to the variable .init.data:sgivwfb_var1600sw
The function __devinit sgivwfb_probe() references
a variable __initdata sgivwfb_var1600sw.
If sgivwfb_var1600sw is only used by sgivwfb_probe then
annotate sgivwfb_var1600sw with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x1e91): Section mismatch in reference from the function sgivwfb_probe() to the variable .init.data:sgivwfb_var
The function __devinit sgivwfb_probe() references
a variable __initdata sgivwfb_var.
If sgivwfb_var is only used by sgivwfb_probe then
annotate sgivwfb_var with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
This patch is compile tested.
---
 drivers/video/sgivwfb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index 7a3a5e2..53455f2 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -47,7 +47,7 @@ static int ywrap = 0;
 
 static int flatpanel_id = -1;
 
-static struct fb_fix_screeninfo sgivwfb_fix __initdata = {
+static struct fb_fix_screeninfo sgivwfb_fix __devinitdata = {
 	.id		= "SGI Vis WS FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
         .visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -57,7 +57,7 @@ static struct fb_fix_screeninfo sgivwfb_fix __initdata = {
 	.line_length	= 640,
 };
 
-static struct fb_var_screeninfo sgivwfb_var __initdata = {
+static struct fb_var_screeninfo sgivwfb_var __devinitdata = {
 	/* 640x480, 8 bpp */
 	.xres		= 640,
 	.yres		= 480,
@@ -79,7 +79,7 @@ static struct fb_var_screeninfo sgivwfb_var __initdata = {
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-static struct fb_var_screeninfo sgivwfb_var1600sw __initdata = {
+static struct fb_var_screeninfo sgivwfb_var1600sw __devinitdata = {
 	/* 1600x1024, 8 bpp */
 	.xres		= 1600,
 	.yres		= 1024,
@@ -825,7 +825,7 @@ fail_ioremap_regs:
 	return -ENXIO;
 }
 
-static int sgivwfb_remove(struct platform_device *dev)
+static int __devexit sgivwfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
@@ -845,7 +845,7 @@ static int sgivwfb_remove(struct platform_device *dev)
 
 static struct platform_driver sgivwfb_driver = {
 	.probe	= sgivwfb_probe,
-	.remove	= sgivwfb_remove,
+	.remove	= __devexit_p(sgivwfb_remove),
 	.driver	= {
 		.name	= "sgivwfb",
 	},
-- 
1.7.0

