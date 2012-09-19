From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 19 Sep 2012 02:24:11 +0000
Subject: RE: [PATCH 1/2] video: exynos_mipi_dsi: Remove unused code
Message-Id: <010601cd960d$db6c6df0$924549d0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347968280-22343-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347968280-22343-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Acked-by: Inki Dae <inki.dae@samsung.com>

> -----Original Message-----
> From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
> Sent: Tuesday, September 18, 2012 8:38 PM
> To: linux-fbdev@vger.kernel.org
> Cc: inki.dae@samsung.com; dh09.lee@samsung.com; FlorianSchandinat@gmx.de;
> sachin.kamat@linaro.org; patches@linaro.org
> Subject: [PATCH 1/2] video: exynos_mipi_dsi: Remove unused code
> 
> This code is never executed and hence removed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/exynos_mipi_dsi_common.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
> b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index 47b533a..7cc4113 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -288,9 +288,6 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device
> *dsim, unsigned int data_id,
>  		mutex_unlock(&dsim->lock);
>  		return -EINVAL;
>  	}
> -
> -	mutex_unlock(&dsim->lock);
> -	return 0;
>  }
> 
>  static unsigned int exynos_mipi_dsi_long_data_rd(struct mipi_dsim_device
> *dsim,
> --
> 1.7.4.1

