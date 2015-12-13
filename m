From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 20:12:08 +0000
Subject: Re: [PATCH 04/23] OMAPDSS: tpd12s015: gpio descriptor API
Message-Id: <18127743.ynUm3nFSLl@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449676791-26304-5-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449676791-26304-5-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wednesday 09 December 2015 17:59:32 Tomi Valkeinen wrote:
> From: Manisha Agrawal <manisha.agrawal@ti.com>
> 
> Migrated the gpio APIs to descriptor-interface based.
> 
> Signed-off-by: Manisha Agrawal <manisha.agrawal@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../fbdev/omap2/displays-new/encoder-tpd12s015.c   | 81 +++++++------------
>  1 file changed, 30 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c index
> 6f5e27a4fe63..93f95eaeadad 100644
> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> @@ -13,9 +13,8 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
> 
>  #include <video/omapdss.h>
>  #include <video/omap-panel-data.h>
> @@ -24,9 +23,9 @@ struct panel_drv_data {
>  	struct omap_dss_device dssdev;
>  	struct omap_dss_device *in;
> 
> -	int ct_cp_hpd_gpio;
> -	int ls_oe_gpio;
> -	int hpd_gpio;
> +	struct gpio_desc *ct_cp_hpd_gpio;
> +	struct gpio_desc *ls_oe_gpio;
> +	struct gpio_desc *hpd_gpio;
> 
>  	struct omap_video_timings timings;
>  };
> @@ -47,7 +46,7 @@ static int tpd_connect(struct omap_dss_device *dssdev,
>  	dst->src = dssdev;
>  	dssdev->dst = dst;
> 
> -	gpio_set_value_cansleep(ddata->ct_cp_hpd_gpio, 1);
> +	gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 1);
>  	/* DC-DC converter needs at max 300us to get to 90% of 5V */
>  	udelay(300);
> 
> @@ -65,7 +64,7 @@ static void tpd_disconnect(struct omap_dss_device *dssdev,
> if (dst != dssdev->dst)
>  		return;
> 
> -	gpio_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
> +	gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
> 
>  	dst->src = NULL;
>  	dssdev->dst = NULL;
> @@ -145,16 +144,16 @@ static int tpd_read_edid(struct omap_dss_device
> *dssdev, struct omap_dss_device *in = ddata->in;
>  	int r;
> 
> -	if (!gpio_get_value_cansleep(ddata->hpd_gpio))
> +	if (!gpiod_get_value_cansleep(ddata->hpd_gpio))
>  		return -ENODEV;
> 
> -	if (gpio_is_valid(ddata->ls_oe_gpio))
> -		gpio_set_value_cansleep(ddata->ls_oe_gpio, 1);
> +	if (ddata->ls_oe_gpio)
> +		gpiod_set_value_cansleep(ddata->ls_oe_gpio, 1);

gpiod_set_value_cansleep() includes a NULL check so you could remove it here.

> 
>  	r = in->ops.hdmi->read_edid(in, edid, len);
> 
> -	if (gpio_is_valid(ddata->ls_oe_gpio))
> -		gpio_set_value_cansleep(ddata->ls_oe_gpio, 0);
> +	if (ddata->ls_oe_gpio)
> +		gpiod_set_value_cansleep(ddata->ls_oe_gpio, 0);

And here.

Apart from that the patch looks good to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	return r;
>  }
> @@ -163,7 +162,7 @@ static bool tpd_detect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
> 
> -	return gpio_get_value_cansleep(ddata->hpd_gpio);
> +	return gpiod_get_value_cansleep(ddata->hpd_gpio);
>  }
> 
>  static int tpd_set_infoframe(struct omap_dss_device *dssdev,
> @@ -207,32 +206,6 @@ static int tpd_probe_of(struct platform_device *pdev)
>  	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
>  	struct device_node *node = pdev->dev.of_node;
>  	struct omap_dss_device *in;
> -	int gpio;
> -
> -	/* CT CP HPD GPIO */
> -	gpio = of_get_gpio(node, 0);
> -	if (!gpio_is_valid(gpio)) {
> -		dev_err(&pdev->dev, "failed to parse CT CP HPD gpio\n");
> -		return gpio;
> -	}
> -	ddata->ct_cp_hpd_gpio = gpio;
> -
> -	/* LS OE GPIO */
> -	gpio = of_get_gpio(node, 1);
> -	if (gpio_is_valid(gpio) || gpio = -ENOENT) {
> -		ddata->ls_oe_gpio = gpio;
> -	} else {
> -		dev_err(&pdev->dev, "failed to parse LS OE gpio\n");
> -		return gpio;
> -	}
> -
> -	/* HPD GPIO */
> -	gpio = of_get_gpio(node, 2);
> -	if (!gpio_is_valid(gpio)) {
> -		dev_err(&pdev->dev, "failed to parse HPD gpio\n");
> -		return gpio;
> -	}
> -	ddata->hpd_gpio = gpio;
> 
>  	in = omapdss_of_find_source_for_first_ep(node);
>  	if (IS_ERR(in)) {
> @@ -250,6 +223,7 @@ static int tpd_probe(struct platform_device *pdev)
>  	struct omap_dss_device *in, *dssdev;
>  	struct panel_drv_data *ddata;
>  	int r;
> +	struct gpio_desc *gpio;
> 
>  	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
> @@ -265,23 +239,28 @@ static int tpd_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> -	r = devm_gpio_request_one(&pdev->dev, ddata->ct_cp_hpd_gpio,
> -			GPIOF_OUT_INIT_LOW, "hdmi_ct_cp_hpd");
> -	if (r)
> +
> +	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 0,
> +		GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio))
>  		goto err_gpio;
> 
> -	if (gpio_is_valid(ddata->ls_oe_gpio)) {
> -		r = devm_gpio_request_one(&pdev->dev, ddata->ls_oe_gpio,
> -				GPIOF_OUT_INIT_LOW, "hdmi_ls_oe");
> -		if (r)
> -			goto err_gpio;
> -	}
> +	ddata->ct_cp_hpd_gpio = gpio;
> 
> -	r = devm_gpio_request_one(&pdev->dev, ddata->hpd_gpio,
> -			GPIOF_DIR_IN, "hdmi_hpd");
> -	if (r)
> +	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 1,
> +		GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio))
>  		goto err_gpio;
> 
> +	ddata->ls_oe_gpio = gpio;
> +
> +	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 2,
> +		GPIOD_IN);
> +	if (IS_ERR(gpio))
> +		goto err_gpio;
> +
> +	ddata->hpd_gpio = gpio;
> +
>  	dssdev = &ddata->dssdev;
>  	dssdev->ops.hdmi = &tpd_hdmi_ops;
>  	dssdev->dev = &pdev->dev;

-- 
Regards,

Laurent Pinchart

