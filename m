From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Oct 2019 03:31:54 +0000
Subject: [PATCH v5 1/7] backlight: gpio: remove unneeded include
Message-Id: <20191007033200.13443-2-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191007033200.13443-1-brgl@bgdev.pl>
In-Reply-To: <20191007033200.13443-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We no longer use any symbols from of_gpio.h. Remove this include.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 18e053e4716c..7e1990199fae 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_data/gpio_backlight.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-- 
2.23.0
