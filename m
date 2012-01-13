From: Sylwester Nawrocki <snjw23@gmail.com>
Date: Fri, 13 Jan 2012 21:03:00 +0000
Subject: Re: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <4F109C04.5090600@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/09/2012 09:01 PM, Thomas Abraham wrote:
>
> +	for (idx = 0; idx<  nr_gpios; idx++) {
> +		gpio = of_get_gpio(dev->of_node, idx);
> +		if (!gpio_is_valid(gpio)) {
> +			dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
> +			return -EINVAL;
> +		}
> +
> +		if (!request)
> +			continue;
> +
> +		ret = gpio_request(gpio, "fimd");

Is it how it normally is supposed to be done, i.e. configuring a gpio
_before_ it has been requested ? of_get_gpio() indirectly touches the
gpio controller and gpio_request() doesn't seem to serve its purpose
in this case, i.e. if there is situation like:

driver A                        driver B

of_get_gpio(nodeA, gpioA);
                                of_get_gpio(nodeB, gpioA);
gpio_request(gpioA);
                                gpio_request(gpioB);

driver B will end up with configuration of gpioA from nodeA, not from 
nodeB. 

As there are few drivers doing that I must be missing something,
not sure what..
I realize the GPIO number needs to be known in order for a GPIO to be
requested. Shouldn't of_get_gpio() be extended to allow locking gpio
controller's module and marking a GPIO as requested in advance ?

> +		if (ret) {
> +			dev_err(dev, "gpio [%d] request failed\n", gpio);
> +			goto gpio_free;
> +		}
> +		sfb->gpios[idx] = gpio;
> +	}
> +	return 0;
> +
> +gpio_free:
> +	while (--idx>= 0)
> +		gpio_free(sfb->gpios[idx]);
> +	return ret;
> +}
> +
> +static void s3c_fb_dt_free_gpios(struct s3c_fb *sfb)
> +{
> +	unsigned int idx, nr_gpio;
> +
> +	nr_gpio = sfb->pdata->win[0]->max_bpp + 4;
> +	for (idx = 0; idx<  nr_gpio; idx++)
> +		gpio_free(sfb->gpios[idx]);
> +}
