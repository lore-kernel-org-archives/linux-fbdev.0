From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 15:48:05 +0000
Subject: Re: [PATCH] fbdev: sis: enforce selection of at least one backend
Message-Id: <5665AA35.1040600@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="29Rk8cLv6Tx1vi2RlBcReTX2uRNPkFaMX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <2902419.SMzMybotxA@wuerfel>
In-Reply-To: <2902419.SMzMybotxA@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--29Rk8cLv6Tx1vi2RlBcReTX2uRNPkFaMX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/11/15 16:33, Arnd Bergmann wrote:
> The sis framebuffer driver complains with a compile-time warning
> if neither the FB_SIS_300 nor FB_SIS_315 symbols are selected:
>=20
> drivers/video/fbdev/sis/sis_main.c:61:2: warning: #warning Neither CONF=
IG_FB_SIS_300 nor CONFIG_FB_SIS_315 is se
>=20
> This is reasonable because it doesn't work in that case, but it's
> also annoying for randconfig builds and is one of the most common
> warnings I'm seeing on ARM now.
>=20
> This changes the Kconfig logic to prevent the silly configuration,
> by always selecting the FB_SIS_300 variant if the other one is
> not set.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Sorry for sending this twice, it looks like I forgot the fbdev list and=

> Tomi as recipients the first time

Thanks, queued for 4.5.

 tomi


--29Rk8cLv6Tx1vi2RlBcReTX2uRNPkFaMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZao1AAoJEPo9qoy8lh71nnMP/05v7af6NNXcqih6jwgQz8bm
g2oTlN6O6Wbrau/FXkQ9zsDBZOBG02RagyHDvPRtBv7YoAJtBo8uzbAHgMh1YmMl
LtW1EnGXfUOaxYqU8o8YgzgIMVIF6NyNkDFXmJvDscuGKaFE0BXd1h7jfnsZhekm
2IIRAUoPFwKFQ11v0zPFDSWGxw1DWMj5276SMWpipq/Xd/8IwDjJ5KvkCbYm7iO1
6/YDtzAezfDkwWpbq5pMkF2KCmiANegH2bgMR0eroSBbq1ZvcXedOCm40epgrGLN
OA4Ho8d6ncgVW75YJnloJLAbnyAeMJmCpZ/VSSAOVo6yZmPCdjwFp1pOzbXY5O20
Qk6olQpycjLXLGLK3iOMSzDmBx01ud/+sIZl4tn8PVF4qBfkdg+2SEbgmJ/fZIDB
7a0BVEO0Gy8WSeMV9e9IrfnIq7aqLCA6WO6FwoiF63rEjAWBGbodnwqhvibVIowe
/rU9j52ak0b7CbV4sk0UT/YZ9b5f3nBcTrB9YVnZNBQQCKYzHpoaUQXc/+J0Zpwz
cWYZJwVSTrN513DJqsFavLsIv9HCxOJziNFmPIta1QVAeGmOmvJ8dR7eWJYX1r7Z
mOrcsXrB9W5SKM/Fi6k343eeo+EEZp58gqKRkxzp1K0EE22e0ZJpBw3yGb9PGJwt
wgasoHl3tFXdY9hQimXs
=VOp7
-----END PGP SIGNATURE-----

--29Rk8cLv6Tx1vi2RlBcReTX2uRNPkFaMX--
