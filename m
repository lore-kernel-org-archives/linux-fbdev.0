From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:56:06 +0000
Subject: Re: [PATCH] video/logo: Remove MIPS-specific include section
Message-Id: <52CFDFD6.8090006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org

--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-04 10:42, Geert Uytterhoeven wrote:
> Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid=
 of
> mips_machgroup") there's no longer a need to include <asm/bootinfo.h> o=
n
> MIPS.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/logo/logo.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 080c35b34bbb..b670cbda38e3 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -17,10 +17,6 @@
>  #include <asm/setup.h>
>  #endif
> =20
> -#ifdef CONFIG_MIPS
> -#include <asm/bootinfo.h>
> -#endif
> -
>  static bool nologo;
>  module_param(nologo, bool, 0);
>  MODULE_PARM_DESC(nologo, "Disables startup logo");
>=20

Queued for 3.14.

 Tomi



--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9/WAAoJEPo9qoy8lh71c/0P/j0iSGTh1uodjhJ1MQG4oL0L
pOeKJgfeyLqZRcPiKXzYuau//hqNbrDGlGkKws1yI2S5Q7JoFdJheAnGG8q/NApx
WTi6eYly+CyyVEqLMXCSZE+rJ1basIIn/bh2aeLwSJ1xodErVT4IrsUOfSvyd9Im
xP1RXr3hEH398bY2U8VmtKaV0dKbZgGkTiKgSozyQtS8xaArv603qpyB50s08wCz
yLU4ZXtdMLlkTfm7f5VusbNRpqR9hvHhD13YJ5wdFshtfTkLWJteCW7TJayra1UG
XLsrWNfQ20+VpeVcxOUdAOQPOgg7G1D+FIA1s+JD7q/1EsGB6Hnm4ZpwdCuPnYEi
l9VYPROTjgIXfC+XTSXKaqEaGCk5KmTqTb+B32BJ3YZbYjbEkipIl3gCyak/frf7
qz34hBCtqcMUa4C/rDpIMFXR/SDgyL7tLg3mJXu8PsZqhkRE3pfv4CxctLCv36+x
/7hHAgbUkFl/YdeIm5viLHBe5gDLzRNSvXdsbiBlQQqzF9QrvVtjOKZQSWM7iYoc
Dr9gdmFwggXO/ARIsKe0dIewPhNuVBdJdsXYlzBPnxD45jMKpGcJ21dScDLNHfA4
O70LfWW51wya3PZ1ey5sVN+dRBV3HdEqHGx2UR6qripPrTku/jL5GVpErLPqSE2m
jqERWGabD/x68GUOlN+C
=zDEo
-----END PGP SIGNATURE-----

--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO--
