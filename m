From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 21 Apr 2018 08:01:41 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency
Message-Id: <7367160.RYi9065hmc@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Geert,

Thank you for the patch.

On Friday, 20 April 2018 17:20:51 EEST Geert Uytterhoeven wrote:
> Since commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
> board code"), the only remaining platforms using this driver are SuperH
> SH-Mobile SoCs (sh7723).  As both SUPERH and ARCH_SHMOBILE are set for
> these platforms, the SUPERH dependency can be dropped.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index d94254263ea5caa7..434e95b9320ead05 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2348,7 +2348,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
> 
>  config FB_SH_MOBILE_MERAM
>  	tristate "SuperH Mobile MERAM read ahead support"
> -	depends on (SUPERH || ARCH_SHMOBILE)
> +	depends on ARCH_SHMOBILE
>  	select GENERIC_ALLOCATOR
>  	---help---
>  	  Enable MERAM support for the SuperH controller.


-- 
Regards,

Laurent Pinchart



