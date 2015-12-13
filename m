From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 20:07:44 +0000
Subject: Re: [PATCH 03/23] OMAPDSS: tpd12s015: remove platform data support
Message-Id: <3029491.9Uo23LfBaE@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449676791-26304-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449676791-26304-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wednesday 09 December 2015 17:59:31 Tomi Valkeinen wrote:
> From: Manisha Agrawal <manisha.agrawal@ti.com>
> 
> All devices using tpd12s015 driver are doing DT boot. No need of further
> supporting the platform data. This patch removes support for platform
> data.
> 
> Signed-off-by: Manisha Agrawal <manisha.agrawal@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../fbdev/omap2/displays-new/encoder-tpd12s015.c   | 31 +------------------
>  include/video/omap-panel-data.h                    | 15 -----------
>  2 files changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c index
> 990af6baeb0f..6f5e27a4fe63 100644
> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> @@ -201,31 +201,6 @@ static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
>  	.set_hdmi_mode		= tpd_set_hdmi_mode,
>  };
> 
> -static int tpd_probe_pdata(struct platform_device *pdev)
> -{
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> -	struct encoder_tpd12s015_platform_data *pdata;
> -	struct omap_dss_device *dssdev, *in;
> -
> -	pdata = dev_get_platdata(&pdev->dev);
> -
> -	ddata->ct_cp_hpd_gpio = pdata->ct_cp_hpd_gpio;
> -	ddata->ls_oe_gpio = pdata->ls_oe_gpio;
> -	ddata->hpd_gpio = pdata->hpd_gpio;
> -
> -	in = omap_dss_find_output(pdata->source);
> -	if (in = NULL) {
> -		dev_err(&pdev->dev, "Failed to find video source\n");
> -		return -ENODEV;
> -	}
> -
> -	ddata->in = in;
> -
> -	dssdev = &ddata->dssdev;
> -	dssdev->name = pdata->name;
> -
> -	return 0;
> -}
> 

One extra blank line here.

>  static int tpd_probe_of(struct platform_device *pdev)
>  {
> @@ -282,11 +257,7 @@ static int tpd_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, ddata);
> 
> -	if (dev_get_platdata(&pdev->dev)) {
> -		r = tpd_probe_pdata(pdev);
> -		if (r)
> -			return r;
> -	} else if (pdev->dev.of_node) {
> +	if (pdev->dev.of_node) {
>  		r = tpd_probe_of(pdev);
>  		if (r)
>  			return r;

How about moving the else case not shown here to the beginning of the function 
with

	if (!pdev->dev.of_node)
		return -ENODEV;

and lowering the indentation level here with just

	r = tpd_probe_of(pdev);
	if (r)
		return r;

Apart from that the patch looks good to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> diff --git a/include/video/omap-panel-data.h
> b/include/video/omap-panel-data.h index 69279c013ac4..56830d1dc762 100644
> --- a/include/video/omap-panel-data.h
> +++ b/include/video/omap-panel-data.h
> @@ -45,21 +45,6 @@ struct encoder_tfp410_platform_data {
>  	int data_lines;
>  };
> 
> -/**
> - * encoder_tpd12s015 platform data
> - * @name: name for this display entity
> - * @ct_cp_hpd_gpio: CT_CP_HPD gpio number
> - * @ls_oe_gpio: LS_OE gpio number
> - * @hpd_gpio: HPD gpio number
> - */
> -struct encoder_tpd12s015_platform_data {
> -	const char *name;
> -	const char *source;
> -
> -	int ct_cp_hpd_gpio;
> -	int ls_oe_gpio;
> -	int hpd_gpio;
> -};
> 
>  /**
>   * connector_dvi platform data

-- 
Regards,

Laurent Pinchart

