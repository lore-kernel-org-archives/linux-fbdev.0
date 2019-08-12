From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Aug 2019 06:59:15 +0000
Subject: Re: [PATCH v2 03/10] input: keyboard: gpio_keys: convert platform driver to use dev_groups
Message-Id: <20190812065915.GU178933@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-4-gregkh@linuxfoundation.org>
In-Reply-To: <20190731124349.4474-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Richard Gong <richard.gong@linux.intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Wed, Jul 31, 2019 at 02:43:42PM +0200, Greg Kroah-Hartman wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a bunch of sysfs files.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/gpio_keys.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 03f4d152f6b7..1373dc5b0765 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -351,10 +351,7 @@ static struct attribute *gpio_keys_attrs[] = {
>  	&dev_attr_disabled_switches.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group gpio_keys_attr_group = {
> -	.attrs = gpio_keys_attrs,
> -};
> +ATTRIBUTE_GROUPS(gpio_keys);
>  
>  static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
>  {
> @@ -851,13 +848,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  
>  	fwnode_handle_put(child);
>  
> -	error = devm_device_add_group(dev, &gpio_keys_attr_group);
> -	if (error) {
> -		dev_err(dev, "Unable to export keys/switches, error: %d\n",
> -			error);
> -		return error;
> -	}
> -
>  	error = input_register_device(input);
>  	if (error) {
>  		dev_err(dev, "Unable to register input device, error: %d\n",
> @@ -1026,6 +1016,7 @@ static struct platform_driver gpio_keys_device_driver = {
>  		.name	= "gpio-keys",
>  		.pm	= &gpio_keys_pm_ops,
>  		.of_match_table = gpio_keys_of_match,
> +		.dev_groups	= gpio_keys_groups,
>  	}
>  };
>  
> -- 
> 2.22.0
> 

-- 
Dmitry
