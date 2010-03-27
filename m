From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Sat, 27 Mar 2010 06:29:09 +0000
Subject: [PATCH 5/7] fbdev: section cleanup in vfb
Message-Id: <1269671353-22041-4-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269671353-22041-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1269671353-22041-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Henrik Kretzschmar <henne@nachtwindheim.de>, Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Arnaud Patard <arnaud.patard@rtp-net.org>, Andres Salomon <dilinger@debian.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org

This patch cleans up the section in the vfb driver.

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

