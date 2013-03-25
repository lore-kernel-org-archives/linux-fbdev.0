From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 25 Mar 2013 05:12:21 +0000
Subject: Re: [PATCH v3 3/3] backlight: as3711: add OF support
Message-Id: <00da01ce2917$54856ce0$fd9046a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363968949-12151-1-git-send-email-g.liakhovetski@gmx.de>
 <1363968949-12151-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1363968949-12151-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Magnus Damm' <magnus.damm@gmail.com>, 'Simon Horman' <horms@verge.net.au>, devicetree-discuss@lists.ozlabs.org, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Richard Purdie' <rpurdie@rpsys.net>, linux-fbdev@vger.kernel.org, 'Guennadi Liakhovetski' <g.liakhovetski+renesas@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Saturday, March 23, 2013 1:16 AM, Guennadi Liakhovetski wrote:
> 
> Add support for configuring AS3711 backlight driver from DT.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>


But, there is a typo in comment.
> +		 * At least one su2-auto-curr* must be specified iff
s/iff/if

Best regards.
Jingoo Han

> ---
>  drivers/video/backlight/as3711_bl.c |  118 ++++++++++++++++++++++++++++++++++-
>  1 files changed, 117 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
> index 41d52fe..123887c 100644
> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -258,6 +258,109 @@ static int as3711_bl_register(struct platform_device *pdev,
>  	return 0;
>  }
> 
> +static int as3711_backlight_parse_dt(struct device *dev)
> +{
> +	struct as3711_bl_pdata *pdata = dev_get_platdata(dev);
> +	struct device_node *bl > +		of_find_node_by_name(dev->parent->of_node, "backlight"), *fb;
> +	int ret;
> +
> +	if (!bl) {
> +		dev_dbg(dev, "backlight node not found\n");
> +		return -ENODEV;
> +	}
> +
> +	fb = of_parse_phandle(bl, "su1-dev", 0);
> +	if (fb) {
> +		pdata->su1_fb = fb->full_name;
> +
> +		ret = of_property_read_u32(bl, "su1-max-uA", &pdata->su1_max_uA);
> +		if (pdata->su1_max_uA <= 0)
> +			ret = -EINVAL;
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	fb = of_parse_phandle(bl, "su2-dev", 0);
> +	if (fb) {
> +		int count = 0;
> +
> +		pdata->su2_fb = fb->full_name;
> +
> +		ret = of_property_read_u32(bl, "su2-max-uA", &pdata->su2_max_uA);
> +		if (pdata->su2_max_uA <= 0)
> +			ret = -EINVAL;
> +		if (ret < 0)
> +			return ret;
> +
> +		if (of_find_property(bl, "su2-feedback-voltage", NULL)) {
> +			pdata->su2_feedback = AS3711_SU2_VOLTAGE;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-feedback-curr1", NULL)) {
> +			pdata->su2_feedback = AS3711_SU2_CURR1;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-feedback-curr2", NULL)) {
> +			pdata->su2_feedback = AS3711_SU2_CURR2;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-feedback-curr3", NULL)) {
> +			pdata->su2_feedback = AS3711_SU2_CURR3;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-feedback-curr-auto", NULL)) {
> +			pdata->su2_feedback = AS3711_SU2_CURR_AUTO;
> +			count++;
> +		}
> +		if (count != 1)
> +			return -EINVAL;
> +
> +		count = 0;
> +		if (of_find_property(bl, "su2-fbprot-lx-sd4", NULL)) {
> +			pdata->su2_fbprot = AS3711_SU2_LX_SD4;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-fbprot-gpio2", NULL)) {
> +			pdata->su2_fbprot = AS3711_SU2_GPIO2;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-fbprot-gpio3", NULL)) {
> +			pdata->su2_fbprot = AS3711_SU2_GPIO3;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-fbprot-gpio4", NULL)) {
> +			pdata->su2_fbprot = AS3711_SU2_GPIO4;
> +			count++;
> +		}
> +		if (count != 1)
> +			return -EINVAL;
> +
> +		count = 0;
> +		if (of_find_property(bl, "su2-auto-curr1", NULL)) {
> +			pdata->su2_auto_curr1 = true;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-auto-curr2", NULL)) {
> +			pdata->su2_auto_curr2 = true;
> +			count++;
> +		}
> +		if (of_find_property(bl, "su2-auto-curr3", NULL)) {
> +			pdata->su2_auto_curr3 = true;
> +			count++;
> +		}
> +
> +		/*
> +		 * At least one su2-auto-curr* must be specified iff
> +		 * AS3711_SU2_CURR_AUTO is used
> +		 */
> +		if (!count ^ (pdata->su2_feedback != AS3711_SU2_CURR_AUTO))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int as3711_backlight_probe(struct platform_device *pdev)
>  {
>  	struct as3711_bl_pdata *pdata = dev_get_platdata(&pdev->dev);
> @@ -267,11 +370,24 @@ static int as3711_backlight_probe(struct platform_device *pdev)
>  	unsigned int max_brightness;
>  	int ret;
> 
> -	if (!pdata || (!pdata->su1_fb && !pdata->su2_fb)) {
> +	if (!pdata) {
>  		dev_err(&pdev->dev, "No platform data, exiting...\n");
>  		return -ENODEV;
>  	}
> 
> +	if (pdev->dev.parent->of_node) {
> +		ret = as3711_backlight_parse_dt(&pdev->dev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "DT parsing failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!pdata->su1_fb && !pdata->su2_fb) {
> +		dev_err(&pdev->dev, "No framebuffer specified\n");
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Due to possible hardware damage I chose to block all modes,
>  	 * unsupported on my hardware. Anyone, wishing to use any of those modes
> --
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

