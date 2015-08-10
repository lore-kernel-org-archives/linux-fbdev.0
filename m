From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 09:53:59 +0000
Subject: Re: [PATCH] video: Fix possible leak in of_get_videomode()
Message-Id: <55C874B7.4090704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iikOjOrBRmHlJ2LTtNwD6xFXDu3HSIKpA"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--iikOjOrBRmHlJ2LTtNwD6xFXDu3HSIKpA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 11/07/15 20:46, Christian Engelmayer wrote:
> In case videomode_from_timings() fails in function of_get_videomode(), =
the
> allocated display timing data is not freed in the exit path. Make sure =
that
> display_timings_release() is called in any case. Detected by Coverity C=
ID
> 1309681.
>=20
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---
> Compile tested only. Applies against linux-next.
> ---
>  drivers/video/of_videomode.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.=
c
> index 111c2d1911d3..3495b48c6805 100644
> --- a/drivers/video/of_videomode.c
> +++ b/drivers/video/of_videomode.c
> @@ -44,11 +44,7 @@ int of_get_videomode(struct device_node *np, struct =
videomode *vm,
>  		index =3D disp->native_mode;
> =20
>  	ret =3D videomode_from_timings(disp, vm, index);
> -	if (ret)
> -		return ret;
> -
>  	display_timings_release(disp);
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_get_videomode);
>=20

Thanks, queued for 4.2.

 Tomi


--iikOjOrBRmHlJ2LTtNwD6xFXDu3HSIKpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyHS3AAoJEPo9qoy8lh7159UP/2dFTS1jg3Qgf3ijqfi/2jYZ
wXwo9joAh0+cZy0mctCId+e/6EV6EOJ6Y7bA3T7D/aBohVB0C2Kg5AkjW49/y2fD
S5aCKhN3iLYspTtGvL0Hx6lLWWTfU/njJVZhngSyMlyrErP1vl5RICYzTscPtjVf
/QNggcTO3YW4AynxJ4VJFw7wuvGG5Pk4yiRwHWpgLNIXbE8KaxeHRgdVlBE9z973
cGkYOzgWNkwDUk4K0A8PaAQ7w0v3jOD+bQiV1Lxu/fiz+u9GEfTUIETLXe+VFk5t
ntXGKNYgF/GYcwbSc7vO0btllt9E4WWBFLWusvXgM4upoX5bAeypwbL6WPQoaUQ4
UkhhhC9AxqXNTegheWYW+thXFhco4cn5Z355RhBEc/0n9x7djSa0PU3+eQJ8qWT3
dipPRqKVYONH7R/4Pj3+znCKAHr+0GR4ZWOnYK44yOb+nbvyVdPgKuNK+l/kRhNU
XCbJb9gFEFQ07RnboPrkvU26wx9/VfvhA9gETeLQd8xz/xyq39sJOSTN6bFZQrlr
nItmG3NVwg6V80472V2hAhCAu+50FrOmfKJ6Jb1xDjmhO385rVO9bXUmfB4jqPjy
Zmv55MTn2XYX1x1U8DGhJ/+TRhvb0Dq5/9xZoEwU4XcHyuWI/kbWy54zDx3yRlUo
A5P0xQ/n+rabzjt2RUf4
=PXoC
-----END PGP SIGNATURE-----

--iikOjOrBRmHlJ2LTtNwD6xFXDu3HSIKpA--
