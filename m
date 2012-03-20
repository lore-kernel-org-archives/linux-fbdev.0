From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 20 Mar 2012 00:21:25 +0000
Subject: Re: [PATCH v3] fbdev: remove dependency of FB_SH_MOBILE_MERAM from FB_SH_MOBILE_LCDC
Message-Id: <4F67CD85.1070302@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87d38qwmi9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d38qwmi9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

sorry for taking so long to reply.

On 03/06/2012 01:23 AM, Kuninori Morimoto wrote:
> MERAM can be used for other IP blocks as well in the future.
> It doesn't necessarily mean that the MERAM driver depends on the LCDC.
> This patch corrects dependency.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
> - move config FB_SH_MOBILE_MERAM out of "choice"

I am afraid but this is still not correct. The problem is that after
your patch this config option has no longer any dependency on the
framebuffer subsystem. As "FB" is a menuconfig option I guess the first
config option without any direct or indirect dependency on FB terminates
the menu. As I don't understand how this driver is used I don't know how
I should resolve this: either leave it where it is and just add an
dependency on "FB" or move it even further down, probably just before
endmenu (AFAIK the first thing that breaks it is OMAP2).


Best regards,

Florian Tobias Schandinat

> 
>  drivers/video/Kconfig |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8951cbd..36e8b06 100644
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
> @@ -2332,6 +2320,17 @@ config FB_MB862XX_LIME
>  
>  endchoice
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
>  config FB_MB862XX_I2C
>  	bool "Support I2C bus on MB862XX GDC"
>  	depends on FB_MB862XX && I2C

