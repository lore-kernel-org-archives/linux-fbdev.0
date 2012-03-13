From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 13 Mar 2012 13:13:57 +0000
Subject: [PATCH v2 2/2] fbdev: da8xx: add support for SP10Q010 display
Message-Id: <1331644437-5440-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add timing data for Hitachi SP10Q010 display and allow configuration
of the 4bpp palette. For 4bpp framebuffer enable reversed order of
pixels in a byte. This requires defining FB_CFB_REV_PIXELS_IN_BYTE
and additionally setting var.nonstd to the value FB_NONSTD_REV_PIX_IN_B.
Note that it is not enough to set da8xx_fb_var.nonstd to this value
statically, since FBIOPUT_VSCREENINFO ioctl might pass var struct with
.nonstd field set to zero or another value. Therefore this setting must
be adjusted in fb_check_var() according to the requested bpp value.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Manjunathappa, Prakash <prakash.pm@ti.com>
---
v2:
 - rebased on fbdev-next branch

 drivers/video/Kconfig    |    1 +
 drivers/video/da8xx-fb.c |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8951cbd..58ea0be 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2245,6 +2245,7 @@ config FB_DA8XX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_REV_PIXELS_IN_BYTE
 	---help---
 	  This is the frame buffer device driver for the TI LCD controller
 	  found on DA8xx/OMAP-L1xx SoCs.
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 8f7e051..47118c7 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -239,6 +239,20 @@ static struct da8xx_panel known_lcd_panels[] = {
 		.pxl_clk = 7833600,
 		.invert_pxl_clk = 0,
 	},
+	[2] = {
+		/* Hitachi SP10Q010 */
+		.name = "SP10Q010",
+		.width = 320,
+		.height = 240,
+		.hfp = 10,
+		.hbp = 10,
+		.hsw = 10,
+		.vfp = 10,
+		.vbp = 10,
+		.vsw = 10,
+		.pxl_clk = 7833600,
+		.invert_pxl_clk = 0,
+	},
 };
 
 /* Enable the Raster Engine of the LCD Controller */
@@ -547,7 +561,26 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
 		return 1;
 
-	if (info->var.bits_per_pixel = 8) {
+	if (info->var.bits_per_pixel = 4) {
+		if (regno > 15)
+			return 1;
+
+		if (info->var.grayscale) {
+			pal = regno;
+		} else {
+			red >>= 4;
+			green >>= 8;
+			blue >>= 12;
+
+			pal = (red & 0x0f00);
+			pal |= (green & 0x00f0);
+			pal |= (blue & 0x000f);
+		}
+		if (regno = 0)
+			pal |= 0x2000;
+		palette[regno] = pal;
+
+	} else if (info->var.bits_per_pixel = 8) {
 		red >>= 4;
 		green >>= 8;
 		blue >>= 12;
@@ -802,6 +835,7 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length = 8;
 		var->transp.offset = 0;
 		var->transp.length = 0;
+		var->nonstd = 0;
 		break;
 	case 4:
 		var->red.offset = 0;
@@ -812,6 +846,7 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length = 4;
 		var->transp.offset = 0;
 		var->transp.length = 0;
+		var->nonstd = FB_NONSTD_REV_PIX_IN_B;
 		break;
 	case 16:		/* RGB 565 */
 		var->red.offset = 11;
@@ -822,6 +857,7 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length = 5;
 		var->transp.offset = 0;
 		var->transp.length = 0;
+		var->nonstd = 0;
 		break;
 	default:
 		err = -EINVAL;
-- 
1.7.1

