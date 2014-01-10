From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:33:39 +0000
Subject: Re: [patch v2] tgafb: potential NULL dereference in init
Message-Id: <52CFDA93.7080000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tTBQerjnMag3Je2cPGPppp79KrXIxGCGx"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--tTBQerjnMag3Je2cPGPppp79KrXIxGCGx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-16 11:49, Dan Carpenter wrote:
> Static checkers complain that there are paths where "tga_type_name" can=

> be NULL.  I've re-arranged the code slightly so that's impossible.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v1: had introduced a "dereferencing uninitialized variable" bug.  Thank=
s
> to Geert Uytterhoeven for catching that.
>=20
> diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
> index f28674fea909..afd8887fd656 100644
> --- a/drivers/video/tgafb.c
> +++ b/drivers/video/tgafb.c
> @@ -1496,10 +1496,9 @@ tgafb_init_fix(struct fb_info *info)
>  		if (tga_bus_tc)
>  			tga_type_name =3D "Digital ZLX-E3";
>  		break;
> -	default:
> -		tga_type_name =3D "Unknown";
> -		break;
>  	}
> +	if (!tga_type_name)
> +		tga_type_name =3D "Unknown";
> =20
>  	strlcpy(info->fix.id, tga_type_name, sizeof(info->fix.id));
> =20
>=20

Queued for 3.14.

 Tomi



--tTBQerjnMag3Je2cPGPppp79KrXIxGCGx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9qTAAoJEPo9qoy8lh71t6gP/A6ff91uTgMTXeGfrU6d2tcs
J08VRCZVJCavdFaNcBvX1+mAwv9c4TF2/f7WQ19p1R6cFZKdUOfu3Qg/AfPC88IL
sGet8Xq0V8VUcJWypBrapX5f1CpXh/mxG7kpt21hOLRweVmLHcXfFcAtzGsyAZ5E
aERIM40PM5RuExu9QhA+BeZ58nBXch+PDJJwesCKt5RwlRNrxZLCHjrSmVKAh2r2
aTalEQnPppNawleZQFEjE7J4WXgcXjKIjeueagKUH6vxXyUefV5Ckh4I8d9wBBpk
nH4nRhikQ4AGRgP9hkc5Zg+rG31KEtm4g1hSDqVrLdhaFmCUODZkXDgJh0T9CQba
FburP0UCcDvhp22HrXtMjK0wuY9KBn+XnxiRaPjYz2g2soWlb62BUpZB2O8nxpWq
m2xkxEGF1NEf4ru4v5tU19inR0A4kJ1xIm84EvbNrZFo2CDSby4LDVj2YMVfBf3p
XHEss6tXwN/YYzcyL7tV9vB1LM6iusWXAN7bXSGJnhWrksSN2uWostBtdQqtr10V
l6aGceKm6gpx61OSiGeMiWms/gO19+pt1vni5oASGbyZlJ06Ms4FSVg0/sylYM8K
DSYibLj309AXs+PLmOG2NPTZi6DBn+R988fg74wZw55+IYcABOvFCbWRKZinsFYR
QjGa4NwDEYNwtKKDXeyv
=wfzy
-----END PGP SIGNATURE-----

--tTBQerjnMag3Je2cPGPppp79KrXIxGCGx--
