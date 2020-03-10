From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 10 Mar 2020 14:34:32 +0000
Subject: Re: [PATCH v7 12/13] backlight: pwm_bl: Use 64-bit division macros for period and duty cycle
Message-Id: <20200310143432.cfjlqac5x6oinshj@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
In-Reply-To: <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Mar 09, 2020 at 12:35:15PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
> 
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by replacing division operations involving pwm period and duty cycle
> with their 64-bit equivalents as appropriate. The actual switch to u64 period
> and duty_cycle follows as a separate patch.
> 
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
> 
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64

This patch looks like it is a tiny change to get the pwm_backlight to
perform 64-bit division. Most of the above text is completely irrelevant
to the change contained in this patch. No need to justify the change in
the PWM structures here since that can go in the patch that changes
those structures.  Just describe what this patch does, perhaps something
like the following:

    The PWM API will shortly switch the state.period and
    state.duty_cycle fields to 64-bit values. Make pwm_bl
    ready for this transition by adopting 64-bit division
    macros.

Also please copy the backlight maintainers into the covering letter. It
is useful to place patches like this into context.


Daniel.

 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
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
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
