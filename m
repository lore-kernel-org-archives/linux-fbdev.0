From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 01 Oct 2019 14:29:18 +0000
Subject: Re: [PATCH v4 1/7] backlight: gpio: remove unneeded include
Message-Id: <20191001142918.gjifvlkz574dbihr@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191001125837.4472-1-brgl@bgdev.pl>
 <20191001125837.4472-2-brgl@bgdev.pl>
In-Reply-To: <20191001125837.4472-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jacopo Mondi <jacopo@jmondi.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 01, 2019 at 02:58:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We no longer use any symbols from of_gpio.h. Remove this include.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

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
