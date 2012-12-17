From: Donghwa Lee <dh09.lee@samsung.com>
Date: Mon, 17 Dec 2012 01:31:20 +0000
Subject: Re: [PATCH] video: exynos_mipi_dsi: Add missing mutex_unlock
Message-Id: <50CE75E8.1010102@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000801cdd9d5$a9536a10$fbfa3e30$%choi@samsung.com>
In-Reply-To: <000801cdd9d5$a9536a10$fbfa3e30$%choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

  On Fri, Dec 14, 2012 at 17:33, Jonghwan Choi wrote:
> Add a mutex_unlock on the error path.
>
> Signed-off-by: Jonghwan Choi<jhbird.choi@samsung.com>
> ---
>   drivers/video/exynos/exynos_mipi_dsi_common.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
> b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index 3cd29a4..bd7f4f2 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -377,6 +377,7 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device
> *dsim, unsigned int data_id,
>   			"data id %x is not supported current DSI spec.\n",
>   			data_id);
>   
> +		mutex_unlock(&dsim->lock);
>   		return -EINVAL;
>   	}
>   
It looks good to me.

Acked-by: Donghwa Lee <dh09.lee@samsung.com>

Thank you,
Donghwa Lee
