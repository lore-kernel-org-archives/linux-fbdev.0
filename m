From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 Jun 2011 18:26:20 +0000
Subject: [PATCH] backlight: l4f00242t03: Use gpio_request_one to simplify error handling
Message-Id: <1308939980-14341-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Using gpio_request_one can make the error handling simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/backlight/l4f00242t03.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 98ad3e5..d6b0812 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -178,29 +178,22 @@ static int __devinit l4f00242t03_probe(struct spi_device *spi)
 
 	priv->spi = spi;
 
-	ret = gpio_request(pdata->reset_gpio, "lcd l4f00242t03 reset");
+	ret = gpio_request_one(pdata->reset_gpio, GPIOF_OUT_INIT_HIGH,
+						"lcd l4f00242t03 reset");
 	if (ret) {
 		dev_err(&spi->dev,
 			"Unable to get the lcd l4f00242t03 reset gpio.\n");
 		goto err;
 	}
 
-	ret = gpio_direction_output(pdata->reset_gpio, 1);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(pdata->data_enable_gpio,
-				"lcd l4f00242t03 data enable");
+	ret = gpio_request_one(pdata->data_enable_gpio, GPIOF_OUT_INIT_LOW,
+						"lcd l4f00242t03 data enable");
 	if (ret) {
 		dev_err(&spi->dev,
 			"Unable to get the lcd l4f00242t03 data en gpio.\n");
 		goto err2;
 	}
-
-	ret = gpio_direction_output(pdata->data_enable_gpio, 0);
-	if (ret)
-		goto err3;
-
+
 	if (pdata->io_supply) {
 		priv->io_reg = regulator_get(NULL, pdata->io_supply);
 
-- 
1.7.1

