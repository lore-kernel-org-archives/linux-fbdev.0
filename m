From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 08 Nov 2012 00:54:25 +0000
Subject: Re: [PATCH 1/2] video: exynos_dp: remove redundant parameters
Message-Id: <001401cdbd4b$99712b60$cc538220$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352286744-22588-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1352286744-22588-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, November 07, 2012 8:12 PM Ajay Kumar wrote
> 
> This patch cleans up few redundant parameters keeping
> the same functionality intact.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>


Acked-by: Jingoo Han <jg1.han@samsung.com>


> ---
>  drivers/video/exynos/exynos_dp_core.c |   14 +++++---------
>  drivers/video/exynos/exynos_dp_core.h |    9 ++-------
>  drivers/video/exynos/exynos_dp_reg.c  |   23 +++++++++--------------
>  3 files changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index d55470e..f62778c 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -752,19 +752,15 @@ static int exynos_dp_set_link_train(struct exynos_dp_device *dp,
>  	return retval;
>  }
> 
> -static int exynos_dp_config_video(struct exynos_dp_device *dp,
> -			struct video_info *video_info)
> +static int exynos_dp_config_video(struct exynos_dp_device *dp)
>  {
>  	int retval = 0;
>  	int timeout_loop = 0;
>  	int done_count = 0;
> 
> -	exynos_dp_config_video_slave_mode(dp, video_info);
> +	exynos_dp_config_video_slave_mode(dp);
> 
> -	exynos_dp_set_video_color_format(dp, video_info->color_depth,
> -			video_info->color_space,
> -			video_info->dynamic_range,
> -			video_info->ycbcr_coeff);
> +	exynos_dp_set_video_color_format(dp);
> 
>  	if (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
>  		dev_err(dp->dev, "PLL is not locked yet.\n");
> @@ -937,7 +933,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> 
>  	exynos_dp_init_video(dp);
> -	ret = exynos_dp_config_video(dp, dp->video_info);
> +	ret = exynos_dp_config_video(dp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to config video\n");
>  		return ret;
> @@ -1003,7 +999,7 @@ static int exynos_dp_resume(struct device *dev)
>  	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> 
>  	exynos_dp_init_video(dp);
> -	exynos_dp_config_video(dp, dp->video_info);
> +	exynos_dp_config_video(dp);
> 
>  	return 0;
>  }
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 57b8a65..1e646d7 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -107,11 +107,7 @@ u32 exynos_dp_get_lane3_link_training(struct exynos_dp_device *dp);
>  void exynos_dp_reset_macro(struct exynos_dp_device *dp);
>  void exynos_dp_init_video(struct exynos_dp_device *dp);
> 
> -void exynos_dp_set_video_color_format(struct exynos_dp_device *dp,
> -				u32 color_depth,
> -				u32 color_space,
> -				u32 dynamic_range,
> -				u32 ycbcr_coeff);
> +void exynos_dp_set_video_color_format(struct exynos_dp_device *dp);
>  int exynos_dp_is_slave_video_stream_clock_on(struct exynos_dp_device *dp);
>  void exynos_dp_set_video_cr_mn(struct exynos_dp_device *dp,
>  			enum clock_recovery_m_value_type type,
> @@ -121,8 +117,7 @@ void exynos_dp_set_video_timing_mode(struct exynos_dp_device *dp, u32 type);
>  void exynos_dp_enable_video_master(struct exynos_dp_device *dp, bool enable);
>  void exynos_dp_start_video(struct exynos_dp_device *dp);
>  int exynos_dp_is_video_stream_on(struct exynos_dp_device *dp);
> -void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp,
> -			struct video_info *video_info);
> +void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp);
>  void exynos_dp_enable_scrambling(struct exynos_dp_device *dp);
>  void exynos_dp_disable_scrambling(struct exynos_dp_device *dp);
> 
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 3f5ca8a..db4975d 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -1034,24 +1034,20 @@ void exynos_dp_init_video(struct exynos_dp_device *dp)
>  	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_8);
>  }
> 
> -void exynos_dp_set_video_color_format(struct exynos_dp_device *dp,
> -			u32 color_depth,
> -			u32 color_space,
> -			u32 dynamic_range,
> -			u32 ycbcr_coeff)
> +void exynos_dp_set_video_color_format(struct exynos_dp_device *dp)
>  {
>  	u32 reg;
> 
>  	/* Configure the input color depth, color space, dynamic range */
> -	reg = (dynamic_range << IN_D_RANGE_SHIFT) |
> -		(color_depth << IN_BPC_SHIFT) |
> -		(color_space << IN_COLOR_F_SHIFT);
> +	reg = (dp->video_info->dynamic_range << IN_D_RANGE_SHIFT) |
> +		(dp->video_info->color_depth << IN_BPC_SHIFT) |
> +		(dp->video_info->color_space << IN_COLOR_F_SHIFT);
>  	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_2);
> 
>  	/* Set Input Color YCbCr Coefficients to ITU601 or ITU709 */
>  	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_3);
>  	reg &= ~IN_YC_COEFFI_MASK;
> -	if (ycbcr_coeff)
> +	if (dp->video_info->ycbcr_coeff)
>  		reg |= IN_YC_COEFFI_ITU709;
>  	else
>  		reg |= IN_YC_COEFFI_ITU601;
> @@ -1178,8 +1174,7 @@ int exynos_dp_is_video_stream_on(struct exynos_dp_device *dp)
>  	return 0;
>  }
> 
> -void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp,
> -			struct video_info *video_info)
> +void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp)
>  {
>  	u32 reg;
> 
> @@ -1190,17 +1185,17 @@ void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp,
> 
>  	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
>  	reg &= ~INTERACE_SCAN_CFG;
> -	reg |= (video_info->interlaced << 2);
> +	reg |= (dp->video_info->interlaced << 2);
>  	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
> 
>  	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
>  	reg &= ~VSYNC_POLARITY_CFG;
> -	reg |= (video_info->v_sync_polarity << 1);
> +	reg |= (dp->video_info->v_sync_polarity << 1);
>  	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
> 
>  	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
>  	reg &= ~HSYNC_POLARITY_CFG;
> -	reg |= (video_info->h_sync_polarity << 0);
> +	reg |= (dp->video_info->h_sync_polarity << 0);
>  	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
> 
>  	reg = AUDIO_MODE_SPDIF_MODE | VIDEO_MODE_SLAVE_MODE;
> --
> 1.7.0.4

