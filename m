From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 25 Jun 2014 09:54:47 +0000
Subject: Re: [PATCH] pwm-backlight: use devm_gpiod_get_optional()
Message-Id: <20140625095447.GT13803@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403687898-26881-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1403687898-26881-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

> Make use of the new devm_gpiod_get_optional() to simplify the probe
> code.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Looks good.  Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 38ca88bc5c3e..d1e0a7c6cac7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -245,13 +245,10 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>  	pb->dev =3D &pdev->dev;
>  	pb->enabled =3D false;
> =20
> -	pb->enable_gpio =3D devm_gpiod_get(&pdev->dev, "enable");
> +	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable");
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret =3D PTR_ERR(pb->enable_gpio);
> -		if (ret =3D -ENOENT)
> -			pb->enable_gpio =3D NULL;
> -		else
> -			goto err_alloc;
> +		goto err_alloc;
>  	}
> =20
>  	/*

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
