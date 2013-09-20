From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:50:52 +0000
Subject: [PATCH 1/2] backlight: l4f00242t03: Remove redundant spi_set_drvdata
Message-Id: <1379659133-18799-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/backlight/l4f00242t03.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index a35a38c..59eebe0 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -244,7 +244,6 @@ static int l4f00242t03_remove(struct spi_device *spi)
 
 	l4f00242t03_lcd_power_set(priv->ld, FB_BLANK_POWERDOWN);
 	lcd_device_unregister(priv->ld);
-	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

