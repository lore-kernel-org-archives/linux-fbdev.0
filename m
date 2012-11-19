From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:26:34 +0000
Subject: [PATCH 445/493] backlight: remove use of __devexit
Message-Id: <1353349642-3677-445-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Richard Purdie <rpurdie@rpsys.net> 
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: linux-fbdev@vger.kernel.org 
---
 drivers/video/backlight/adp5520_bl.c         | 2 +-
 drivers/video/backlight/adp8860_bl.c         | 6 +++---
 drivers/video/backlight/adp8870_bl.c         | 6 +++---
 drivers/video/backlight/ams369fg06.c         | 2 +-
 drivers/video/backlight/apple_bl.c           | 2 +-
 drivers/video/backlight/corgi_lcd.c          | 2 +-
 drivers/video/backlight/ep93xx_bl.c          | 2 +-
 drivers/video/backlight/hp680_bl.c           | 2 +-
 drivers/video/backlight/ili9320.c            | 2 +-
 drivers/video/backlight/l4f00242t03.c        | 2 +-
 drivers/video/backlight/ld9040.c             | 2 +-
 drivers/video/backlight/lm3533_bl.c          | 2 +-
 drivers/video/backlight/lm3630_bl.c          | 2 +-
 drivers/video/backlight/lm3639_bl.c          | 2 +-
 drivers/video/backlight/lms283gf05.c         | 2 +-
 drivers/video/backlight/lp855x_bl.c          | 2 +-
 drivers/video/backlight/ltv350qv.c           | 2 +-
 drivers/video/backlight/max8925_bl.c         | 2 +-
 drivers/video/backlight/pcf50633-backlight.c | 2 +-
 drivers/video/backlight/platform_lcd.c       | 2 +-
 drivers/video/backlight/s6e63m0.c            | 2 +-
 drivers/video/backlight/tdo24m.c             | 2 +-
 drivers/video/backlight/tosa_bl.c            | 2 +-
 drivers/video/backlight/tosa_lcd.c           | 2 +-
 drivers/video/backlight/vgg2432a4.c          | 2 +-
 25 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index a7eb3c4..a1e41d4 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -333,7 +333,7 @@ static int adp5520_bl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit adp5520_bl_remove(struct platform_device *pdev)
+static int adp5520_bl_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct adp5520_bl *data = bl_get_data(bl);
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 6feda75..6bb72c0 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -295,7 +295,7 @@ static int adp8860_led_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int __devexit adp8860_led_remove(struct i2c_client *client)
+static int adp8860_led_remove(struct i2c_client *client)
 {
 	struct adp8860_backlight_platform_data *pdata  		client->dev.platform_data;
@@ -315,7 +315,7 @@ static int adp8860_led_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int __devexit adp8860_led_remove(struct i2c_client *client)
+static int adp8860_led_remove(struct i2c_client *client)
 {
 	return 0;
 }
@@ -755,7 +755,7 @@ out1:
 	return ret;
 }
 
