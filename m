From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 05 Dec 2013 12:04:05 +0000
Subject: [GIT PULL] fbdev fixes for 3.13
Message-Id: <52A06BB5.8070904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w91r13w7uO1n65sj17XR6VTmThSbbMqmQ"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

--w91r13w7uO1n65sj17XR6VTmThSbbMqmQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull these minor fbdev fixes for 3.13.

 Tomi

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42=
ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-3.13

for you to fetch changes up to 46ac29568e63c9da9c15804648d3ed8c25e2dc44:

  video: vt8500: fix error handling in probe() (2013-12-04 10:50:16 +0200=
)

----------------------------------------------------------------
Minor fbdev fixes for 3.13.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAPFB: panel-sony-acx565akm: fix bad unlock balance

Dan Carpenter (1):
      video: vt8500: fix error handling in probe()

Geert Uytterhoeven (1):
      fbdev: sh_mobile_meram: Fix defined but not used compiler warnings

Johan Hovold (1):
      atmel_lcdfb: fix module autoload

Sasha Levin (1):
      video: kyro: fix incorrect sizes when copying to userspace

 drivers/video/atmel_lcdfb.c                             |  1 +
 drivers/video/kyro/fbdev.c                              |  6 +++---
 drivers/video/omap2/displays-new/panel-sony-acx565akm.c |  5 ++---
 drivers/video/sh_mobile_meram.c                         |  2 ++
 drivers/video/vt8500lcdfb.c                             | 25 +++++++++++=
--------------
 5 files changed, 19 insertions(+), 20 deletions(-)


--w91r13w7uO1n65sj17XR6VTmThSbbMqmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSoGu1AAoJEPo9qoy8lh71dF0QAJL1/3n5hohw0aoU14rRYP+/
+Wn4xni97j5vcvNbKTnhWCZZO2HPz+3aLqIVV/IywhOUu6eoK10409g7DpdXfKtC
Q8nIjFVHxb18jkC9uJhS7dvtGarN/9fb1HyfsI9N/pIV72jOZoowAnWaHhJTBGka
oErz6vn8vYE7HOU0K6NjPF9SFdRRrhRd3vje8txzdz8H85jyXHGP5OKd95y3oavH
Va5sFS0m3SIWtFwjqeOmQBi6ZXDLba4/yzEGOvj/gxKgaUZUyGzeARL6lSjqy1KM
R5qOcx8DzXnUpr7agST1nW5Dy//YVKL/A/ZlykjI59ZCjzVIF8BVTuWECt41OR/k
Dhz/jGevULgKxXxMbdnXxu5p6NpvgxjjXsLNdHQmv4RsnK5gXBCnUixgFQI5d/z8
m8maHab9lPTrxnOlA4uVDlchHINZByvoxjREgiYmFOlpduMuSxHGiX/PnYgdxkNX
gwRqaB5d64k60ZNyZdZvYae4ndJaAKUDABREzBVT+1MR7S4PbpC5lzCqe3xFjZt3
PI5WzPv8iW4+I5kDSCa0EXJ8yojVIm7HGcDn3u+XaO7dlxMyfWCJvYl2A+/77Shh
JzGR8kBMrbPk0Vbj9TD9iOEibNb1Att/MnKdu4mnkl8szpfOrnGdGDJkYk9sZ0Up
W4Bxlxtnsy4mzOafjrCu
=QEoV
-----END PGP SIGNATURE-----

--w91r13w7uO1n65sj17XR6VTmThSbbMqmQ--
