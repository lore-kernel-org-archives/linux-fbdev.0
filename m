From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sun, 20 Aug 2017 17:56:51 +0000
Subject: [PATCH] video: fbdev: annotate fb_fix_screeninfo with const and  __initconst
Message-Id: <1503251091-23485-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, nicolas.ferre@microchip.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const as they are only used during a copy operation.
Some structures are used as a copy operation inside __init functions, so
make them const and replace __initdata with __initconst to avoid section
conflict error.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/68328fb.c     | 2 +-
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 drivers/video/fbdev/dnfb.c        | 2 +-
 drivers/video/fbdev/grvga.c       | 2 +-
 drivers/video/fbdev/pmag-aa-fb.c  | 2 +-
 drivers/video/fbdev/pmag-ba-fb.c  | 2 +-
 drivers/video/fbdev/pmagb-b-fb.c  | 2 +-
 drivers/video/fbdev/ps3fb.c       | 2 +-
 drivers/video/fbdev/skeletonfb.c  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/68328fb.c b/drivers/video/fbdev/68328fb.c
index c0c6b88..d48e960 100644
--- a/drivers/video/fbdev/68328fb.c
+++ b/drivers/video/fbdev/68328fb.c
@@ -72,7 +72,7 @@
       	.vmode =	FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo mc68x328fb_fix __initdata = {
+static const struct fb_fix_screeninfo mc68x328fb_fix __initconst = {
 	.id =		"68328fb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.xpanstep =	1,
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 669ecc7..e06358d 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -320,7 +320,7 @@ static inline void atmel_lcdfb_power_control(struct atmel_lcdfb_info *sinfo, int
 	}
 }
 
-static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
+static const struct fb_fix_screeninfo atmel_lcdfb_fix __initconst = {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.xpanstep	= 0,
diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index 3526899..7b1492d 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -126,7 +126,7 @@ struct fb_var_screeninfo dnfb_var = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo dnfb_fix = {
+static const struct fb_fix_screeninfo dnfb_fix = {
 	.id		= "Apollo Mono",
 	.smem_start	= (FRAME_BUFFER_START + IO_BASE),
 	.smem_len	= FRAME_BUFFER_LEN,
diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index b471f92..8fc8f46 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -70,7 +70,7 @@ struct grvga_par {
     }
  };
 
-static struct fb_fix_screeninfo grvga_fix = {
+static const struct fb_fix_screeninfo grvga_fix = {
 	.id =		"AG SVGACTRL",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =       FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/fbdev/pmag-aa-fb.c b/drivers/video/fbdev/pmag-aa-fb.c
index 39922f0..b07ef49 100644
--- a/drivers/video/fbdev/pmag-aa-fb.c
+++ b/drivers/video/fbdev/pmag-aa-fb.c
@@ -90,7 +90,7 @@ struct aafb_par {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo aafb_fix = {
+static const struct fb_fix_screeninfo aafb_fix = {
 	.id		= "PMAG-AA",
 	.smem_len	= (2048 * 1024),
 	.type		= FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/fbdev/pmag-ba-fb.c b/drivers/video/fbdev/pmag-ba-fb.c
index 1fd02f4..8d1a878 100644
--- a/drivers/video/fbdev/pmag-ba-fb.c
+++ b/drivers/video/fbdev/pmag-ba-fb.c
@@ -67,7 +67,7 @@ struct pmagbafb_par {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo pmagbafb_fix = {
+static const struct fb_fix_screeninfo pmagbafb_fix = {
 	.id		= "PMAG-BA",
 	.smem_len	= (1024 * 1024),
 	.type		= FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/fbdev/pmagb-b-fb.c b/drivers/video/fbdev/pmagb-b-fb.c
index 46e96c4..5ad9b63 100644
--- a/drivers/video/fbdev/pmagb-b-fb.c
+++ b/drivers/video/fbdev/pmagb-b-fb.c
@@ -57,7 +57,7 @@ struct pmagbbfb_par {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo pmagbbfb_fix = {
+static const struct fb_fix_screeninfo pmagbbfb_fix = {
 	.id		= "PMAGB-BA",
 	.smem_len	= (2048 * 1024),
 	.type		= FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index b269abd..5ed2db3 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -952,7 +952,7 @@ static irqreturn_t ps3fb_vsync_interrupt(int irq, void *ptr)
 	.fb_compat_ioctl = ps3fb_ioctl
 };
 
-static struct fb_fix_screeninfo ps3fb_fix = {
+static const struct fb_fix_screeninfo ps3fb_fix = {
 	.id =		DEVICE_NAME,
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index 09a1d8c..7f4e908 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -84,7 +84,7 @@
  * if we don't use modedb. If we do use modedb see xxxfb_init how to use it
  * to get a fb_var_screeninfo. Otherwise define a default var as well. 
  */
-static struct fb_fix_screeninfo xxxfb_fix = {
+static const struct fb_fix_screeninfo xxxfb_fix = {
 	.id =		"FB's name", 
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
-- 
1.9.1

