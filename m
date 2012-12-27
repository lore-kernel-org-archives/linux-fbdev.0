From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 27 Dec 2012 00:25:43 +0000
Subject: [PATCH fix-3.8] video: vt8500: Fix X crash when initializing framebuffer.
Message-Id: <1356567943-3836-1-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds support for .fb_check_var which is required when
X attempts to initialize the framebuffer. The only supported
resolution is the native resolution of the LCD panel, so we test
against the resolution supplied from the DT panel definition.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/video/wm8505fb.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 77539c1..c84e376 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -41,10 +41,18 @@
 
 #define to_wm8505fb_info(__info) container_of(__info, \
 						struct wm8505fb_info, fb)
+
+struct lcd_params {
+	u32 pixel_width;
+	u32 pixel_height;
+	u32 color_depth;
+};
+
 struct wm8505fb_info {
 	struct fb_info		fb;
 	void __iomem		*regbase;
 	unsigned int		contrast;
+	struct lcd_params	lcd_params;
 };
 
 
@@ -248,8 +256,21 @@ static int wm8505fb_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
+static int wm8505fb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	struct wm8505fb_info *fbi = to_wm8505fb_info(info);
+        if (!fbi) return -EINVAL;
+
+	if (info->var.bits_per_pixel != fbi->lcd_params.color_depth) return -EINVAL;
+	if (info->var.xres != fbi->lcd_params.pixel_width) return -EINVAL;
+	if (info->var.yres != fbi->lcd_params.pixel_height) return -EINVAL;
+	return 0;
+}
+
 static struct fb_ops wm8505fb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_check_var	= wm8505fb_check_var,
 	.fb_set_par	= wm8505fb_set_par,
 	.fb_setcolreg	= wm8505fb_setcolreg,
 	.fb_fillrect	= wmt_ge_fillrect,
@@ -354,6 +375,10 @@ static int __devinit wm8505fb_probe(struct platform_device *pdev)
 		goto failed_free_res;
 	}
 
+	fbi->lcd_params.pixel_width = of_mode.xres;
+	fbi->lcd_params.pixel_height = of_mode.yres;
+	fbi->lcd_params.color_depth = bpp;
+
 	of_mode.vmode = FB_VMODE_NONINTERLACED;
 	fb_videomode_to_var(&fbi->fb.var, &of_mode);
 
-- 
1.7.9.5

