From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 08:43:04 +0000
Subject: Re: [PATCH] video: mmp: drop needless devm cleanup
Message-Id: <5243F398.1070705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ChuROpVOOLl1CtLJi9OPHIX5M6AqRahxE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--ChuROpVOOLl1CtLJi9OPHIX5M6AqRahxE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/09/13 19:13, Uwe Kleine-K=C3=B6nig wrote:
> The nice thing about devm_* is that the driver doesn't need to free the=

> resources but the driver core takes care about that. This also
> simplifies the error path quite a bit and removes the wrong check for a=

> clock pointer being NULL.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20

Thanks, queuing for 3.12 fixes.

 Tomi




--ChuROpVOOLl1CtLJi9OPHIX5M6AqRahxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/OZAAoJEPo9qoy8lh71KXsQAJuLZSXvX2yHmT6WKCrQnkmu
aXCnEg22/OL5005wWSM0DEOtwuY39vfNNOnUp/euXzrSJVGa/KKQRSYRhrYh/kFU
r1zMgo3w8h0Ga7u/ohjvjooRvrXP8/QNTfRE/Mn2PUI6veha3wxAsRX64exrS3nD
yA29u89xHAlTyuanTj2+slrooX6zXdEYF1PNYCkgej3MaC6qIi948Lihnw7RVrVE
oKFaSS3hCR11McUf6bpFa8/AFjdr3AzAfxmDdtYjZYS7lMXHbQ3/HO3vVnyMsaGL
MSgeJIFtQzDcUR6Oxb+II9LPRkkizQtYI+KJFkdXI1XyG1xtqsNxtByL1wXU6Kf8
EvJH5VBQWcbf5DyRmOTWy3umIDzaUTWxGmhnaKQ0xXgd9lfUOb9zgSYbo9RX0z8o
SBdJI5ROb9qoJTkil9RrQe/umvV0+I1eyeg5NTiu5dm8Qw251ka6TeTDt21zx3tt
J5yvEAlQgSBCn4TEKJcLippeCMcoy9Z+aMRhAo2em1v9KtdAGRdH9HEMlwbdaTQo
sjCeYQX+hIi7BZOU/BEWaBtNAab85KGd2vC6uQHSH5MBbOraNNvvE7tDKBuYUsju
49wtwVvAQ1kyVtfuupadbCb6VmGLLtGHK/i4KoeT9Czoq9xIuEWV7FzLAXEltt8T
pOXBSBhrjMEBeQJdrYa0
=oNA3
-----END PGP SIGNATURE-----

--ChuROpVOOLl1CtLJi9OPHIX5M6AqRahxE--
