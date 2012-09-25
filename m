From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Sep 2012 13:40:54 +0000
Subject: Re: [PATCH] OMAPDSS: DISPC: Add predecimation limit for TILER based rotations
Message-Id: <1348580454.2342.40.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-qDssQnSI5OWYN5zN5SQ9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348468707-5142-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1348468707-5142-1-git-send-email-cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-qDssQnSI5OWYN5zN5SQ9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-09-24 at 12:08 +0530, Chandrabhanu Mahapatra wrote:
> In OMAP4 and OMAP5 when TILER 2D burst mode is used, a maximum of one lin=
e can
> be skipped as per the respective TRMs. The MBlockStride OCP signal, which=
 is
> sum of ROWINC and image width in memory, is only 17 bits wide. In 2D mode=
 TILER
> supports 8192, 16384, 32768 and 65536 values of MBlockStride. In case whe=
n 2 or
> more lines are skipped the ROWINC value exceeds 65536 resulting in OCP er=
rors.
> So, maximum vertical predecimation achievable is 2.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, looks fine to me.

 Tomi


--=-qDssQnSI5OWYN5zN5SQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYbRmAAoJEPo9qoy8lh7160UP/RyXLZNmyr/dltMOFbXQ3y0A
26I2vHT0fIfWQuUl/+Xi2kHj83AQTd3x1j8AxitBtiCe2dbk5ub78+tSg2f2rbSp
JNFxqn40SHd0mehWjHig/z7tgCnRbC+0T55IWgib4utGMIQZuw7TE6vYHNlVCle6
wOGe7maFs1C1lVDaqbcf39PNb6+anMtK6vfk6jbvWnOXITLkMZkJ0EVT1ffagTQq
sTz/33EwU41i3aKaTnZ1vPOu4STCfzeln4tialmw0pHWbYiSBpjGWx1GVdGqjd1V
ujR1LLQHmfVB7U7QK4tfFTi9ZfRKIPqZeKSV5kvuS2t8tT5B0ryq/PCo5HiIw28H
ZyMvZ3qV95u71btwSRFNMP7xgUEW7JitzuUw0CjZ43i/C/rFJYoNIYgvxV2e2+lw
HHksynGFfkUZAZEMTM4tjvbnp8OinTaOZIbIRSV0P17dKr53b3JGVxXY0lQEKpC9
gUxTZU7eSuZWV5YRnQT5zWBSYD3kl71T77Bht38HxGzMXqIKcSfUJ/YlHdFg4lgq
EC3XvdJ/tx47mpfZ8MME5KhtcYDOBwek+GkMPXgbeEFXecAPbotcORVKOLsSl/lB
6Jo+Fk6LCO/3a1X1BjWmkGA4S/qj44peneaQPU7X9CluKVjXsCnOPDfexBi9fqd2
rsYb2/gNuAhOqyAuaL0c
=WyRC
-----END PGP SIGNATURE-----

--=-qDssQnSI5OWYN5zN5SQ9--

