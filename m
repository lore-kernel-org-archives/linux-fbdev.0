From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:52:42 +0000
Subject: Re: [PATCH] video: EXYNOS: changes mipi dsi regulator name from vdd10 to vdd11
Message-Id: <4FB01F1A.5030204@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FA71563.5050401@samsung.com>
In-Reply-To: <4FA71563.5050401@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/07/2012 12:20 AM, Donghwa Lee wrote:
> MIPI DSI uses 1.1v regulator, so change its supply name.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 95e33f0..2e779d3 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -58,7 +58,7 @@ static struct mipi_dsim_platform_data *to_dsim_plat(struct platform_device
>  }
>  
>  static struct regulator_bulk_data supplies[] = {
> -	{ .supply = "vdd10", },
> +	{ .supply = "vdd11", },
>  	{ .supply = "vdd18", },
>  };
>  

