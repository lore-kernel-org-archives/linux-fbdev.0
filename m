From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 12 Feb 2014 09:58:17 +0000
Subject: [PATCH 1/1] video: s6e8ax0: Use devm_* APIs
Message-Id: <1392198779-5203-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

devm_* APIs make the cleanup paths simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/exynos/s6e8ax0.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/exynos/s6e8ax0.c b/drivers/video/exynos/s6e8ax0.c
index ca2602413aa4..29e70ed3f154 100644
--- a/drivers/video/exynos/s6e8ax0.c
+++ b/drivers/video/exynos/s6e8ax0.c
@@ -794,19 +794,18 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
 		return ret;
 	}
 
-	lcd->ld = lcd_device_register("s6e8ax0", lcd->dev, lcd,
+	lcd->ld = devm_lcd_device_register(lcd->dev, "s6e8ax0", lcd->dev, lcd,
 			&s6e8ax0_lcd_ops);
 	if (IS_ERR(lcd->ld)) {
 		dev_err(lcd->dev, "failed to register lcd ops.\n");
 		return PTR_ERR(lcd->ld);
 	}
 
-	lcd->bd = backlight_device_register("s6e8ax0-bl", lcd->dev, lcd,
-			&s6e8ax0_backlight_ops, NULL);
+	lcd->bd = devm_backlight_device_register(lcd->dev, "s6e8ax0-bl",
+				lcd->dev, lcd, &s6e8ax0_backlight_ops, NULL);
 	if (IS_ERR(lcd->bd)) {
 		dev_err(lcd->dev, "failed to register backlight ops.\n");
-		ret = PTR_ERR(lcd->bd);
-		goto err_backlight_register;
+		return PTR_ERR(lcd->bd);
 	}
 
 	lcd->bd->props.max_brightness = MAX_BRIGHTNESS;
@@ -834,10 +833,6 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
 	dev_dbg(lcd->dev, "probed s6e8ax0 panel driver.\n");
 
 	return 0;
-
-err_backlight_register:
-	lcd_device_unregister(lcd->ld);
-	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
1.7.9.5

