From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 14 May 2020 13:28:07 +0000
Subject: Re: [PATCH] fbdev: annotate rivafb/nvidiafb as obsolete
Message-Id: <178a203a-fc3e-0027-60c9-786c3e907407@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200513215627eucas1p1c919a6175b210c13fe7b920c455ebb62@eucas1p1.samsung.com>
 <20200513215342.2145495-1-emil.l.velikov@gmail.com>
In-Reply-To: <20200513215342.2145495-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi!

On 5/13/20 11:53 PM, Emil Velikov wrote:
> Drivers have not seen any love for years.
> 
> Be that fixes or improvements, or cosmetics like introducing symbolic
> names, style and code-flow polish.
> 
> Seemingly the maintainer has also disappeared years ago :-\
> 
> Considering nouveau supports all that hardware (modulo nv03) just mark
> these as obsolete/broken, referring to nouveau in the help text.
> 
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
>  MAINTAINERS                           | 3 +--
>  arch/powerpc/configs/g5_defconfig     | 2 --
>  arch/powerpc/configs/pasemi_defconfig | 2 --
>  arch/powerpc/configs/pmac32_defconfig | 2 --
>  arch/powerpc/configs/ppc6xx_defconfig | 3 ---
>  drivers/video/fbdev/Kconfig           | 6 ++++++
>  6 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 515a81fdb7d6..cc9da9a1e230 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11247,9 +11247,8 @@ F:	include/linux/nubus.h
>  F:	include/uapi/linux/nubus.h
>  
>  NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
> -M:	Antonino Daplas <adaplas@gmail.com>
>  L:	linux-fbdev@vger.kernel.org
> -S:	Maintained
> +S:	Obsolete
>  F:	drivers/video/fbdev/riva/
>  F:	drivers/video/fbdev/nvidia/
>  
> diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
> index ceb3c770786f..24225e39662a 100644
> --- a/arch/powerpc/configs/g5_defconfig
> +++ b/arch/powerpc/configs/g5_defconfig
> @@ -130,8 +130,6 @@ CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_TILEBLITTING=y
>  CONFIG_FB_OF=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_RADEON=y
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
> index c0423b2cf7c0..36b242efae9a 100644
> --- a/arch/powerpc/configs/pasemi_defconfig
> +++ b/arch/powerpc/configs/pasemi_defconfig
> @@ -107,8 +107,6 @@ CONFIG_DRM_RADEON=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_TILEBLITTING=y
>  CONFIG_FB_VGA16=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_RADEON=y
>  # CONFIG_LCD_CLASS_DEVICE is not set
>  CONFIG_VGACON_SOFT_SCROLLBACK=y
> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
> index 50b610b48914..ef4470d44763 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -211,8 +211,6 @@ CONFIG_FB_PLATINUM=y
>  CONFIG_FB_VALKYRIE=y
>  CONFIG_FB_CT65550=y
>  CONFIG_FB_IMSTT=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_MATROX=y
>  CONFIG_FB_MATROX_MILLENIUM=y
>  CONFIG_FB_MATROX_MYSTIQUE=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 7c6baf6df139..5b4e26de0bcf 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -752,9 +752,6 @@ CONFIG_FB_OF=y
>  CONFIG_FB_PLATINUM=y
>  CONFIG_FB_VALKYRIE=y
>  CONFIG_FB_CT65550=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
> -CONFIG_FB_RIVA=m
>  CONFIG_FB_MATROX=y
>  CONFIG_FB_MATROX_MILLENIUM=y
>  CONFIG_FB_MATROX_MYSTIQUE=y

defconfigs should be converted to use the nouveau driver
(in a separate patch please).

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 1b2f5f31fb6f..cad3e4bc5e52 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -868,6 +868,7 @@ config FB_ATMEL
>  
>  config FB_NVIDIA
>  	tristate "nVidia Framebuffer Support"
> +	depends on BROKEN

Please don't add new users of BROKEN config option.

Either it is broken and should be removed right now (BROKEN config option
predates git and with git nothing is ever lost), or it still works and
should be left alone.

>  	depends on FB && PCI
>  	select FB_BACKLIGHT if FB_NVIDIA_BACKLIGHT
>  	select FB_MODE_HELPERS
> @@ -877,6 +878,8 @@ config FB_NVIDIA
>  	select BITREVERSE
>  	select VGASTATE
>  	help
> +	  Obsolete, use nouveau instead.

"nouveau" -> "nouveau DRM driver"

Please also add a runtime warning in the driver probe function with a fixed
date for removal, i.e.:

	pr_warn("Legacy nvidiafb framebuffer driver will be removed in 2022\n
		"Please switch to nouveau DRM driver\n");

> +
>  	  This driver supports graphics boards with the nVidia chips, TNT
>  	  and newer. For very old chipsets, such as the RIVA128, then use
>  	  the rivafb.
> @@ -915,6 +918,7 @@ config FB_NVIDIA_BACKLIGHT
>  
>  config FB_RIVA
>  	tristate "nVidia Riva support"
> +	depends on BROKEN
>  	depends on FB && PCI
>  	select FB_BACKLIGHT if FB_RIVA_BACKLIGHT
>  	select FB_MODE_HELPERS
> @@ -924,6 +928,8 @@ config FB_RIVA
>  	select BITREVERSE
>  	select VGASTATE
>  	help
> +	  Obsolete, use nouveau instead.
> +

ditto

>  	  This driver supports graphics boards with the nVidia Riva/Geforce
>  	  chips.
>  	  Say Y if you have such a graphics board.
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
