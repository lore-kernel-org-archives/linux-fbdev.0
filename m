From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 08:41:55 +0000
Subject: Re: [PATCH v2] drivers: video: fbcmap: remove the redundency and incorrect checkings
Message-Id: <52205AD3.5000002@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sbWoHEwGX3Fuxn3wIolmLJ6akmfrkkdiw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <5212D594.3020802@asianux.com>
In-Reply-To: <5212D594.3020802@asianux.com>
To: linux-fbdev@vger.kernel.org

--sbWoHEwGX3Fuxn3wIolmLJ6akmfrkkdiw
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

On 20/08/13 05:33, Chen Gang wrote:
> fb_set_cmap() already checks the parameters, so need remove the
> redundancy checking.
>=20
> This redundancy checking is also incorrect, the related warning:
>=20
>   drivers/video/fbcmap.c:288:2: warning: comparison of unsigned express=
ion < 0 is always false [-Wtype-limits]
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/video/fbcmap.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index 5c3960d..f89245b 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -285,13 +285,8 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, st=
ruct fb_info *info)
>  		rc =3D -ENODEV;
>  		goto out;
>  	}
> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> -				!info->fbops->fb_setcmap)) {
> -		rc =3D -EINVAL;
> -		goto out1;
> -	}
> +
>  	rc =3D fb_set_cmap(&umap, info);
> -out1:
>  	unlock_fb_info(info);
>  out:
>  	fb_dealloc_cmap(&umap);
>=20

Thanks, queued this for 3.12.

 Tomi



--sbWoHEwGX3Fuxn3wIolmLJ6akmfrkkdiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIFrTAAoJEPo9qoy8lh71RE8P/0cWwQc4niKOVQd5Hh63GuCn
uNYR0ibxIkXnmP6NGxBIIuPoqzZ7pvoY7zaobr4OYG3z5M5fLHb7b9ZnY7HH/5jT
Axv2uZf/KrN8vXQKdsNuM6vn+Ais7E2D0RQllX2oOzJsUSddGNkW6RrMJl5fE63b
BZ8YWUTgn+eJAXDRMBO4TFRVi93FgMQDqC74hB1Na+Ra27q23iFOyX+FHnDRvvgS
QEA/RqzKamjCgGuVxsBR4WqrAg1SQCYiVR8ifoYJL3hzvT9+OpCHLw05Mp1i5cYl
BAldJJdnuI0rB52f5KZ1xzt4vfVaAGZO315yJTn8wRro8/DjeFj1GvpedMlJjOwx
7eoK9Zwc48A/5Ge5LBxHki6MrFNxj5tWzUQnxxNZoldFDqCGnaX4Ig9tZdutiEKB
inv7ErS3r7TjNCh86BBo4Rza1cJbFrkpdNBcLwA7hqXaB1xppsqcaDXsp9fFIbJj
XhfEHj5mo/CbFAcSt2ZUGHMqm/NUlym4dcba9jiNgjbOUww9wKFbb+0hOUM3kkI2
Kwplu+0KL0GfG9Izac4ABCnYNfTV6MILh/V6wOz1ZRZaT45Cx8nT53KNZi96NBjC
GYw8r1FbVWnxUzbL/XhzC2TafVo83N5bX+meS3UNAfRMUstD4i6OBIlubayl6Bm5
KGWxagMLL7F+cwuFGMyb
=hNTJ
-----END PGP SIGNATURE-----

--sbWoHEwGX3Fuxn3wIolmLJ6akmfrkkdiw--
