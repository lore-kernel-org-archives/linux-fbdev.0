From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 09:05:58 +0000
Subject: Re: [PATCH v3] simplefb: print some info about the registered fb
Message-Id: <52551C76.8050600@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LwwfGFORCf97aihrbJ4GhvvQ64ieBOnV0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdXDAA3PgbgNrccStUZGByDXuSsMG_yJMwwUWXwMvyOfsA@mail.gmail.com> <1378562915-893-1-git-send-email-teg@jklm.no>
In-Reply-To: <1378562915-893-1-git-send-email-teg@jklm.no>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, David Herrmann <dh.herrmann@gmail.com>

--LwwfGFORCf97aihrbJ4GhvvQ64ieBOnV0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/09/13 17:08, Tom Gundersen wrote:
> This is similar to the output printed by efifb.
>=20
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> ---
> v2: also print smem_len, as requested by David
> v3: don't cast, as requested by Geert
>=20
>  drivers/video/simplefb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index a29f1c4..50cbceb 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -220,6 +220,14 @@ static int simplefb_probe(struct platform_device *=
pdev)
>  	}
>  	info->pseudo_palette =3D (void *)(info + 1);
> =20
> +	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%=
p\n",
> +			     info->fix.smem_start, info->fix.smem_len,
> +			     info->screen_base);
> +	dev_info(&pdev->dev, "format=3D%s, mode=3D%dx%dx%d, linelength=3D%d\n=
",
> +			     params.format->name,
> +			     info->var.xres, info->var.yres,
> +			     info->var.bits_per_pixel, info->fix.line_length);
> +
>  	ret =3D register_framebuffer(info);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
>=20

Thanks, queued for 3.13.

 Tomi



--LwwfGFORCf97aihrbJ4GhvvQ64ieBOnV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVRx2AAoJEPo9qoy8lh71sHEQAJgdvb9qb6JVfM3sTZDtGA9a
Jz7SlA3qlh2IGLtMQ7PJfOM+S280azNHh2iMWBt/R+1/s/vc7xutlULhwmwgiJgT
622enutABR3dix+uCdbEeltTD2amtZTaFaX2nj7AWzp1dOyZxU5s+trprbx4NM0+
LdREWDl+hG9IRFVNlQDJmmLCPzVxOKT7+Ui9BXf4MrcRSotRFYGW+wqrphn3+Wqw
Z4eOqhcJZpMntVWhHmwvQuJ+bmXHYg0ZfrQ06My0z6RqM1Rf/Vr2VAwkCXxHlaqY
GjkQjfIUK4DHpBLsEEuZBIQt3UH8RdHBbZR+P/+EDbMfn3bJCAgj5gFN/e7B5sfm
dU0qWACxw5fT0YKOJr6Q1KpjXIzDEconuhLE+qwRc1LJJSasCB/me3RMg6Ap+zax
pF6eArUUjIZgDRkddCDOLfCYQZkCZ6mFqxKNGlqePKkbQjyCI8QpDb1ajfMLjNZL
2X9QY5GGBvUiJ14ygBJS+kxeokoZO8L5j4AhVtf32vOyPa+vrn8DN14OZr6Gk0sG
R4qkB4bkw0y1Fi/hwpqV4BAjPQP1sv1oCy8aDLAhZPBiEHhS5Mb5eKRbu04kYa9b
ZNbZ7U3xxh/7ZKckxwsdo+Fujl/Fzk3MBJLrP2YRfm3pAs7ryzWU/vLTyswU2UBD
pIdtnMlIVXG+V4uTXOYz
=a1Tu
-----END PGP SIGNATURE-----

--LwwfGFORCf97aihrbJ4GhvvQ64ieBOnV0--
