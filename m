From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 20 May 2015 07:05:40 +0000
Subject: Re: [PATCH] video: exynos: fix modular build
Message-Id: <1432105540.21715.26.camel@x220>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2708563.ADEZz3igC5@wuerfel>
In-Reply-To: <2708563.ADEZz3igC5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2015-05-19 at 14:17 +0200, Arnd Bergmann wrote:
> Finally, the EXYNOS_VIDEO option is turned into tristate as well
> for good measure, as all framebuffer drivers should be configurable
> as modules.

EXYNOS_MIPI_DSI and EXYNOS_LCD_S6E8AX0 are made tristate too. And that
is, I think, what counts. See below.

For anyone wondering how these two drivers can be made modular with only
a few tweaks to the build system: that is because exynos_mipi_dsi.c and
s6e8ax0.c already contain module specific boilerplate. They probably
already contained that boilerplate when they were added three years ago.
(Perhaps the changelog should mention this.)

> --- a/drivers/video/fbdev/exynos/Kconfig
> +++ b/drivers/video/fbdev/exynos/Kconfig

>  menuconfig EXYNOS_VIDEO
> -	bool "Exynos Video driver support"
> +	tristate "Exynos Video driver support"
>  	depends on ARCH_S5PV210 || ARCH_EXYNOS
>  	help
>  	  This enables support for EXYNOS Video device.

I have tested this only lightly but I do think this hunk is not needed.
Because basically all that this entry does is making EXYNOS_MIPI_DSI and
EXYNOS_LCD_S6E8AX0 available. And that works just as well if it's a
bool. Correct?

>  config EXYNOS_MIPI_DSI
> -	bool "EXYNOS MIPI DSI driver support."
> +	tristate "EXYNOS MIPI DSI driver support."
>  	select GENERIC_PHY
>  	help
>  	  This enables support for MIPI-DSI device.
>  
>  config EXYNOS_LCD_S6E8AX0
> -	bool "S6E8AX0 MIPI AMOLED LCD Driver"
> +	tristate "S6E8AX0 MIPI AMOLED LCD Driver"
>  	depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
>  	depends on (LCD_CLASS_DEVICE = y)
>  	default n

> --- a/drivers/video/fbdev/exynos/Makefile
> +++ b/drivers/video/fbdev/exynos/Makefile

> -obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> -				     	exynos_mipi_dsi_lowlevel.o
> +obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos-mipi-dsi-mod.o
> +
> +exynos-mipi-dsi-mod-objs		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> +					   exynos_mipi_dsi_lowlevel.o

I don't speak Makefilese fluently, so I have to ask. Is the -mod
extension needed because a module built from multiple files can't have a
name that matches the name of one of its .c files (minus the .c
extension, of course)?

>  obj-$(CONFIG_EXYNOS_LCD_S6E8AX0)	+= s6e8ax0.o

Thanks,


Paul Bolle

