From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Jul 2019 08:25:07 +0000
Subject: [PATCH v3 6/7] backlight: gpio: remove def_value from struct gpio_backlight
Message-Id: <20190724082508.27617-7-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl>
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is unused outside of probe(). There's no need to store it.
We can make it into a local variable.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 70882556f047..cd6a75bca9cc 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -21,7 +21,6 @@
 struct gpio_backlight {
 	struct device *fbdev;
 	struct gpio_desc *gpiod;
-	int def_value;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
@@ -61,7 +60,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	enum gpiod_flags flags;
-	int ret;
+	int ret, def_value;
 
 	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl = NULL)
@@ -70,8 +69,8 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	def_value = device_property_read_bool(&pdev->dev, "default-on");
+	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
 	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
 	if (IS_ERR(gbl->gpiod)) {
@@ -94,7 +93,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.brightness = def_value;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.21.0
