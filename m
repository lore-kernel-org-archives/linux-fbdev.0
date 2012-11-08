From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 08 Nov 2012 00:58:19 +0000
Subject: Re: [PATCH 2/2] video: exynos_dp: move exynos_dp_config_video to a workqueue
Message-Id: <001501cdbd4c$248320f0$6d8962d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352286744-22588-2-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1352286744-22588-2-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, November 07, 2012 8:12 PM Ajay Kumar wrote
> 
> This speeds up boot significantly, since it can take up to a second to
> get the display up and going, and we want to keep on booting (through
> some userspace) while that happens.

This patch is not necessary.
The exynos_dp_config_video was already moved by Sean Paul's patch.
(http://www.spinics.net/lists/linux-fbdev/msg08555.html)
This patch including other Sean Paul's patches, will be merged to 3.8-rc1.


> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/video/exynos/exynos_dp_core.c |   30 ++++++++++++++++++------------
>  drivers/video/exynos/exynos_dp_core.h |    1 +
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index f62778c..ecae6f4 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/workqueue.h>
> 
>  #include <video/exynos_dp.h>
> 
> @@ -752,19 +753,22 @@ static int exynos_dp_set_link_train(struct exynos_dp_device *dp,
>  	return retval;
>  }
> 
> -static int exynos_dp_config_video(struct exynos_dp_device *dp)
> +static void exynos_dp_config_video(struct work_struct *work)
>  {
> +	struct exynos_dp_device *dp;
>  	int retval = 0;
>  	int timeout_loop = 0;
>  	int done_count = 0;
> 
> +	dp = container_of(work, struct exynos_dp_device, config_work);
> +
>  	exynos_dp_config_video_slave_mode(dp);
> 
>  	exynos_dp_set_video_color_format(dp);
> 
>  	if (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
>  		dev_err(dp->dev, "PLL is not locked yet.\n");
> -		return -EINVAL;
> +		return;
>  	}
> 
>  	for (;;) {
> @@ -773,7 +777,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp)
>  			break;
>  		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>  			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> -			return -ETIMEDOUT;
> +			return;
>  		}
> 
>  		usleep_range(1, 2);
> @@ -807,7 +811,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp)
>  		}
>  		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>  			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> -			return -ETIMEDOUT;
> +			return;
>  		}
> 
>  		usleep_range(1000, 1001);
> @@ -815,8 +819,6 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp)
> 
>  	if (retval != 0)
>  		dev_err(dp->dev, "Video stream is not detected!\n");
> -
> -	return retval;
>  }
> 
>  static void exynos_dp_enable_scramble(struct exynos_dp_device *dp, bool enable)
> @@ -933,11 +935,9 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> 
>  	exynos_dp_init_video(dp);
> -	ret = exynos_dp_config_video(dp);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to config video\n");
> -		return ret;
> -	}
> +
> +	INIT_WORK(&dp->config_work, exynos_dp_config_video);
> +	schedule_work(&dp->config_work);
> 
>  	platform_set_drvdata(pdev, dp);
> 
> @@ -949,6 +949,9 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>  	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>  	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> +	if (work_pending(&dp->config_work))
> +		flush_work_sync(&dp->config_work);
> +
>  	if (pdata && pdata->phy_exit)
>  		pdata->phy_exit();
> 
> @@ -964,6 +967,9 @@ static int exynos_dp_suspend(struct device *dev)
>  	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>  	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> +	if (work_pending(&dp->config_work))
> +		flush_work_sync(&dp->config_work);
> +
>  	if (pdata && pdata->phy_exit)
>  		pdata->phy_exit();
> 
> @@ -999,7 +1005,7 @@ static int exynos_dp_resume(struct device *dev)
>  	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> 
>  	exynos_dp_init_video(dp);
> -	exynos_dp_config_video(dp);
> +	schedule_work(&dp->config_work);
> 
>  	return 0;
>  }
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 1e646d7..303831d 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -32,6 +32,7 @@ struct exynos_dp_device {
> 
>  	struct video_info	*video_info;
>  	struct link_train	link_train;
> +	struct work_struct	config_work;
>  };
> 
>  /* exynos_dp_reg.c */
> --
> 1.7.0.4