-static int __devexit adp8860_remove(struct i2c_client *client)
+static int adp8860_remove(struct i2c_client *client)
 {
 	struct adp8860_bl *data = i2c_get_clientdata(client);
 
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 0ef93e1..63c882b 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -320,7 +320,7 @@ static int adp8870_led_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int __devexit adp8870_led_remove(struct i2c_client *client)
+static int adp8870_led_remove(struct i2c_client *client)
 {
 	struct adp8870_backlight_platform_data *pdata  		client->dev.platform_data;
@@ -340,7 +340,7 @@ static int adp8870_led_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int __devexit adp8870_led_remove(struct i2c_client *client)
+static int adp8870_led_remove(struct i2c_client *client)
 {
 	return 0;
 }
@@ -929,7 +929,7 @@ out1:
 	return ret;
 }
 
-static int __devexit adp8870_remove(struct i2c_client *client)
+static int adp8870_remove(struct i2c_client *client)
 {
 	struct adp8870_bl *data = i2c_get_clientdata(client);
 
diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index fbe43b0..f57e190 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -548,7 +548,7 @@ out_lcd_unregister:
 	return ret;
 }
 
-static int __devexit ams369fg06_remove(struct spi_device *spi)
+static int ams369fg06_remove(struct spi_device *spi)
 {
 	struct ams369fg06 *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index 5b650be..f088d4c 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -196,7 +196,7 @@ static int apple_bl_add(struct acpi_device *dev)
 	return 0;
 }
 
-static int __devexit apple_bl_remove(struct acpi_device *dev, int type)
+static int apple_bl_remove(struct acpi_device *dev, int type)
 {
 	backlight_device_unregister(apple_backlight_device);
 
diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index 89e7d99..e2e1b62 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -592,7 +592,7 @@ err_unregister_lcd:
 	return ret;
 }
 
-static int __devexit corgi_lcd_remove(struct spi_device *spi)
+static int corgi_lcd_remove(struct spi_device *spi)
 {
 	struct corgi_lcd *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
index 2748cca..fd073b2 100644
--- a/drivers/video/backlight/ep93xx_bl.c
+++ b/drivers/video/backlight/ep93xx_bl.c
@@ -106,7 +106,7 @@ static int ep93xxbl_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit ep93xxbl_remove(struct platform_device *dev)
+static int ep93xxbl_remove(struct platform_device *dev)
 {
 	struct backlight_device *bl = platform_get_drvdata(dev);
 
diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index a21baae..5cefd73 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -124,7 +124,7 @@ static int hp680bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit hp680bl_remove(struct platform_device *pdev)
+static int hp680bl_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bd = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 26b0df9..1235bf9 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -260,7 +260,7 @@ int ili9320_probe_spi(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(ili9320_probe_spi);
 
-int __devexit ili9320_remove(struct ili9320 *ili)
+int ili9320_remove(struct ili9320 *ili)
 {
 	ili9320_power(ili, FB_BLANK_POWERDOWN);
 
diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index b6c50fc..9a35196 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -229,7 +229,7 @@ err1:
 	return ret;
 }
 
-static int __devexit l4f00242t03_remove(struct spi_device *spi)
+static int l4f00242t03_remove(struct spi_device *spi)
 {
 	struct l4f00242t03_priv *priv = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index 77ba103..1cb3524 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -788,7 +788,7 @@ out_free_regulator:
 	return ret;
 }
 
-static int __devexit ld9040_remove(struct spi_device *spi)
+static int ld9040_remove(struct spi_device *spi)
 {
 	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 029901e..5d18d4d 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -351,7 +351,7 @@ err_unregister:
 	return ret;
 }
 
-static int __devexit lm3533_bl_remove(struct platform_device *pdev)
+static int lm3533_bl_remove(struct platform_device *pdev)
 {
 	struct lm3533_bl *bl = platform_get_drvdata(pdev);
 	struct backlight_device *bd = bl->bd;
diff --git a/drivers/video/backlight/lm3630_bl.c b/drivers/video/backlight/lm3630_bl.c
index 86e46d4..a6d637b 100644
--- a/drivers/video/backlight/lm3630_bl.c
+++ b/drivers/video/backlight/lm3630_bl.c
@@ -429,7 +429,7 @@ err_chip_init:
 	return ret;
 }
 
-static int __devexit lm3630_remove(struct i2c_client *client)
+static int lm3630_remove(struct i2c_client *client)
 {
 	int ret;
 	struct lm3630_chip_data *pchip = i2c_get_clientdata(client);
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index e0820bd..7ab2d2a 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -397,7 +397,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit lm3639_remove(struct i2c_client *client)
+static int lm3639_remove(struct i2c_client *client)
 {
 	struct lm3639_chip_data *pchip = i2c_get_clientdata(client);
 
diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index 35e23f5..13e24d5 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -189,7 +189,7 @@ static int lms283gf05_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit lms283gf05_remove(struct spi_device *spi)
+static int lms283gf05_remove(struct spi_device *spi)
 {
 	struct lms283gf05_state *st = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index b90ec2b..6e4db0c 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -300,7 +300,7 @@ err_dev:
 	return ret;
 }
 
-static int __devexit lp855x_remove(struct i2c_client *cl)
+static int lp855x_remove(struct i2c_client *cl)
 {
 	struct lp855x *lp = i2c_get_clientdata(cl);
 
diff --git a/drivers/video/backlight/ltv350qv.c b/drivers/video/backlight/ltv350qv.c
index b449bf2..226d813 100644
--- a/drivers/video/backlight/ltv350qv.c
+++ b/drivers/video/backlight/ltv350qv.c
@@ -261,7 +261,7 @@ out_unregister:
 	return ret;
 }
 
-static int __devexit ltv350qv_remove(struct spi_device *spi)
+static int ltv350qv_remove(struct spi_device *spi)
 {
 	struct ltv350qv *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
index 4ce1d52..2c9bce0 100644
--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -166,7 +166,7 @@ out_brt:
 	return ret;
 }
 
-static int __devexit max8925_backlight_remove(struct platform_device *pdev)
+static int max8925_backlight_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index 2522ef0..e87c7a3 100644
--- a/drivers/video/backlight/pcf50633-backlight.c
+++ b/drivers/video/backlight/pcf50633-backlight.c
@@ -147,7 +147,7 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit pcf50633_bl_remove(struct platform_device *pdev)
+static int pcf50633_bl_remove(struct platform_device *pdev)
 {
 	struct pcf50633_bl *pcf_bl = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index f42a004..17a6b83 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -112,7 +112,7 @@ static int platform_lcd_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit platform_lcd_remove(struct platform_device *pdev)
+static int platform_lcd_remove(struct platform_device *pdev)
 {
 	struct platform_lcd *plcd = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index a048cbb..3e1c113 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -825,7 +825,7 @@ out_lcd_unregister:
 	return ret;
 }
 
-static int __devexit s6e63m0_remove(struct spi_device *spi)
+static int s6e63m0_remove(struct spi_device *spi)
 {
 	struct s6e63m0 *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index f8a1b85..ad2325f 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -402,7 +402,7 @@ out_unregister:
 	return err;
 }
 
-static int __devexit tdo24m_remove(struct spi_device *spi)
+static int tdo24m_remove(struct spi_device *spi)
 {
 	struct tdo24m *lcd = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index 617f6f5..9ee9054 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -125,7 +125,7 @@ err_reg:
 	return ret;
 }
 
-static int __devexit tosa_bl_remove(struct i2c_client *client)
+static int tosa_bl_remove(struct i2c_client *client)
 {
 	struct tosa_bl_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 648efdd..96bae94 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -224,7 +224,7 @@ err_gpio_tg:
 	return ret;
 }
 
-static int __devexit tosa_lcd_remove(struct spi_device *spi)
+static int tosa_lcd_remove(struct spi_device *spi)
 {
 	struct tosa_lcd_data *data = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index 7f3c7ad..45e81b4 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -240,7 +240,7 @@ static int vgg2432a4_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit vgg2432a4_remove(struct spi_device *spi)
+static int vgg2432a4_remove(struct spi_device *spi)
 {
 	return ili9320_remove(dev_get_drvdata(&spi->dev));
 }
-- 
1.8.0

