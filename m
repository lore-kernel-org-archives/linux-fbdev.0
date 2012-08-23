From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:42:39 +0000
Subject: Re: [PATCH] video: exynos_dp: check time loop for RPLY_RECEIV
Message-Id: <503695BF.7090705@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003901cd7502$abac1ba0$030452e0$%han@samsung.com>
In-Reply-To: <003901cd7502$abac1ba0$030452e0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/08/2012 01:10 AM, Jingoo Han wrote:
> This patch checks time loop for RPLY_RECEIV which means that
> AUX channel command reply is received.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_reg.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 2db5b9a..174c445 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -401,6 +401,7 @@ int exynos_dp_start_aux_transaction(struct exynos_dp_device *dp)
>  {
>  	int reg;
>  	int retval = 0;
> +	int timeout_loop = 0;
>  
>  	/* Enable AUX CH operation */
>  	reg = readl(dp->reg_base + EXYNOS_DP_AUX_CH_CTL_2);
> @@ -409,8 +410,15 @@ int exynos_dp_start_aux_transaction(struct exynos_dp_device *dp)
>  
>  	/* Is AUX CH command reply received? */
>  	reg = readl(dp->reg_base + EXYNOS_DP_INT_STA);
> -	while (!(reg & RPLY_RECEIV))
> +	while (!(reg & RPLY_RECEIV)) {
> +		timeout_loop++;
> +		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
> +			dev_err(dp->dev, "AUX CH command reply failed!\n");
> +			return -ETIMEDOUT;
> +		}
>  		reg = readl(dp->reg_base + EXYNOS_DP_INT_STA);
> +		usleep_range(10, 11);
> +	}
>  
>  	/* Clear interrupt source for AUX CH command reply */
>  	writel(RPLY_RECEIV, dp->reg_base + EXYNOS_DP_INT_STA);

