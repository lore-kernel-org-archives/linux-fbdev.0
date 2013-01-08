From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 08 Jan 2013 09:31:40 +0000
Subject: [PATCH 2/2] backlight: l4f00242t03: Use devm_regulator_get API
Message-Id: <1357636780-14783-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

devm_regulator_get is device managed and saves some cleanup
and exit code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/backlight/l4f00242t03.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 9bef9cf..9d18073 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -190,27 +190,24 @@ static int l4f00242t03_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	priv->io_reg = regulator_get(&spi->dev, "vdd");
+	priv->io_reg = devm_regulator_get(&spi->dev, "vdd");
 	if (IS_ERR(priv->io_reg)) {
 		dev_err(&spi->dev, "%s: Unable to get the IO regulator\n",
 		       __func__);
 		return PTR_ERR(priv->io_reg);
 	}
 
-	priv->core_reg = regulator_get(&spi->dev, "vcore");
+	priv->core_reg = devm_regulator_get(&spi->dev, "vcore");
 	if (IS_ERR(priv->core_reg)) {
-		ret = PTR_ERR(priv->core_reg);
 		dev_err(&spi->dev, "%s: Unable to get the core regulator\n",
 		       __func__);
-		goto err1;
+		return PTR_ERR(priv->core_reg);
 	}
 
 	priv->ld = lcd_device_register("l4f00242t03",
 					&spi->dev, priv, &l4f_ops);
-	if (IS_ERR(priv->ld)) {
-		ret = PTR_ERR(priv->ld);
-		goto err2;
-	}
+	if (IS_ERR(priv->ld))
+		return PTR_ERR(priv->ld);
 
 	/* Init the LCD */
 	l4f00242t03_lcd_init(spi);
@@ -220,13 +217,6 @@ static int l4f00242t03_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "Epson l4f00242t03 lcd probed.\n");
 
 	return 0;
-
-err2:
-	regulator_put(priv->core_reg);
-err1:
-	regulator_put(priv->io_reg);
-
-	return ret;
 }
 
 static int l4f00242t03_remove(struct spi_device *spi)
@@ -238,9 +228,6 @@ static int l4f00242t03_remove(struct spi_device *spi)
 
 	spi_set_drvdata(spi, NULL);
 
-	regulator_put(priv->io_reg);
-	regulator_put(priv->core_reg);
-
 	return 0;
 }
 
-- 
1.7.4.1

