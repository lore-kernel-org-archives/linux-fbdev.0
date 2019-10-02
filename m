From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 02 Oct 2019 10:33:18 +0000
Subject: Re: [PATCH v4 7/7] backlight: gpio: pull gpio_backlight_initial_power_state() into probe
Message-Id: <20191002103318.6owxberhml6mbtxm@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191001125837.4472-1-brgl@bgdev.pl>
 <20191001125837.4472-8-brgl@bgdev.pl>
In-Reply-To: <20191001125837.4472-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jacopo Mondi <jacopo@jmondi.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 01, 2019 at 02:58:37PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The probe function in the gpio-backlight driver is quite short. If we
> pull gpio_backlight_initial_power_state() into probe we can drop two
> more fields from struct gpio_backlight and shrink the driver code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 36 ++++++++----------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 6247687b6330..37ec184f0c5c 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -17,11 +17,8 @@
>  #include <linux/slab.h>
>  
>  struct gpio_backlight {
> -	struct device *dev;
>  	struct device *fbdev;
> -
>  	struct gpio_desc *gpiod;
> -	int def_value;
>  };
>  
>  static int gpio_backlight_update_status(struct backlight_device *bl)
> @@ -53,41 +50,24 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> -static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)

I'm inclined to view deleting this function as removing a comment (e.g.
the function name helps us to read the code)!

Removing the variables from the context structure is good but why not
just pass them to the function and let the compiler decided whether or
not to inline.


Daniel.


> -{
> -	struct device_node *node = gbl->dev->of_node;
> -
> -	/* Not booted with device tree or no phandle link to the node */
> -	if (!node || !node->phandle)
> -		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> -
> -	/* if the enable GPIO is disabled, do not enable the backlight */
> -	if (gpiod_get_value_cansleep(gbl->gpiod) = 0)
> -		return FB_BLANK_POWERDOWN;
> -
> -	return FB_BLANK_UNBLANK;
> -}
> -
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
> +	struct device_node *of_node = dev->of_node;
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> -	int ret;
> +	int ret, def_value;
>  
>  	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl = NULL)
>  		return -ENOMEM;
>  
> -	gbl->dev = dev;
> -
>  	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
>  
> -	gbl->def_value = device_property_read_bool(dev, "default-on");
> +	def_value = device_property_read_bool(dev, "default-on");
>  
>  	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
>  	if (IS_ERR(gbl->gpiod)) {
> @@ -109,7 +89,15 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return PTR_ERR(bl);
>  	}
>  
> -	bl->props.power = gpio_backlight_initial_power_state(gbl);
> +	/* Not booted with device tree or no phandle link to the node */
> +	if (!of_node || !of_node->phandle)
> +		bl->props.power = def_value ? FB_BLANK_UNBLANK
> +					    : FB_BLANK_POWERDOWN;
> +	else if (gpiod_get_value_cansleep(gbl->gpiod) = 0)
> +		bl->props.power = FB_BLANK_POWERDOWN;
> +	else
> +		bl->props.power = FB_BLANK_UNBLANK;
> +
>  	bl->props.brightness = 1;
>  
>  	backlight_update_status(bl);
> -- 
> 2.23.0
> 
