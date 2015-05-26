From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 07:02:45 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: fix logical error
Message-Id: <55641A95.1010102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fh6eT0sJ3BeTaE8BMtLsGP9EoXl9GW51i"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432582161-14684-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1432582161-14684-1-git-send-email-niederp@physik.uni-kl.de>
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, plagnioj@jcrosoft.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, dan.carpenter@oracle.com, prabhakar.csengg@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--Fh6eT0sJ3BeTaE8BMtLsGP9EoXl9GW51i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/05/15 22:29, Thomas Niederpr=C3=BCm wrote:
> The logical not needs to be done after the bit masking.
>=20
> Fixes: a3998fe03e87 ("fbdev: ssd1307fb: Unify init code and obtain
> hw specific bits from DT")
>=20
> Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index 8fc224c..9771d56 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -368,7 +368,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par=
)
>  	if (ret < 0)
>  		return ret;
> =20
> -	compins =3D 0x02 | (!par->com_seq & 0x1) << 4
> +	compins =3D 0x02 | !(par->com_seq & 0x1) << 4
>  				   | (par->com_lrremap & 0x1) << 5;
>  	ret =3D ssd1307fb_write_cmd(par->client, compins);
>  	if (ret < 0)
>=20

Thanks, queued for 4.2.

 Tomi


--Fh6eT0sJ3BeTaE8BMtLsGP9EoXl9GW51i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZBqVAAoJEPo9qoy8lh71MzYP/R2bbNh/rvZENP08oGxhGxZW
Ejzmayq1B4K6wmfKJkK5yl0+lLz4OHnCJ7yX7RSbsgc+P2BpuCtNlAkeCdlNbL3P
cZshXBvq2nuG4oWsR7lkcop2o4Q91ojTjWuSgfBp8vW+ECrmqhahi0EEB4WdK+3D
RiZ1pyS8kPeJcaU84CnqNH+zBx0T0ySHtzFIr+zWZq2OOjvevDv556Ptmr6IcPio
aP4sQ+e5LuOcOWxIj2xr9pKKElNBcDpBArW6RZRURNzxc9lC+acokTzmaRFgbSdm
AKfK8Wl3CowR1qRSqVqiAZkJdiSmbZMI5VCVBHLmR6Z4eCv+3blexUsBqTWeHGm4
fBNLV9syDRSVid2JYFuaZ2NA3IRtL3lqzLtQEoD+Y1dA9dDbodhVozmLtraWoPLe
AyhOM+JYLM1m3gOVdl5SqC1Z19SzOedzQm7kaZeVG+a9ans0b1JAFEoKqKqlqG66
Ax02RatT+nsjN40oADFjnV9nX6lfps848ZTmmsOFKAd0TQTUibT8dUEoC+5KDNSw
iVSKIy84t3clAQpmBl4C7khdlzjCEqYKvysTaxnrlhwgXbEcqFQGHoiCpYUtjBXq
2J1rCZJH8uTmQ8JLsm7cZ6fsrkbTMcdDxhulsVkh+aBlfl/JxcfgyO5pjqSFZO0/
i/gVmxe/G+VL7XyQUnuR
=fGJV
-----END PGP SIGNATURE-----

--Fh6eT0sJ3BeTaE8BMtLsGP9EoXl9GW51i--
