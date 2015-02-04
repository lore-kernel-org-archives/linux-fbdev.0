From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Feb 2015 10:42:41 +0000
Subject: Re: [PATCH] omapfb: Return error code when applying overlay settings fails
Message-Id: <54D1F7A1.3010309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ncxJJ6WNgFE7oLm9GiAU3WIxvaoNH5eiT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422604786-6804-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1422604786-6804-1-git-send-email-pmeerw@pmeerw.net>
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

--ncxJJ6WNgFE7oLm9GiAU3WIxvaoNH5eiT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 30/01/15 09:59, Peter Meerwald wrote:
> the check of the return code is missing, user space does not get notifi=
ed
> about the error condition:
>=20
> omapdss OVERLAY error: overlay 2 horizontally not inside the display ar=
ea (403 + 800 >=3D 800)
> omapdss APPLY error: failed to apply settings: illegal configuration.
>=20
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/=
video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index 146b6f5..9ddfdd6 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -137,8 +137,11 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
>  			goto undo;
>  	}
> =20
> -	if (ovl->manager)
> -		ovl->manager->apply(ovl->manager);
> +	if (ovl->manager) {
> +		r =3D ovl->manager->apply(ovl->manager);
> +		if (r)
> +			goto undo;
> +	}
> =20
>  	if (pi->enabled) {
>  		r =3D ovl->enable(ovl);
>=20

Thanks, queued for 3.20.

 Tomi



--ncxJJ6WNgFE7oLm9GiAU3WIxvaoNH5eiT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0fehAAoJEPo9qoy8lh71EV4P/3uv3bu2tsSj1SqQZtCuTGEE
Y/pRjnNP5LbkpyIZdQ/JICf+cGHwVgfgwA6J/fDiBHYJYAznBsh05bydoFXK2cpG
IO/SKwagvPWT3vvmX1NtaZVASzvLVKwuU65NJqPYIdx+pglb8fRMpDVyJ11F18fI
JJlkAD6uWBuPs8LP5QFaoNrjUMOd2a9IxyKlGwYCavSY2zsp/yn1HxfGAYlzqadx
/kZrXbPT/ufzdosS9BEiHMWIJ3IRFqTqV+q2Q67ui+vmALsLCDVqEkzHIXJcjcwH
EKPBouFGb091SQJiSfMPFt1DYnsdjU+0ZG29i8WEIo8xCdq/kRSwK6hatSX6YGiO
aBNS2VcDNfjNkrqCNQ6PGIIKzcQjNVYvYtTIB1mMv8tntxLCxA9JC9E5E4xHYnWE
d1MLWNpxgESopM5u/X3zBi4DLz/3b9EGPuP9A+mUDpWtbfKOuBtJp8V+H5hWVPyG
vTq8IocoynClhIp6py82ZSGpLfv+ogVlVcMKvpU4nmOdO8IxnClaFUMg/yxDT+AO
sxkiQFCQ741EXfLKHgbdsZw4lyxAtiR7hztgGZaR0QqZAScGxrHTq/RCr6bkARAu
thKUstwf+/iSOv+AaIlDIbYmnzFnDLS2GZeKMcJlSRB1HYceUTZuS3X5Q9yvAzUn
ViURYoR2wzwG+BGAtJ4Y
=fW6P
-----END PGP SIGNATURE-----

--ncxJJ6WNgFE7oLm9GiAU3WIxvaoNH5eiT--
