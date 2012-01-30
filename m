From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 30 Jan 2012 05:23:52 +0000
Subject: Re: [PATCH 1/2] video: s3c-fb: add alpha value width setting
Message-Id: <4F262968.2000606@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <007d01ccdcb7$24131ce0$6c3956a0$%han@samsung.com>
In-Reply-To: <007d01ccdcb7$24131ce0$6c3956a0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 01/27/2012 05:47 AM, Jingoo Han wrote:
> This patch adds alpha value width setting according to
> transparency value of each window format, using BLENDCON
> register. When alpha value is 8 bits, BLENDCON will set
> alpha value width as 8 bits.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied both patches of this series.


Thanks,

Florian Tobias Schandinat

> ---
>  arch/arm/plat-samsung/include/plat/regs-fb.h |    6 ++++++
>  drivers/video/s3c-fb.c                       |   18 ++++++++++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
> index 8f39aa5..6bf68ed 100644
> --- a/arch/arm/plat-samsung/include/plat/regs-fb.h
> +++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
> @@ -384,3 +384,9 @@
>  #define WPALCON_W0PAL_16BPP_A555		(0x5 << 0)
>  #define WPALCON_W0PAL_16BPP_565			(0x6 << 0)
>  
> +/* Blending equation control */
> +#define BLENDCON				(0x260)
> +#define BLENDCON_NEW_MASK			(1 << 0)
> +#define BLENDCON_NEW_8BIT_ALPHA_VALUE		(1 << 0)
> +#define BLENDCON_NEW_4BIT_ALPHA_VALUE		(0 << 0)
> +
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 0c63b69..e92be55 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -81,6 +81,7 @@ struct s3c_fb;
>   * @palette: Address of palette memory, or 0 if none.
>   * @has_prtcon: Set if has PRTCON register.
>   * @has_shadowcon: Set if has SHADOWCON register.
> + * @has_blendcon: Set if has BLENDCON register.
>   * @has_clksel: Set if VIDCON0 register has CLKSEL bit.
>   */
>  struct s3c_fb_variant {
> @@ -99,6 +100,7 @@ struct s3c_fb_variant {
>  
>  	unsigned int	has_prtcon:1;
>  	unsigned int	has_shadowcon:1;
> +	unsigned int	has_blendcon:1;
>  	unsigned int	has_clksel:1;
>  };
>  
> @@ -692,6 +694,17 @@ static int s3c_fb_set_par(struct fb_info *info)
>  	writel(data, regs + sfb->variant.wincon + (win_no * 4));
>  	writel(0x0, regs + sfb->variant.winmap + (win_no * 4));
>  
> +	/* Set alpha value width */
> +	if (sfb->variant.has_blendcon) {
> +		data = readl(sfb->regs + BLENDCON);
> +		data &= ~BLENDCON_NEW_MASK;
> +		if (var->transp.length > 4)
> +			data |= BLENDCON_NEW_8BIT_ALPHA_VALUE;
> +		else
> +			data |= BLENDCON_NEW_4BIT_ALPHA_VALUE;
> +		writel(data, sfb->regs + BLENDCON);
> +	}
> +
>  	shadow_protect_win(win, 0);
>  
>  	pm_runtime_put_sync(sfb->dev);
> @@ -1819,6 +1832,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
>  		},
>  
>  		.has_prtcon	= 1,
> +		.has_blendcon	= 1,
>  		.has_clksel	= 1,
>  	},
>  	.win[0]	= &s3c_fb_data_s5p_wins[0],
> @@ -1850,6 +1864,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
>  		},
>  
>  		.has_shadowcon	= 1,
> +		.has_blendcon	= 1,
>  		.has_clksel	= 1,
>  	},
>  	.win[0]	= &s3c_fb_data_s5p_wins[0],
> @@ -1881,6 +1896,7 @@ static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
>  		},
>  
>  		.has_shadowcon	= 1,
> +		.has_blendcon	= 1,
>  	},
>  	.win[0]	= &s3c_fb_data_s5p_wins[0],
>  	.win[1]	= &s3c_fb_data_s5p_wins[1],
> @@ -1944,6 +1960,8 @@ static struct s3c_fb_driverdata s3c_fb_data_s5p64x0 = {
>  			[1] = 0x2800,
>  			[2] = 0x2c00,
>  		},
> +
> +		.has_blendcon	= 1,
>  	},
>  	.win[0] = &s3c_fb_data_s5p_wins[0],
>  	.win[1] = &s3c_fb_data_s5p_wins[1],

