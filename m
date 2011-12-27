From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 27 Dec 2011 01:02:05 +0000
Subject: RE: [PATCH] video: s3c-fb: Use s3c_fb_enable() to enable the
Message-Id: <000301ccc433$26bf4ff0$743defd0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324925318-10022-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1324925318-10022-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi, Mark.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Tuesday, December 27, 2011 3:49 AM
> To: Jingoo Han; Florian Tobias Schandinat
> Cc: linux-fbdev@vger.kernel.org; Mark Brown
> Subject: [PATCH] video: s3c-fb: Use s3c_fb_enable() to enable the framebuffer
> 
> The s3c-fb driver has a function called s3c_fb_enable() which turns on
> and off the physical output. However it is only actually used in paths
> which disable the screen, the enabling just writes to the register. Make
> the code less confusing by ensuring that the enable also goes through
> the same path.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It looks good to me.

	Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks.

> ---
>  drivers/video/s3c-fb.c |   55 ++++++++++++++++++++++++-----------------------
>  1 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 690b44e..76f6155 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -439,6 +439,32 @@ static void shadow_protect_win(struct s3c_fb_win *win, bool protect)
>  }
> 
>  /**
> + * s3c_fb_enable() - Set the state of the main LCD output
> + * @sfb: The main framebuffer state.
> + * @enable: The state to set.
> + */
> +static void s3c_fb_enable(struct s3c_fb *sfb, int enable)
> +{
> +	u32 vidcon0 = readl(sfb->regs + VIDCON0);
> +
> +	if (enable)
> +		vidcon0 |= VIDCON0_ENVID | VIDCON0_ENVID_F;
> +	else {
> +		/* see the note in the framebuffer datasheet about
> +		 * why you cannot take both of these bits down at the
> +		 * same time. */
> +
> +		if (!(vidcon0 & VIDCON0_ENVID))
> +			return;
> +
> +		vidcon0 |= VIDCON0_ENVID;
> +		vidcon0 &= ~VIDCON0_ENVID_F;
> +	}
> +
> +	writel(vidcon0, sfb->regs + VIDCON0);
> +}
> +
> +/**
>   * s3c_fb_set_par() - framebuffer request to set new framebuffer state.
>   * @info: The framebuffer to change.
>   *
> @@ -508,9 +534,10 @@ static int s3c_fb_set_par(struct fb_info *info)
>  		if (sfb->variant.is_2443)
>  			data |= (1 << 5);
> 
> -		data |= VIDCON0_ENVID | VIDCON0_ENVID_F;
>  		writel(data, regs + VIDCON0);
> 
> +		s3c_fb_enable(sfb, 1);
> +
>  		data = VIDTCON0_VBPD(var->upper_margin - 1) |
>  		       VIDTCON0_VFPD(var->lower_margin - 1) |
>  		       VIDTCON0_VSPW(var->vsync_len - 1);
> @@ -759,32 +786,6 @@ static int s3c_fb_setcolreg(unsigned regno,
>  }
> 
>  /**
> - * s3c_fb_enable() - Set the state of the main LCD output
> - * @sfb: The main framebuffer state.
> - * @enable: The state to set.
> - */
> -static void s3c_fb_enable(struct s3c_fb *sfb, int enable)
> -{
> -	u32 vidcon0 = readl(sfb->regs + VIDCON0);
> -
> -	if (enable)
> -		vidcon0 |= VIDCON0_ENVID | VIDCON0_ENVID_F;
> -	else {
> -		/* see the note in the framebuffer datasheet about
> -		 * why you cannot take both of these bits down at the
> -		 * same time. */
> -
> -		if (!(vidcon0 & VIDCON0_ENVID))
> -			return;
> -
> -		vidcon0 |= VIDCON0_ENVID;
> -		vidcon0 &= ~VIDCON0_ENVID_F;
> -	}
> -
> -	writel(vidcon0, sfb->regs + VIDCON0);
> -}
> -
> -/**
>   * s3c_fb_blank() - blank or unblank the given window
>   * @blank_mode: The blank state from FB_BLANK_*
>   * @info: The framebuffer to blank.
> --
> 1.7.7.3

