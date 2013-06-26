From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 12:20:35 +0000
Subject: Re: [PATCH] video: replace strict_strtoul() with kstrtoul()
Message-Id: <51CADC93.2090405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2DEQURHEDGNADASKTUIXI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <001401ce5e9a$03b485e0$0b1d91a0$@samsung.com>
In-Reply-To: <001401ce5e9a$03b485e0$0b1d91a0$@samsung.com>
To: linux-fbdev@vger.kernel.org

------enig2DEQURHEDGNADASKTUIXI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/06/13 10:31, Jingoo Han wrote:
> The usage of strict_strtoul() is not preferred, because
> strict_strtoul() is obsolete. Thus, kstrtoul() should be
> used.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/fsl-diu-fb.c                |    4 ++--
>  drivers/video/omap2/displays/panel-taal.c |    6 +++---
>  drivers/video/wm8505fb.c                  |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

I've added this to my fbdev-3.11 branch.

 Tomi



------enig2DEQURHEDGNADASKTUIXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRytyTAAoJEPo9qoy8lh71FG4QAIhAamjKvpmxkfbhjfwqlw0O
G5F57iOU2qzSYvgZwdp2HdsY3d7jtUgbQseo4f4EXZ5F6xdfI6dR3cfVgye4lS6z
1AYYsFD585+AgMlkGLejp9pwZit6glfXGv3FnUhdn15XpxCuxi3VHiKlr+jLUcyT
FY+fk9QA9VLHqZNAbLNZQBDlHz4EfphczAnDwTFvEkbF7DvT4/+JsxYB5VgTFobN
zf/6mOM8ZZae1GOLV9ROe0m3AM5y+noSUXquBfOiRfbYt/pgO1h4Axafhd5Afcib
YrBBfsfnWDMv75aPDbM1mTmkH731f+UHThnba9OE0F/S2i/5ALh7CVJEJP8nCcgI
ng6LwvFQVX8xXq5cH6JsmWo4/X9khkAMofKsaHFqYqqk5mRedgLoWyUrU6XjQw9x
5a1RHZiCjzOxFTad0R/Nry7gIN6ov9XrX1qbXwEMD5tml3lkUXjD3G9nxaYT+iAm
sdzi0b0egCrFM6N+EKczYbxPEXWPhXkC84C9up+zNRopMnltZvHKZYuBOmzrDh37
a4LNI/DMVz0DDA9DaG6pCekCDMWU+SpiVyyfFlZ7LlNhxp4Qks3O35QBFR6JImAX
0mClu8enNUB6zKhnkHuk7P8g/jHxtj4FDaq6w40pmuR2B0SMuXIr8tc5XIcvwiFB
ABySWJuNxde1QeWzxO8d
=pd/l
-----END PGP SIGNATURE-----

------enig2DEQURHEDGNADASKTUIXI--
