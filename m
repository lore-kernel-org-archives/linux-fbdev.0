From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 08 Jan 2013 09:31:39 +0000
Subject: [PATCH 1/2] backlight: ld9040: Use devm_regulator_bulk_get API
Message-Id: <1357636780-14783-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

devm_regulator_bulk_get is device managed and saves some cleanup
and exit code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Donghwa Lee <dh09.lee@samsung.com>
---
 drivers/video/backlight/ld9040.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index 24f2c9a..1b642f5 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -710,17 +710,15 @@ static int ld9040_probe(struct spi_device *spi)
 
 	mutex_init(&lcd->lock);
 
-	ret = regulator_bulk_get(lcd->dev, ARRAY_SIZE(supplies), supplies);
+	ret = devm_regulator_bulk_get(lcd->dev, ARRAY_SIZE(supplies), supplies);
 	if (ret) {
 		dev_err(lcd->dev, "Failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
 	ld = lcd_device_register("ld9040", &spi->dev, lcd, &ld9040_lcd_ops);
-	if (IS_ERR(ld)) {
-		ret = PTR_ERR(ld);
-		goto out_free_regulator;
-	}
+	if (IS_ERR(ld))
+		return PTR_ERR(ld);
 
 	lcd->ld = ld;
 
@@ -762,8 +760,6 @@ static int ld9040_probe(struct spi_device *spi)
 
 out_unregister_lcd:
 	lcd_device_unregister(lcd->ld);
-out_free_regulator:
-	regulator_bulk_free(ARRAY_SIZE(supplies), supplies);
 
 	return ret;
 }
@@ -775,7 +771,6 @@ static int ld9040_remove(struct spi_device *spi)
 	ld9040_power(lcd, FB_BLANK_POWERDOWN);
 	backlight_device_unregister(lcd->bd);
 	lcd_device_unregister(lcd->ld);
-	regulator_bulk_free(ARRAY_SIZE(supplies), supplies);
 
 	return 0;
 }
-- 
1.7.4.1

