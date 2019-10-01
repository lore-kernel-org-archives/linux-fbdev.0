From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 01 Oct 2019 13:06:27 +0000
Subject: Re: [PATCH v4 1/7] backlight: gpio: remove unneeded include
Message-Id: <20191001130627.GO32742@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191001125837.4472-1-brgl@bgdev.pl>
 <20191001125837.4472-2-brgl@bgdev.pl>
In-Reply-To: <20191001125837.4472-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Oct 01, 2019 at 02:58:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> We no longer use any symbols from of_gpio.h. Remove this include.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 18e053e4716c..7e1990199fae 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -12,7 +12,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_data/gpio_backlight.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko
