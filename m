From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 20 Aug 2010 17:13:24 +0000
Subject: [PATCH 1/4] fbdev: fix section mismatches in q40fb.c
Message-Id: <1282324404-3480-1-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: arnaud.patard@rtp-net.org, u.kleine-koenig@pengutronix.de, jayakumar.lkml@gmail.com, henne@nachtwindheim.de, tj@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org

This patch moves the q40_fix and q40_var structures from .init.data
to .devinit.data.
This is where now the probe function resides, which only uses them.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
This patch is against Linus tree and is not compile tested.
It would be nice if someone with a m68k toolchain could test this
and tell if it works like expected.

 drivers/video/q40fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
index fc32c32..f5a39f5 100644
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -28,7 +28,7 @@
 
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
-static struct fb_fix_screeninfo q40fb_fix __initdata = {
+static struct fb_fix_screeninfo q40fb_fix __devinitdata = {
 	.id		= "Q40",
 	.smem_len	= 1024*1024,
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -37,7 +37,7 @@ static struct fb_fix_screeninfo q40fb_fix __initdata = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo q40fb_var __initdata = {
+static struct fb_var_screeninfo q40fb_var __devinitdata = {
 	.xres		= 1024,
 	.yres		= 512,
 	.xres_virtual	= 1024,
-- 
1.7.0.4

