From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 10:18:08 +0000
Subject: Re: [PATCH] video: fbdev: mb862xx: Fix module autoload for OF platform driver
Message-Id: <5603CDE0.5050708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hrOasjhHNeDOcSjQqWUUO2xuRh81FMo76"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150918184609.GA32729@goodgumbo.baconseed.org>
In-Reply-To: <20150918184609.GA32729@goodgumbo.baconseed.org>
To: Luis de Bethencourt <luis@debethencourt.com>, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org

--hrOasjhHNeDOcSjQqWUUO2xuRh81FMo76
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/09/15 21:46, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>=20
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>=20
> Hello,
>=20
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
>=20
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
>=20
> Thanks,
> Luis
>=20
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video=
/fbdev/mb862xx/mb862xxfbdrv.c
> index 9b8bebd..f9ec5c0 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -831,6 +831,7 @@ static struct of_device_id of_platform_mb862xx_tbl[=
] =3D {
>  	{ .compatible =3D "fujitsu,coral", },
>  	{ /* end */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_platform_mb862xx_tbl);
> =20
>  static struct platform_driver of_platform_mb862xxfb_driver =3D {
>  	.driver =3D {
>=20

Thanks, queued for 4.3 fixes.

Tomi


--hrOasjhHNeDOcSjQqWUUO2xuRh81FMo76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA83gAAoJEPo9qoy8lh71kvkP/RP9vTJ5JLhGG62R4MH4sx6n
8KECWzwDmfKD9vyoV0XHDk6jUrHOvCdV50F0G6b6oSSzqUR0b0i1dH0xBW7x1Pb4
qDw9dqj6tLYqwh1vZ1x7jZ1SkjBq1fdcRp95HPxu1Td2pumF0XNgAgEQESIugjDJ
52Bt4erq1rmYEvgHS/0PeXzsOoCfV+OSKsXekcYO8QZQVs6qIdR8jjEZbTmwW1gc
JPkjin0Oqybzp+kuUiY6VVSa1oebBZ5KpbUKayPH5nx1IaGybKe43IwUOsPvvESS
XczogCYp12jG/rAcyC71vMJKAX4YdZ+TQLbUcnOXfayvHujCRb3FWuuxAoRL4zX7
IBAl/XlmLYf5XGezBzgy2jdx18moRAOzyaG7uNX99QF4Y2vr+oPvpafY0DpAtBht
vNA3iJxFDRTdWkfsQbIPZ6LtOxnoUXD6K+QhfdGspuWGXOUxsPjUIXRdHFXsgAGz
Pwmefi/ODQ6i3astDfcLNSv8quM12KgHit2RxI7jstTC9ZYmhCHrA+M6+8CmwZdz
XTDARFViPOWKF3HnTv7Zus8Cr7fXKjW9934JQubkYDYvhqWBcPAsNqQGDitTSstw
iiPETwXUHhLpCth8hWuB5cOp9mzxOZguJ5pyq3zRdPqkGsRwuU5VHAdocxkvzGJJ
0TbEIaNrzmT3WYn3NRmS
=pJ0M
-----END PGP SIGNATURE-----

--hrOasjhHNeDOcSjQqWUUO2xuRh81FMo76--
