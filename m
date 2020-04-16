From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 16 Apr 2020 09:44:20 +0000
Subject: Re: [PATCH v12 09/11] backlight: pwm_bl: Use 64-bit division function
Message-Id: <20200416094420.GB2167633@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
In-Reply-To: <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, David Collins <collinsd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>

On Wed, 08 Apr 2020, Guru Das Srinagesh wrote:

> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I see that this is part of a large set, but the remainder of the
patches have been hidden from me.

Does this mean I can apply this patch on its own?

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index efb4efc..3e5dbcf 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->scale = data->max_brightness;
>  	}
>  
> -	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> +	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
> +				pb->scale));
>  
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = data->max_brightness;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
