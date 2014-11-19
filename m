From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Nov 2014 12:51:09 +0000
Subject: Re: [PATCH] video: ARM CLCD: Remove duplicated include in amba-clcd.c
Message-Id: <546C923D.6000800@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lHKtTusqfS2bWCjFlCkfEBJ3AQXn0RhPa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416216301-15854-1-git-send-email-qiang2.chen@sonymobile.com>
In-Reply-To: <1416216301-15854-1-git-send-email-qiang2.chen@sonymobile.com>
To: Qiang Chen <qiang2.chen@sonymobile.com>
Cc: plagnioj@jcrosoft.com, linux@arm.linux.org.uk, pawel.moll@arm.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, qcwj.lk@gmail.com

--lHKtTusqfS2bWCjFlCkfEBJ3AQXn0RhPa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/11/14 11:25, Qiang Chen wrote:
> This patch fixes duplicated include dma-mapping.h in
> drivers/video/fbdev/amba-clcd.c
>=20
> Signed-off-by: Qiang Chen <qiang2.chen@sonymobile.com>
> ---
>  drivers/video/fbdev/amba-clcd.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> index 6ad23bd..32c0b6b 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -27,7 +27,6 @@
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/hardirq.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_graph.h>
>=20

Thanks, queued for 3.19.

 Tomi




--lHKtTusqfS2bWCjFlCkfEBJ3AQXn0RhPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbJI9AAoJEPo9qoy8lh71TIMP/j4N4ijbgcD4kNa/e1fStgdJ
QcAqYk5a8++vduLHYK7JN6+QB9AgRjidFEpDZVcVGDlZ06wMAmyovqEK9MjvGV8D
rDz4Zv7nTzNfFTxI+2nnWHN8FeETVKlsQ8wsDFbZo9wOcAFpNUIgxIQo45sbXIr3
aRU8Tcgbm56WjdHJCUkvIWrGhu9RSyie/LqiUH5S1ne1fafW2HsCdID4ppMMY/bZ
ziyJUQIQtW+1hdOPdARIlfB96Ehtou/twD10A9pMh7aDluim7agZEeUwY9KjIeoI
/UZROA2Iy7esCVWqgnIO4RK1+syOWUShSe1sp5uFAUpCbdPpkZAF06BJGIt2iC2m
MYu0lBRLMg8kZc8vz4i9yj9K3PCxMwiCRY/fmUqGuSpzJLe3ITTwm8I5zVXl9GAa
Oq9ZhfHuhe36zx+b4PAQsVGqbeogUZGlFuX6c2KCYkA7TxcEm5RIeyiwxoJeP54K
vKdrS93qatMwMdBJiJkFCeUd0MYiVZ28q90/MpOCbpbJMv+56nRhAkaiMsFSBESt
PV0wsGoXhmlVswi6TRCWHhbs+0ahYkShPXtNxsFsvq+feb2YJtruEPwwopYU5YmU
KBUl3PtAaJECv0mkGWnkO6/e4viFc6b3kSYJahYkpoexJLsOZ2ocwhdGToG9WNZs
XFujtA7IUHA2ystzfkZr
=0rin
-----END PGP SIGNATURE-----

--lHKtTusqfS2bWCjFlCkfEBJ3AQXn0RhPa--
