From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 29 May 2013 06:37:25 +0000
Subject: Fbdev changes
Message-Id: <51A5A225.3060800@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2CROHFFPCKLFGBBSWJHLN"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

------enig2CROHFFPCKLFGBBSWJHLN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jean-Christophe,

I've pushed the patches I had already collected for fbdev:

git://gitorious.org/linux-omap-dss2/linux.git fbdev-3.10-fixes
git://gitorious.org/linux-omap-dss2/linux.git fbdev-3.11

fbdev-3.10-fixes contains two fixes for 3.10.

fbdev-3.11 contains ssd1307fb patches from Maxime Ripard, and minor
improvement for the common videomode code from me.

Feel free to cherry pick/rebase the patches, I don't think a merge is
necessary for these.

 Tomi


------enig2CROHFFPCKLFGBBSWJHLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpaIoAAoJEPo9qoy8lh71H8wQALCXvB/yRlH+mDdmbJJ3z5hC
uwAgp5MoN7nVZLlBXYXVKyNCAMsPLtD1AlkHOwk6QAhLx22H7Yi35IBzLjYYMjD9
CkIix4UpjnRHPimBTX3MNd08EinKzL69EGj6ly0zhx51GW4ylXbexBJZbwcDlO6l
LOJEtdYXBoT9WM9zyqm1u0Ls+d+JPv4UWg9P5viaCnuhqAwOdby2w5RpD8drrXrr
aJa9VlJ5CQkFWH5jvSoPSHVTxl1Zhs5E3ptZ4SEksTZwMViSH/WRdOVOzl+FrM2q
URgZDGiczqmyYmWzVyZ0yxGQUETFTmcND/YP5C3XKyCzJr1emfCBfb8ChBk3JEQD
g4vGHYsCvz5T6KFDOx2/7IGFlFRMLRS/42IeVtf5yD1liaB5yAxZo5F1cV51Qcmt
GFg0gOFWhRbJAej58Ns0CgtITwEFjKvplFQ2BGMZydZLOHOIxNZkpSNTK/3APw04
1GmwsjcjCpFc59pry15eYvgUAQhCFCBhZ2N2FLEovjQmoh/12PiQeQqF0cEf1WAQ
ZPVHwFa71LTPK7pH/gf/VjG5PDG/88ybOu7TmfGeUN1XKzgvim0WW/Lr9UD1FXpf
Im/KpiLy8gzwnYHLy9opWgIFAgxVmcfZGCV6w2wpzqt+pJUwBY27wkKV2hO9zCmf
BrH9BVVXob8WaN3PLSzm
=wpaN
-----END PGP SIGNATURE-----

------enig2CROHFFPCKLFGBBSWJHLN--
