From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Sep 2016 08:16:57 +0000
Subject: Re: [PATCH] video: fbdev: intelfb: remove impossible condition
Message-Id: <d1e7fd38-2ece-6477-8ea4-c7776d3d0467@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7g9Tc4iEdoFFBXjQL5f5wOsgP7VtNFsjx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472658269-1234-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1472658269-1234-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Maik Broemme <mbroemme@plusserver.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--7g9Tc4iEdoFFBXjQL5f5wOsgP7VtNFsjx
Content-Type: multipart/mixed; boundary="RDq2kj6Eu36dBBo7BrHoWmQK8aUqQEEnk";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Maik Broemme <mbroemme@plusserver.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <d1e7fd38-2ece-6477-8ea4-c7776d3d0467@ti.com>
Subject: Re: [PATCH] video: fbdev: intelfb: remove impossible condition
References: <1472658269-1234-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1472658269-1234-1-git-send-email-sudipm.mukherjee@gmail.com>

--RDq2kj6Eu36dBBo7BrHoWmQK8aUqQEEnk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31/08/16 18:44, Sudip Mukherjee wrote:
> xoffset and yoffset of struct fb_var_screeninfo are unsigned and so
> they can never be less than 0.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/fbdev/intelfb/intelfbdrv.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/f=
bdev/intelfb/intelfbdrv.c
> index bf20744..ff2a5d2 100644
> --- a/drivers/video/fbdev/intelfb/intelfbdrv.c
> +++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
> @@ -1301,11 +1301,6 @@ static int intelfb_check_var(struct fb_var_scree=
ninfo *var,
>  		break;
>  	}
> =20
> -	if (v.xoffset < 0)
> -		v.xoffset =3D 0;
> -	if (v.yoffset < 0)
> -		v.yoffset =3D 0;
> -
>  	if (v.xoffset > v.xres_virtual - v.xres)
>  		v.xoffset =3D v.xres_virtual - v.xres;
>  	if (v.yoffset > v.yres_virtual - v.yres)
>=20

Thanks, queued for 4.9.

 Tomi


--RDq2kj6Eu36dBBo7BrHoWmQK8aUqQEEnk--

--7g9Tc4iEdoFFBXjQL5f5wOsgP7VtNFsjx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz8z5AAoJEPo9qoy8lh71W2AQAJItadHodUliIT+euVG9TKvn
Odjs4qyEfJXa6rBQkJRhh3CF5L6dos2WwRvfAGCb36LEn1P3rB9R89yL26XfmAW2
DC/rEhpGXIK5llJjnBqibd08qbRnHyVVU+xn6ASYmfzSuQNVlX6roCt7xxPmK/8O
DgIgey/JDYgvT/42gq8x8pdog/VByKvL6NQuATzhvmUHOoerhhRgJfRu+KehSBKs
HLHGQeRTvgqecnYw8JGnODP1ITxM5mM5nnErx8Zd1XH5u9s1j68bWEBuulXCytrs
rtqi0wA2ghUMu4BsHNKhR3/JIEeVhf6IoklC3CadydGpku558Xy68Sotzld2jKes
s+jujULFcHRwgMNhWVDWDpCBcH/xt4ORX1NiwlHmnZ1RIqG/7WXA6KXl7f0HClVS
HCjfVK8flHBckgem/uAJ1czodFlHeAW2CnL5C/CeAGdAEMzGuEeWZYOIeJU8ROU6
vEuL1ARP4F2NK09TfaCjGisAjuujcvP9A3X/KzSfoIe6rUr77dJjbf0ujMDmw0by
dfgIfIzZ1fFsSVDFsb00+sJK2CON6NE56S+0ynPfXA0VZuZOXY+PD8EQxOL7Fwns
ZREoPcfa0hvTL0kU6pId1B1zaRtyg6+oz8u9Go64v8jHHRVlaWJbQLzGrqbgOgz1
vjowuaT7nLwb6oBJKZ2G
=yB2r
-----END PGP SIGNATURE-----

--7g9Tc4iEdoFFBXjQL5f5wOsgP7VtNFsjx--
