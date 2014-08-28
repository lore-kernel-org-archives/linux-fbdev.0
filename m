From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 28 Aug 2014 07:35:08 +0000
Subject: Re: [PATCH] backlight: generic_bl: Remove unused function
Message-Id: <20140828073508.GI24579@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409168700-19042-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1409168700-19042-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, 27 Aug 2014, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> genericbl_limit_intensity() is exported, but it is never
> called anywhere else.
>=20
> Fix the following sparse warning:
>=20
> drivers/video/backlight/generic_bl.c:59:6: warning: symbol 'genericbl_lim=
it_intensity' was not declared. Should it be static?
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/backlight/generic_bl.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlig=
ht/generic_bl.c
> index 5d8d652..67dfb93 100644
> --- a/drivers/video/backlight/generic_bl.c
> +++ b/drivers/video/backlight/generic_bl.c
> @@ -52,24 +52,6 @@ static int genericbl_get_intensity(struct backlight_de=
vice *bd)
>  	return genericbl_intensity;
>  }
> =20
> -/*
> - * Called when the battery is low to limit the backlight intensity.
> - * If limit=3D0 clear any limit, otherwise limit the intensity
> - */
> -void genericbl_limit_intensity(int limit)
> -{
> -	struct backlight_device *bd =3D generic_backlight_device;
> -
> -	mutex_lock(&bd->ops_lock);
> -	if (limit)
> -		bd->props.state |=3D GENERICBL_BATTLOW;
> -	else
> -		bd->props.state &=3D ~GENERICBL_BATTLOW;
> -	backlight_update_status(generic_backlight_device);
> -	mutex_unlock(&bd->ops_lock);
> -}
> -EXPORT_SYMBOL(genericbl_limit_intensity);
> -
>  static const struct backlight_ops genericbl_ops =3D {
>  	.options =3D BL_CORE_SUSPENDRESUME,
>  	.get_brightness =3D genericbl_get_intensity,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
