From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 05 Mar 2012 15:11:27 +0000
Subject: Re: [PATCH] fbdev: remove "default y" from FB_SH_MOBILE_MERAM
Message-Id: <6558972.58UQFYlcLG@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nu7bcd3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nu7bcd3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

Thanks for the patch.

On Friday 02 March 2012 01:06:53 Kuninori Morimoto wrote:
> "default y" of FB_SH_MOBILE_MERAM was overkill option.
> "depends on FB_SH_MOBILE_LCDC" is very enough here.

Actually the sh_mobile_meram driver doesn't depend on the LCDC driver. What 
would you think about removing both the dependency and the default=y ?

> This patch remove it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/video/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 549b960..dfec9b7 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1994,7 +1994,6 @@ config FB_SH_MOBILE_HDMI
>  config FB_SH_MOBILE_MERAM
>  	tristate "SuperH Mobile MERAM read ahead support for LCDC"
>  	depends on FB_SH_MOBILE_LCDC
> -	default y
>  	---help---
>  	  Enable MERAM support for the SH-Mobile LCD controller.

-- 
Regards,

Laurent Pinchart

