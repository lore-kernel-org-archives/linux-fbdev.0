From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Feb 2016 11:15:43 +0000
Subject: [GIT PULL] fbdev fixes for 4.5
Message-Id: <56BDBEDF.5080603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wXC2x7wFfEnabsptAwiSCxawFeePjPg90"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--wXC2x7wFfEnabsptAwiSCxawFeePjPg90
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f0=
8d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.5

for you to fetch changes up to b82fe6ddd782f847332aeabf8cab980852f61629:

  video: fbdev: imxfb: Provide a reset mechanism (2016-01-29 14:20:16 +02=
00)

----------------------------------------------------------------
fbdev fixes for v4.5

* fix omap2plus_defconfig to enable omapfb as it was in v4.4
* ocfb: fix timings for margins
* s6e8ax0, da8xx-fb: fix compile warnings
* mmp: fix build failure caused by bad printk parameters
* imxfb: fix clock issue which kept the display off

----------------------------------------------------------------
Andrea Merello (1):
      ocfb: fix tgdel and tvdel timing parameters

Arnd Bergmann (3):
      fbdev: s6e8ax0: avoid unused function warnings
      fbdev: da8xx-fb: remove incorrect type cast
      fbdev: mmp: print IRQ resource using %pR format string

Fabio Estevam (1):
      video: fbdev: imxfb: Provide a reset mechanism

Tomi Valkeinen (1):
      ARM: omap2plus_defconfig: update display configs

 arch/arm/configs/omap2plus_defconfig  | 33 ++++++++++++++++-------------=
----
 drivers/video/fbdev/da8xx-fb.c        |  6 +++---
 drivers/video/fbdev/exynos/s6e8ax0.c  | 13 ++++---------
 drivers/video/fbdev/imxfb.c           | 15 +++++++++++++++
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c |  3 +--
 drivers/video/fbdev/ocfb.c            |  4 ++--
 6 files changed, 41 insertions(+), 33 deletions(-)


--wXC2x7wFfEnabsptAwiSCxawFeePjPg90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvb7fAAoJEPo9qoy8lh71MjcP/RfrJvpPsWuSVAxQg5sD9gIV
ThCn3huYpoO5GA88btqyeIp5rD5t4FPRleKuEeN68GdLPBV8MO4aEfooAuyaUgnH
IVju4pfe3NUF2Yh4ij7iMx0vOBTB+PYRylyPjaKR1v7IW/F6meBkBt1e4z1NxhDX
Aba33bq5LjQroC+MN9H7KtmKhtzLcYHYR+b2zqBAw2GKqkd9igAR+Sv3DlAnxgBZ
16Uzu3Sk8MbS5vfn5EBbZEq5t6RGwU1MJCLPru6lY+T/V8kc+tlbLP68VMJWc0vI
93vSlYS/aifa+DzOxT9isFxuVV2s5wCOnzG3nqG+vhs9An9WRPtd35FyJOuvWgqG
jvtqyejBX9KiZ76BLpqz/HJpgNRtVsb3EcwsoFiunIBlQ076//GU3+8ODuBzqR50
prt0wRYLQyD0EMErICActgUBAX677dSZc8g26XqQ3lv9GxXjzrE++3usd8bE7uaO
rWn2AC1YE7NL7Eqo+mRnVv6UsMEpGSu1HXwd8QXcPDOfoDvUmPWt6hCBOCp6RTFs
PnVFaHfwT6Bp6y6+lUw5mFwuILENG1xxFbVN7MKNfbbmi/XwCKMGY4DM8qbDZid4
HOv5MhCSUIvVPOklu+cBHJMMg4HZCmuCpGQ5htBr3qX5mw3H7OTZv40lQNiWr4pl
QT+sTXUWYXlwYCdmvclw
=4Nie
-----END PGP SIGNATURE-----

--wXC2x7wFfEnabsptAwiSCxawFeePjPg90--
