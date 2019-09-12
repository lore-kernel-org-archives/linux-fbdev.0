From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 12 Sep 2019 21:32:57 +0000
Subject: [PATCH v4 2/2] backlight: lm3630a: add an enable gpio for the HWEN pin
Message-Id: <20190912213257.24147-3-andreas@kemnade.info>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info>
In-Reply-To: <20190912213257.24147-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>

For now just enable it in the probe function to allow i2c
access. Disabling also means resetting the register values
to default and according to the datasheet does not give
power savings.

Tested on Kobo Clara HD.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Dan Murphy <dmurphy@ti.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
changes in v2:
- simplification
- correct gpio direction initialisation

changes in v3:
- removed legacy include

 drivers/video/backlight/lm3630a_bl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f84f3684f04..d9e67b9b2571 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pwm.h>
 #include <linux/platform_data/lm3630a_bl.h>
 
@@ -48,6 +49,7 @@ struct lm3630a_chip {
 	struct lm3630a_platform_data *pdata;
 	struct backlight_device *bleda;
 	struct backlight_device *bledb;
+	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
 	struct pwm_device *pwmd;
 };
@@ -535,6 +537,13 @@ static int lm3630a_probe(struct i2c_client *client,
 	}
 	pchip->pdata = pdata;
 
+	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(pchip->enable_gpio)) {
+		rval = PTR_ERR(pchip->enable_gpio);
+		return rval;
+	}
+
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);
 	if (rval < 0) {
-- 
2.20.1
