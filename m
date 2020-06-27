From: B K Karthik <bkkarthik@pesu.pes.edu>
Date: Sat, 27 Jun 2020 04:51:50 +0000
Subject: [PATCH] fbtft-bus.c: Removing that prohibited space before ')'
Message-Id: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t7rr5fenqhwyb57p"
List-Id: <linux-fbdev.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.net>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org


--t7rr5fenqhwyb57p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fbtft-bus.c:

fixing ERROR: space prohibited before that close parenthesis ')' by removin=
g that space and ',' in line 65 and 67.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtf=
t-bus.c
index 63c65dd67b17..847cbfbbd766 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                         =
    \
 EXPORT_SYMBOL(func);
=20
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
=20
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
--=20
2.20.1


--t7rr5fenqhwyb57p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl720GYACgkQ471Q5AHe
Z2qzmAv9H0yKGQeZE/+LG3U87JdxsfJKO6l2V+1+Bqb4T+jrD52zcitgEaKaPkMd
y5JqgAPxpFk1YNpSFbw+j4xsa36+TFKGYIDCuPIPmYhEtUfUG1Aj8roQPdqrs2Ir
oiGfJ293xMBp1GDYOMAAdB55BWNGHGiEgJ1GG++9AVSXz1Nm0R9SIJwPddoPq9yA
Ez+tYms6eNVfnk+CVEpsEjhUf6rk+WARb+UgfJ9lxzebU1damViQda/naEiIOPm5
MRt1V5PUUZcYYlGsrisCbc8DhTrMrD82j/j3uKyS/3Wm/+J39bq7WZO2t6kDcl9k
2vdUFUinO9szZJR9bfEbsZkRVZzkv3j5Qyqg4Sur09vy04se6JZWod2vTBaepnnx
vulIXywLvtsnfyZLVsBsRPit8zyO1BI2P+o1T+NRjfQKUuvkmzChmGt3DanuvGBB
Fop35oDLMjcbK/KIH8lQGXzt51kpQ8M5sCc8DAWxGlGJFK7h0bVUnOe5w/3G1S5G
YWNuuvZC
=Tfl7
-----END PGP SIGNATURE-----

--t7rr5fenqhwyb57p--
