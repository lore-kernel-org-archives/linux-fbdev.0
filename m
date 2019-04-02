From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 02 Apr 2019 13:45:40 +0000
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-Id: <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Hello

On 4/1/19 5:30 AM, Brian Masney wrote:
> Add device tree support to the lm3630a driver and allow configuring
> independently on both banks the mapping mode (linear or exponential),
> initial and maximum LED brightness.
> 
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 

Don't need this in the commit message.

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..96fbc1273dda 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -35,6 +35,9 @@
>  #define REG_MAX		0x50
>  
>  #define INT_DEBOUNCE_MSEC	10
> +
> +#define LM3630A_MAX_SOURCES	2
> +
>  struct lm3630a_chip {
>  	struct device *dev;
>  	struct delayed_work work;
> @@ -364,6 +367,64 @@ static const struct regmap_config lm3630a_regmap = {
>  	.max_register = REG_MAX,
>  };
>  
> +static void lm3630a_parse_dt(struct lm3630a_chip *pchip)
> +{
> +	u32 sources[LM3630A_MAX_SOURCES], val;
> +	struct device_node *child_node;
> +	int num_sources, ret, i;
> +	bool linear;
> +
> +	for_each_available_child_of_node(pchip->dev->of_node, child_node) {

I would prefer we use fwnode api's.

See lm3532 patch submission for example
https://lore.kernel.org/patchwork/patch/1053132/

> +		num_sources = of_property_count_u32_elems(child_node,
> +							  "led-sources");
> +		if (num_sources < 0)
> +			continue;
> +

Not sure what this is checking here.  Wondering if you should return an error here instead.

> +		if (num_sources > LM3630A_MAX_SOURCES)
> +			num_sources = LM3630A_MAX_SOURCES;
> +

If num_sources is greater than max should we not log and return an error?
Why does the driver fix a malformed property?

> +		ret = of_property_read_u32_array(child_node, "led-sources",
> +						 sources, num_sources);
> +		if (ret) {
> +			dev_err(pchip->dev,
> +				"Error parsing led-sources node: %d\n", ret);
> +			return;

We should return an error here see comment below on the order of operation pdata->dt->default parameters.

> +		}
> +
> +		linear = of_property_read_bool(child_node,
> +					       "ti,linear-mapping-mode");
> +
> +		for (i = 0; i < num_sources; i++) {

If the reg property is used to determine control bank then this for..loop may be eliminated


> +			if (sources[i] = 0)
> +				pchip->pdata->leda_ctrl = linear ?
> +					LM3630A_LEDA_ENABLE_LINEAR :
> +					LM3630A_LEDA_ENABLE;
> +			else if (sources[i] = 1)
> +				pchip->pdata->ledb_ctrl = linear ?
> +					LM3630A_LEDB_ENABLE_LINEAR :
> +					LM3630A_LEDB_ENABLE;
> +
> +			ret = of_property_read_u32(child_node,
> +						   "default-brightness", &val);
> +			if (!ret) {
> +				if (sources[i] = 0)
> +					pchip->pdata->leda_init_brt = val;
> +				else if (sources[i] = 1)
> +					pchip->pdata->ledb_init_brt = val;
> +			}
> +
> +			ret = of_property_read_u32(child_node, "max-brightness",
> +						   &val);
> +			if (!ret) {
> +				if (sources[i] = 0)
> +					pchip->pdata->leda_max_brt = val;
> +				else if (sources[i] = 1)
> +					pchip->pdata->ledb_max_brt = val;
> +			}
> +		}
> +	};
> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -405,6 +466,7 @@ static int lm3630a_probe(struct i2c_client *client,
>  		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
>  	}
>  	pchip->pdata = pdata;
> +	lm3630a_parse_dt(pchip);
>  

Hmm.  Wondering if this should be in the if (pdata = NULL) case and if parsing the
node fails then set defaults.

Because the way it is written if pdata is null then all the defaults are set then the dt parsing
overwrites the data.

Not sure if thats what you intended.

Dan

>  	/* chip initialize */
>  	rval = lm3630a_chip_init(pchip);
> @@ -470,11 +532,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +
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


-- 
------------------
Dan Murphy
