From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Sat, 27 Mar 2010 06:29:08 +0000
Subject: [PATCH 4/7] fbdev: section cleanup in vesafb
Message-Id: <1269671353-22041-3-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269671353-22041-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1269671353-22041-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Henrik Kretzschmar <henne@nachtwindheim.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Jones <pjones@redhat.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org

This patch cleans up the sections in the vesafb driver.

WARNING: drivers/video/built-in.o(.devinit.text+0x19495): Section mismatch in reference from the function vesafb_probe() to the variable .init.data:vesafb_fix
The function __devinit vesafb_probe() references
a variable __initdata vesafb_fix.
If vesafb_fix is only used by vesafb_probe then
annotate vesafb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x194a5): Section mismatch in reference from the function vesafb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit vesafb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by vesafb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x194d5): Section mismatch in reference from the function vesafb_probe() to the variable .init.data:vesafb_defined
The function __devinit vesafb_probe() references
a variable __initdata vesafb_defined.
If vesafb_defined is only used by vesafb_probe then
annotate vesafb_defined with a matching annotation.

...
fbdev: section cleanup in vesafb

This patch cleans up the sections in the vesafb driver.

WARNING: drivers/video/built-in.o(.devinit.text+0x19495): Section mismatch in reference from the function vesafb_probe() to the variable .init.data:vesafb_fix
The function __devinit vesafb_probe() references
a variable __initdata vesafb_fix.
If vesafb_fix is only used by vesafb_probe then
annotate vesafb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x194a5): Section mismatch in reference from the function vesafb_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit vesafb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by vesafb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x194d5): Section mismatch in reference from the function vesafb_probe() to the variable .init.data:vesafb_defined
The function __devinit vesafb_probe() references
a variable __initdata vesafb_defined.
If vesafb_defined is only used by vesafb_probe then
annotate vesafb_defined with a matching annotation.

...

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/vesafb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index ef4128c..ba8e394 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -30,7 +30,7 @@
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo vesafb_defined __initdata = {
+static struct fb_var_screeninfo vesafb_defined __devinitdata = {
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,
@@ -41,7 +41,7 @@ static struct fb_var_screeninfo vesafb_defined __initdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo vesafb_fix __initdata = {
+static struct fb_fix_screeninfo vesafb_fix __devinitdata = {
 	.id	= "VESA VGA",
 	.type	= FB_TYPE_PACKED_PIXELS,
 	.accel	= FB_ACCEL_NONE,
@@ -49,8 +49,8 @@ static struct fb_fix_screeninfo vesafb_fix __initdata = {
 
 static int   inverse    __read_mostly;
 static int   mtrr       __read_mostly;		/* disable mtrr */
-static int   vram_remap __initdata;		/* Set amount of memory to be used */
-static int   vram_total __initdata;		/* Set total amount of memory */
+static int   vram_remap __devinitdata;		/* Set amount of memory to be used */
+static int   vram_total __devinitdata;		/* Set total amount of memory */
 static int   pmi_setpal __read_mostly = 1;	/* pmi for palette changes ??? */
 static int   ypan       __read_mostly;		/* 0..nothing, 1..ypan, 2..ywrap */
 static void  (*pmi_start)(void) __read_mostly;
-- 
1.7.0

