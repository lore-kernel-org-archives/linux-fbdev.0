From: Inki Dae <inki.dae@samsung.com>
Date: Thu, 05 Sep 2013 10:00:26 +0000
Subject: RE: [PATCH] video/drm: Drop superfluous "select VT_HW_CONSOLE_BINDING"
Message-Id: <010b01ceaa1e$beba1510$3c2e3f30$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378369230-7786-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1378369230-7786-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> Sent: Thursday, September 05, 2013 5:21 PM
> To: David Herrmann; H. Peter Anvin
> Cc: Inki Dae; David Airlie; Geoff Levand; dri-devel@lists.freedesktop.org;
> linux-fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; Geert
> Uytterhoeven
> Subject: [PATCH] video/drm: Drop superfluous "select
> VT_HW_CONSOLE_BINDING"
> 
> commit 765d5b9c2b72f5b99722cdfcf4bf8f88c556cf92 ("fbdev: fbcon: select
> VT_HW_CONSOLE_BINDING") made FRAMEBUFFER_CONSOLE always select
> VT_HW_CONSOLE_BINDING, but forgot to remove
> 
> 	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
> 
> from the individual drivers' sections that already did this before.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/exynos/Kconfig |    1 -
>  drivers/video/Kconfig          |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/Kconfig
> b/drivers/gpu/drm/exynos/Kconfig
> index 772c62a..1344d34 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -5,7 +5,6 @@ config DRM_EXYNOS
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option if you have a Samsung SoC EXYNOS chipset.
>  	  If M is selected the module will be called exynosdrm.
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 9788340..f60e3fa 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2174,7 +2174,6 @@ config FB_PS3
>  	select FB_SYS_COPYAREA
>  	select FB_SYS_IMAGEBLIT
>  	select FB_SYS_FOPS
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	---help---
>  	  Include support for the virtual frame buffer in the PS3 platform.

Signed-off-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> 
> --
> 1.7.9.5

