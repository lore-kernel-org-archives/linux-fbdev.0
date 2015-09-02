From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Sep 2015 11:25:45 +0000
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: remove useless include
Message-Id: <55E6DCB9.2080204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KUplgXDa5OCjEs8pbWXqfHVv1o4NnLftB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439217114-12317-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1439217114-12317-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org

--KUplgXDa5OCjEs8pbWXqfHVv1o4NnLftB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/08/15 17:31, Alexandre Belloni wrote:
> Definitions from linux/platform_data/atmel.h are not used, remove the
> include.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>=

> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/at=
mel_lcdfb.c
> index abadc490fa1f..a5006788647c 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -19,7 +19,6 @@
>  #include <linux/backlight.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> -#include <linux/platform_data/atmel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>

Thanks, queued for 4.3.

 Tomi


--KUplgXDa5OCjEs8pbWXqfHVv1o4NnLftB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5ty5AAoJEPo9qoy8lh71JkYQAJroN5DvEprLSTXVytP3bh/m
QOQRP58XSRRXtXA740qAPdk77MK6prWCtqjm5DdWHZzhylMsXgcUFGZz2CezNac5
7vJB1h1SdTyER7AsvrGocud8WWApEVgBNpe1iAV6SHOBnVJtd4BN6BRl/oQTt6s9
z5W8Mc7GQI/IBaokR2gK3oufzR2m5esFXP1pDGlkVJDt+ECVMPXxvwUBvwE6mIrq
YL7Hg8rB5NfzMT/5b3e/hG8aO7yiUsZdkQ94ARuZRkMsBhk63wP2NKvTpQvYvG2y
6O98rVErDBkovethFBrWeWJrpoDrgyUeQ67jEhGLGLaS5ePsKY//PF8kKHfcEk7U
2Bap8FlEKH8ftwBaVYpOLtfTngt7JpLpQYebgmfogHZf4r5lvqOxqf7GT6539iOx
eaQdN/J5d8bsDcaBzEkIKqCuaOJTo1UWUHzkdanQ4hrusaHLdl249Y1ZwObox+ia
PmGspeJ5oRB72WNY+lkushNArt8bbcAtQUWRKUVtrjsjZ/db2fLrZ2PoI76LUc2O
jtYDPFVnyLySOuVDiVPATtFpmGjfS5y9J11+Jg/86jmLpZ/j3CYDppktnfVSLgdM
Ukt47R0pjStIilSsoEaq47z2KVcKI+IIOsCgKNpPQYnEcDWy00E4RHmhw/376408
+md8wQBW+4/dXySkHEf7
=S7nn
-----END PGP SIGNATURE-----

--KUplgXDa5OCjEs8pbWXqfHVv1o4NnLftB--
