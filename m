From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 01 Aug 2012 22:59:46 +0000
Subject: Re: [PATCH v2] video: exynos_dp: use devm_clk_get function
Message-Id: <000e01cd7039$58e08b90$0aa1a2b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <877gti1t48.fsf@gmail.com>
In-Reply-To: <877gti1t48.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Damien Cassou' <damien.cassou@gmail.com>
Cc: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, August 02, 2012 1:21 AM Damien Cassou wrote:
> 
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The devm_clk_get function allocates memory that is released when a driver
> detaches. This patch uses this function for data that is allocated in the probe
> function of a platform device and is only freed in the remove function.
> 
> Additionally, this patch removes a null check after platform_get_resource that
> is redundant with the one done by devm_request_and_ioremap.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Thank you for sending the patch.

Best regards,
Jingoo Han

> 
> ---
> Changed subject line and description
>  drivers/video/exynos/exynos_dp_core.c |   27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index c6c016a..00fe4f0 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -872,7 +872,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> 
>  	dp->dev = &pdev->dev;
> 
> -	dp->clock = clk_get(&pdev->dev, "dp");
> +	dp->clock = devm_clk_get(&pdev->dev, "dp");
>  	if (IS_ERR(dp->clock)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		return PTR_ERR(dp->clock);
> @@ -881,31 +881,24 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	clk_enable(dp->clock);
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to get registers\n");
> -		ret = -EINVAL;
> -		goto err_clock;
> -	}
> 
>  	dp->reg_base = devm_request_and_ioremap(&pdev->dev, res);
>  	if (!dp->reg_base) {
>  		dev_err(&pdev->dev, "failed to ioremap\n");
> -		ret = -ENOMEM;
> -		goto err_clock;
> +		return -ENOMEM;
>  	}
> 
>  	dp->irq = platform_get_irq(pdev, 0);
>  	if (!dp->irq) {
>  		dev_err(&pdev->dev, "failed to get irq\n");
> -		ret = -ENODEV;
> -		goto err_clock;
> +		return -ENODEV;
>  	}
> 
>  	ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler, 0,
>  				"exynos-dp", dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request irq\n");
> -		goto err_clock;
> +		return ret;
>  	}
> 
>  	dp->video_info = pdata->video_info;
> @@ -917,7 +910,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	ret = exynos_dp_detect_hpd(dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to detect hpd\n");
> -		goto err_clock;
> +		return ret;
>  	}
> 
>  	exynos_dp_handle_edid(dp);
> @@ -926,7 +919,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  				dp->video_info->link_rate);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to do link train\n");
> -		goto err_clock;
> +		return ret;
>  	}
> 
>  	exynos_dp_enable_scramble(dp, 1);
> @@ -940,17 +933,12 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	ret = exynos_dp_config_video(dp, dp->video_info);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to config video\n");
> -		goto err_clock;
> +		return ret;
>  	}
> 
>  	platform_set_drvdata(pdev, dp);
> 
>  	return 0;
> -
> -err_clock:
> -	clk_put(dp->clock);
> -
> -	return ret;
>  }
> 
>  static int __devexit exynos_dp_remove(struct platform_device *pdev)
> @@ -962,7 +950,6 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>  		pdata->phy_exit();
> 
>  	clk_disable(dp->clock);
> -	clk_put(dp->clock);
> 
>  	return 0;
>  }

