From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 21 Sep 2012 06:01:23 +0000
Subject: RE: [PATCH v2 1/2] video: exynos_mipi_dsi: Remove unused code
Message-Id: <005b01cd97be$87993e80$96cbbb80$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348204007-1347-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1348204007-1347-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Acked-by: Inki Dae <inki.dae@samsung.com>

> -----Original Message-----
> From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
> Sent: Friday, September 21, 2012 2:07 PM
> To: linux-fbdev@vger.kernel.org
> Cc: inki.dae@samsung.com; FlorianSchandinat@gmx.de;
> sachin.kamat@linaro.org; patches@linaro.org
> Subject: [PATCH v2 1/2] video: exynos_mipi_dsi: Remove unused code
> 
> This code is never executed and hence removed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> 
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

