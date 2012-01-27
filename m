From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 27 Jan 2012 12:58:33 +0000
Subject: [patch v2] intelfb: remove some dead code
Message-Id: <20120127125833.GD3356@mwanda>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Mjcb6KWfk+dITC8b"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--Mjcb6KWfk+dITC8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The goto on the line before means the return is unreachable.  The goto
also returns -ENODEV so no changes are needed there.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: fixed a typo in the commit message

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/int=
elfbdrv.c
index c6afa33..02fd226 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -529,7 +529,6 @@ static int __devinit intelfb_pci_register(struct pci_de=
v *pdev,
 	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
 		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
 		goto err_out_cmap;
-		return -ENODEV;
 	}
=20
 	dinfo =3D info->par;


--Mjcb6KWfk+dITC8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIp94AAoJEOnZkXI/YHqR1M0QAJOkKtcwcn6asAnKBIUyol6R
TgHRjCVxacOybtyt5xJus7ODsAZxxnsF3PN4T7ratyljVIRXTcc+8R2AD8jsWKBb
hFN0Iq1qWYY+sieB0R/ZdrqnDtAUpM78PYcSA8O4iIO5pT3WZPPYsNFb4sb4OIcJ
zwy0Bybcqo/gb1akcetKm3yaz3lUpKiHv+6pSCQmkjrbYOTHqv1yrWIpp25rwmao
JtEdHTGEW1K+Xl6O/blKw3mZO5gKB8WNZFjgeXuP1BC3shXDZGhJCiiltfmeBOHj
MJMRTnHpoSp7TcFsOFJ8WAT1q7fDCfkbOglNDKJF+LeBXnLXyQJaewY3Zl2fh1cb
jdSvLyhAQ3dI4zgG8eAgCThH9YWxdqmKoQfkW77x6QNNMSJgwVjgGuda35EGDx/o
n55C6d1E4ZBTv2uOhO0KEDslDBcp6+AYbHhANRiykuWg/Ydvls1xoTdSKDEW4XWF
N3dY1CmcOtlUwvtAdkqbFGgQFS+uGBvwTWLeMlASKbfLJ+jnlcmLJVyXzRbOzfFP
OXyLbu9P3HFgjOBvesO1J1uUuBBC+Sv0vJ/jzg7Ce+Rn+dKoGst9t5ABCDQy8k79
9tXxNSTmABf5cYIvF4WuJrHicyjs66IRuvDLwMzq601ZPTmvbFHpN9U4nYMAzIR5
GnY6pglXO2xrC/N9y9HD
=+OBg
-----END PGP SIGNATURE-----

--Mjcb6KWfk+dITC8b--
