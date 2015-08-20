From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 11:04:09 +0000
Subject: Re: [RFC] fbdev/nvidia:change reverse_order() macro
Message-Id: <55D5B429.8040605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5icb3k99BN7rEN7fJhMseB7EWKAWfnDqr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440053547-24193-1-git-send-email-yalin.wang2010@gmail.com>
In-Reply-To: <1440053547-24193-1-git-send-email-yalin.wang2010@gmail.com>
To: yalin wang <yalin.wang2010@gmail.com>, adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--5icb3k99BN7rEN7fJhMseB7EWKAWfnDqr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 20/08/15 09:52, yalin wang wrote:
> This change reverse_order() to swab32(bitrev32()), so that
> it can have better performance on some platforms.
>=20
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  drivers/video/fbdev/nvidia/nv_accel.c |  4 ++--
>  drivers/video/fbdev/nvidia/nv_local.h | 13 ++++---------
>  2 files changed, 6 insertions(+), 11 deletions(-)

I have more or less the same comments here as for the riva patch, except
in this one I'd change the macro to an static inline function.

 Tomi


--5icb3k99BN7rEN7fJhMseB7EWKAWfnDqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1bQpAAoJEPo9qoy8lh71HtIP/jEMSdBGXPU3/CHhJcBpHkT2
0Y9dVEukQiWZcPrrtb0c89tJGE+O5AzMPN5ZzNURVRuHlOAm1kbB8mqbJA6c4ZTH
G9e71s616k8GAuyxmwPmR1ewt8UmWJIMzQLlf68MCAkj0FVtFGVFXhAPmva5zO98
rT9vAPWKf+d8lQvhFFB84WLmdYjcEC+56c8+B7v2thd5XfYKTO4CP+6PUbzUOUbH
QrKIebDmlXr+iibG32sEBVOTjUIZNLCeEQJGClr6aTDdHeUqlDu0lkNzmXBl46R9
DBZvNwRxdn3AlLmqdWpjGk0K44J496uXmLBZBvE6bQDsBmEJwwufWnCfbFKPILZc
MrGQq7fNqgwwn3RObMGrqfcFTkVO6RH/dNdaYgN02FRDH1G8JTrM4IvT7S1Ch78v
596UyajYWZv4fqUbGyMfJcpCmd7wTn9pCFFyJH0VTCcvVHwKkuon1+BDFuHMM43k
JBpZyhFFkfkCiR680rFM6k3KTJ/GXghIvz2OKp/8rKN6oUdk8VEtdjFo6Rx+FQwq
/9ew4c3Sc3PyYV1ExCzrKuF2qhya9JipWhmVT6OymilVi09aPDuDSvx3Udkp7p6v
iqPDHSdfoIU7Qnekb46XPGIqwjFx+MpGDjQx9auCaA8i44CIwtNl4ZKJfezuNauV
yN0bXI2FXFC6tAZlsuOS
=WW/f
-----END PGP SIGNATURE-----

--5icb3k99BN7rEN7fJhMseB7EWKAWfnDqr--
