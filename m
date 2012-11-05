From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 05 Nov 2012 02:28:41 +0000
Subject: Re: video: exynos_dp: Fix incorrect setting for INT_CTL
Message-Id: <001a01cdbafd$4585eef0$d091ccd0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351926402-25484-2-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1351926402-25484-2-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Saturday, November 03, 2012 4:07 PM Ajay Kumar wrote
> Subject: video: exynos_dp: Fix incorrect setting for INT_CTL

Please don't forget to add "[PATCH] " as below.

[PATCH] video: exynos_dp: Fix incorrect setting for INT_CTL

> 
> INT_CTL register contains bits INT_POL0 and INT_POL1, and not INT_POL.
> This patch fixes the wrong register setting for INT_CTL.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/video/exynos/exynos_dp_reg.c |    2 +-
>  drivers/video/exynos/exynos_dp_reg.h |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 3f5ca8a..d67f49b 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -88,7 +88,7 @@ void exynos_dp_init_analog_param(struct exynos_dp_device *dp)
>  void exynos_dp_init_interrupt(struct exynos_dp_device *dp)
>  {
>  	/* Set interrupt pin assertion polarity as high */
> -	writel(INT_POL, dp->reg_base + EXYNOS_DP_INT_CTL);
> +	writel(INT_POL0 | INT_POL1, dp->reg_base + EXYNOS_DP_INT_CTL);
> 
>  	/* Clear pending regisers */
>  	writel(0xff, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_1);
> diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
> index 1f2f014..fcf386e 100644
> --- a/drivers/video/exynos/exynos_dp_reg.h
> +++ b/drivers/video/exynos/exynos_dp_reg.h
> @@ -242,7 +242,8 @@
> 
>  /* EXYNOS_DP_INT_CTL */
>  #define SOFT_INT_CTRL				(0x1 << 2)
> -#define INT_POL					(0x1 << 0)
> +#define INT_POL0				(0x1 << 0)
> +#define INT_POL1				(0x1 << 0)

Why are the bit definitions the same???
INT_POL1 uses 1st bit of DP_INT_CTL register.

Please fix this bug as below.

#define INT_POL1				(0x1 << 1)
#define INT_POL0				(0x1 << 0)

Ajay,
please don't make careless mistake.
I don't want to waste my time.


> 
>  /* EXYNOS_DP_SYS_CTL_1 */
>  #define DET_STA					(0x1 << 2)
> --
> 1.7.0.4

