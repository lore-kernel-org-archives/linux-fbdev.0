From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2019 16:34:24 +0000
Subject: [PATCH 02/12] backlight: gpio: use a helper variable for &pdev->dev
Message-Id: <20190625163434.13620-3-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of dereferencing pdev each time, use a helper variable for
the associated device pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 654c19d3a81d..8adbc8d75097 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -83,15 +83,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct gpio_backlight_platform_data *pdata  		dev_get_platdata(&pdev->dev);
 	struct backlight_properties props;
+	struct device *dev = &pdev->dev;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	int ret;
 
-	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
+	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl = NULL)
 		return -ENOMEM;
 
-	gbl->dev = &pdev->dev;
+	gbl->dev = dev;
 
 	if (pdata) {
 		/*
@@ -108,7 +109,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
 					    pdata ? pdata->name : "backlight");
 		if (ret < 0) {
-			dev_err(&pdev->dev, "unable to request GPIO\n");
+			dev_err(dev, "unable to request GPIO\n");
 			return ret;
 		}
 		gbl->gpiod = gpio_to_desc(pdata->gpio);
@@ -123,11 +124,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 1;
-	bl = devm_backlight_device_register(&pdev->dev, dev_name(&pdev->dev),
-					&pdev->dev, gbl, &gpio_backlight_ops,
-					&props);
+	bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
+					    &gpio_backlight_ops, &props);
 	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
+		dev_err(dev, "failed to register backlight\n");
 		return PTR_ERR(bl);
 	}
 
-- 
2.21.0
