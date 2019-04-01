From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 01 Apr 2019 21:34:07 +0000
Subject: Re: [PATCH v2 1/3] backlight: lm3630a: return 0 on success in update_status functions
Message-Id: <20190401213407.GC14681@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1ccMZA6j1vT5UqiK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-2-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-2-masneyb@onstation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 06:30:32, Brian Masney wrote:
> lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status()
> both return the brightness value if the brightness was successfully
> updated. Writing to these attributes via sysfs would cause a 'Bad
> address' error to be returned. These functions should return 0 on
> success, so let's change it to correct that error.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlig=
ht/lm3630a_bl.c
> index 2030a6b77a09..ef2553f452ca 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -201,7 +201,7 @@ static int lm3630a_bank_a_update_status(struct backli=
ght_device *bl)
>  				      LM3630A_LEDA_ENABLE, LM3630A_LEDA_ENABLE);
>  	if (ret < 0)
>  		goto out_i2c_err;
> -	return bl->props.brightness;
> +	return 0;
> =20
>  out_i2c_err:
>  	dev_err(pchip->dev, "i2c failed to access\n");
> @@ -278,7 +278,7 @@ static int lm3630a_bank_b_update_status(struct backli=
ght_device *bl)
>  				      LM3630A_LEDB_ENABLE, LM3630A_LEDB_ENABLE);
>  	if (ret < 0)
>  		goto out_i2c_err;
> -	return bl->props.brightness;
> +	return 0;
> =20
>  out_i2c_err:
>  	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyig88ACgkQMOfwapXb+vITaACdF82J0YVRKNAu08dGT2c58KU7
iYAAnA5BrWUDZ425s2tdrFOD+Ls7mNhx
=xORY
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
