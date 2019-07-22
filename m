From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 22 Jul 2019 16:09:08 +0000
Subject: Re: [PATCH v2 7/7] backlight: gpio: use a helper variable for &pdev->dev
Message-Id: <20190722160908.GZ9224@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-8-brgl@bgdev.pl>
In-Reply-To: <20190722150302.29526-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Mon, Jul 22, 2019 at 05:03:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Instead of dereferencing pdev each time, use a helper variable for
> the associated device pointer.

>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
> -	struct gpio_backlight_platform_data *pdata > -		dev_get_platdata(&pdev->dev);
> +	struct gpio_backlight_platform_data *pdata;
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	enum gpiod_flags flags;
> +	struct device *dev;

Can't we do

	struct device dev = &pdev->dev;
	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);

? It fits 80 nicely.

-- 
With Best Regards,
Andy Shevchenko
