From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:21:46 +0000
Subject: [PATCH 157/493] backlight: remove use of __devinit
Message-Id: <1353349642-3677-157-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

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
 drivers/video/backlight/ili9320.c            | 4 ++--
 drivers/video/backlight/l4f00242t03.c        | 2 +-
 drivers/video/backlight/lm3533_bl.c          | 4 ++--
 drivers/video/backlight/lm3630_bl.c          | 4 ++--
 drivers/video/backlight/lm3639_bl.c          | 4 ++--
 drivers/video/backlight/lms283gf05.c         | 2 +-
 drivers/video/backlight/ltv350qv.c           | 2 +-
 drivers/video/backlight/max8925_bl.c         | 2 +-
 drivers/video/backlight/pcf50633-backlight.c | 2 +-
 drivers/video/backlight/platform_lcd.c       | 2 +-
 drivers/video/backlight/s6e63m0.c            | 2 +-
 drivers/video/backlight/tdo24m.c             | 2 +-
 drivers/video/backlight/tosa_bl.c            | 2 +-
 drivers/video/backlight/tosa_lcd.c           | 2 +-
 drivers/video/backlight/vgg2432a4.c          | 2 +-
 23 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index e2a0da3..a7eb3c4 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -282,7 +282,7 @@ static const struct attribute_group adp5520_bl_attr_group = {
 	.attrs = adp5520_bl_attributes,
 };
 
-static int __devinit adp5520_bl_probe(struct platform_device *pdev)
+static int adp5520_bl_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 953c521..6feda75 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -213,7 +213,7 @@ static int adp8860_led_setup(struct adp8860_led *led)
 	return ret;
 }
 
-static int __devinit adp8860_led_probe(struct i2c_client *client)
+static int adp8860_led_probe(struct i2c_client *client)
 {
 	struct adp8860_backlight_platform_data *pdata  		client->dev.platform_data;
@@ -310,7 +310,7 @@ static int __devexit adp8860_led_remove(struct i2c_client *client)
 	return 0;
 }
 #else
-static int __devinit adp8860_led_probe(struct i2c_client *client)
+static int adp8860_led_probe(struct i2c_client *client)
 {
 	return 0;
 }
@@ -650,7 +650,7 @@ static const struct attribute_group adp8860_bl_attr_group = {
 	.attrs = adp8860_bl_attributes,
 };
 
-static int __devinit adp8860_probe(struct i2c_client *client,
+static int adp8860_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct backlight_device *bl;
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 558772b..0ef93e1 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -235,7 +235,7 @@ static int adp8870_led_setup(struct adp8870_led *led)
 	return ret;
 }
 
-static int __devinit adp8870_led_probe(struct i2c_client *client)
+static int adp8870_led_probe(struct i2c_client *client)
 {
 	struct adp8870_backlight_platform_data *pdata  		client->dev.platform_data;
@@ -335,7 +335,7 @@ static int __devexit adp8870_led_remove(struct i2c_client *client)
 	return 0;
 }
 #else
-static int __devinit adp8870_led_probe(struct i2c_client *client)
+static int adp8870_led_probe(struct i2c_client *client)
 {
 	return 0;
 }
@@ -839,7 +839,7 @@ static const struct attribute_group adp8870_bl_attr_group = {
 	.attrs = adp8870_bl_attributes,
 };
 
