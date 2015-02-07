From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 11:45:34 +0000
Subject: Re: [PATCH 8/8] fbdev: ssd1307fb: Turn off display on driver unload.
Message-Id: <20150207114534.GR2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JB7KW7Ey7eB5HOHs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-9-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-9-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2015 at 11:28:14PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20

A commit log is always nice :)

> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 02931c7..be91dfc 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -762,6 +762,11 @@ static int ssd1307fb_remove(struct i2c_client *clien=
t)
>  {
>  	struct fb_info *info =3D i2c_get_clientdata(client);
>  	struct ssd1307fb_par *par =3D info->par;
> +	int ret =3D 0;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
> +	if (ret < 0)
> +		return ret;

I don't think we really care about the return value here.

It might be even worse actually, since you'll end up in a intermediate
state, where you won't have freed everything, but your remove method
has been called still.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1freAAoJEBx+YmzsjxAgSE8QAKES2rC55BjqNVSaszu2Gth5
dpgCh7Q1JB25ZtIIFZco6gANDrsg3xKDlmXZHf6Jz1Y/INVHx0Tx5wwsCLs96zxU
BRag0UVrOZleDQdJb8s5PEpu4xrbxeZOk1qIvW//cNrA1etaXs7v/P9Z83dfMAbi
wbmWM/6B7KZSpa5IaaT3eu2GQfE0h7zQZgxOVNi2F0aCA803QRuA8XtT6UuLEM1q
Vez/kzqPxZ2qt1sqR/o4mMsRSVT/juJEIlnHn9oi+zzamD6EE8PNa09ocFWaSmua
758c5ktttv72NFw+aCMfl/YAVy3nV9VOqdZEADwvFxAa8YnGMmx+kssBa8gNJ2Ma
SQ9YefHSZVUjTzt8mOFgkJZKHZ5SnL0hn+CtMxEzemc/Kf5aL79NZ9pgQFJTSq4g
8/25bYaOrE0K/KrzWcjQBy46VMBN0JI226F+94+tuFpOtBGz5q9o50teMaZNU+Op
3I/1zvP9bEIyHDxLel3dHpwSwDEGD4ifIGtu+88I6IlNvsn/vYlebESTQEMiyUuy
XJaQ2qEn41I1WhVHbm4MJav0qSKMlfdrBk9B60X27A+v8zd48Sd2fZwmGM01mXYu
gDng0zxIn26RbWHm6BY1/YmV9X679gZx9YFukRD+HXBkr9r2sj6OcoHmk5emd/Zs
9nMEcReVlhtkPL1kl7yq
=/THx
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
