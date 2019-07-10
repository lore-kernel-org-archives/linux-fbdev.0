From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Wed, 10 Jul 2019 23:50:12 +0000
Subject: Re: BUG: Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <20190710234940.GB29252@nishad>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3ca02376-631b-d159-7070-7c50403126de@electromag.com.au>
In-Reply-To: <3ca02376-631b-d159-7070-7c50403126de@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Reid <preid@electromag.com.au>, gregkh@linuxfoundation.org, thomas.petazzoni@free-electrons.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, nsaenzjulienne@suse.de

On Wed, Jul 10, 2019 at 04:31:09PM +0800, Phil Reid wrote:
> G'day Nishad,
> 
> I'm just wondering if the commit
> c440eee1a7a1d0f "Staging: fbtft: Switch to the gpio descriptor interface"
> was tested on anything.
> 
> I've had to apply the following patch to get my display functioning again.
> 
> in particular the devm_gpiod_get_index using dev->driver->name for the gpio lookup seems
> wrong.
> 
> Also I've had to invert the polarity of the reset-gpios in the DT file for the display to function.
> 
> this code:
> 	gpiod_set_value_cansleep(par->gpio.reset, 0);
> 	usleep_range(20, 40);
> 	gpiod_set_value_cansleep(par->gpio.reset, 1);
> 
> could be read as deasserting the reset line and then asserting it.
> So I've had to specify and active high reset line in the DT.
> 
> Regards
> Phil
> 
Hello Phil,

This patch was only compiled successfully.

It hasn't been tested on any hardware.

Sorry for the mistake.

Thanks and regards,
Nishad

> 
> 
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 9b07bad..6fe7cb5 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -79,18 +79,16 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
>  	struct device_node *node = dev->of_node;
>  	int ret = 0;
> 
> -	if (of_find_property(node, name, NULL)) {
> -		*gpiop = devm_gpiod_get_index(dev, dev->driver->name, index,
> -					      GPIOD_OUT_HIGH);
> -		if (IS_ERR(*gpiop)) {
> -			ret = PTR_ERR(*gpiop);
> -			dev_err(dev,
> -				"Failed to request %s GPIO:%d\n", name, ret);
> -			return ret;
> -		}
> -		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> -			      __func__, name);
> +	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
> +				      GPIOD_OUT_HIGH);
> +	if (IS_ERR(*gpiop)) {
> +		ret = PTR_ERR(*gpiop);
> +		dev_err(dev,
> +			"Failed to request %s GPIO: (%d)\n", name, ret);
> +		return ret;
>  	}
> +	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> +		      __func__, name);
> 
>  	return ret;
>  }
> @@ -103,34 +101,34 @@ static int fbtft_request_gpios_dt(struct fbtft_par *par)
>  	if (!par->info->device->of_node)
>  		return -EINVAL;
> 
> -	ret = fbtft_request_one_gpio(par, "reset-gpios", 0, &par->gpio.reset);
> +	ret = fbtft_request_one_gpio(par, "reset", 0, &par->gpio.reset);
>  	if (ret)
>  		return ret;
> -	ret = fbtft_request_one_gpio(par, "dc-gpios", 0, &par->gpio.dc);
> +	ret = fbtft_request_one_gpio(par, "dc", 0, &par->gpio.dc);
>  	if (ret)
>  		return ret;
> -	ret = fbtft_request_one_gpio(par, "rd-gpios", 0, &par->gpio.rd);
> +	ret = fbtft_request_one_gpio(par, "rd", 0, &par->gpio.rd);
>  	if (ret)
>  		return ret;
> -	ret = fbtft_request_one_gpio(par, "wr-gpios", 0, &par->gpio.wr);
> +	ret = fbtft_request_one_gpio(par, "wr", 0, &par->gpio.wr);
>  	if (ret)
>  		return ret;
> -	ret = fbtft_request_one_gpio(par, "cs-gpios", 0, &par->gpio.cs);
> +	ret = fbtft_request_one_gpio(par, "cs", 0, &par->gpio.cs);
>  	if (ret)
>  		return ret;
> -	ret = fbtft_request_one_gpio(par, "latch-gpios", 0, &par->gpio.latch);
> +	ret = fbtft_request_one_gpio(par, "latch", 0, &par->gpio.latch);
>  	if (ret)
>  		return ret;
>  	for (i = 0; i < 16; i++) {
> -		ret = fbtft_request_one_gpio(par, "db-gpios", i,
> +		ret = fbtft_request_one_gpio(par, "db", i,
>  					     &par->gpio.db[i]);
>  		if (ret)
>  			return ret;
> -		ret = fbtft_request_one_gpio(par, "led-gpios", i,
> +		ret = fbtft_request_one_gpio(par, "led", i,
>  					     &par->gpio.led[i]);
>  		if (ret)
>  			return ret;
> -		ret = fbtft_request_one_gpio(par, "aux-gpios", i,
> +		ret = fbtft_request_one_gpio(par, "aux", i,
>  					     &par->gpio.aux[i]);
>  		if (ret)
>  			return ret;
> 
> 
> 
> 
