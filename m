From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:50:53 +0000
Subject: [PATCH 2/2] backlight: tosa: Remove redundant spi_set_drvdata
Message-Id: <1379659133-18799-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/backlight/tosa_lcd.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index bf08157..be5d636 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -198,7 +198,7 @@ static int tosa_lcd_probe(struct spi_device *spi)
 	ret = devm_gpio_request_one(&spi->dev, TOSA_GPIO_TG_ON,
 				GPIOF_OUT_INIT_LOW, "tg #pwr");
 	if (ret < 0)
-		goto err_gpio_tg;
+		return ret;
 
 	mdelay(60);
 
@@ -219,8 +219,6 @@ static int tosa_lcd_probe(struct spi_device *spi)
 
 err_register:
 	tosa_lcd_tg_off(data);
-err_gpio_tg:
-	spi_set_drvdata(spi, NULL);
 	return ret;
 }
 
@@ -235,8 +233,6 @@ static int tosa_lcd_remove(struct spi_device *spi)
 
 	tosa_lcd_tg_off(data);
 
-	spi_set_drvdata(spi, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

