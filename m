From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 03 Dec 2014 10:15:31 +0000
Subject: Re: [PATCH v2 1/2] backlight/lp855x: Refactor dt parsing code
Message-Id: <20141203101531.GB327@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417570752-23633-1-git-send-email-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: milo.kim-l0cyMroinI0@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On Tue, 02 Dec 2014, Sean Paul wrote:

> This patch refactors the dt parsing code to avoid setting platform_data,
> instead just setting lp->pdata directly. This facilitates easier
> probe deferral since the current scheme would require us to clear out
> dev->platform_data before deferring.
> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/video/backlight/lp855x_bl.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)

Applied with Acks, thanks.

> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index 25fb8e3..257b3ba 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -341,8 +341,10 @@ static const struct attribute_group lp855x_attr_group = {
>  };
>  
>  #ifdef CONFIG_OF
> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
> +static int lp855x_parse_dt(struct lp855x *lp)
>  {
> +	struct device *dev = lp->dev;
> +	struct device_node *node = dev->of_node;
>  	struct lp855x_platform_data *pdata;
>  	int rom_length;
>  
> @@ -381,12 +383,12 @@ static int lp855x_parse_dt(struct device *dev, struct device_node *node)
>  		pdata->rom_data = &rom[0];
>  	}
>  
> -	dev->platform_data = pdata;
> +	lp->pdata = pdata;
>  
>  	return 0;
>  }
>  #else
> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
> +static int lp855x_parse_dt(struct lp855x *lp)
>  {
>  	return -EINVAL;
>  }
> @@ -395,18 +397,8 @@ static int lp855x_parse_dt(struct device *dev, struct device_node *node)
>  static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>  {
>  	struct lp855x *lp;
> -	struct lp855x_platform_data *pdata = dev_get_platdata(&cl->dev);
> -	struct device_node *node = cl->dev.of_node;
>  	int ret;
>  
> -	if (!pdata) {
> -		ret = lp855x_parse_dt(&cl->dev, node);
> -		if (ret < 0)
> -			return ret;
> -
> -		pdata = dev_get_platdata(&cl->dev);
> -	}
> -
>  	if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -EIO;
>  
> @@ -414,16 +406,23 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>  	if (!lp)
>  		return -ENOMEM;
>  
> -	if (pdata->period_ns > 0)
> -		lp->mode = PWM_BASED;
> -	else
> -		lp->mode = REGISTER_BASED;
> -
>  	lp->client = cl;
>  	lp->dev = &cl->dev;
> -	lp->pdata = pdata;
>  	lp->chipname = id->name;
>  	lp->chip_id = id->driver_data;
> +	lp->pdata = dev_get_platdata(&cl->dev);
> +
> +	if (!lp->pdata) {
> +		ret = lp855x_parse_dt(lp);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (lp->pdata->period_ns > 0)
> +		lp->mode = PWM_BASED;
> +	else
> +		lp->mode = REGISTER_BASED;
> +
>  	i2c_set_clientdata(cl, lp);
>  
>  	ret = lp855x_configure(lp);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
