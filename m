From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 18 May 2015 08:47:16 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Message-Id: <20150518084716.GM22418@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431785290.6638.1.camel@ingics.com>
In-Reply-To: <1431785290.6638.1.camel@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Axel Lin <axel.lin@ingics.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>

On Sat, 16 May 2015, Axel Lin wrote:

> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions),
> the gpiod_get* functions take an additional parameter that allows to
> specify direction and initial value for output.
> Simplify the usage of devm_gpiod_get_optional accordingly.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 3a145a6..57cb9ec 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -241,7 +241,8 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  	pb->dev =3D &pdev->dev;
>  	pb->enabled =3D false;
> =20
> -	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable");
> +	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> +						  GPIOD_OUT_HIGH);
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret =3D PTR_ERR(pb->enable_gpio);
>  		goto err_alloc;
> @@ -263,9 +264,6 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
>  	}
> =20
> -	if (pb->enable_gpio)
> -		gpiod_direction_output(pb->enable_gpio, 1);
> -
>  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
>  		ret =3D PTR_ERR(pb->power_supply);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
