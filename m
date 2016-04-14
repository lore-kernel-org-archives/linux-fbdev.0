From: Joachim Eastwood <manabian@gmail.com>
Date: Thu, 14 Apr 2016 19:24:47 +0000
Subject: Re: [PATCH v5 02/24] pwm: use pwm_get/set_xxx() helpers where appropriate
Message-Id: <CAGhQ9VyyWgcCZ3UoT7u8+YRdMouUuOO_7sE+-bM+JGSYhsNTrQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
	<1460661464-11216-3-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-3-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 14 April 2016 at 21:17, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Use pwm_get/set_xxx() helpers instead of directly accessing the pwm->xxx
> field. Doing that will ease adaptation of the PWM framework to support
> atomic update.
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
> +pwm_set_polarity(p, e);
> |
> -(p)->polarity
> +pwm_get_polarity(p)
> |
> -(p)->period = e;
> +pwm_set_period(p, e);
> |
> -(p)->period
> +pwm_get_period(p)
> |
> -(p)->duty_cycle = e;
> +pwm_set_duty_cycle(p, e);
> |
> -(p)->duty_cycle
> +pwm_get_duty_cycle(p)
> )
> --->8---
> ---
>  drivers/pwm/pwm-crc.c          | 2 +-
>  drivers/pwm/pwm-lpc18xx-sct.c  | 2 +-

> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 9861fed..19dc64c 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -249,7 +249,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>                            LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
>                            LPC18XX_PWM_EVSTATEMSK_ALL);
>
> -       if (pwm->polarity = PWM_POLARITY_NORMAL) {
> +       if (pwm_get_polarity(pwm) = PWM_POLARITY_NORMAL) {
>                 set_event = lpc18xx_pwm->period_event;
>                 clear_event = lpc18xx_data->duty_event;
>                 res_action = LPC18XX_PWM_RES_SET;

For the lpc18xx-sct part:
Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
