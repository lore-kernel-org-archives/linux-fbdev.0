From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:10:08 +0000
Subject: Re: [PATCH] fbdev: sm501fb: use memset_io
Message-Id: <54E72420.4030605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6OGuudDxUcECWMHVQNgKCCxlMgCwD6WOp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423571852-14511-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1423571852-14511-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--6OGuudDxUcECWMHVQNgKCCxlMgCwD6WOp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/02/15 14:37, Sudip Mukherjee wrote:
> we should really be using memset_io() instead of using memset() as
> this is actually io space mapped into our memory.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> it has only been build tested. I only have the hardware of sm712 and sm=
750.
>=20
>  drivers/video/fbdev/sm501fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501f=
b.c
> index e8d4121..d0a4e2f 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -1606,7 +1606,7 @@ static int sm501fb_start(struct sm501fb_info *inf=
o,
>  	info->fbmem_len =3D resource_size(res);
> =20
>  	/* clear framebuffer memory - avoids garbage data on unused fb */
> -	memset(info->fbmem, 0, info->fbmem_len);
> +	memset_io(info->fbmem, 0, info->fbmem_len);
> =20
>  	/* clear palette ram - undefined at power on */
>  	for (k =3D 0; k < (256 * 3); k++)
>=20

Thanks, queued for 3.21.

 Tomi



--6OGuudDxUcECWMHVQNgKCCxlMgCwD6WOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yQgAAoJEPo9qoy8lh71LZgP/AuZ8z4TWeMd9RrdrsWtzMCd
7VyUuxyQIvlaVDNc2Pre8xVs7RmEbrk5qzd4IAnEHeM5x2naL+gMmyL9g8RwYKaf
ZKS70oLEEvV/Ieh7yUD8qWEQI1qk3yLuRod6JF9iFY7ET4DO9cR7OAJF1rOP/Oqz
c2Zmb+oPpSDwEhTMhuCBh5BQ0B5QgWVpnqbfHGOkJK7H1NAPXfkomyI9qyvF+G5H
f4IG5zDH5iyircjfytIIXPruU3MYkzhnuU7ulhg0j70zcXygsk8W0gv13Q2woA8k
0pcPVkn0jxIuPoa9dzuW0kCIrnVlDwDEZTfjCB6wPYeFMT+ehcprRxgbXwWNUqWa
FGpH/ceXOEOhDIamEpzkyHgcYronKWZIXs70j7sAg+2s69Mi1eTpZJrCISEpM6wk
+V+NX3VTWqMx2t0sVHk26n/Pm6hZREyJq2ZIugoyD1lKXBL1EtjztSVFIedInqkR
DQQ5wfBRAJ9KfoEUG8v3QCwmT1vZ8dyLq1Uu8wxRtWxWovRheJySNQU9ik2aXfuR
dv98eFRPIPKIdEtzaib6oQ1eQqdtehTBwHHnsUF4YveLX8eVrlvWD6T+0DM4N1bQ
TiDGBMTOeIliV3asqMg0EAIDkDw5E1JSTYS7UF1ypkLyNmVHhVF0+GChBnhqXLVe
nBfe9MSzKcLCr7ZzE3gK
=rypR
-----END PGP SIGNATURE-----

--6OGuudDxUcECWMHVQNgKCCxlMgCwD6WOp--
