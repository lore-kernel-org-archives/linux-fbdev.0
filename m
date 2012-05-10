From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:20:39 +0000
Subject: Re: [PATCH] video: EXYNOS: enable interrupt again after sw reset
Message-Id: <4FAB09D7.7010404@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FA3622A.7060401@samsung.com>
In-Reply-To: <4FA3622A.7060401@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/04/2012 04:59 AM, Donghwa Lee wrote:
> When exynos_mipi_update_cfg() is called, mipi dsi registers were become
> sw reset. So, It needs to enable interrupt again.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 557091d..49c7351 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -102,6 +102,8 @@ static void exynos_mipi_update_cfg(struct mipi_dsim_device *dsim)
>  	/* set display timing. */
>  	exynos_mipi_dsi_set_display_mode(dsim, dsim->dsim_config);
>  
> +	exynos_mipi_dsi_init_interrupt(dsim);
> +
>  	/*
>  	 * data from Display controller(FIMD) is transferred in video mode
>  	 * but in case of command mode, all settigs is updated to registers.

