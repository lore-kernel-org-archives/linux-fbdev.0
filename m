From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Mar 2014 11:06:48 +0000
Subject: Re: [PATCH] video: atmel_lcdfb: ensure the hardware is initialized with the correct mode
Message-Id: <53203FC8.7010604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oWQgwu03dqCmd8n6XrDVOOF8LCNPk5qf8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org

--oWQgwu03dqCmd8n6XrDVOOF8LCNPk5qf8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/14 18:20, Antoine T=C3=A9nart wrote:
> If no driver takeover the atmel_lcdfb, the lcd won't be in a working st=
ate
> since atmel_lcdfb_set_par() will never be called. Enabling a driver whi=
ch does,
> like fbcon, will call the function and put atmel_lcdfb in a working sta=
te.
>=20
> Fixes: b985172b328a (video: atmel_lcdfb: add device tree suport)
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/video/atmel_lcdfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index cd96162..b74e5f5d 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1298,6 +1298,12 @@ static int __init atmel_lcdfb_probe(struct platf=
orm_device *pdev)
>  		goto unregister_irqs;
>  	}
> =20
> +	ret =3D atmel_lcdfb_set_par(info);
> +	if (ret < 0) {
> +		dev_err(dev, "set par failed: %d\n", ret);
> +		goto unregister_irqs;
> +	}
> +
>  	dev_set_drvdata(dev, info);
> =20
>  	/*
>=20

Thanks, queued for 3.15.

 Tomi



--oWQgwu03dqCmd8n6XrDVOOF8LCNPk5qf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTID/IAAoJEPo9qoy8lh71IaYP/38bFWu7zOwlI54wRJt8J3Np
lMNruJQfB2fGk5USGpXD5kzi4XtqF6B2X/eckrmwBMZL09tt39CaOwBD22TgoUip
p1MgsW4iIAXNU8ICVcuxxODanTlpSjb7muaY+rojhHKhWy8s//dqNXMzrBgMdJz9
yWlN0H9LOQxu3Og+eyKWa3zVrKhcPJUhhg3uMlYj7KWEfwRj4KoP2kW8bAckUJik
GkNqYNu/KwCgUeIwm1phPl7CLadex91jVNOmjbCP7qFPAWSvqE2eVtJbVOy6XD/c
EgxePr5qpXbgN+khuGX9BDggFXjbw0kO+ZqfE0TLQXGcKdtO1mhU4hCWjywNUTRt
HEQuN1ohPIxAGhcXv7O9aXtA9ALesGW30kCRj5LwKEDJ4xRJNzfH5tKoYq88x9Qp
7jNGiQOtk/NiOZwQa2Kt0RY+E/gTmq8KfXEh0B9hGul4fmfOFFBMqDBVI7gfUqKo
3sorPlPWRURLp5FdA30wmP39BYK61QZoZwXctwdr1bzoiSYoq4PsHggHUefmFN8N
kabBMhlaHN+IVqgjfvKiK+S3I+V9wMXfF50Evj30i2JPnDwrz0CcIEGWPpjuI2B3
oRuh53KMHHXXW6f8vB6JvzrebgJx5yg/AKXT55oJOLdP3+m6uY18TmzbUckxyseA
SCewQLgvi3fDx62RDZD9
=qbeM
-----END PGP SIGNATURE-----

--oWQgwu03dqCmd8n6XrDVOOF8LCNPk5qf8--
