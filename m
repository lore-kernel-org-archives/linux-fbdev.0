From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:34:35 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi/sh_mobile_hdmi: clk_round_rate() can return a zero upon error
Message-Id: <2303829.DoTdkXvVfE@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.02.1311261651300.11450@tamien>
In-Reply-To: <alpine.DEB.2.02.1311261651300.11450@tamien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Tuesday 26 November 2013 16:53:26 Paul Walmsley wrote:
> Treat both negative and zero return values from clk_round_rate() as
> errors.  This is needed since subsequent patches will convert
> clk_round_rate()'s return value to be an unsigned type, rather than a
> signed type, since some clock sources can generate rates higher than
> (2^31)-1 Hz.
> 
> Eventually, when calling clk_round_rate(), only a return value of zero
> will be considered a error.  All other values will be considered valid
> rates.  The comparison against values less than 0 is kept to preserve
> the correct behavior in the meantime.
> 
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> 
> Applies on v3.13-rc1.  See also:
> 
> http://marc.info/?l=linux-arm-kernel&m8542591313620&w=2
> 
>   drivers/video/sh_mipi_dsi.c    |    4 +++-
>   drivers/video/sh_mobile_hdmi.c |    6 +++---
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
> index 8f6e8ff620d4..510cfb668a0c 100644
> --- a/drivers/video/sh_mipi_dsi.c
> +++ b/drivers/video/sh_mipi_dsi.c
> @@ -494,8 +494,10 @@ static int __init sh_mipi_probe(struct platform_device
> *pdev) ret = clk_set_rate(mipi->dsit_clk, rate);
>   	else
>   		ret = rate;
> -	if (ret < 0)
> +	if (ret <= 0) {
> +		ret = -ERANGE;
>   		goto esettrate;
> +	}
> 
>   	dev_dbg(&pdev->dev, "DSI-T clk %lu -> %lu\n", f_current, rate);
> 
> diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
> index 9a33ee0413fb..1e757e54c784 100644
> --- a/drivers/video/sh_mobile_hdmi.c
> +++ b/drivers/video/sh_mobile_hdmi.c
> @@ -818,7 +818,7 @@ static unsigned long sh_hdmi_rate_error(struct sh_hdmi
> *hdmi, struct sh_mobile_hdmi_info *pdata = dev_get_platdata(hdmi->dev);
> 
>   	*hdmi_rate = clk_round_rate(hdmi->hdmi_clk, target);
> -	if ((long)*hdmi_rate < 0)
> +	if ((long)*hdmi_rate <= 0)
>   		*hdmi_rate = clk_get_rate(hdmi->hdmi_clk);
> 
>   	rate_error = (long)*hdmi_rate > 0 ? abs(*hdmi_rate - target) : ULONG_MAX;
> @@ -1321,8 +1321,8 @@ static int __init sh_hdmi_probe(struct
> platform_device *pdev) if (rate > 0)
>   		rate = sh_hdmi_clk_configure(hdmi, rate, 0);
> 
> -	if (rate < 0) {
> -		ret = rate;
> +	if (rate <= 0) {
> +		ret = -EINVAL;
>   		goto erate;
>   	}
> 

-- 
Regards,

Laurent Pinchart

