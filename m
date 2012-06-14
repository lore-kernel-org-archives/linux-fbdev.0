From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Jun 2012 18:44:31 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: fix a section mismatch
Message-Id: <1847900.HzylUCpON9@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1206140951570.30810@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206140951570.30810@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Thursday 14 June 2012 09:53:33 Guennadi Liakhovetski wrote:
> sh_mipi_setup() is called from a .text function, therefore it cannot be
> __init. Additionally, sh_mipi_remove() can be moved to the .devexit.text
> section.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Would you like me to take the patch in my tree ?

> ---
>  drivers/video/sh_mipi_dsi.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
> index 4c6b844..3951fda 100644
> --- a/drivers/video/sh_mipi_dsi.c
> +++ b/drivers/video/sh_mipi_dsi.c
> @@ -127,8 +127,7 @@ static void sh_mipi_shutdown(struct platform_device
> *pdev) sh_mipi_dsi_enable(mipi, false);
>  }
> 
> -static int __init sh_mipi_setup(struct sh_mipi *mipi,
> -				struct sh_mipi_dsi_info *pdata)
> +static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info
> *pdata) {
>  	void __iomem *base = mipi->base;
>  	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
> @@ -551,7 +550,7 @@ efindslot:
>  	return ret;
>  }
> 
> -static int __exit sh_mipi_remove(struct platform_device *pdev)
> +static int __devexit sh_mipi_remove(struct platform_device *pdev)
>  {
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> @@ -592,7 +591,7 @@ static int __exit sh_mipi_remove(struct platform_device
> *pdev) }
> 
>  static struct platform_driver sh_mipi_driver = {
> -	.remove		= __exit_p(sh_mipi_remove),
> +	.remove		= __devexit_p(sh_mipi_remove),
>  	.shutdown	= sh_mipi_shutdown,
>  	.driver = {
>  		.name	= "sh-mipi-dsi",

-- 
Regards,

Laurent Pinchart

