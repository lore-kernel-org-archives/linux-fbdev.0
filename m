From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Apr 2020 16:50:41 +0000
Subject: Re: [PATCH 6/8] drm: decouple from CONFIG_FB
Message-Id: <20200417165041.GA30483@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-7-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: marex@denx.de, linux-renesas-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, dsd@laptop.org, Nicolas Pitre <nico@fluxnic.net>, airlied@linux.ie, masahiroy@kernel.org, jfrederich@gmail.com, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, Andrzej Hajda <a.hajda@samsung.com>, kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org, dri-devel@lists.freedesktop.org, linux-graphics-maintainer@vmware.com, robert.jarzmik@free.fr, Jason Gunthorpe <jgg@ziepe.ca>, daniel@zonque.org, Laurent.pinchart@ideasonboard.com

Hi Arnd.

On Fri, Apr 17, 2020 at 05:55:51PM +0200, Arnd Bergmann wrote:
> CONFIG_DRM_KMS_FB_HELPER selects CONFIG_FB, which is something it
> really should not, to avoid circular dependencies and accidentally
> including potentially dangerous user interfaces in the kernel,
> so change this into a 'depends on' check.
> 
> Two device drivers currently select CONFIG_DRM_KMS_FB_HELPER, but
> as far as I can tell, they do not really need to any more, so those
> selects can be removed.
> 
> This leaves DRM_FBDEV_EMULATION as the only thing that rightfully
> selects CONFIG_DRM_KMS_FB_HELPER, and this now has to depend on
> CONFIG_FB and its dependencies.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/Kconfig       | 5 +++--
>  drivers/gpu/drm/mxsfb/Kconfig | 1 -
>  drivers/gpu/drm/zte/Kconfig   | 1 -
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 43594978958e..7c3109133685 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -80,7 +80,7 @@ config DRM_KMS_HELPER
>  config DRM_KMS_FB_HELPER
>  	bool
>  	depends on DRM_KMS_HELPER
> -	select FB
> +	depends on FB
>  	select FRAMEBUFFER_CONSOLE if !EXPERT
>  	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>  	select FB_SYS_FOPS
> @@ -111,7 +111,8 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>  
>  config DRM_FBDEV_EMULATION
>  	bool "Enable legacy fbdev support for your modesetting driver"
> -	depends on DRM
> +	depends on DRM && FB
> +	depends on FB=y || DRM=m
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_FB_HELPER
>  	default y
This statement:

	depends on DRM && FB

tell us that both symbols must be either y or m. Any combination of y
and m will do the trick


Then we have this statement:

	depends on FB=y || DRM=m

It tells us that either FB equals y or DRM equals m.

So we have following table

	FB	DRM	Result
	n	n	n
	n	y	n
	n	m	n
	y	n	n
	y	y	y
	y	m	y
	m	n	n
	m	y	N
	m	m	y

So what this try to say is that we cannot have FB a module while DRM is
built-in (marked N in the above).

Could you explain in the changelog why this combination is not good.
(Or tell me if my analysis was flawed).

With this fixed (assuming I am right):
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

> diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
> index 0dca8f27169e..33916b7b2c50 100644
> --- a/drivers/gpu/drm/mxsfb/Kconfig
> +++ b/drivers/gpu/drm/mxsfb/Kconfig
> @@ -10,7 +10,6 @@ config DRM_MXSFB
>  	depends on COMMON_CLK
>  	select DRM_MXS
>  	select DRM_KMS_HELPER
> -	select DRM_KMS_FB_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_PANEL
>  	help
> diff --git a/drivers/gpu/drm/zte/Kconfig b/drivers/gpu/drm/zte/Kconfig
> index 90ebaedc11fd..aa8594190b50 100644
> --- a/drivers/gpu/drm/zte/Kconfig
> +++ b/drivers/gpu/drm/zte/Kconfig
> @@ -3,7 +3,6 @@ config DRM_ZTE
>  	tristate "DRM Support for ZTE SoCs"
>  	depends on DRM && ARCH_ZX
>  	select DRM_KMS_CMA_HELPER
> -	select DRM_KMS_FB_HELPER
>  	select DRM_KMS_HELPER
>  	select SND_SOC_HDMI_CODEC if SND_SOC
>  	select VIDEOMODE_HELPERS
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
