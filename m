From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 29 May 2012 15:06:57 +0000
Subject: Re: [PATCH 1/3] video: exynos_dp: use devm_ functions
Message-Id: <4FC4E611.6000906@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001d01cd3a46$e68d8b10$b3a8a130$%han@samsung.com>
In-Reply-To: <001d01cd3a46$e68d8b10$b3a8a130$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Applied all 3 patches.


Thanks,

Florian Tobias Schandinat


On 05/25/2012 07:20 AM, Jingoo Han wrote:
> The devm_ functions allocate memory that is released when a driver
> detaches. This makes the code smaller and a bit simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/exynos/exynos_dp_core.c |   49 ++++++++-------------------------
>  drivers/video/exynos/exynos_dp_core.h |    1 -
>  2 files changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index ef4d1ab..aabd214 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -858,7 +858,8 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	dp = kzalloc(sizeof(struct exynos_dp_device), GFP_KERNEL);
> +	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
> +				GFP_KERNEL);
>  	if (!dp) {
>  		dev_err(&pdev->dev, "no memory for device data\n");
>  		return -ENOMEM;
> @@ -869,8 +870,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	dp->clock = clk_get(&pdev->dev, "dp");
>  	if (IS_ERR(dp->clock)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
> -		ret = PTR_ERR(dp->clock);
> -		goto err_dp;
> +		return PTR_ERR(dp->clock);
>  	}
>  
>  	clk_enable(dp->clock);
> @@ -882,35 +882,25 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  		goto err_clock;
>  	}
>  
> -	res = request_mem_region(res->start, resource_size(res),
> -				dev_name(&pdev->dev));
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to request registers region\n");
> -		ret = -EINVAL;
> -		goto err_clock;
> -	}
> -
> -	dp->res = res;
> -
> -	dp->reg_base = ioremap(res->start, resource_size(res));
> +	dp->reg_base = devm_request_and_ioremap(&pdev->dev, res);
>  	if (!dp->reg_base) {
>  		dev_err(&pdev->dev, "failed to ioremap\n");
>  		ret = -ENOMEM;
> -		goto err_req_region;
> +		goto err_clock;
>  	}
>  
>  	dp->irq = platform_get_irq(pdev, 0);
>  	if (!dp->irq) {
>  		dev_err(&pdev->dev, "failed to get irq\n");
>  		ret = -ENODEV;
> -		goto err_ioremap;
> +		goto err_clock;
>  	}
>  
> -	ret = request_irq(dp->irq, exynos_dp_irq_handler, 0,
> -			"exynos-dp", dp);
> +	ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler, 0,
> +				"exynos-dp", dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request irq\n");
> -		goto err_ioremap;
> +		goto err_clock;
>  	}
>  
>  	dp->video_info = pdata->video_info;
> @@ -922,7 +912,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	ret = exynos_dp_detect_hpd(dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to detect hpd\n");
> -		goto err_irq;
> +		goto err_clock;
>  	}
>  
>  	exynos_dp_handle_edid(dp);
> @@ -931,7 +921,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  				dp->video_info->link_rate);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to do link train\n");
> -		goto err_irq;
> +		goto err_clock;
>  	}
>  
>  	exynos_dp_enable_scramble(dp, 1);
> @@ -945,23 +935,15 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	ret = exynos_dp_config_video(dp, dp->video_info);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to config video\n");
> -		goto err_irq;
> +		goto err_clock;
>  	}
>  
>  	platform_set_drvdata(pdev, dp);
>  
>  	return 0;
>  
> -err_irq:
> -	free_irq(dp->irq, dp);
> -err_ioremap:
> -	iounmap(dp->reg_base);
> -err_req_region:
> -	release_mem_region(res->start, resource_size(res));
>  err_clock:
>  	clk_put(dp->clock);
> -err_dp:
> -	kfree(dp);
>  
>  	return ret;
>  }
> @@ -974,16 +956,9 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>  	if (pdata && pdata->phy_exit)
>  		pdata->phy_exit();
>  
> -	free_irq(dp->irq, dp);
> -	iounmap(dp->reg_base);
> -
>  	clk_disable(dp->clock);
>  	clk_put(dp->clock);
>  
> -	release_mem_region(dp->res->start, resource_size(dp->res));
> -
> -	kfree(dp);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 519c3a6..8f596b9 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -26,7 +26,6 @@ struct link_train {
>  
>  struct exynos_dp_device {
>  	struct device		*dev;
> -	struct resource		*res;
>  	struct clk		*clock;
>  	unsigned int		irq;
>  	void __iomem		*reg_base;

