From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:05:55 +0000
Subject: [PATCH 1/6] FBDEV: JZ4740: Refactor GPIO pin operations
Message-Id: <7f854ef86a16dd03f415965b3535c607c401941e.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Encapsulate all GPIO pins related operations into 1 function which'll make it
easier to add on SLCD support.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/video/jz4740_fb.c |   82 +++++++++++++++++++++-----------------------
 1 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 7e61e68..65741d0 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -178,59 +178,60 @@ static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
 	JZ_GPIO_BULK_PIN(LCD_DATA17),
 };
 
-static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
+enum jzfb_pin_operation {
+	REQUEST_PINS,
+	FREE_PINS,
+	RESUME_PINS,
+	SUSPEND_PINS,
+};
+
+static void jzfb_pins_operation(struct jzfb *jzfb,
+				enum jzfb_pin_operation operation)
 {
-	unsigned int num;
+	unsigned int ctrl_num = 0, data_num = 0, data_start = 0;
 
 	switch (jzfb->pdata->lcd_type) {
 	case JZ_LCD_TYPE_GENERIC_16_BIT:
-		num = 4;
+		ctrl_num = 4;
+		data_num = 16;
 		break;
 	case JZ_LCD_TYPE_GENERIC_18_BIT:
-		num = 4;
+		ctrl_num = 4;
+		data_num = 18;
 		break;
 	case JZ_LCD_TYPE_8BIT_SERIAL:
-		num = 3;
+		ctrl_num = 3;
+		data_num = 8;
 		break;
 	case JZ_LCD_TYPE_SPECIAL_TFT_1:
 	case JZ_LCD_TYPE_SPECIAL_TFT_2:
 	case JZ_LCD_TYPE_SPECIAL_TFT_3:
-		num = 8;
-		break;
-	default:
-		num = 0;
+		ctrl_num = 8;
+		if (jzfb->pdata->bpp = 18)
+			data_num = 18;
+		else
+			data_num = 16;
 		break;
 	}
-	return num;
-}
 
-static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
-{
-	unsigned int num;
-
-	switch (jzfb->pdata->lcd_type) {
-	case JZ_LCD_TYPE_GENERIC_16_BIT:
-		num = 16;
+	switch (operation) {
+	case REQUEST_PINS:
+		jz_gpio_bulk_request(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_request(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	case JZ_LCD_TYPE_GENERIC_18_BIT:
-		num = 18;
+	case FREE_PINS:
+		jz_gpio_bulk_free(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_free(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	case JZ_LCD_TYPE_8BIT_SERIAL:
-		num = 8;
-		break;
-	case JZ_LCD_TYPE_SPECIAL_TFT_1:
-	case JZ_LCD_TYPE_SPECIAL_TFT_2:
-	case JZ_LCD_TYPE_SPECIAL_TFT_3:
-		if (jzfb->pdata->bpp = 18)
-			num = 18;
-		else
-			num = 16;
+	case RESUME_PINS:
+		jz_gpio_bulk_resume(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_resume(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	default:
-		num = 0;
+	case SUSPEND_PINS:
+		jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_suspend(&jz_lcd_data_pins[data_start], data_num);
 		break;
 	}
-	return num;
 }
 
 /* Based on CNVT_TOHW macro from skeletonfb.c */
@@ -487,8 +488,7 @@ static void jzfb_enable(struct jzfb *jzfb)
 
 	clk_enable(jzfb->ldclk);
 
-	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, RESUME_PINS);
 
 	writel(0, jzfb->base + JZ_REG_LCD_STATE);
 
@@ -511,8 +511,7 @@ static void jzfb_disable(struct jzfb *jzfb)
 		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
 	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
 
-	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, SUSPEND_PINS);
 
 	clk_disable(jzfb->ldclk);
 }
@@ -715,8 +714,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 	fb->mode = NULL;
 	jzfb_set_par(fb);
 
-	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, REQUEST_PINS);
 
 	ret = register_framebuffer(fb);
 	if (ret) {
@@ -729,8 +727,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_devmem:
-	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, FREE_PINS);
 
 	fb_dealloc_cmap(&fb->cmap);
 	jzfb_free_devmem(jzfb);
@@ -753,8 +750,7 @@ static int __devexit jzfb_remove(struct platform_device *pdev)
 
 	jzfb_blank(FB_BLANK_POWERDOWN, jzfb->fb);
 
-	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, FREE_PINS);
 
 	iounmap(jzfb->base);
 	release_mem_region(jzfb->mem->start, resource_size(jzfb->mem));
-- 
1.7.4

