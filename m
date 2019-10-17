From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 17 Oct 2019 11:47:27 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Jingoo Han <jingoohan1@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=F6nig wrote:
> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> pwm_get_state() return the last implemented state")) changed the
> semantic of pwm_get_state() and disclosed an (as it seems) common
> problem in lowlevel PWM drivers. By not relying on the period and duty
> cycle being retrievable from a disabled PWM this type of problem is
> worked around.
>=20
> Apart from this issue only calling the pwm_get_state/pwm_apply_state
> combo once is also more effective.

I'm only interested in the second paragraph here.

There seems to be a reasonable consensus that the i.MX27 and cros-ec
PWM drivers should be fixed for the benefit of other PWM clients.
So we make this change because it makes the pwm-bl better... not to
work around bugs ;-).

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 746eebc411df..ddebd62b3978 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data=
 *pb)
> =20
>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  {
> -	struct pwm_state state;
> -
> -	pwm_get_state(pb->pwm, &state);
> -	if (!pb->enabled)
> -		return;
> -

Why remove the pb->enabled check? I thought that was there to ensure we
don't mess up the regular reference counts.


Daniel.
