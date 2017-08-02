From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 02 Aug 2017 09:04:39 +0000
Subject: [PATCH] video: fbdev: constify copied structures
Message-Id: <1501664679-10356-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Make const some structures that are only copied into other structures.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/xilinxfb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 17dc119..9531474 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -100,7 +100,7 @@ struct xilinxfb_platform_data {
 /*
  * Default xilinxfb configuration
  */
-static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
+static const struct xilinxfb_platform_data xilinx_fb_default_pdata = {
 	.xres = 640,
 	.yres = 480,
 	.xvirt = 1024,
@@ -110,14 +110,14 @@ struct xilinxfb_platform_data {
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

