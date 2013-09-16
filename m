From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 09:17:02 +0000
Subject: Re: [PATCH] video: au1100fb: Remove casting the return value which is a void pointer
Message-Id: <5236CC8E.1000709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="m2dhEeu2HTSRTlsggDpIBxwc4m3PBKafF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <005c01cead20$50fe87e0$f2fb97a0$%han@samsung.com>
In-Reply-To: <005c01cead20$50fe87e0$f2fb97a0$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--m2dhEeu2HTSRTlsggDpIBxwc4m3PBKafF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/09/13 08:49, Jingoo Han wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/au1100fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
> index a54ccdc..248abd5 100644
> --- a/drivers/video/au1100fb.c
> +++ b/drivers/video/au1100fb.c
> @@ -588,7 +588,7 @@ int au1100fb_drv_remove(struct platform_device *dev=
)
>  	if (!dev)
>  		return -ENODEV;
> =20
> -	fbdev =3D (struct au1100fb_device *) platform_get_drvdata(dev);
> +	fbdev =3D platform_get_drvdata(dev);
> =20
>  #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
>  	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
>=20

Thanks, applied for 3.13.

 Tomi



--m2dhEeu2HTSRTlsggDpIBxwc4m3PBKafF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNsyOAAoJEPo9qoy8lh71fyYP/1eRsm9n9pT5KxzNUVsbwG+U
oxyOBmRx/5fEIcuBGxElhSXP/8HTyOoSzC1uqn5zLRqNv7o4r8g9yfbliHF5woW2
Tka5eptC/IMx6TBwHunKMG34jj2kn93Jq2v2trVG03hq9ars+z7Nr3vmLP0EwKoz
Di6iFb6kubhLfpU+I+SCCpAuKysSm7II/CW1WhXE48qkdGvvUkWy1NcxSaFF+AVk
XHq8Sx9+NoD1bMCNzvNKvXDakct/eouUHsMUTSQiHHsbw7J01D1Q6bn0C4aDbEvQ
nw/NivmYUiDrPTIFQS+7zmHKHGSxS2Nh7eFFeEmdDfVTxg5to2NTxY/GGB0P5tQ4
BgPtc59mZX4OGLGKQCRnisKlEyiarhXUTK6nrBoGLETTG6HEipeqTxx8MOVyyx/8
HYp/XPT7+mIzxeD8GjbEf2vHxYuQScjJnykeWdB/7iUvGhvUJa81wLvYNoxZcsXV
Z0SIjXJyVN8+1XtN+44p2sOVqSYMKI+VsMA/eKg5UbtmXzpKcK1RSglQ8FWZt7hU
tTCfIGvQRZVEI41qZyJ0OSH0QEkW2iOOIbOwrafJqs5AUXLxAwUtK8YSVGX2G9t3
uamMKZ4l0xtjgk3wzZnzqIIdfpiijWtR3+hGusbQKDRZlL/CE6LqXVj7WOFFh5Br
KATWGDNkGDpxaUO9E9/F
=B2Mr
-----END PGP SIGNATURE-----

--m2dhEeu2HTSRTlsggDpIBxwc4m3PBKafF--
