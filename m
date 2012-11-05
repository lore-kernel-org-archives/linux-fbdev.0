From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 05 Nov 2012 02:47:04 +0000
Subject: Re: video: exynos_dp: Reset and initialize DP before requesting irq
Message-Id: <001b01cdbaff$d6c05c50$844114f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351926402-25484-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1351926402-25484-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Saturday, November 03, 2012 4:07 PM Ajay Kumar wrote
> Subject: video: exynos_dp: Reset and initialize DP before requesting irq

Please don't forget to add "[PATCH] " as below.

[PATCH] video: exynos_dp: Reset and initialize DP before requesting irq

> 
> If DP is not reset properly before kernel bootup(in bootloader code),
> there can be few pending interrupts, and sometimes they invoke
> DP irq handler as soon as the irq handler is registered in DP probe.
> So, we make the DP driver more robust by resetting and
> initializing DP at the earliest and then registering the irq handler.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Tested with Exynos5250.

> ---
>  drivers/video/exynos/exynos_dp_core.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index d55470e..d241fd3 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -901,6 +901,12 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> +	dp->video_info = pdata->video_info;
> +	if (pdata->phy_init)
> +		pdata->phy_init();
> +
> +	exynos_dp_init_dp(dp);
> +
>  	ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler, 0,
>  				"exynos-dp", dp);
>  	if (ret) {
> @@ -908,12 +914,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> 
> -	dp->video_info = pdata->video_info;
> -	if (pdata->phy_init)
> -		pdata->phy_init();
> -
> -	exynos_dp_init_dp(dp);
> -
>  	ret = exynos_dp_detect_hpd(dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to detect hpd\n");
> --
> 1.7.0.4

