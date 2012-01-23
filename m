From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 23 Jan 2012 10:36:28 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: add extra settings method for platform
Message-Id: <201201231136.30647.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Morimoto-san,

Thank you for the patch.

On Monday 23 January 2012 06:08:34 Kuninori Morimoto wrote:
> Some platform needs extra MIPI settings.
> This patch add support it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/video/sh_mipi_dsi.c |    8 ++++++++
>  include/video/sh_mipi_dsi.h |    3 +++
>  2 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
> index 05151b8..1532894 100644
> --- a/drivers/video/sh_mipi_dsi.c
> +++ b/drivers/video/sh_mipi_dsi.c
> @@ -386,6 +386,14 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
>  			  pixfmt << 4);
>  	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
> 
> +	/*
> +	 * extra dcs settings for platform
> +	 */
> +	if (pdata->set_dcs)
> +		pdata->set_dcs(ch->chan,
> +			       sh_mipi_dcs,
> +			       sh_mipi_dcs_param);
> +
>  	/* Enable timeout counters */
>  	iowrite32(0x00000f00, base + DSICTRL);
> 
> diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
> index 434d56b..6e1f7bc 100644
> --- a/include/video/sh_mipi_dsi.h
> +++ b/include/video/sh_mipi_dsi.h
> @@ -52,6 +52,9 @@ struct sh_mipi_dsi_info {
>  	unsigned long			flags;
>  	u32				clksrc;
>  	unsigned int			vsynw_offset;
> +	void (*set_dcs)(int handle,
> +			int (*mipi_dcs)(int handle, u8 cmd),
> +			int (*mipi_dcs_param)(int handle, u8 cmd, u8 param));

I don't think this is a good idea. First of all, we should reduce the number 
of board code callbacks to make transition to the device tree easier. Then, 
passing two functions to board code to read and write any device register 
without the driver having any knowledge about that is a clear violation of the 
device model, and will result in problems sooner or later.

What MIPI settings do platforms need to modify ? Can those settings be 
expressed as data in the sh_mipi_dsi_info structure instead ?

>  	int	(*set_dot_clock)(struct platform_device *pdev,
>  				 void __iomem *base,
>  				 int enable);

-- 
Regards,

Laurent Pinchart
