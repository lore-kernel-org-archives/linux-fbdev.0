From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 17 Jan 2019 16:19:08 +0000
Subject: Re: [PATCH v2 1/2] video: lcd: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
Message-Id: <20190117161908.4fd2lx62m5soqrff@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
In-Reply-To: <20190117133336.19737-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, Jan 17, 2019 at 04:33:35PM +0300, Alexander Shiyan wrote:
> We have two *_CLASS_DEVICE kernel config options (LCD_CLASS_DEVICE
> and BACKLIGHT_LCD_DEVICE) that do the same job.
> The patch removes useless BACKLIGHT_LCD_SUPPORT option
> and converts LCD_CLASS_DEVICE into a menu.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

A cover letter with the v1 -> v2 changelog would be nice... but
nevertheless:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/unicore32/Kconfig            |  1 -
>  drivers/gpu/drm/Kconfig           |  2 --
>  drivers/gpu/drm/bridge/Kconfig    |  1 -
>  drivers/gpu/drm/fsl-dcu/Kconfig   |  1 -
>  drivers/gpu/drm/i915/Kconfig      |  1 -
>  drivers/gpu/drm/nouveau/Kconfig   |  2 --
>  drivers/gpu/drm/shmobile/Kconfig  |  1 -
>  drivers/gpu/drm/tilcdc/Kconfig    |  1 -
>  drivers/staging/olpc_dcon/Kconfig |  1 -
>  drivers/usb/misc/Kconfig          |  1 -
>  drivers/video/backlight/Kconfig   | 10 ++--------
>  drivers/video/fbdev/Kconfig       |  5 -----
>  12 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index c3a41bf..1138334 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -195,7 +195,6 @@ config I2C_EEPROM_AT24
>  
>  config LCD_BACKLIGHT
>  	tristate "LCD Backlight support"
> -	select BACKLIGHT_LCD_SUPPORT
>  	select BACKLIGHT_PWM
>  
>  endmenu
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 4385f00..ef442a7 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -198,7 +198,6 @@ config DRM_RADEON
>  	select POWER_SUPPLY
>  	select HWMON
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	select INTERVAL_TREE
>  	help
>  	  Choose this option if you have an ATI Radeon graphics card.  There
> @@ -219,7 +218,6 @@ config DRM_AMDGPU
>  	select POWER_SUPPLY
>  	select HWMON
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	select INTERVAL_TREE
>  	select CHASH
>  	help
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b..5b5a8e5 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -75,7 +75,6 @@ config DRM_PARADE_PS8622
>  	depends on OF
>  	select DRM_PANEL
>  	select DRM_KMS_HELPER
> -	select BACKLIGHT_LCD_SUPPORT
>  	select BACKLIGHT_CLASS_DEVICE
>  	---help---
>  	  Parade eDP-LVDS bridge chip driver.
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index 14a72c4..dc82588 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -2,7 +2,6 @@ config DRM_FSL_DCU
>  	tristate "DRM Support for Freescale DCU"
>  	depends on DRM && OF && ARM && COMMON_CLK
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_PANEL
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 148be8e..3d5f1cb 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -15,7 +15,6 @@ config DRM_I915
>  	select IRQ_WORK
>  	# i915 depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> -	select BACKLIGHT_LCD_SUPPORT if ACPI
>  	select BACKLIGHT_CLASS_DEVICE if ACPI
>  	select INPUT if ACPI
>  	select ACPI_VIDEO if ACPI
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 432c440..fd7b869 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -5,14 +5,12 @@ config DRM_NOUVEAU
>  	select DRM_KMS_HELPER
>  	select DRM_TTM
>  	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> -	select BACKLIGHT_LCD_SUPPORT if DRM_NOUVEAU_BACKLIGHT
>  	select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
>  	select X86_PLATFORM_DEVICES if ACPI && X86
>  	select ACPI_WMI if ACPI && X86
>  	select MXM_WMI if ACPI && X86
>  	select POWER_SUPPLY
>  	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
> -	select BACKLIGHT_LCD_SUPPORT if ACPI && X86
>  	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
>  	select INPUT if ACPI && X86
>  	select THERMAL if ACPI && X86
> diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
> index 61bbe8e..e2a6c82 100644
> --- a/drivers/gpu/drm/shmobile/Kconfig
> +++ b/drivers/gpu/drm/shmobile/Kconfig
> @@ -4,7 +4,6 @@ config DRM_SHMOBILE
>  	depends on DRM && ARM
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER
> diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
> index 5259804..cb7df20 100644
> --- a/drivers/gpu/drm/tilcdc/Kconfig
> +++ b/drivers/gpu/drm/tilcdc/Kconfig
> @@ -8,7 +8,6 @@ config DRM_TILCDC
>  	select DRM_PANEL_BRIDGE
>  	select VIDEOMODE_HELPERS
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	help
>  	  Choose this option if you have an TI SoC with LCDC display
>  	  controller, for example AM33xx in beagle-bone, DA8xx, or
> diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
> index 192cc8d..c91a56f 100644
> --- a/drivers/staging/olpc_dcon/Kconfig
> +++ b/drivers/staging/olpc_dcon/Kconfig
> @@ -2,7 +2,6 @@ config FB_OLPC_DCON
>  	tristate "One Laptop Per Child Display CONtroller support"
>  	depends on OLPC && FB
>  	depends on I2C
> -	depends on BACKLIGHT_LCD_SUPPORT
>  	depends on (GPIO_CS5535 || GPIO_CS5535=n)
>  	select BACKLIGHT_CLASS_DEVICE
>  	help
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 68d2f2c..a86a80b 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -141,7 +141,6 @@ config USB_FTDI_ELAN
>  
>  config USB_APPLEDISPLAY
>  	tristate "Apple Cinema Display support"
> -	select BACKLIGHT_LCD_SUPPORT
>  	select BACKLIGHT_CLASS_DEVICE
>  	help
>  	  Say Y here if you want to control the backlight of Apple Cinema
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 71ee978..3fdc18e 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -2,13 +2,7 @@
>  # Backlight & LCD drivers configuration
>  #
>  
> -menuconfig BACKLIGHT_LCD_SUPPORT
> -	bool "Backlight & LCD device support"
> -	help
> -	  Enable this to be able to choose the drivers for controlling the
> -	  backlight and the LCD panel on some platforms, for example on PDAs.
> -
> -if BACKLIGHT_LCD_SUPPORT
> +menu "Backlight & LCD device support"
>  
>  #
>  # LCD
> @@ -466,4 +460,4 @@ config BACKLIGHT_RAVE_SP
>  
>  endif # BACKLIGHT_CLASS_DEVICE
>  
> -endif # BACKLIGHT_LCD_SUPPORT
> +endmenu
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index ae7712c..7b5c404 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -186,7 +186,6 @@ config FB_MACMODES
>  config FB_BACKLIGHT
>  	tristate
>  	depends on FB
> -	select BACKLIGHT_LCD_SUPPORT
>  	select BACKLIGHT_CLASS_DEVICE
>  
>  config FB_MODE_HELPERS
> @@ -281,7 +280,6 @@ config FB_ARMCLCD
>  	select FB_CFB_IMAGEBLIT
>  	select FB_MODE_HELPERS if OF
>  	select VIDEOMODE_HELPERS if OF
> -	select BACKLIGHT_LCD_SUPPORT if OF
>  	select BACKLIGHT_CLASS_DEVICE if OF
>  	help
>  	  This framebuffer device driver is for the ARM PrimeCell PL110
> @@ -315,7 +313,6 @@ config FB_ACORN
>  config FB_CLPS711X
>  	tristate "CLPS711X LCD support"
>  	depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
> -	select BACKLIGHT_LCD_SUPPORT
>  	select FB_MODE_HELPERS
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
> @@ -343,7 +340,6 @@ config FB_SA1100
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
>  	depends on FB && ARCH_MXC
> -	select BACKLIGHT_LCD_SUPPORT
>  	select LCD_CLASS_DEVICE
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
> @@ -2192,7 +2188,6 @@ config FB_MX3
>  	tristate "MX3 Framebuffer support"
>  	depends on FB && MX3_IPU
>  	select BACKLIGHT_CLASS_DEVICE
> -	select BACKLIGHT_LCD_SUPPORT
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 2.10.2
> 
