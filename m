From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 22 Sep 2015 22:12:18 +0000
Subject: Re: [PATCH v3 04/12] backlight: pwm_bl: remove useless call to pwm_set_period
Message-Id: <20150922221218.GA9317@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-5-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 21 Sep 2015, Boris Brezillon wrote:

> The PWM period will be set when calling pwm_config. Remove this useless
> call to pwm_set_period, which might mess up with the initial PWM state
> once we have added proper support for PWM init state retrieval.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index ae498c1..71944f8 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -293,12 +293,14 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>  	 * period, parsed from the DT, in the PWM device. For the non-DT case,
>  	 * set the period from platform data if it has not already been set
>  	 * via the PWM lookup table.
> +	 * FIXME: This assignment should be dropped as soon as all the boards
> +	 * have moved to the PWM lookup table approach. The same goes for the
> +	 * pb->period field which should be replaced by
> +	 * pwm_get_default_period() calls.
>  	 */
>  	pb->period =3D pwm_get_default_period(pb->pwm);
> -	if (!pb->period && (data->pwm_period_ns > 0)) {
> +	if (!pb->period && (data->pwm_period_ns > 0))
>  		pb->period =3D data->pwm_period_ns;
> -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> -	}
> =20
>  	pb->lth_brightness =3D data->lth_brightness * (pb->period / pb->scale);
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
