From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 13 Nov 2017 14:16:09 +0000
Subject: Re: [PATCH 1/3] backlight: as3711_bl: fix device-tree node lookup
Message-Id: <94c3debe-17f6-9151-eefe-129f2bd1cfd4@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171113102049.9342-1-johan@kernel.org>
In-Reply-To: <20171113102049.9342-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <johan@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>



On 13/11/17 10:20, Johan Hovold wrote:
> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
> 
> To make things worse, the parent mfd node was also prematurely freed.
> 
> Note that the nodes returned from the two calls to of_parse_phandle()
> are also leaking, but fixing that is a bit more involved as pointers to
> node fields are being stored for later use.

Is using a devm_kstrdup() to remember the full_name sufficient so get 
each of the FIXMEs cleaned up as well?


Daniel.


> Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support")
> Cc: stable <stable@vger.kernel.org>     # 3.10
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/video/backlight/as3711_bl.c | 35 +++++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
> index 734a9158946b..21ce56053c88 100644
> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -262,15 +262,16 @@ static int as3711_bl_register(struct platform_device *pdev,
>   static int as3711_backlight_parse_dt(struct device *dev)
>   {
>   	struct as3711_bl_pdata *pdata = dev_get_platdata(dev);
> -	struct device_node *bl > -		of_find_node_by_name(dev->parent->of_node, "backlight"), *fb;
> +	struct device_node *bl, *fb;
>   	int ret;
>   
> +	bl = of_get_child_by_name(dev->parent->of_node, "backlight");
>   	if (!bl) {
>   		dev_dbg(dev, "backlight node not found\n");
>   		return -ENODEV;
>   	}
>   
> +	/* FIXME: need to drop reference to returned node */
>   	fb = of_parse_phandle(bl, "su1-dev", 0);
>   	if (fb) {
>   		pdata->su1_fb = fb->full_name;
> @@ -279,9 +280,10 @@ static int as3711_backlight_parse_dt(struct device *dev)
>   		if (pdata->su1_max_uA <= 0)
>   			ret = -EINVAL;
>   		if (ret < 0)
> -			return ret;
> +			goto err_put_bl;
>   	}
>   
> +	/* FIXME: need to drop reference to returned node */
>   	fb = of_parse_phandle(bl, "su2-dev", 0);
>   	if (fb) {
>   		int count = 0;
> @@ -292,7 +294,7 @@ static int as3711_backlight_parse_dt(struct device *dev)
>   		if (pdata->su2_max_uA <= 0)
>   			ret = -EINVAL;
>   		if (ret < 0)
> -			return ret;
> +			goto err_put_bl;
>   
>   		if (of_find_property(bl, "su2-feedback-voltage", NULL)) {
>   			pdata->su2_feedback = AS3711_SU2_VOLTAGE;
> @@ -314,8 +316,10 @@ static int as3711_backlight_parse_dt(struct device *dev)
>   			pdata->su2_feedback = AS3711_SU2_CURR_AUTO;
>   			count++;
>   		}
> -		if (count != 1)
> -			return -EINVAL;
> +		if (count != 1) {
> +			ret = -EINVAL;
> +			goto err_put_bl;
> +		}
>   
>   		count = 0;
>   		if (of_find_property(bl, "su2-fbprot-lx-sd4", NULL)) {
> @@ -334,8 +338,10 @@ static int as3711_backlight_parse_dt(struct device *dev)
>   			pdata->su2_fbprot = AS3711_SU2_GPIO4;
>   			count++;
>   		}
> -		if (count != 1)
> -			return -EINVAL;
> +		if (count != 1) {
> +			ret = -EINVAL;
> +			goto err_put_bl;
> +		}
>   
>   		count = 0;
>   		if (of_find_property(bl, "su2-auto-curr1", NULL)) {
> @@ -355,11 +361,20 @@ static int as3711_backlight_parse_dt(struct device *dev)
>   		 * At least one su2-auto-curr* must be specified iff
>   		 * AS3711_SU2_CURR_AUTO is used
>   		 */
> -		if (!count ^ (pdata->su2_feedback != AS3711_SU2_CURR_AUTO))
> -			return -EINVAL;
> +		if (!count ^ (pdata->su2_feedback != AS3711_SU2_CURR_AUTO)) {
> +			ret = -EINVAL;
> +			goto err_put_bl;
> +		}
>   	}
>   
> +	of_node_put(bl);
> +
>   	return 0;
> +
> +err_put_bl:
> +	of_node_put(bl);
> +
> +	return ret;
>   }
>   
>   static int as3711_backlight_probe(struct platform_device *pdev)
> 
