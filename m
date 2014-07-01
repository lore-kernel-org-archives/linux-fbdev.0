From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 11:31:53 +0000
Subject: [GIT PULL] fbdev fixes for 3.16
Message-Id: <53B29C29.8020901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AQEJhRUGi73eC7PmcFU6hbheMup5HNX0A"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--AQEJhRUGi73eC7PmcFU6hbheMup5HNX0A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42=
ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-3.16

for you to fetch changes up to 0b479c3db63303814c1d2f8e97497db6be1caaa4:

  fb: adv7393: add missing semicolon (2014-07-01 13:18:38 +0300)

----------------------------------------------------------------
fbdev fixes for 3.16

A few minor fbdev fixes for bfin_adv7393fb, omapdss, vt8500lcdfb, atmel_l=
cdfb.

----------------------------------------------------------------
Emil Goode (1):
      video: vt8500lcdfb: Remove kfree call since devm_kzalloc() is used

Michael Welling (1):
      drivers:video:fbdev atmel_lcdfb.c power GPIO registration bug

Sachin Kamat (1):
      video: omapdss: Fix potential null pointer dereference

Scott Jiang (1):
      fb: adv7393: add missing semicolon

 drivers/video/fbdev/atmel_lcdfb.c                 | 2 ++
 drivers/video/fbdev/bfin_adv7393fb.c              | 2 +-
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c | 8 +++++---
 drivers/video/fbdev/vt8500lcdfb.c                 | 2 --
 4 files changed, 8 insertions(+), 6 deletions(-)


--AQEJhRUGi73eC7PmcFU6hbheMup5HNX0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTspwpAAoJEPo9qoy8lh71MvwP/R02QdsRonhHyZM0VdGNeJO+
LIdiOJMmbPV2nKYyDgZ2vd7y0Vk6xyoBTJ6t6+89KbQaaeKCUSFd2ssmBDr8x7c7
C1CzHYDly6tWRJFdoU0tZDqml6yCelDQn4wKZZrk+ajz0UUJreMa3Bjaz/h1fnG/
Up/kS2L6UpdMXfrjKVWMK2BuHOLPLSTZlyb386BJCdfEZ63KiZzSuzUdD8vQkxmm
x/t4cJqfNk1OL0vYCkgqKlEOp0SCwxQG9RBsKJ9xXa2DnRArinXlz6UB8IotKQYX
3hClSktdGBBkabB4ok4HnLkpR1svIo3TWlCREQhqy6Iy2Qr1pRmmZFJhCY9vDCpM
1ew/fn+S8jJitY1r6bLV4DBaFEa5AxCucfmhcNeSK0D5ix6j3Tp31u0cLbh5xaQi
X2nGNA+vOMZ66Ne62jTs/qTy0jHH21uixLGMMGSZ3YAl2YV3EGDx5jBTZG9Bk/Dd
/L8vv0asYjJrypFPD0LnEAkl3OTYETW4kge3xpKotzjZT0vnHoxVRRNaPr10pXRp
X9ky3of9w4pacMT17c9kBIDHZLy+g8oyQkeOy+uY6CqtAzx4AGLP/cSqxFf5C67R
+5cMN+EysbaQ6pI4ZjAvw6qv7uRcaiN/DscKnIqv2M7uYn5MCXytdengnZT9elzV
K5SHHHNWbe78PIFTLR0C
=T+hv
-----END PGP SIGNATURE-----

--AQEJhRUGi73eC7PmcFU6hbheMup5HNX0A--
