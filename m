From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Sep 2013 09:24:12 +0000
Subject: Re: [PATCH 00/19] video: use dev_get_platdata()
Message-Id: <523C143C.9070007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7gaQkBQSVHWOep4cK5rw1wgsfNVE4W87J"
List-Id: <linux-fbdev.vger.kernel.org>
References: <000401ceb361$d84c4600$88e4d200$%han@samsung.com>
In-Reply-To: <000401ceb361$d84c4600$88e4d200$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--7gaQkBQSVHWOep4cK5rw1wgsfNVE4W87J
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/09/13 07:53, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly. This is a cosmetic change
> to make the code simpler and enhance the readability.
>=20
> ---
>  drivers/video/amba-clcd.c        |    2 +-
>  drivers/video/atmel_lcdfb.c      |    4 ++--
>  drivers/video/da8xx-fb.c         |    4 ++--
>  drivers/video/ep93xx-fb.c        |    2 +-
>  drivers/video/imxfb.c            |    6 +++---
>  drivers/video/mbx/mbxfb.c        |    2 +-
>  drivers/video/mx3fb.c            |    4 ++--
>  drivers/video/nuc900fb.c         |    6 +++---
>  drivers/video/omap/hwa742.c      |    2 +-
>  drivers/video/omap/omapfb_main.c |    4 ++--
>  drivers/video/pxa168fb.c         |    6 +++---
>  drivers/video/pxafb.c            |   16 ++++++++--------
>  drivers/video/s1d13xxxfb.c       |   12 ++++++------
>  drivers/video/s3c-fb.c           |    2 +-
>  drivers/video/s3c2410fb.c        |    6 +++---
>  drivers/video/sa1100fb.c         |    4 ++--
>  drivers/video/sh_mobile_hdmi.c   |    6 +++---
>  drivers/video/simplefb.c         |    4 ++--
>  drivers/video/tmiofb.c           |   10 +++++-----
>  drivers/video/w100fb.c           |    2 +-
>  20 files changed, 52 insertions(+), 52 deletions(-)
>=20
>=20

Thanks, applying for 3.13.

 Tomi



--7gaQkBQSVHWOep4cK5rw1wgsfNVE4W87J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPBQ8AAoJEPo9qoy8lh71mN0QAJ4DJuzYo/uqGcUNgeEtQ3e5
XMhkUFBuBYLMnP9Abmp55C/sm30/GofG+KDXg0ULKfzCyDQo2maYs3lFiWdeiqMb
nQKMnVUj0N4iAc5a/zAVfz4Aom4sM1/o56sA8AqGyWvgzAurXJN0RM2onfWkOaX/
C9OL77klFFWREMRC+Gow3kQW0vSLubBkP3DzBXFMf3z0/w7yUmgv8+WkMoj6Otk6
6kTILWq4zYrbRHmd74vDlOznOQmYpsviL8DFime06Rw73keR0QpndRyBUpaSM1wW
0QIgjvliRIyJwNyDJ9JIXa+pYVdPXshXz4tssjrDQRASrhk+2jKBssp6aKTrICYm
rZwgS16TLuPA2cztuiLTaqU4H17C+oyiRi87RSZJtkCyfxjAzFWynfThW2LxkHu3
o7XWhZnwKmfIUlf9dTntrFwbGTZ+7JkDrp/avTiAuldLjv3W4OAhspub1jp9tZ/D
YCsTHr88lB57+VWRxNANTYggO7s5+2wCPypOzk+gisE8Ta1GIYow66r0Ax1SWXZ4
8nOC02sDnkqbtwAvyxjkPPM0qehJw6JRsaQgJiepvgYkaeOXvGasjZpeIl302Eay
CfuW8A/5fO9mx/D5DLgz9VmBQQekL3oTL7BbWw9LMxhdDHL9IlALXJGdHlbjhgJb
1U4sFaJEiBUaAqBiizqP
=ITCr
-----END PGP SIGNATURE-----

--7gaQkBQSVHWOep4cK5rw1wgsfNVE4W87J--
