From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 19 Nov 2012 08:33:39 +0000
Subject: Re: [PATCH] video: Kconfig: Specify the SoCs that make use of FB_IMX
Message-Id: <20121119083339.GB10369@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353182050-13338-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1353182050-13338-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Nov 17, 2012 at 05:54:10PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> FB_IMX is the framebuffer driver used by MX25 and MX27 processors.
> 
> Pass this information to the Kconfig text to make it clear.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
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
> +	tristate "Freescale i.MX25/27 LCD support"

i.MX1 and i.MX21 use this driver aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
