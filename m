From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:08:57 +0000
Subject: Re: [PATCH] video: fbdev: i810: add in missing white space in error message text
Message-Id: <8b5cc5cc-14fc-02bf-64b3-251471802747@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S3ixbme0tpls7MX2MNwJ2gHoV1Hg698MT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160912121412.31730-1-colin.king@canonical.com>
In-Reply-To: <20160912121412.31730-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

--S3ixbme0tpls7MX2MNwJ2gHoV1Hg698MT
Content-Type: multipart/mixed; boundary="VTNAHkVdx7JnitJpdmbu1G8Uc3VUSHDet";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Colin King <colin.king@canonical.com>, Antonino Daplas
 <adaplas@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <8b5cc5cc-14fc-02bf-64b3-251471802747@ti.com>
Subject: Re: [PATCH] video: fbdev: i810: add in missing white space in error
 message text
References: <20160912121412.31730-1-colin.king@canonical.com>
In-Reply-To: <20160912121412.31730-1-colin.king@canonical.com>

--VTNAHkVdx7JnitJpdmbu1G8Uc3VUSHDet
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/09/16 15:14, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> A printk message spans two lines and the literal string is missing
> a white space between words. Add the white space.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/i810/i810_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev=
/i810/i810_main.c
> index 025b882..30f6a74 100644
> --- a/drivers/video/fbdev/i810/i810_main.c
> +++ b/drivers/video/fbdev/i810/i810_main.c
> @@ -1691,7 +1691,7 @@ static int i810_alloc_agp_mem(struct fb_info *inf=
o)
>  	if (!(par->i810_gtt.i810_cursor_memory =3D=20
>  	      agp_allocate_memory(bridge, par->cursor_heap.size >> 12,
>  				  AGP_PHYSICAL_MEMORY))) {
> -		printk("i810fb_alloc_cursormem:  can't allocate"=20
> +		printk("i810fb_alloc_cursormem:  can't allocate "
>  		       "cursor memory\n");
>  		agp_backend_release(bridge);
>  		return -ENOMEM;
>=20

Thanks, queued for 4.9.

 Tomi


--VTNAHkVdx7JnitJpdmbu1G8Uc3VUSHDet--

--S3ixbme0tpls7MX2MNwJ2gHoV1Hg698MT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6ikZAAoJEPo9qoy8lh71xmoP/3f+xGuJOMMkgIF089xoNUhp
jDbF0iiHeiOFvUl2ikjaecN33aCs1ndu0z8ooYplWkb23sGnIkhhrirnJAWWXe9/
vA8i6INQ+7RhWJB5GOcrHZSny8ZecHZJrD6yQ4FUsK1d0NRNoOLfwJ5Tk7TG0Oac
O0VdnX1mgC36UrJYUT7SYD8X5cTI+EJWT8FjOpIZN/CksCrrb80MQAtCi2TZfZM4
8Gjx9iIQfQdlvV/kclPbDhRhaPiLiA3VwLJfUpycw/+0AlKEIeiyGVbZnNvwpJMC
61SMSUfvMWIO2+oFTtuDjtY9nfwwUOfeQhtfAi3f0gn44PucI33N+grxhPnUjFfB
cZcNWFrDcQ5QIT95nFJ1YjNvL9wmtHyTM8I/HBAS49urku7lp+59Dxv0R8ErrR5R
fBvFJk0LX1+2XOJHyVR+GWpyCtPWBFo5nRx0qxxZO5VIqOfgb0s93FfyqfUF/pZ1
NU4wk1xdrWa6aNQ3+46erOCl9Zkmuh/SBzTucYuT0EY5ueBibgtWoJDO/GhlnNKi
LSiZOvsbWBXwCexZ8l9in+Qi/I3Ed4yP8awX/+82mjjVjmSqPLnIFiow52oiYu3V
hoyu/+YxC+k8Sc4xfEquNvoPK2uG8fqNguQABvVqcQNef+tkAgKjD0Rcr5fdUUNt
zaskU56WJ8W5GMYLSorE
=NSYc
-----END PGP SIGNATURE-----

--S3ixbme0tpls7MX2MNwJ2gHoV1Hg698MT--
