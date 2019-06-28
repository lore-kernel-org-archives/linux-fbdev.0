From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Jun 2019 10:02:51 +0000
Subject: [PATCH RFT 2/4] backlight: gpio: simplify the platform data handling
Message-Id: <20190628100253.8385-3-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190628100253.8385-1-brgl@bgdev.pl>
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that the last user of platform data (sh ecovec24) defines a proper
GPIO lookup and sets the 'default-on' device property, we can drop the
platform_data-specific GPIO handling and unify a big chunk of code.

The only field used from the platform data is now the fbdev pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 46 +++++++-----------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 89e10bccfd3c..b20d2d5d5190 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -71,41 +71,21 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	gbl->dev = dev;
 
-	if (pdata) {
-		/*
-		 * Legacy platform data GPIO retrieveal. Do not expand
-		 * the use of this code path, currently only used by one
-		 * SH board.
-		 */
-		unsigned long flags = GPIOF_DIR_OUT;
-
+	if (pdata)
 		gbl->fbdev = pdata->fbdev;
-		gbl->def_value = pdata->def_value;
-		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
-
-		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
-					    pdata ? pdata->name : "backlight");
-		if (ret < 0) {
-			dev_err(dev, "unable to request GPIO\n");
-			return ret;
-		}
-		gbl->gpiod = gpio_to_desc(pdata->gpio);
-		if (!gbl->gpiod)
-			return -EINVAL;
-	} else {
-		gbl->def_value = device_property_read_bool(dev, "default-on");
-		flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-
-		gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
-		if (IS_ERR(gbl->gpiod)) {
-			ret = PTR_ERR(gbl->gpiod);
-
-			if (ret != -EPROBE_DEFER) {
-				dev_err(dev,
-					"Error: The gpios parameter is missing or invalid.\n");
-			}
-			return ret;
+
+	gbl->def_value = device_property_read_bool(dev, "default-on");
+	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+	if (IS_ERR(gbl->gpiod)) {
+		ret = PTR_ERR(gbl->gpiod);
+
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev,
+				"Error: The gpios parameter is missing or invalid.\n");
 		}
+		return ret;
 	}
 
 	memset(&props, 0, sizeof(props));
-- 
2.21.0
