From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 19 Nov 2012 19:23:43 +0000
Subject: Re: [PATCH v2] video: Kconfig: Specify the SoCs that make use of FB_IMX
Message-Id: <20121119192343.GX10369@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353335821-30283-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1353335821-30283-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 19, 2012 at 12:37:01PM -0200, Fabio Estevam wrote:
> FB_IMX is the framebuffer driver used by MX1, MX21, MX25 and MX27 processors.
> 
> Pass this information to the Kconfig text to make it clear.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Changes since v1:
> - Add mx1/21 to the list.
> 
>  drivers/video/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0cff083..f0c53b2 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -364,7 +364,7 @@ config FB_SA1100
>  	  Y here.
>  
>  config FB_IMX
> -	tristate "Freescale i.MX LCD support"
> +	tristate "Freescale i.MX1/21/25/27 LCD support"
>  	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
