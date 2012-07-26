From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 26 Jul 2012 17:22:03 +0000
Subject: Re: [PATCH] video: exynos_dp: use usleep_range instead of delay
Message-Id: <50117CBB.1080906@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002201cd64ca$d5bbabb0$81330310$%han@samsung.com>
In-Reply-To: <002201cd64ca$d5bbabb0$81330310$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/18/2012 09:50 AM, Jingoo Han wrote:
> This patch replaces udelay and mdelay with usleep_range to remove
> the busy loop waiting.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_core.c |   14 +++++++-------
>  drivers/video/exynos/exynos_dp_reg.c  |    4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 9db7b9f..25907f4 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -47,7 +47,7 @@ static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
>  
>  	exynos_dp_init_hpd(dp);
>  
> -	udelay(200);
> +	usleep_range(200, 210);
>  
>  	while (exynos_dp_get_plug_in_status(dp) != 0) {
>  		timeout_loop++;
> @@ -55,7 +55,7 @@ static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
>  			dev_err(dp->dev, "failed to get hpd plug status\n");
>  			return -ETIMEDOUT;
>  		}
> -		udelay(10);
> +		usleep_range(10, 11);
>  	}
>  
>  	return 0;
> @@ -486,7 +486,7 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>  	u8 pre_emphasis;
>  	u8 training_lane;
>  
> -	udelay(100);
> +	usleep_range(100, 101);
>  
>  	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
>  				6, link_status);
> @@ -571,7 +571,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>  
>  	u8 adjust_request[2];
>  
> -	udelay(400);
> +	usleep_range(400, 401);
>  
>  	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
>  				6, link_status);
> @@ -739,7 +739,7 @@ static int exynos_dp_set_link_train(struct exynos_dp_device *dp,
>  		if (retval = 0)
>  			break;
>  
> -		udelay(100);
> +		usleep_range(100, 110);
>  	}
>  
>  	return retval;
> @@ -773,7 +773,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp,
>  			return -ETIMEDOUT;
>  		}
>  
> -		udelay(1);
> +		usleep_range(1, 2);
>  	}
>  
>  	/* Set to use the register calculated M/N video */
> @@ -807,7 +807,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp,
>  			return -ETIMEDOUT;
>  		}
>  
> -		mdelay(1);
> +		usleep_range(1000, 1001);
>  	}
>  
>  	if (retval != 0)
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 6ce76d5..ce401c8 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -122,7 +122,7 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
>  		LS_CLK_DOMAIN_FUNC_EN_N;
>  	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
>  
> -	udelay(20);
> +	usleep_range(20, 30);
>  
>  	exynos_dp_lane_swap(dp, 0);
>  
> @@ -988,7 +988,7 @@ void exynos_dp_reset_macro(struct exynos_dp_device *dp)
>  	writel(reg, dp->reg_base + EXYNOS_DP_PHY_TEST);
>  
>  	/* 10 us is the minimum reset time. */
> -	udelay(10);
> +	usleep_range(10, 20);
>  
>  	reg &= ~MACRO_RST;
>  	writel(reg, dp->reg_base + EXYNOS_DP_PHY_TEST);

