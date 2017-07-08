From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Sat, 08 Jul 2017 01:24:16 +0000
Subject: [PATCH] video: xilinxfb: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <20170708012416.GA1843@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

These structures are only used to copy into other structures,
so declare them as const.

This issue was detected using Coccinelle and the following semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct fb_fix_screeninfo i@p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i@p

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct fb_fix_screeninfo e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct fb_fix_screeninfo i = { ... };

The semantic patch for fb_var_screeninfo is analogous.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/xilinxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 17dc119..0bda18e 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -110,14 +110,14 @@ static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
 /*
  * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
  */
-static struct fb_fix_screeninfo xilinx_fb_fix = {
+static const struct fb_fix_screeninfo xilinx_fb_fix = {
 	.id =		"Xilinx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
 	.accel =	FB_ACCEL_NONE
 };
 
-static struct fb_var_screeninfo xilinx_fb_var = {
+static const struct fb_var_screeninfo xilinx_fb_var = {
 	.bits_per_pixel =	BITS_PER_PIXEL,
 
 	.red =		{ RED_SHIFT, 8, 0 },
-- 
2.5.0

