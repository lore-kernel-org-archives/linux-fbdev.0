From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 May 2012 10:28:28 +0000
Subject: Re: [PATCH] OMAPDSS: OMAPFB: always allow to configure overlay
Message-Id: <1336645708.5182.32.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-T9T9qvLfHz9R7Yy0KCOy"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336144581-25151-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1336144581-25151-1-git-send-email-notasas@gmail.com>
To: linux-fbdev@vger.kernel.org


--=-T9T9qvLfHz9R7Yy0KCOy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 18:16 +0300, Grazvydas Ignotas wrote:
> Currently when multiple overlays are active, OMAPFB_SETUP_PLANE fails.
> Instead of failing, allow it to configure the first overlay as if there
> was only one overlay, the remaining ones will have to be configured in
> other ways (sysfs).
>=20
> This allows overlay-controlling programs (like video players) to function
> properly when framebuffer is cloned to another display (like TV).
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |   36 ++++++++++-------------=
-----
>  1 files changed, 13 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/om=
ap2/omapfb/omapfb-ioctl.c
> index 6a09ef8..58b7f2d 100644
> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> @@ -70,11 +70,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, str=
uct omapfb_plane_info *pi)
> =20
>  	DBG("omapfb_setup_plane\n");
> =20
> -	if (ofbi->num_overlays !=3D 1) {
> -		r =3D -EINVAL;
> -		goto out;
> -	}
> -
>  	/* XXX uses only the first overlay */
>  	ovl =3D ofbi->overlays[0];

What if there are no overlays? I'm not quite sure about it, but I think
it's possible.

 Tomi


--=-T9T9qvLfHz9R7Yy0KCOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq5hMAAoJEPo9qoy8lh71KlMQALIH8soyR4gpGDzU6YKhH3AZ
JYNN03uhm4q82FijEKfUIGu4Ue8q17QTOJhMC+wMsyJ6kX8h8Y0GRRGPwOSVQ4Tf
CEP9m20gske9jOlYqHCrjfEq25bJOtgw+JzDrJ9ufU+CiWNKWBI0Z5i4yqqNa7E4
aoz3ejf4vw9l0wkAqORk3tUDrpD7lVlxqaPKu7I33lqIQ5UtU3a0jdeyUbkbqrUu
Cq0Bc1Wac4UyNx5a4ZXO3LGD2YVaytpyFgjqn14MUHK2XZxZFER4eOkzmC+wab8v
82cbWNo196WKo3bdT+GZNmimOORQ7E47D781+t0do0tGRxLWEURrlGTdXhS26MiL
NQ1Gz0j54oaLvVTnSkJ2rbCw7YGXpqnkd6Ax72C4Fjh4Gtwhv7KrnrtAZEArcpRe
z5v4ef/ldmHjNu5vpqafYyd/FPyXLlSimw6+dIbvqzMOY+ve8ZDt0cpc6zX7EMEg
CPQGeRQyFyf0Cdk7Cc8t7ANsGld+58q2Zes/rHdNT9JtNsMCDqJfZgCopHmtiU4F
Km0J0U3YgeWdN/zn1S9maZQgN8ozdSNhJ8FsocEAB2F4it+2J7tgSUzEcohgPYVH
68ACgIcjY/q56k5ROB5JqrchKuBQVtx3I6OXD069ndL0s2XIu8MZjPIHMpEQwojn
eS1V1Gjbc/UyT46a3HAd
=Hu5r
-----END PGP SIGNATURE-----

--=-T9T9qvLfHz9R7Yy0KCOy--

