From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Jul 2019 08:25:06 +0000
Subject: [PATCH v3 5/7] backlight: gpio: remove dev from struct gpio_backlight
Message-Id: <20190724082508.27617-6-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl>
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 01262186fa1e..70882556f047 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -19,9 +19,7 @@
 #include <linux/slab.h>
 
 struct gpio_backlight {
-	struct device *dev;
 	struct device *fbdev;
-
 	struct gpio_desc *gpiod;
 	int def_value;
 };
@@ -69,8 +67,6 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	if (gbl = NULL)
 		return -ENOMEM;
 
-	gbl->dev = &pdev->dev;
-
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-- 
2.21.0
