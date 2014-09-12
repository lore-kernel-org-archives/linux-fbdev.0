From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Sep 2014 08:50:55 +0000
Subject: Re: [PATCH] video: ARM CLCD: Fix color model capabilities for DT platforms
Message-Id: <5412B3EF.9090604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rp0vie7xMJwOCl3LqS5qaRlSomnqj8TOx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1410358553-2344-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1410358553-2344-1-git-send-email-pawel.moll@arm.com>
To: linux-fbdev@vger.kernel.org

--rp0vie7xMJwOCl3LqS5qaRlSomnqj8TOx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/09/14 17:15, Pawel Moll wrote:
> The DT-based panel capabilities selection was picking up
> a subset of available modes based on hardware configuration.
> This was wrong, as the capabilities describe available
> memory models and adapt the display controller to them
> that the RGB output is wired up correctly (as in: R and
> B components are not swapped).
>=20
> This patch fixes it by removing the unnecessary limitation.
>=20
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/video/fbdev/amba-clcd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> index a7b6217..6ad23bd 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -639,9 +639,7 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb =
*fb, u32 r0, u32 g0, u32 b0)
>  		if (g0 !=3D panels[i].g0)
>  			continue;
>  		if (r0 =3D=3D panels[i].r0 && b0 =3D=3D panels[i].b0)
> -			fb->panel->caps =3D panels[i].caps & CLCD_CAP_RGB;
> -		if (r0 =3D=3D panels[i].b0 && b0 =3D=3D panels[i].r0)
> -			fb->panel->caps =3D panels[i].caps & CLCD_CAP_BGR;
> +			fb->panel->caps =3D panels[i].caps;
>  	}
> =20
>  	return fb->panel->caps ? 0 : -EINVAL;
>=20

Thanks, queued for 3.17 fbdev fixes.

 Tomi



--rp0vie7xMJwOCl3LqS5qaRlSomnqj8TOx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUErPvAAoJEPo9qoy8lh71FrwP/3Ws4xIrP+Ma5wPTHXKElIAW
we7DTp2mvOBA91ae27GD8XYkfE4vl9+eC9X4WmvjwQqNKeeYGb8o0EaoF7C+FoyR
DPrVUajhWN+A+90v67cd4t7OfQrpDPthKzFHFOW2jK6FgRuTsalGBBaJmlUBS/tY
XFhnsgUr/mpk2Ll2YC+lgsJni5tpkI3vMYVnNotRB9PHz4VZjQsb2uZ+cgimcHvs
UgiOCU7rFG0gfNmxwfX6B2rm+x8NgqLKeX8sBm+lSpOiS8F5URWY9A2JtrLyOvtX
k05GZekteqhGNCkT6xCTeGoitgI69d/zUSaFEo0aEGPYnbrP8zY5XXU0Wf3oqHG7
sC893KnK2l54j194L+YnAnt9cwdP42ChZqrA7OHJOxe+N495WUGF5XR/49KEwtSZ
1qbZOPNwczBFI7pWDGIAhRjo9QVACHF7uBcErUvoL/TJzvh/jEdsa374U5nvPt0Y
fOT+IU0tHY5B58U1WWRqX7usYiXOIiCJFepQXfepEeNETfqltDXLhVxfpVm+uNz1
+uPKAEQoRdEYuKGCG2vnu5KvnLCAX+6uMt0iAuixRqV07XGgnPmuyiUPGWv4IDV4
F/nsmjNH0osshkT3pqRFRGw4R73AxzJ2fkWCsqGB65a6UgGOo1vDSXZzzqxDOReL
ER74njztnjCQKk0xAi7x
=HDIa
-----END PGP SIGNATURE-----

--rp0vie7xMJwOCl3LqS5qaRlSomnqj8TOx--
