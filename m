From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 May 2020 00:44:51 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <9b0db95949b973c682b449906573e7b28c6113ef.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
In-Reply-To: <20200517220524.4036334-2-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Sun, 2020-05-17 at 23:05 +0100, Emil Velikov wrote:
> As mentioned in earlier commit, the riva and nvidia fbdev drivers
> have
> seen no love over the years, are short on features and overall below
> par
> 
> Users are encouraged to switch to the nouveau drm driver instead.
> 
> v2: Split configs to separate patch, enable nouveau (Bartlomiej)

Back when I still had these things to play with (years ago) nouveau
didn't work properly on these ancient machines.

Cheers,
Ben.

> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
> ---
> Hi all unless, there are objections I would prefer to merge this via
> the drm tree.
> 
> Thanks
> Emil
> ---
>  arch/powerpc/configs/g5_defconfig     | 10 ++++++++--
>  arch/powerpc/configs/pasemi_defconfig |  9 +++++++--
>  arch/powerpc/configs/pmac32_defconfig |  9 +++++++--
>  arch/powerpc/configs/ppc6xx_defconfig | 10 +++++++---
>  4 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/configs/g5_defconfig
> b/arch/powerpc/configs/g5_defconfig
> index a68c7f3af10e..213472f373b3 100644
> --- a/arch/powerpc/configs/g5_defconfig
> +++ b/arch/powerpc/configs/g5_defconfig
> @@ -124,12 +124,18 @@ CONFIG_RAW_DRIVER=y
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_AGP=m
>  CONFIG_AGP_UNINORTH=m
> +CONFIG_DRM=y
> +CONFIG_DRM_NOUVEAU=m
> +# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG_MMU is not set
> +CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> +# CONFIG_DRM_NOUVEAU_SVM is not set
>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_TILEBLITTING=y
>  CONFIG_FB_OF=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_RADEON=y
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> diff --git a/arch/powerpc/configs/pasemi_defconfig
> b/arch/powerpc/configs/pasemi_defconfig
> index 08b7f4cef243..ccb3ab5e01da 100644
> --- a/arch/powerpc/configs/pasemi_defconfig
> +++ b/arch/powerpc/configs/pasemi_defconfig
> @@ -102,11 +102,16 @@ CONFIG_SENSORS_LM85=y
>  CONFIG_SENSORS_LM90=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
> +CONFIG_DRM_NOUVEAU=m
> +# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG_MMU is not set
> +CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> +# CONFIG_DRM_NOUVEAU_SVM is not set
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_TILEBLITTING=y
>  CONFIG_FB_VGA16=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_RADEON=y
>  # CONFIG_LCD_CLASS_DEVICE is not set
>  CONFIG_VGACON_SOFT_SCROLLBACK=y
> diff --git a/arch/powerpc/configs/pmac32_defconfig
> b/arch/powerpc/configs/pmac32_defconfig
> index 05e325ca3fbd..f858627385c8 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -199,6 +199,13 @@ CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_LEGACY=y
>  CONFIG_DRM_R128=m
> +CONFIG_DRM_NOUVEAU=m
> +# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG_MMU is not set
> +CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> +# CONFIG_DRM_NOUVEAU_SVM is not set
>  CONFIG_FB=y
>  CONFIG_FB_OF=y
>  CONFIG_FB_CONTROL=y
> @@ -206,8 +213,6 @@ CONFIG_FB_PLATINUM=y
>  CONFIG_FB_VALKYRIE=y
>  CONFIG_FB_CT65550=y
>  CONFIG_FB_IMSTT=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
>  CONFIG_FB_MATROX=y
>  CONFIG_FB_MATROX_MILLENIUM=y
>  CONFIG_FB_MATROX_MYSTIQUE=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig
> b/arch/powerpc/configs/ppc6xx_defconfig
> index feb5d47d8d1e..48421f5007ed 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -738,15 +738,19 @@ CONFIG_DRM_MGA=m
>  CONFIG_DRM_SIS=m
>  CONFIG_DRM_VIA=m
>  CONFIG_DRM_SAVAGE=m
> +CONFIG_DRM_NOUVEAU=m
> +# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG_MMU is not set
> +CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> +# CONFIG_DRM_NOUVEAU_SVM is not set
>  CONFIG_FB=y
>  CONFIG_FB_CIRRUS=m
>  CONFIG_FB_OF=y
>  CONFIG_FB_PLATINUM=y
>  CONFIG_FB_VALKYRIE=y
>  CONFIG_FB_CT65550=y
> -CONFIG_FB_NVIDIA=y
> -CONFIG_FB_NVIDIA_I2C=y
> -CONFIG_FB_RIVA=m
>  CONFIG_FB_MATROX=y
>  CONFIG_FB_MATROX_MILLENIUM=y
>  CONFIG_FB_MATROX_MYSTIQUE=y
