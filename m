From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Oct 2015 12:04:58 +0000
Subject: [GIT PULL] fbdev fixes for 4.3
Message-Id: <56150A6A.6090102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GqeOJT4WXQ8vc8VXkhLnbSvK0F6jDKft6"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--GqeOJT4WXQ8vc8VXkhLnbSvK0F6jDKft6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100f=
de:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.3

for you to fetch changes up to d663baba8b16f3097ac3fb5baf97c54970d2f1ff:

  video: of: fix memory leak (2015-10-07 14:13:59 +0300)

----------------------------------------------------------------
fbdev fixes for v4.3

* fbdev: Minor fixes to broadsheetfb, fsl-diu-fb, mb862xxfb, tridentfb, o=
mapfb
* display-timing: Fix memory leak in error path

----------------------------------------------------------------
Jason Jin (1):
      video: fbdev: fsl: Fix the sleep function for FSL DIU module

Javier Martinez Canillas (1):
      OMAPDSS: panel-sony-acx565akm: Export OF module alias information

Luis de Bethencourt (1):
      video: fbdev: mb862xx: Fix module autoload for OF platform driver

Ondrej Zary (2):
      tridentfb: fix hang on Blade3D with CONFIG_CC_OPTIMIZE_FOR_SIZE
      tridentfb: Fix set_lwidth on TGUI9440 and CYBER9320

Sudip Mukherjee (2):
      fbdev: broadsheetfb: fix memory leak
      video: of: fix memory leak

Vladimir Zapolskiy (1):
      fbdev: omap2: connector-dvi: use of_get_i2c_adapter_by_node interfa=
ce

 drivers/video/fbdev/broadsheetfb.c                           |  8 +++++-=
--
 drivers/video/fbdev/fsl-diu-fb.c                             |  9 ++++++=
++-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c                   |  1 +
 drivers/video/fbdev/omap2/displays-new/connector-dvi.c       |  2 +-
 .../video/fbdev/omap2/displays-new/panel-sony-acx565akm.c    |  1 +
 drivers/video/fbdev/tridentfb.c                              | 12 ++++++=
+++---
 drivers/video/of_display_timing.c                            |  1 +
 7 files changed, 26 insertions(+), 8 deletions(-)


--GqeOJT4WXQ8vc8VXkhLnbSvK0F6jDKft6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFQpqAAoJEPo9qoy8lh71OkYP+wUrIxdCwyj6y3+Sm8xB804n
AEmFUDijPpe6O1wtDSE/Ae5NzA+nTNhoyGHeXyYjOlUxVq83jYA/7A9cOIDuvjP/
u5aVm8OTuFboTOLceRTo6Wz6QYtodUuONrzQTo3gLBMcvdu1ST9LFPeAu1S0L4s/
tXkLYheKP0mG1cuIhHHlYUQKA7CYXZnyS9yzcb1Wxc9LvRaVrDZZuVu935j+hZgp
bPAymmrOY+B8FJUV0i8owa9PXrKL67Bp6jpgzF+SbDx9eRgSr+8UamtNw8/CJQoR
h95yNx5G8mC1ktAqFhf9uuLvETPRx8rIXKyzvGePTjYUtwD0m3Ei35GaEjvYBJc0
LqBAVVUr3RYz8z5p0FlphXR8ncig+NozI+9G8/b/nbkVzSDtwHg42Y1uzrB/bgVI
6D2BPWc6tho4g15MegYfQB4OCQ+yMux3CpMnqzzSPVUNN1ZCeb61Wat/7jJg/m9P
vyrudj9TzEA9HzcI1rQcVzqK0QeOWVMDV26Gr+ZAN/AY+7+/RAAomyxLcRO2ZrOZ
/dWElfixwxuAaiiD0fU0xpyTO/q1SKRwXzy2opDp48CfNsKg5axupHP3tXlqOR+Z
AJ89HjeXFre/9fBNV3x1HwFbQAK/J3qtjw+mp80I+8GHl8HQKJ6DT48vUqrWvQb1
Ow0ugSiLHiqYZPxtkhx6
=a/30
-----END PGP SIGNATURE-----

--GqeOJT4WXQ8vc8VXkhLnbSvK0F6jDKft6--
