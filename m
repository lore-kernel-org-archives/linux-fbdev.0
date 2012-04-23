From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 23 Apr 2012 06:15:47 +0000
Subject: Re: [PATCH] video: exynos_dp: check DP PLL Lock status
Message-Id: <4F94F393.3000409@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001401cd1230$7846abc0$68d40340$%han@samsung.com>
In-Reply-To: <001401cd1230$7846abc0$68d40340$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/04/2012 06:59 AM, Jingoo Han wrote:
> DP PLL Lock status should be checked in order to  prevent unlocked PLL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_reg.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index d9c66fd..661d010 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -285,6 +285,7 @@ void exynos_dp_set_analog_power_down(struct exynos_dp_device *dp,
>  void exynos_dp_init_analog_func(struct exynos_dp_device *dp)
>  {
>  	u32 reg;
> +	int timeout_loop = 0;
>  
>  	exynos_dp_set_analog_power_down(dp, POWER_ALL, 0);
>  
> @@ -296,9 +297,19 @@ void exynos_dp_init_analog_func(struct exynos_dp_device *dp)
>  	writel(reg, dp->reg_base + EXYNOS_DP_DEBUG_CTL);
>  
>  	/* Power up PLL */
> -	if (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED)
> +	if (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
>  		exynos_dp_set_pll_power_down(dp, 0);
>  
> +		while (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
> +			timeout_loop++;
> +			if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
> +				dev_err(dp->dev, "failed to get pll lock status\n");
> +				return;
> +			}
> +			usleep_range(10, 20);
> +		}
> +	}
> +
>  	/* Enable Serdes FIFO function and Link symbol clock domain module */
>  	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_2);
>  	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N

