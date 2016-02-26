From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 12:39:26 +0000
Subject: Re: [PATCH v2 0/3] fbdev: omap2: panel-dpi: support reset-gpios and vcc regulator
Message-Id: <56D0477E.5000004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f3GI0tD3MSqsr7gcuHoEVt7jlUpKgQbwk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--f3GI0tD3MSqsr7gcuHoEVt7jlUpKgQbwk
Content-Type: multipart/mixed; boundary="lvvFNlOqh2buAoIxN1jofSf6ftNS36sWO"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
 kernel@pengutronix.de
Message-ID: <56D0477E.5000004@ti.com>
Subject: Re: [PATCH v2 0/3] fbdev: omap2: panel-dpi: support reset-gpios and
 vcc regulator
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>

--lvvFNlOqh2buAoIxN1jofSf6ftNS36sWO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/12/15 13:13, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> these patches are what is remaining from my previous series sent
> starting with
> Message-Id: 1449753107-11410-1-git-send-email-uwe@kleine-koenig.org .
>=20
> I split out the changes to
> Documentation/devicetree/bindings/video/panel-dpi.txt in a (single)
> separate patch. Also I changed the behaviour of the reset gpio to never=

> assert it because there are too many different needs.
>=20
> Have fun
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
>   fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
>   fbdev: omap2: panel-dpi: implement support for a vcc regulator
>=20
>  .../bindings/display/panel/panel-dpi.txt           |  2 ++
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 23 ++++++++++++++=
++++++++
>  2 files changed, 25 insertions(+)

I think these look fine. However...

omapfb is now in maintenance state, and all new development should be
done for omapdrm. In v4.5 omapdss and all the panels were copied to
drivers/gpu/drm/omapdrm/.

So please send these to dri-devel list, with the path fixed (git-am does
that automatically), and subject prefix changed, and you can add my
reviewed-by.

If you really want these for omapfb, you need to convince me that they
are really needed for the legacy driver =3D).

 Tomi


--lvvFNlOqh2buAoIxN1jofSf6ftNS36sWO--

--f3GI0tD3MSqsr7gcuHoEVt7jlUpKgQbwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0Ed+AAoJEPo9qoy8lh71BlsP/1/YLVBbHMKo7iMVc03ViafN
ybQvQsrz2U2Dz3JqZcZlPPjvsB3Rvqxb22zan8dnAiaZiniqDPdYd3gBSs6EFG+f
zo4u/Q7MF+FRxhUsa9rbaQcHkjTMmX+dO75uOPilkJrmD4lna41ASbLR5OJpLpUY
rWZaAo4AvMk6B7WvaZ9FIRjagNBKZp9KNA6zghh7qyO/jUoX6m58PJHclHgJDZwa
KL6zT3c0f/iipWcCB4x08bFYUeCnO4lbtKXzj+Ihh6Yb238PuqMRV5Z1+KQhKuow
xHQLMeXNkUlonL+pU98LsiaXeqUWIUVwAYnm/U5gExvqeAuPnplqZG+AciPC++oZ
7N5i8KxdCfyN1I85mQsv7hgwqp9CTq/3tyR8qp8HqXL2fJDNvIV7BZOU7v/nDrAj
+bo7qrPBDujxtxXlXZsapit5BMKXimbFOAEyTrLmXJEUUTk9Na8bkMv2qKOVZX1J
P99ozMehU8YMiYZ0Zm/5TVpXhiIK5UTdYf9i0CVYS+ens/3K27sppX6qa44d6C2X
dAKku8cPOcUwR2WIjA32odoKZIMZfo6+Fs8fjUgo5rI1goXxPfp62DhrpBnf0yJD
uPCNbRSYvjlFpcLTYCKg+9a61Bu5LTDQsFF2kUW9vB6N1X6VUD43GPZdY1QyVClM
pkp2Vyvvh9a+bhvO2fYZ
=oL+6
-----END PGP SIGNATURE-----

--f3GI0tD3MSqsr7gcuHoEVt7jlUpKgQbwk--
