From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 10 Oct 2012 12:35:12 +0000
Subject: Re: [PATCH] video: exynos_dp: use clk_prepare_enable and clk_disable_unprepare
Message-Id: <50756B80.7080306@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <006701cda1fb$cee12fe0$6ca38fa0$%han@samsung.com>
In-Reply-To: <006701cda1fb$cee12fe0$6ca38fa0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Thomas Abraham' <thomas.abraham@linaro.org>

On 10/04/2012 06:45 AM, Jingoo Han wrote:
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat


> ---
>  drivers/video/exynos/exynos_dp_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index cdc1398..d55470e 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -885,7 +885,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  		return PTR_ERR(dp->clock);
>  	}
>  
> -	clk_enable(dp->clock);
> +	clk_prepare_enable(dp->clock);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> @@ -956,7 +956,7 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>  	if (pdata && pdata->phy_exit)
>  		pdata->phy_exit();
>  
> -	clk_disable(dp->clock);
> +	clk_disable_unprepare(dp->clock);
>  
>  	return 0;
>  }
> @@ -971,7 +971,7 @@ static int exynos_dp_suspend(struct device *dev)
>  	if (pdata && pdata->phy_exit)
>  		pdata->phy_exit();
>  
> -	clk_disable(dp->clock);
> +	clk_disable_unprepare(dp->clock);
>  
>  	return 0;
>  }
> @@ -985,7 +985,7 @@ static int exynos_dp_resume(struct device *dev)
>  	if (pdata && pdata->phy_init)
>  		pdata->phy_init();
>  
> -	clk_enable(dp->clock);
> +	clk_prepare_enable(dp->clock);
>  
>  	exynos_dp_init_dp(dp);
>  

