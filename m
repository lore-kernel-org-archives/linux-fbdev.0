From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 15 Apr 2019 12:10:55 +0000
Subject: Re: [PATCH v3 3/3] backlight: lm3630a: add firmware node support
Message-Id: <0e5e26ba-cf98-913e-8e76-e988a86dc0d1@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-4-masneyb@onstation.org>
In-Reply-To: <20190415072905.2861-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca



On 4/15/19 2:29 AM, Brian Masney wrote:
> Add fwnode support to the lm3630a driver and allow configuring
> the initial and maximum LED brightness on both LED banks independently.
> The two outputs can be controlled by bank A and B independently or
> bank A can control both outputs.
> 
> If the platform data was not configured, then the driver defaults to
> enabling both banks. This patch changes the default value to disable
> both banks before parsing the firmware node so that just a single bank
> can be enabled if desired. There are no in-tree users of this driver.
> 
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v2
> - Separated out control banks and outputs via the reg and led-sources
>   properties.
> - Use fwnode instead of of API
> - Disable both banks by default before calling lm3630a_parse_node()
> - Add lots of error handling
> - Check for duplicate source / bank definitions
> - Remove extra ;
> - Make probe() method fail if fwnode parsing fails.
> 
>  drivers/video/backlight/lm3630a_bl.c | 128 ++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..15922da9c05a 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -364,6 +364,116 @@ static const struct regmap_config lm3630a_regmap = {
>  	.max_register = REG_MAX,
>  };
>  
> +/**
> + * lm3630a_parse_led_sources - Parse the optional led-sources fwnode property.
> + * @node: firmware node
> + * @default_bitmask: bitmask to return if the led-sources property was not
> + *                   specified
> + *
> + * Parses the optional led-sources firmware node and returns a bitmask that
> + * contains the outputs that are associated with the control bank. If the
> + * property is missing, then the value of of @default_bitmask will be returned.
> + */
> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
> +				     int default_bitmask)
> +{
> +	int ret, num_sources, i;
> +	u32 sources[2];
> +
> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
> +						     0);
> +	if (num_sources < 0)
> +		return default_bitmask;
> +	else if (num_sources > ARRAY_SIZE(sources))
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
> +					     num_sources);
> +	if (ret)
> +		return ret;
> +
> +	ret = 0;
> +	for (i = 0; i < num_sources; i++) {
> +		if (sources[i] < 0 || sources[i] > 1)
> +			return -EINVAL;
> +
> +		ret |= BIT(sources[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int lm3630a_parse_node(struct lm3630a_chip *pchip,
> +			      struct lm3630a_platform_data *pdata)
> +{
> +	int seen = 0, led_sources, ret;
> +	struct fwnode_handle *node;
> +	u32 bank, val;
> +	bool linear;
> +
> +	device_for_each_child_node(pchip->dev, node) {
> +		ret = fwnode_property_read_u32(node, "reg", &bank);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (bank < 0 || bank > 1)
> +			return -EINVAL;
> +
> +		if (seen & BIT(bank))
> +			return -EINVAL;

Need line break for clarity.

> +		seen |= BIT(bank);
> +
> +		led_sources = lm3630a_parse_led_sources(node, BIT(bank));
> +		if (led_sources < 0)
> +			return led_sources;
> +
> +		linear = fwnode_property_read_bool(node,
> +						   "ti,linear-mapping-mode");
> +		if (bank = 0) {
> +			if (!(led_sources & BIT(0)))
> +				return -EINVAL;
> +
> +			pdata->leda_ctrl = linear ?
> +				LM3630A_LEDA_ENABLE_LINEAR :
> +				LM3630A_LEDA_ENABLE;
> +
> +			if (led_sources & BIT(1)) {
> +				if (seen & BIT(1))
> +					return -EINVAL;

Need line break for clarity.

> +				seen |= BIT(1);
> +
> +				pdata->ledb_ctrl = LM3630A_LEDB_ON_A;
> +			}
> +		} else {
> +			if (led_sources & BIT(0) || !(led_sources & BIT(1)))
> +				return -EINVAL;
> +
> +			pdata->ledb_ctrl = linear ?
> +				LM3630A_LEDB_ENABLE_LINEAR :
> +				LM3630A_LEDB_ENABLE;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "default-brightness",
> +					       &val);
> +		if (!ret) {
> +			if (bank = 0)
> +				pdata->leda_init_brt = val;
> +			else
> +				pdata->ledb_init_brt = val;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "max-brightness", &val);
> +		if (!ret) {
> +			if (bank = 0)
> +				pdata->leda_max_brt = val;
> +			else
> +				pdata->ledb_max_brt = val;
> +		}
> +	}
> +
> +	return 0;

Shouldn't we return ret here and set ret to -ENODEV?
If device_for_each does not find a node if falls through and returns a success but really is should fail.

> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -396,13 +506,20 @@ static int lm3630a_probe(struct i2c_client *client,
>  				     GFP_KERNEL);
>  		if (pdata = NULL)
>  			return -ENOMEM;
> +
>  		/* default values */
> -		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
> -		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
> +		pdata->leda_ctrl = LM3630A_LEDA_DISABLE;
> +		pdata->ledb_ctrl = LM3630A_LEDB_DISABLE;

This is not needed since default is disabled and kzalloc will set these to 0

>  		pdata->leda_max_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
> +
> +		rval = lm3630a_parse_node(pchip, pdata);
> +		if (rval) {
> +			dev_err(&client->dev, "fail : parse node\n");
> +			return rval;
> +		}
>  	}
>  	pchip->pdata = pdata;
>  
> @@ -470,11 +587,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +

Extra new line here.

>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> 
