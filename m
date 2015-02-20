From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:13:45 +0000
Subject: Re: [PATCH] video: fbdev: fix possible null dereference
Message-Id: <54E724F9.9010404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BmWJOqP3iK3Us49mMH8BBcASBCpdjhThi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423756056-15108-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1423756056-15108-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--BmWJOqP3iK3Us49mMH8BBcASBCpdjhThi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/02/15 17:47, Sudip Mukherjee wrote:
> we were dereferencing edid first and the NULL check was after
> accessing that. now we are using edid only if we know that
> it is not NULL.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/video/fbdev/core/fbmon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 9533859..868facd 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -624,9 +624,6 @@ static struct fb_videomode *fb_create_modedb(unsign=
ed char *edid, int *dbsize,
>  	int num =3D 0, i, first =3D 1;
>  	int ver, rev;
> =20
> -	ver =3D edid[EDID_STRUCT_VERSION];
> -	rev =3D edid[EDID_STRUCT_REVISION];
> -
>  	mode =3D kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
>  	if (mode =3D=3D NULL)
>  		return NULL;
> @@ -637,6 +634,9 @@ static struct fb_videomode *fb_create_modedb(unsign=
ed char *edid, int *dbsize,
>  		return NULL;
>  	}
> =20
> +	ver =3D edid[EDID_STRUCT_VERSION];
> +	rev =3D edid[EDID_STRUCT_REVISION];
> +
>  	*dbsize =3D 0;
> =20
>  	DPRINTK("   Detailed Timings\n");
>=20

Thanks, queued for 3.20.

 Tomi



--BmWJOqP3iK3Us49mMH8BBcASBCpdjhThi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yT5AAoJEPo9qoy8lh71XPcQAJBsfSLXjlh1OwFTED1qSAzX
ilzkzrNCG/tQnkYxZ4UTyQ/GuTj32ioVpKbnCV7M4gOJ08uc334HFJise5B0Qicl
vCnecYBE/nD3fXV6G/Ks+SRCPrNZ0tOzzaDTQVtQbfbKhngzHyE0COFh5y2Jc4lX
x1RnGdiesF21/Qv35MiIT6jl/RCdJjbgTg9aITd/zxDxtbikSxbgzXH+1xFJlDo6
JzaEteQUXAMo9zeJdfJqji9ti4JaWqOgM6eGOH8z66o4pIDQJbjJPwCaWalKiAOe
/xSbKon55rHV6gubXLsERThYSOeu15SBHyl415vDk/EWjhblVC44rTUgPoCXZP+k
Y6EPR4wii2kSqkKVmZfc7+bxVSOqC43OVrx3E77vgVsiFKSW1A/+aYVH+8455ry1
C9m7cI/CPyOL0eiv0CmKr35/eN2DO5Ku+uuonxA59QlwaZeR9c3y/qNjiQh1odtY
7q3Cn7moaZBW3YdCbnBaZufCL4cIG6vP2oQWAVZnoECkMan8wmTmp7fnFQzq+Etd
HUXXpOHbuU8iXUX0KLdtL0nXQHeycDJ4xkK3NDth9SWKp6s0iFQQLDVo8Gf8k01q
d1csfuGGvZAezPkCZ7qQaOBxyyyqy5E/qwXVOYaIN0od2z+VI2GE/TX63xA4AKOq
wqIEflHJch0483I8lRxd
=btep
-----END PGP SIGNATURE-----

--BmWJOqP3iK3Us49mMH8BBcASBCpdjhThi--
