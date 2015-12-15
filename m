From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Dec 2015 15:01:26 +0000
Subject: [GIT PULL] fbdev fixes for 4.4
Message-Id: <56702B46.6060302@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0akCO3W25Wih95ejRebmusO6nIVVRnM7c"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--0akCO3W25Wih95ejRebmusO6nIVVRnM7c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull two fbdev fixes for 4.4.

 Tomi

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52b=
b9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.4

for you to fetch changes up to a54c1ddbe3bc07eadb0096c4abe6224e7f363b66:

  OMAPDSS: fix timings for VENC to match what omapdrm expects (2015-12-09=
 12:57:13 +0200)

----------------------------------------------------------------
fbdev fixes for 4.4

* OMAP: fix analog tv-out when using omapdrm
* fsl: Fix kernel crash when diu_ops is not implemented

----------------------------------------------------------------
H. Nikolaus Schaller (1):
      OMAPDSS: fix timings for VENC to match what omapdrm expects

Wang Dongsheng (1):
      video: fbdev: fsl: Fix kernel crash when diu_ops is not implemented=


 drivers/video/fbdev/fsl-diu-fb.c     | 13 ++++++++++++-
 drivers/video/fbdev/omap2/dss/venc.c | 12 ++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)


--0akCO3W25Wih95ejRebmusO6nIVVRnM7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcCtGAAoJEPo9qoy8lh717c8P/R6ezHod++Ecnjvkcm5iIYrX
VQQ2FOxQ4vU4SYQ5f0HGWHk6ei1oUWQ7rXFRH0kj7LNQObK81mt2nkeoVdQHRVrt
ChvNh9zZ+/1i8lte4w5kum8Y8QbsoiWiLg7cF0UUt0zJ8b3S1Kahr1UhX3Qne5+a
zqmWfP/ZNUAGZVNn6T8m6fWsWflfjt/Fu4Knimk9IUbYOTBGtu0M1szYM4tYUABF
zV/fhbfX/VlW4v0l8jvEJny4SYkfSOSawj+a/Wly/i5rSRuxePVE/sZhUtmB+9xU
bULHthjDoLfh3yOCprq6tRwiBKiQ+7qDtPDOm2YX+H9qtlILGUOa0+MLgpilJ+1n
vdnhGH6MMjRaaDn8H/vRFx9LbExtknRrupKsHQRpQg4NV8QcQ2bjl2tYzPTbB1SD
flh9EQkw08Rhrm+ALbcQ8p4zgr+/SL64AVWzdY7Fc+ayWGsT6xW9Hj3SehUw+zDm
5WrIufXYCNd6cVzG963usvFFXI2KfZ20bJBeAM78g/LghdwhHXuwSoUrLKjpcVtM
OFWSkoe5DLI4JJkDuYXLSmAfxAhPEKC8xkOqZKa/hP0wW8S5ZurWxKmb7vwa27CJ
2aKQH842pXOz268fNPSsNDngGgOs/1aG1FplMd2yOou0umNAFspE9zf3wjIMUKvE
Ry4nm6dx/Jkcx1dHdLul
=GRp6
-----END PGP SIGNATURE-----

--0akCO3W25Wih95ejRebmusO6nIVVRnM7c--
