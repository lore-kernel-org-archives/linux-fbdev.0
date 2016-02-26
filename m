From: Alan <alan@linux.intel.com>
Date: Fri, 26 Feb 2016 18:42:19 +0000
Subject: [PATCH 4/5] Subject: goldfish: 32 bit framebuffer support
Message-Id: <20160226184219.2731.30360.stgit@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: bohu <bohu@google.com>

Add support for display formats and allow the use of both 16-bit and
32-bit framebuffers in the emulator.

Signed-off-by: Bo Hu <bohu@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/video/fbdev/goldfishfb.c |   88 ++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 131fee0..cddc91d 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -38,11 +38,56 @@ enum {
 	FB_SET_BLANK        = 0x18,
 	FB_GET_PHYS_WIDTH   = 0x1c,
 	FB_GET_PHYS_HEIGHT  = 0x20,
+	FB_GET_FORMAT       = 0x24,
 
 	FB_INT_VSYNC             = 1U << 0,
 	FB_INT_BASE_UPDATE_DONE  = 1U << 1
 };
 
+/* These values *must* match the platform definitions found under
+ * <system/graphics.h> in the Goldfish emulator.
+ */
+enum {
+	HAL_PIXEL_FORMAT_RGBA_8888          = 1,
+	HAL_PIXEL_FORMAT_RGBX_8888          = 2,
+	HAL_PIXEL_FORMAT_RGB_888            = 3,
+	HAL_PIXEL_FORMAT_RGB_565            = 4,
+	HAL_PIXEL_FORMAT_BGRA_8888          = 5,
+	HAL_PIXEL_FORMAT_RGBA_5551          = 6,
+	HAL_PIXEL_FORMAT_RGBA_4444          = 7,
+};
+
+struct framebuffer_config {
+	u8 format;
+	u8 bytes_per_pixel;
+	u8 transp_offset;
+	u8 transp_length;
+	u8 red_offset;
+	u8 red_length;
+	u8 green_offset;
+	u8 green_length;
+	u8 blue_offset;
+	u8 blue_length;
+};
+
+static const struct framebuffer_config *get_fb_config_from_format(int format)
+{
+	/* Only configurations supported by the emulator. */
+	static const struct framebuffer_config fb_configs[] = {
+		{ HAL_PIXEL_FORMAT_RGB_565, 2, 0, 0, 11, 5, 5, 6, 0, 5 },
+		{ HAL_PIXEL_FORMAT_RGBX_8888, 4, 0, 0, 16, 8, 8, 8, 0, 8 },
+		{ HAL_PIXEL_FORMAT_RGBA_8888, 4, 24, 8, 16, 8, 8, 8, 0, 8 },
+	};
+	const int fb_configs_size = ARRAY_SIZE(fb_configs);
+	int n;
+
+	for (n = 0; n < fb_configs_size; ++n) {
+		if (format = fb_configs[n].format)
+			return &fb_configs[n];
+	}
+	return &fb_configs[0]; /* default to RGB565 */
+}
+
 struct goldfish_fb {
 	void __iomem *reg_base;
 	int irq;
@@ -126,7 +171,8 @@ static int goldfish_fb_set_par(struct fb_info *info)
 {
 	struct goldfish_fb *fb = container_of(info, struct goldfish_fb, fb);
 	if (fb->rotation != fb->fb.var.rotate) {
-		info->fix.line_length = info->var.xres * 2;
+		info->fix.line_length = info->var.xres *
+			(fb->fb.var.bits_per_pixel / 8);
 		fb->rotation = fb->fb.var.rotate;
 		writel(fb->rotation, fb->reg_base + FB_SET_ROTATION);
 	}
@@ -143,8 +189,10 @@ static int goldfish_fb_pan_display(struct fb_var_screeninfo *var,
 
 	spin_lock_irqsave(&fb->lock, irq_flags);
 	base_update_count = fb->base_update_count;
-	writel(fb->fb.fix.smem_start + fb->fb.var.xres * 2 * var->yoffset,
-						fb->reg_base + FB_SET_BASE);
+	writel(fb->fb.fix.smem_start +
+		fb->fb.var.xres * (
+			fb->fb.var.bits_per_pixel / 8) * var->yoffset,
+		fb->reg_base + FB_SET_BASE);
 	spin_unlock_irqrestore(&fb->lock, irq_flags);
 	wait_event_timeout(fb->wait,
 			fb->base_update_count != base_update_count, HZ / 15);
@@ -186,8 +234,10 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct goldfish_fb *fb;
 	size_t framesize;
-	u32 width, height;
+	u32 width, height, format;
+	int bytes_per_pixel;
 	dma_addr_t fbpaddr;
+	const struct framebuffer_config *fb_config;
 
 	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
 	if (fb = NULL) {
@@ -217,13 +267,20 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 
 	width = readl(fb->reg_base + FB_GET_WIDTH);
 	height = readl(fb->reg_base + FB_GET_HEIGHT);
+	format = readl(fb->reg_base + FB_GET_FORMAT);
+	fb_config = get_fb_config_from_format(format);
+	if (!fb_config) {
+		ret = -EINVAL;
+		goto err_no_irq;
+	}
+	bytes_per_pixel = fb_config->bytes_per_pixel;
 
 	fb->fb.fbops		= &goldfish_fb_ops;
 	fb->fb.flags		= FBINFO_FLAG_DEFAULT;
 	fb->fb.pseudo_palette	= fb->cmap;
 	fb->fb.fix.type		= FB_TYPE_PACKED_PIXELS;
 	fb->fb.fix.visual = FB_VISUAL_TRUECOLOR;
-	fb->fb.fix.line_length = width * 2;
+	fb->fb.fix.line_length = width * bytes_per_pixel;
 	fb->fb.fix.accel	= FB_ACCEL_NONE;
 	fb->fb.fix.ypanstep = 1;
 
@@ -231,20 +288,22 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	fb->fb.var.yres		= height;
 	fb->fb.var.xres_virtual	= width;
 	fb->fb.var.yres_virtual	= height * 2;
-	fb->fb.var.bits_per_pixel = 16;
+	fb->fb.var.bits_per_pixel = bytes_per_pixel * 8;
 	fb->fb.var.activate	= FB_ACTIVATE_NOW;
 	fb->fb.var.height	= readl(fb->reg_base + FB_GET_PHYS_HEIGHT);
 	fb->fb.var.width	= readl(fb->reg_base + FB_GET_PHYS_WIDTH);
 	fb->fb.var.pixclock	= 0;
 
-	fb->fb.var.red.offset = 11;
-	fb->fb.var.red.length = 5;
-	fb->fb.var.green.offset = 5;
-	fb->fb.var.green.length = 6;
-	fb->fb.var.blue.offset = 0;
-	fb->fb.var.blue.length = 5;
+	fb->fb.var.red.offset = fb_config->red_offset;
+	fb->fb.var.red.length = fb_config->red_length;
+	fb->fb.var.green.offset = fb_config->green_offset;
+	fb->fb.var.green.length = fb_config->green_length;
+	fb->fb.var.blue.offset = fb_config->blue_offset;
+	fb->fb.var.blue.length = fb_config->blue_length;
+	fb->fb.var.transp.offset = fb_config->transp_offset;
+	fb->fb.var.transp.length = fb_config->transp_length;
 
-	framesize = width * height * 2 * 2;
+	framesize = width * height * 2 * bytes_per_pixel;
 	fb->fb.screen_base = (char __force __iomem *)dma_alloc_coherent(
 						&pdev->dev, framesize,
 						&fbpaddr, GFP_KERNEL);
@@ -295,7 +354,8 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 	size_t framesize;
 	struct goldfish_fb *fb = platform_get_drvdata(pdev);
 
-	framesize = fb->fb.var.xres_virtual * fb->fb.var.yres_virtual * 2;
+	framesize = fb->fb.var.xres_virtual * fb->fb.var.yres_virtual *
+		(fb->fb.var.bits_per_pixel / 8);
 	unregister_framebuffer(&fb->fb);
 	free_irq(fb->irq, fb);
 

