From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Jul 2019 11:13:00 +0000
Subject: Re: [PATCH v3 4/7] backlight: gpio: remove unused fields from platform data
Message-Id: <20190724111300.pt624m3olrpzp4nj@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-5-brgl@bgdev.pl>
In-Reply-To: <20190724082508.27617-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Wed, Jul 24, 2019 at 10:25:05AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove the platform data fields that nobody uses.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/platform_data/gpio_backlight.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
> index 34179d600360..1a8b5b1946fe 100644
> --- a/include/linux/platform_data/gpio_backlight.h
> +++ b/include/linux/platform_data/gpio_backlight.h
> @@ -9,9 +9,6 @@ struct device;
>  
>  struct gpio_backlight_platform_data {
>  	struct device *fbdev;
> -	int gpio;
> -	int def_value;
> -	const char *name;
>  };
>  
>  #endif
> -- 
> 2.21.0
> 
