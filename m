From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Nov 2015 15:59:23 +0000
Subject: Re: [PATCH v4 04/24] hwmon: pwm-fan: use pwm_get_xxx() helpers where appropriate
Message-Id: <5649FD5B.3000208@roeck-us.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-5-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/16/2015 12:56 AM, Boris Brezillon wrote:
> Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
> Doing that will ease adaptation of the PWM framework to support atomic
> update.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Patch generated with the following coccinelle script:
>
> --->8---
> virtual patch
>
> @@
> struct pwm_device *p;
> expression e;
> @@
> (
> -(p)->polarity = e;
> +pwm_set_polarity((p), e);
> |
> -(p)->polarity
> +pwm_get_polarity((p))

s/((p))/(p)/

> |
> -(p)->period = e;
> +pwm_set_period((p), e);
> |
> -(p)->period
> +pwm_get_period((p))

s/((p))/(p)/

> |
> -(p)->duty_cycle = e;
> +pwm_set_duty_cycle((p), e);

The (p) seems unnecessary here.

> |
> -(p)->duty_cycle
> +pwm_get_duty_cycle((p))

s/((p))/(p)/

> )
> --->8---
> ---
>   drivers/hwmon/pwm-fan.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 3e23003..105b964 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -47,8 +47,8 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>   	if (ctx->pwm_value = pwm)
>   		goto exit_set_pwm_err;
>
> -	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
> +	duty = DIV_ROUND_UP(pwm * (pwm_get_period((ctx->pwm)) - 1), MAX_PWM);
> +	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));

Please drop all the unnecessary ( ).

Thanks,
Guenter

>   	if (ret)
>   		goto exit_set_pwm_err;
>
> @@ -234,10 +234,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, ctx);
>
>   	/* Set duty cycle to maximum allowed */
> -	duty_cycle = ctx->pwm->period - 1;
> +	duty_cycle = pwm_get_period((ctx->pwm)) - 1;
>   	ctx->pwm_value = MAX_PWM;
>
> -	ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
> +	ret = pwm_config(ctx->pwm, duty_cycle, pwm_get_period((ctx->pwm)));
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to configure PWM\n");
>   		return ret;
> @@ -309,8 +309,9 @@ static int pwm_fan_resume(struct device *dev)
>   	if (ctx->pwm_value = 0)
>   		return 0;
>
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (ctx->pwm->period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
> +	duty = DIV_ROUND_UP(ctx->pwm_value * (pwm_get_period((ctx->pwm)) - 1),
> +			    MAX_PWM);
> +	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
>   	if (ret)
>   		return ret;
>   	return pwm_enable(ctx->pwm);
>

