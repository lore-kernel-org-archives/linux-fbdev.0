From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Sat, 27 Mar 2010 06:29:06 +0000
Subject: [PATCH 2/7] fbdev: section cleanup in efifb
Message-Id: <1269671353-22041-1-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Henrik Kretzschmar <henne@nachtwindheim.de>, Peter Jones <pjones@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alex Zhavnerchik <alex.vizor@gmail.com>, Huang Ying <ying.huang@intel.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org

This patch fixes the sections on the efifb driver.

WARNING: drivers/video/built-in.o(.devinit.text+0x19f8c): Section mismatch in re
ference from the function efifb_probe() to the (unknown reference) .init.data:(u
nknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x19f9a): Section mismatch in reference from the function efifb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x19fa1): Section mismatch in reference from the function efifb_probe() to the variable .init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x19fa7): Section mismatch in reference from the function efifb_probe() to the variable .init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/efifb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 581d2db..6aea0d3 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -16,7 +16,7 @@
 
 #include <video/vga.h>
 
-static struct fb_var_screeninfo efifb_defined __initdata = {
+static struct fb_var_screeninfo efifb_defined __devinitdata = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
 	.width			= -1,
@@ -27,7 +27,7 @@ static struct fb_var_screeninfo efifb_defined __initdata = {
 	.vmode			= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo efifb_fix __initdata = {
+static struct fb_fix_screeninfo efifb_fix __devinitdata = {
 	.id			= "EFI VGA",
 	.type			= FB_TYPE_PACKED_PIXELS,
 	.accel			= FB_ACCEL_NONE,
-- 
1.7.0

