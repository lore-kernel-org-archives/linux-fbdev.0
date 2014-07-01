From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 06:14:02 +0000
Subject: Re: [PATCH 2/2] video: clps711x: Fix sparse warnings
Message-Id: <53B251AA.5080708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AKKKR9msoEXKScUwT2qs03Rnfw7qJJurk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
In-Reply-To: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--AKKKR9msoEXKScUwT2qs03Rnfw7qJJurk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/06/14 09:34, Alexander Shiyan wrote:
> This patch fixes below warnings:
> CHECK   drivers/video/fbdev/clps711x-fb.c
>   drivers/video/fbdev/clps711x-fb.c:247:24: warning: incorrect type in =
argument 1 (different address spaces)
>   drivers/video/fbdev/clps711x-fb.c:247:24:    expected void const *ptr=

>   drivers/video/fbdev/clps711x-fb.c:247:24:    got char [noderef] <asn:=
2>*screen_base
>   drivers/video/fbdev/clps711x-fb.c:248:35: warning: incorrect type in =
argument 1 (different address spaces)
>   drivers/video/fbdev/clps711x-fb.c:248:35:    expected void const *ptr=

>   drivers/video/fbdev/clps711x-fb.c:248:35:    got char [noderef] <asn:=
2>*screen_base
>   drivers/video/fbdev/clps711x-fb.c:314:17: warning: incorrect type in =
initializer (different address spaces)
>   drivers/video/fbdev/clps711x-fb.c:314:17:    expected void *__p
>   drivers/video/fbdev/clps711x-fb.c:314:17:    got char [noderef] <asn:=
2>*screen_base
> CC [M]  drivers/video/fbdev/clps711x-fb.o
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/fbdev/clps711x-fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/cl=
ps711x-fb.c
> index 4d17fbb..bbf40fe 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -244,8 +244,8 @@ static int clps711x_fb_probe(struct platform_device=
 *pdev)
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	info->screen_base =3D devm_ioremap_resource(dev, res);
> -	if (IS_ERR(info->screen_base)) {
> -		ret =3D PTR_ERR(info->screen_base);
> +	if (IS_ERR((__force void *)info->screen_base)) {
> +		ret =3D PTR_ERR((__force void *)info->screen_base);

I don't see any other user of devm_ioremap_resource() having that kind
of casts. Why are they needed here?

 Tomi



--AKKKR9msoEXKScUwT2qs03Rnfw7qJJurk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTslGqAAoJEPo9qoy8lh71DJ8P/ieb+SAO+r3arJyn8w29bpLQ
Hm+XBYJZasWqWpsXAgjyLTw12Q0p3+tASsIW1nMpWZsZRkb2ecviZNmU0M9ERMb1
nR3ZuSmqF5prAeHbgbfzfkzKywc8gBJ8Gm4RxH/UBIJaXvbelvd8duZFH0GasFDA
4sbi4q0QcASM5jdis/rYt5ahZdS055LfIDfSP7n7Z0xO6sJztpB0s6XP67Q9iveu
jIeDovoQVfD/UoEsDv46gqDwjZiuIBRo6u1+Qri4cVJH+o3jbFVJPLiMum0YXkfS
Mw7dIEfndEe4iupLlMeKH2y6DBAzjURCv66PG/2ULCwK+I6+9teWk0BmQ+t1ELqY
eLNZmGfjsLQK2sSLAG667zh1foD6KrdYiN1oE3dZ+Klv3D8zubiY7Bnyd4zKCX2X
2dykrTQGOkF8fRB+wxb2G39pjWnf/3WR0/AozbWExTwJUjqmCkSmsgXqjMxvwbMn
jGJwAuzkXss3TUP6mz9mDh+F1FXia36eURtv5KmwGai7sh5iSpL0vCfQTJjZdNKW
pEFzj/T6FRaO5gYHYDLdvQdIJnGJ3zTdDvt9Z48fRuWph7EePN4fkWbNDtwAEYXO
AbCe/Y4Q8zOPY7+81WCRcy8I0/aO7D/Js2XF6eOMakyyesoqXNAFoVkjVx/6+cs2
+ba/WrgAWYgZGt3+Arps
=GYqG
-----END PGP SIGNATURE-----

--AKKKR9msoEXKScUwT2qs03Rnfw7qJJurk--
