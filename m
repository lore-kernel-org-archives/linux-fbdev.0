From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Mar 2012 13:49:04 +0000
Subject: Re: [PATCH v4] fbdev: remove dependency of FB_SH_MOBILE_MERAM from FB_SH_MOBILE_LCDC
Message-Id: <3438840.3my5icGzLr@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87obrqwxp2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obrqwxp2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

On Tuesday 20 March 2012 18:27:08 Kuninori Morimoto wrote:
> MERAM can be used for other IP blocks as well in the future.
> It doesn't necessarily mean that the MERAM driver depends on the LCDC.
> This patch corrects dependency.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
> - move config to before endpoint

As the driver doesn't depend on FB and can also be used by other subsystems, 
would it make sense to move it out of drivers/video/ ? drivers/sh/ might be a 
candidate, although I think selecting a location based on the platform is 
frowned upon (drivers/platform/x86 comes to mind). There's probably a better 
location.

>  drivers/video/Kconfig |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8951cbd..0fb9540 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2013,18 +2013,6 @@ config FB_SH_MOBILE_HDMI
>  	---help---
>  	  Driver for the on-chip SH-Mobile HDMI controller.
> 
> -config FB_SH_MOBILE_MERAM
> -	tristate "SuperH Mobile MERAM read ahead support for LCDC"
> -	depends on FB_SH_MOBILE_LCDC
> -	default y
> -	---help---
> -	  Enable MERAM support for the SH-Mobile LCD controller.
> -
> -	  This will allow for caching of the framebuffer to provide more
> -	  reliable access under heavy main memory bus traffic situations.
> -	  Up to 4 memory channels can be configured, allowing 4 RGB or
> -	  2 YCbCr framebuffers to be configured.
> -
>  config FB_TMIO
>  	tristate "Toshiba Mobile IO FrameBuffer support"
>  	depends on FB && MFD_CORE
> @@ -2434,4 +2422,15 @@ if FB || SGI_NEWPORT_CONSOLE
>  	source "drivers/video/logo/Kconfig"
>  endif
> 
> +config FB_SH_MOBILE_MERAM
> +	tristate "SuperH Mobile MERAM read ahead support"
> +	depends on (SUPERH || ARCH_SHMOBILE)
> +	---help---
> +	  Enable MERAM support for the SuperH controller.
> +
> +	  This will allow for caching of the framebuffer to provide more
> +	  reliable access under heavy main memory bus traffic situations.
> +	  Up to 4 memory channels can be configured, allowing 4 RGB or
> +	  2 YCbCr framebuffers to be configured.
> +
>  endmenu
-- 
Regards,

Laurent Pinchart

