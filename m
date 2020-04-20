From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 15:29:26 +0000
Subject: Re: [PATCH 1/5] backlight: led_bl: fix cosmetic issues
Message-Id: <20200420152926.iqtpvy6e3rbrm475@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200417113312.24340-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Apr 17, 2020 at 02:33:08PM +0300, Tomi Valkeinen wrote:
> Fix issues reported by checkpatch. No functional changes.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/led_bl.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3f66549997c8..d4e1ce684366 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -126,7 +126,7 @@ static int led_bl_get_leds(struct device *dev,
>  }
>  
>  static int led_bl_parse_levels(struct device *dev,
> -			   struct led_bl_data *priv)
> +			       struct led_bl_data *priv)
>  {
>  	struct device_node *node = dev->of_node;
>  	int num_levels;
> @@ -148,8 +148,8 @@ static int led_bl_parse_levels(struct device *dev,
>  			return -ENOMEM;
>  
>  		ret = of_property_read_u32_array(node, "brightness-levels",
> -						levels,
> -						num_levels);
> +						 levels,
> +						 num_levels);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -159,14 +159,15 @@ static int led_bl_parse_levels(struct device *dev,
>  		 */
>  		db = priv->default_brightness;
>  		for (i = 0 ; i < num_levels; i++) {
> -			if ((i && db > levels[i-1]) && db <= levels[i])
> +			if ((i && db > levels[i - 1]) && db <= levels[i])
>  				break;
>  		}
>  		priv->default_brightness = i;
>  		priv->max_brightness = num_levels - 1;
>  		priv->levels = levels;
> -	} else if (num_levels >= 0)
> +	} else if (num_levels >= 0) {
>  		dev_warn(dev, "Not enough levels defined\n");
> +	}
>  
>  	ret = of_property_read_u32(node, "default-brightness-level", &value);
>  	if (!ret && value <= priv->max_brightness)
> @@ -208,7 +209,8 @@ static int led_bl_probe(struct platform_device *pdev)
>  	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
>  		      FB_BLANK_UNBLANK;
>  	priv->bl_dev = backlight_device_register(dev_name(&pdev->dev),
> -			&pdev->dev, priv, &led_bl_ops, &props);
> +						 &pdev->dev, priv, &led_bl_ops,
> +						 &props);
>  	if (IS_ERR(priv->bl_dev)) {
>  		dev_err(&pdev->dev, "Failed to register backlight\n");
>  		return PTR_ERR(priv->bl_dev);
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
