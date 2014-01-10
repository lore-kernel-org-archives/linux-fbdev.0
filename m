From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:31:42 +0000
Subject: Re: [patch 2/2] video: mmp: Using plain integer as NULL pointer
Message-Id: <52CFDA1E.3060902@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VntJiupCc59N6Jq4JLpFFAVrkxHjcaAKO"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--VntJiupCc59N6Jq4JLpFFAVrkxHjcaAKO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-14 10:19, Dan Carpenter wrote:
> Sparse complains here:
>=20
> 	drivers/video/mmp/core.c:33:16:
> 		warning: Using plain integer as NULL pointer
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
> index c8d4265..b563b92 100644
> --- a/drivers/video/mmp/core.c
> +++ b/drivers/video/mmp/core.c
> @@ -30,7 +30,7 @@ static struct mmp_overlay *path_get_overlay(struct mm=
p_path *path,
>  {
>  	if (path && overlay_id < path->overlay_num)
>  		return &path->overlays[overlay_id];
> -	return 0;
> +	return NULL;
>  }
> =20
>  static int path_check_status(struct mmp_path *path)
>=20

Queued for 3.14.

 Tomi



--VntJiupCc59N6Jq4JLpFFAVrkxHjcaAKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9oeAAoJEPo9qoy8lh71ISMP/j3BTOq9ahorG2SDXLxe0rre
Qs9cBl5zqTzDkoVyUM4wRRn+I7QsII99bYKDpgeuKBtALnhgd3iTm+VtGXpJJPC2
O2JaQIkX6BQPmNaV0l640aPT7yjrNpM0m75/AtiAMAsV88gJQsfJWUisvFZVs+G0
FEzv+94UtZOUBq9orW4NHIJQp2BUo6Aj3Zd8UG3tqkjIdC2kHwxieBI+ytWjDL0X
ZaVTbeXQ+fHaGMwuvwAWOs/7htVDUOuqvNL8ZnzcnnkKYXQft20L5T4zHZs5jGKi
VAT0ChTNrI/O/26S0Iog4hHaT1R8mCFPahFH/JBZNkIgJCDyGOXE/nySJ9mC/Biz
z+GwK2fSbQzEJ83zwCPCHroade1oI4qYRHvZgbO6aooqW1CU8AuMthQU2Qla9sXF
uuQbiqb+FCkxkpJ2fKRwhgNHusD5XZCCcNYt/bPN70di/mlUmsM6X1EjyIRmSuU7
XunpbABNcN8Z883A1xr5U3PbmOqyMaAIDMbZre9ENAkZvCuWiblHD2TSZDL+2NUD
xMDvO+4ZXiS3Fs9n/mzZruP/zTH1j0Ye8yAEfS4dTvSGWf2f8Ge3ML7Pld8PlGq4
YUFN0z1pWKANm1tsSlIeg8EWl03RLlmiCB1rye0SfdJ7M4NeHd90avlMwFgz7mPP
DuesFko9b4ALrGYXBG6U
=LX4U
-----END PGP SIGNATURE-----

--VntJiupCc59N6Jq4JLpFFAVrkxHjcaAKO--