-static int __devinit adp8870_probe(struct i2c_client *client,
+static int adp8870_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct backlight_properties props;
diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index e48f4b1..fbe43b0 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -474,7 +474,7 @@ static const struct backlight_ops ams369fg06_backlight_ops = {
 	.update_status = ams369fg06_set_brightness,
 };
 
-static int __devinit ams369fg06_probe(struct spi_device *spi)
+static int ams369fg06_probe(struct spi_device *spi)
 {
 	int ret = 0;
 	struct ams369fg06 *lcd = NULL;
diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index 9dc73ac..5b650be 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -137,7 +137,7 @@ static const struct hw_data nvidia_chipset_data = {
 	.set_brightness = nvidia_chipset_set_brightness,
 };
 
-static int __devinit apple_bl_add(struct acpi_device *dev)
+static int apple_bl_add(struct acpi_device *dev)
 {
 	struct backlight_properties props;
 	struct pci_dev *host;
diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index 476dcb0..89e7d99 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -531,7 +531,7 @@ static int setup_gpio_backlight(struct corgi_lcd *lcd,
 	return 0;
 }
 
-static int __devinit corgi_lcd_probe(struct spi_device *spi)
+static int corgi_lcd_probe(struct spi_device *spi)
 {
 	struct backlight_properties props;
 	struct corgi_lcd_platform_data *pdata = spi->dev.platform_data;
diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
index f50b580..2748cca 100644
--- a/drivers/video/backlight/ep93xx_bl.c
+++ b/drivers/video/backlight/ep93xx_bl.c
@@ -60,7 +60,7 @@ static const struct backlight_ops ep93xxbl_ops = {
 	.get_brightness	= ep93xxbl_get_brightness,
 };
 
-static int __devinit ep93xxbl_probe(struct platform_device *dev)
+static int ep93xxbl_probe(struct platform_device *dev)
 {
 	struct ep93xxbl *ep93xxbl;
 	struct backlight_device *bl;
diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index a8274ed..a21baae 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -103,7 +103,7 @@ static const struct backlight_ops hp680bl_ops = {
 	.update_status  = hp680bl_set_intensity,
 };
 
-static int __devinit hp680bl_probe(struct platform_device *pdev)
+static int hp680bl_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bd;
diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index a0a369d..26b0df9 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -169,7 +169,7 @@ static struct lcd_ops ili9320_ops = {
 	.set_power	= ili9320_set_power,
 };
 
-static void __devinit ili9320_setup_spi(struct ili9320 *ili,
+static void ili9320_setup_spi(struct ili9320 *ili,
 					struct spi_device *dev)
 {
 	struct ili9320_spi *spi = &ili->access.spi;
@@ -195,7 +195,7 @@ static void __devinit ili9320_setup_spi(struct ili9320 *ili,
 	spi_message_add_tail(&spi->xfer[1], &spi->message);
 }
 
-int __devinit ili9320_probe_spi(struct spi_device *spi,
+int ili9320_probe_spi(struct spi_device *spi,
 				struct ili9320_client *client)
 {
 	struct ili9320_platdata *cfg = spi->dev.platform_data;
diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 052cdac..b6c50fc 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -149,7 +149,7 @@ static struct lcd_ops l4f_ops = {
 	.get_power	= l4f00242t03_lcd_power_get,
 };
 
-static int __devinit l4f00242t03_probe(struct spi_device *spi)
+static int l4f00242t03_probe(struct spi_device *spi)
 {
 	struct l4f00242t03_priv *priv;
 	struct l4f00242t03_pdata *pdata = spi->dev.platform_data;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index c9a0b51..029901e 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -257,7 +257,7 @@ static struct attribute_group lm3533_bl_attribute_group = {
 	.attrs		= lm3533_bl_attributes
 };
 
-static int __devinit lm3533_bl_setup(struct lm3533_bl *bl,
+static int lm3533_bl_setup(struct lm3533_bl *bl,
 					struct lm3533_bl_platform_data *pdata)
 {
 	int ret;
@@ -269,7 +269,7 @@ static int __devinit lm3533_bl_setup(struct lm3533_bl *bl,
 	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
 }
 
-static int __devinit lm3533_bl_probe(struct platform_device *pdev)
+static int lm3533_bl_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
 	struct lm3533_bl_platform_data *pdata;
diff --git a/drivers/video/backlight/lm3630_bl.c b/drivers/video/backlight/lm3630_bl.c
index 39981ba..86e46d4 100644
--- a/drivers/video/backlight/lm3630_bl.c
+++ b/drivers/video/backlight/lm3630_bl.c
@@ -55,7 +55,7 @@ struct lm3630_chip_data {
 };
 
 /* initialize chip */
-static int __devinit lm3630_chip_init(struct lm3630_chip_data *pchip)
+static int lm3630_chip_init(struct lm3630_chip_data *pchip)
 {
 	int ret;
 	unsigned int reg_val;
@@ -349,7 +349,7 @@ static const struct regmap_config lm3630_regmap = {
 	.max_register = REG_MAX,
 };
 
-static int __devinit lm3630_probe(struct i2c_client *client,
+static int lm3630_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct lm3630_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 0e8d9ca..e0820bd 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -48,7 +48,7 @@ struct lm3639_chip_data {
 };
 
 /* initialize chip */
-static int __devinit lm3639_chip_init(struct lm3639_chip_data *pchip)
+static int lm3639_chip_init(struct lm3639_chip_data *pchip)
 {
 	int ret;
 	unsigned int reg_val;
@@ -299,7 +299,7 @@ static const struct regmap_config lm3639_regmap = {
 	.max_register = REG_MAX,
 };
 
-static int __devinit lm3639_probe(struct i2c_client *client,
+static int lm3639_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index a9afb82..35e23f5 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -150,7 +150,7 @@ static struct lcd_ops lms_ops = {
 	.get_power	= NULL,
 };
 
-static int __devinit lms283gf05_probe(struct spi_device *spi)
+static int lms283gf05_probe(struct spi_device *spi)
 {
 	struct lms283gf05_state *st;
 	struct lms283gf05_pdata *pdata = spi->dev.platform_data;
diff --git a/drivers/video/backlight/ltv350qv.c b/drivers/video/backlight/ltv350qv.c
index c63ce6e..b449bf2 100644
--- a/drivers/video/backlight/ltv350qv.c
+++ b/drivers/video/backlight/ltv350qv.c
@@ -226,7 +226,7 @@ static struct lcd_ops ltv_ops = {
 	.set_power	= ltv350qv_set_power,
 };
 
-static int __devinit ltv350qv_probe(struct spi_device *spi)
+static int ltv350qv_probe(struct spi_device *spi)
 {
 	struct ltv350qv *lcd;
 	struct lcd_device *ld;
diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
index b509c4c..4ce1d52 100644
--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -101,7 +101,7 @@ static const struct backlight_ops max8925_backlight_ops = {
 	.get_brightness	= max8925_backlight_get_brightness,
 };
 
-static int __devinit max8925_backlight_probe(struct platform_device *pdev)
+static int max8925_backlight_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct max8925_backlight_pdata *pdata = pdev->dev.platform_data;
diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index d05196d..2522ef0 100644
--- a/drivers/video/backlight/pcf50633-backlight.c
+++ b/drivers/video/backlight/pcf50633-backlight.c
@@ -99,7 +99,7 @@ static const struct backlight_ops pcf50633_bl_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 };
 
-static int __devinit pcf50633_bl_probe(struct platform_device *pdev)
+static int pcf50633_bl_probe(struct platform_device *pdev)
 {
 	struct pcf50633_bl *pcf_bl;
 	struct device *parent = pdev->dev.parent;
diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index 8e584fe..f42a004 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -73,7 +73,7 @@ static struct lcd_ops platform_lcd_ops = {
 	.check_fb	= platform_lcd_match,
 };
 
-static int __devinit platform_lcd_probe(struct platform_device *pdev)
+static int platform_lcd_probe(struct platform_device *pdev)
 {
 	struct plat_lcd_data *pdata;
 	struct platform_lcd *plcd;
diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 7ca5a88..a048cbb 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -733,7 +733,7 @@ static ssize_t s6e63m0_sysfs_show_gamma_table(struct device *dev,
 static DEVICE_ATTR(gamma_table, 0444,
 		s6e63m0_sysfs_show_gamma_table, NULL);
 
-static int __devinit s6e63m0_probe(struct spi_device *spi)
+static int s6e63m0_probe(struct spi_device *spi)
 {
 	int ret = 0;
 	struct s6e63m0 *lcd = NULL;
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index 0e707a3..f8a1b85 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -329,7 +329,7 @@ static struct lcd_ops tdo24m_ops = {
 	.set_mode	= tdo24m_set_mode,
 };
 
-static int __devinit tdo24m_probe(struct spi_device *spi)
+static int tdo24m_probe(struct spi_device *spi)
 {
 	struct tdo24m *lcd;
 	struct spi_message *m;
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index b692eec..617f6f5 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -78,7 +78,7 @@ static const struct backlight_ops bl_ops = {
 	.update_status		= tosa_bl_update_status,
 };
 
-static int __devinit tosa_bl_probe(struct i2c_client *client,
+static int tosa_bl_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct backlight_properties props;
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 9e9716b..648efdd 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -171,7 +171,7 @@ static struct lcd_ops tosa_lcd_ops = {
 	.set_mode = tosa_lcd_set_mode,
 };
 
-static int __devinit tosa_lcd_probe(struct spi_device *spi)
+static int tosa_lcd_probe(struct spi_device *spi)
 {
 	int ret;
 	struct tosa_lcd_data *data;
diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index b7255c9..7f3c7ad 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -227,7 +227,7 @@ static struct ili9320_client vgg2432a4_client = {
 
 /* Device probe */
 
-static int __devinit vgg2432a4_probe(struct spi_device *spi)
+static int vgg2432a4_probe(struct spi_device *spi)
 {
 	int ret;
 
-- 
1.8.0

