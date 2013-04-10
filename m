From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Apr 2013 08:23:09 +0000
Subject: Re: [PATCH 1/1] video: wm8505fb: Convert to devm_ioremap_resource()
Message-Id: <5165216D.8090705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigB17EB971E4FD592C34F602B7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365415496-6825-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1365415496-6825-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--------------enigB17EB971E4FD592C34F602B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-08 13:04, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handlin=
g.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/wm8505fb.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index 19e2e7f..01f9ace 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
> @@ -18,6 +18,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/fb.h>
>  #include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -303,9 +304,9 @@ static int wm8505fb_probe(struct platform_device *p=
dev)
>  	fbi->fb.pseudo_palette	=3D addr;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	fbi->regbase =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (fbi->regbase =3D=3D NULL)
> -		return -EBUSY;
> +	fbi->regbase =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fbi->regbase))
> +		return PTR_ERR(fbi->regbase);
> =20
>  	disp_timing =3D of_get_display_timings(pdev->dev.of_node);
>  	if (!disp_timing)
>=20

Thanks, applying on top of the previous series from Tony Prisk.

 Tomi



--------------enigB17EB971E4FD592C34F602B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRZSFtAAoJEPo9qoy8lh71p/wP/2FGqwan5HLlw0Q8ukwKX59s
qfE09j5qXEYQ+S1Zeq1XbWqX5HnOkM91yH6lxJ0D7zaB7ntc0+IixP5tUGlocxlA
hX8mIzcaBLzAZbfBQRqGg4TQWETCPLffkWkubakE8VW2lVaBJt5ITlZ6AMMtmzip
nJLJj0De9d2Xi6+7foe4r0mAHDCmt2AZwBxcw1f9rCV8SPgEQPeQqhpLAgRsEB5d
7v7l3d6Z4fbgGsywdVQGs1ej9eWdyzk9psHnn02VsNLKlPUCM89sGKeiwZGWKDKs
jSA9lYXHdSJJyYshhoS9nARHQN9D7w+sDW0jogWtLj9o/SIQnso6s2BDybGH6vRr
5xWNu/mHlkIb07XYyeqahFmSloi/+JqUsGZJkLS4NwoTUs9E+oUaH+YJRZXFAsdd
V/CMun/IzbujiiSlvFm3N4dbpRg5LFF8uKP8lUUMzgCRD73t829P+4Y3Vbc4C2NG
DpxzCKFZ7mJrVGKuIasMfcZmTPdBT49vK4XIvidqcS88ukdydc3r/Z/OicGngMi9
DP1VVdRkmgAwn5SnFMz7XYANPjCLN9ZnsSur3AKlGNGYPo69In0UZOtqZOddFd+f
oxUZ21t/vk/dtYZ4QRyoI7BXAe2GnN8LDOXJQ6Gx3ImtwRN5YJVnKgIGB6eKHrxe
Y7sq9O8yJ/wCpJsZFZq6
=WoPI
-----END PGP SIGNATURE-----

--------------enigB17EB971E4FD592C34F602B7--
