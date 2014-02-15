From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 15 Feb 2014 05:56:25 +0000
Subject: [PATCH 4/5] video: imxfb: Resolve mismatch between backlight/contrast
Message-Id: <1392443786-30527-4-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently, driver uses backlight class to control contrast value.
This is not correct. This patch resolves this issue by removing
backlight class from the driver and replace handling of LCDC PWM
Contrast Control Register by contrast control through LCD class.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/imxfb.c | 124 ++++++++++++--------------------------------------
 1 file changed, 30 insertions(+), 94 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 3137a69..398a8ca 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -48,12 +48,6 @@
  */
 #define DEBUG_VAR 1
 
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
-	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
-		defined(CONFIG_FB_IMX_MODULE))
-#define PWMR_BACKLIGHT_AVAILABLE
-#endif
-
 #define DRIVER_NAME "imx-fb"
 
 #define LCDC_SSA	0x00
@@ -172,9 +166,6 @@ struct imxfb_info {
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
-#ifdef PWMR_BACKLIGHT_AVAILABLE
-	struct backlight_device *bl;
-#endif
 
 	struct regulator	*lcd_pwr;
 };
@@ -482,83 +473,6 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
 
-#ifdef PWMR_BACKLIGHT_AVAILABLE
-static int imxfb_bl_get_brightness(struct backlight_device *bl)
-{
-	struct imxfb_info *fbi = bl_get_data(bl);
-
-	return readl(fbi->regs + LCDC_PWMR) & 0xFF;
-}
-
-static int imxfb_bl_update_status(struct backlight_device *bl)
-{
-	struct imxfb_info *fbi = bl_get_data(bl);
-	int brightness = bl->props.brightness;
-
-	if (!fbi->pwmr)
-		return 0;
-
-	if (bl->props.power != FB_BLANK_UNBLANK)
-		brightness = 0;
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
-		brightness = 0;
-
-	fbi->pwmr = (fbi->pwmr & ~0xFF) | brightness;
-
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK) {
-		clk_prepare_enable(fbi->clk_ipg);
-		clk_prepare_enable(fbi->clk_ahb);
-		clk_prepare_enable(fbi->clk_per);
-	}
-	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK) {
-		clk_disable_unprepare(fbi->clk_per);
-		clk_disable_unprepare(fbi->clk_ahb);
-		clk_disable_unprepare(fbi->clk_ipg);
-	}
-
-	return 0;
-}
-
-static const struct backlight_ops imxfb_lcdc_bl_ops = {
-	.update_status = imxfb_bl_update_status,
-	.get_brightness = imxfb_bl_get_brightness,
-};
-
-static void imxfb_init_backlight(struct imxfb_info *fbi)
-{
-	struct backlight_properties props;
-	struct backlight_device	*bl;
-
-	if (fbi->bl)
-		return;
-
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.max_brightness = 0xff;
-	props.type = BACKLIGHT_RAW;
-	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
-
-	bl = backlight_device_register("imxfb-bl", &fbi->pdev->dev, fbi,
-				       &imxfb_lcdc_bl_ops, &props);
-	if (IS_ERR(bl)) {
-		dev_err(&fbi->pdev->dev, "error %ld on backlight register\n",
-				PTR_ERR(bl));
-		return;
-	}
-
-	fbi->bl = bl;
-	bl->props.power = FB_BLANK_UNBLANK;
-	bl->props.fb_blank = FB_BLANK_UNBLANK;
-	bl->props.brightness = imxfb_bl_get_brightness(bl);
-}
-
-static void imxfb_exit_backlight(struct imxfb_info *fbi)
-{
-	if (fbi->bl)
-		backlight_device_unregister(fbi->bl);
-}
-#endif
-
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
 
@@ -697,10 +611,8 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 			fbi->regs + LCDC_SIZE);
 
 	writel(fbi->pcr, fbi->regs + LCDC_PCR);
-#ifndef PWMR_BACKLIGHT_AVAILABLE
 	if (fbi->pwmr)
 		writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
-#endif
 	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
 
 	/* dmacr = 0 is no valid value, as we need DMA control marks. */
@@ -844,6 +756,32 @@ static int imxfb_lcd_check_fb(struct lcd_device *lcddev, struct fb_info *fi)
 	return 0;
 }
 
+static int imxfb_lcd_get_contrast(struct lcd_device *lcddev)
+{
+	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
+
+	return fbi->pwmr & 0xff;
+}
+
+static int imxfb_lcd_set_contrast(struct lcd_device *lcddev, int contrast)
+{
+	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
+
+	if (fbi->pwmr && fbi->enabled) {
+		if (contrast > 255)
+			contrast = 255;
+		else if (contrast < 0)
+			contrast = 0;
+
+		fbi->pwmr &= ~0xff;
+		fbi->pwmr |= contrast;
+
+		writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
+	}
+
+	return 0;
+}
+
 static int imxfb_lcd_get_power(struct lcd_device *lcddev)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
@@ -870,6 +808,8 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
 
 static struct lcd_ops imxfb_lcd_ops = {
 	.check_fb	= imxfb_lcd_check_fb,
+	.get_contrast	= imxfb_lcd_get_contrast,
+	.set_contrast	= imxfb_lcd_set_contrast,
 	.get_power	= imxfb_lcd_get_power,
 	.set_power	= imxfb_lcd_set_power,
 };
@@ -1062,11 +1002,10 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_lcd;
 	}
 
+	lcd->props.max_contrast = 0xff;
+
 	imxfb_enable_controller(fbi);
 	fbi->pdev = pdev;
-#ifdef PWMR_BACKLIGHT_AVAILABLE
-	imxfb_init_backlight(fbi);
-#endif
 
 	return 0;
 
@@ -1105,9 +1044,6 @@ static int imxfb_remove(struct platform_device *pdev)
 
 	imxfb_disable_controller(fbi);
 
-#ifdef PWMR_BACKLIGHT_AVAILABLE
-	imxfb_exit_backlight(fbi);
-#endif
 	unregister_framebuffer(info);
 
 	pdata = dev_get_platdata(&pdev->dev);
-- 
1.8.3.2

