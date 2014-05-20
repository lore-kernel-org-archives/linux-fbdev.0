From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 20 May 2014 11:36:36 +0000
Subject: Re: [PATCH 2/3] OMAPDSS: panel-lgphilips-lb035q02: Add DT support
Message-Id: <537B3E44.1070906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com> <1400148637-17726-3-git-send-email-tomi.valkeinen@ti.com> <537B3543.2040906@epfl.ch>
In-Reply-To: <537B3543.2040906@epfl.ch>
To: florian.vaussard@epfl.ch, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/05/14 13:58, Florian Vaussard wrote:

>>  static struct spi_driver lb035q02_spi_driver =3D {
>>  	.probe		=3D lb035q02_panel_spi_probe,
>>  	.remove		=3D lb035q02_panel_spi_remove,
>> @@ -357,6 +398,7 @@ static struct spi_driver lb035q02_spi_driver =3D {=

>> =20
>=20
> 		.of_match_table =3D lb035q02_of_match,
>=20
> is missing.

Thanks. I seem to have missed it with the other panels also in the
patches I sent last week.

 Tomi



--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTez5EAAoJEPo9qoy8lh71edcP/3B18TuA8rhnbUb0YQ1Wh0eV
iIUD5XAITFbnDfNoEevdfcCeMFTxOT88Zn6XoB3VNxx5A1Rgdef4YHHaqycNkUiM
hQCBBrIt7hG/ab6zKAtIopg8Ew6b6PggANhPYYRIZjYlMUf2hxH+cGplnVF16gAZ
6mF+5f40Ompcp1qD01PepGuuOdNLkisOm8IJgOtPd22dPWXWQAJ0tQ0p5x8XTdHI
X2UDI2WI/W/bGkjy8tYacIBA2bTnOZ2awjaJszlzWSfqNHr5an+0Mj7kH+AJRunb
dhq4fveI0KXsC61lwpZeF/1x0xKUKzJbDAXQPKf6Y2mnQ/hSg5+8N0YXnMVTKYB7
PNDKjLKrsCIid07MhmqogQmYH+vm0mGQlRF4nyK1j8Txt/CCjrC++zug5srVWH5+
dV6aApRz3CsW4jvLDLG/BSelATDjteM66kgWa92jwq3dqI3AkrZNkhCHs7Ln49m4
4BJrnwIE1WXXkAdp3S/a4qykWFIVgP7yF4WkOw5sXrUin5MggWxsILHYqvjPByIl
4bnbx83bW3hoTRNi3+Vl8aXS+GN7HVc7e+eBQKJfws8f6HgRsP1Ie8tbAvECKXOV
9y5JeId43TFi65KlX7zcx+39h/fF4yRu3vOS3tRibylwUlGK/KWXn19d7eQlIzG3
IhGkVMQKak0mlhYeA1LO
=p6oV
-----END PGP SIGNATURE-----

--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF--
