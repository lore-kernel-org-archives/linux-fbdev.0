From: B K Karthik <bkkarthik@pesu.pes.edu>
Date: Sat, 27 Jun 2020 04:50:04 +0000
Subject: [PATCH] fbtft-bus.c:
Message-Id: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wcjbyctbs2w26lm4"
List-Id: <linux-fbdev.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.net>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org


--wcjbyctbs2w26lm4
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


--wcjbyctbs2w26lm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl72z/wACgkQ471Q5AHe
Z2o05Qv9ElUD8lscq3RLdrWxDC3fGK3n7kQZTWCQEFU+K0muQXceEX0JRhGy9N1F
8aGgIb3wumF0ZaWhX8b4HW7tivAQTkmJoKhWcYDzjrkfvFv/9viCvUw5A3SqUFoA
X919WgEO4epopUMRpK97SRksK1L6RACBVjTttO3BOX31i550BUSH53PCLtbdbiPm
F30wh0jIBPykPOSJXcctTTOYZXco03xpQ8J8POmfIGQVyluM/ZOjOL10PbQvJXlZ
SpqGUTwu3VRyPnSRCtBvvNHUNHUUNOMhhN1uG7Scrt4SONQJWe4trYHDSFaA838q
8QUXzwWFVRGYy9paUzdYPKH/B++F3xJ1//kySDxsSfYuZOaJIUc33gjOCCs+pkvU
sXzHAQdUPDKYm2S0WaZJqHHUDj1PRcJfIuHVxZCPegs5hcd5J6TECzhYrURzBadb
odcMJCHYpy/bt78inyLdi0CK8rseZDCJkHCfndjoWBVSclHqVlc9eGZ7X/xypu0L
r8Vq99ni
=7vSF
-----END PGP SIGNATURE-----

--wcjbyctbs2w26lm4--
