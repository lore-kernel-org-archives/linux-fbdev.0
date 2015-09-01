From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 10:35:57 +0000
Subject: Re: [patch v2] fbdev: fix snprintf() limit in show_bl_curve()
Message-Id: <55E57F8D.6090209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W7upFCIChVwC4NpDbxtqwkV3x9dutLRfL"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--W7upFCIChVwC4NpDbxtqwkV3x9dutLRfL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/08/15 22:54, Dan Carpenter wrote:
> The limit should be "PAGE_SIZE - len" instead of PAGE_SIZE.  Also let's=

> use scnprintf() because snprintf() returns the number of bytes which
> would have been printed if there were space and scnprintf() returns the=

> number of bytes actually printed.
>=20
> I don't think we are ever going to actually hit this limit in real life=
=2E
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/c=
ore/fbsysfs.c
> index 60c3f0a..15755ce 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -485,7 +485,7 @@ static ssize_t show_bl_curve(struct device *device,=

> =20
>  	mutex_lock(&fb_info->bl_curve_mutex);
>  	for (i =3D 0; i < FB_BACKLIGHT_LEVELS; i +=3D 8)
> -		len +=3D snprintf(&buf[len], PAGE_SIZE, "%8ph\n",
> +		len +=3D scnprintf(&buf[len], PAGE_SIZE - len, "%8ph\n",
>  				fb_info->bl_curve + i);
>  	mutex_unlock(&fb_info->bl_curve_mutex);

Thanks, queued for 4.3.

 Tomi


--W7upFCIChVwC4NpDbxtqwkV3x9dutLRfL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5X+NAAoJEPo9qoy8lh71XE0P/2ZSrxNcpdxCIIbZKxDPRd5p
M9fryGXcunP0gTeCiG2qDGTwsv+TFuNZr/prN3s7Jnb0J7FTP+yKvb2sZsfFM4sl
SvZ812s540et0PJFs1KTVS9A2XQ/zA0NgDeL7LZ+h02H4o3M4lOopXmfWOfvqn3O
o6jWUStUp519HO/NK4W1j/0gtpn9lvqnJ0keRbU+F+p5jwI3HXgOt7swmcr1juFs
fsZX5BtPrMxlWSGmGW0TWfIAQGGklEHB1n/fgAbBob81sgR+giWy64/2geBfLfXH
tSjYMvLdfXX+CV4FCyVQh1QeWgdi70m7DTzWByDk2DhlnQbIO6BYOgMhms+ZkZfM
VWP7VYGRu01FjRxkG0SuPu7eIHpZeAw0bzgJZTYI031Xm0Mp07aTHwHtiATTsJk3
eF1GN/TuIiZs29OTRr3WIJMsfGqeNxan5scrzRFdLLKRdDdZzeJyXGrT5/zhvfgO
n6MOHGXtpplADZ17xpyd/GRMuI68KosDg2DwGApnbgdHsddwyaL5DT9997T9h0C/
SjT8vejEdKC8vs0Woz5MgIaLo275OsHJgL+fIOevu+XATg+Ebxgl/moMweumdn3v
bwNhTl73ma+qFckKb2MAEFajFJntFk4C2gHEAAVw9hwhXeAECFvgGp23YX/BskeR
rA6qFK4EMpF77YKhJZUU
=HZhM
-----END PGP SIGNATURE-----

--W7upFCIChVwC4NpDbxtqwkV3x9dutLRfL--
