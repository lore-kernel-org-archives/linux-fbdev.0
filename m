From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Mar 2016 12:50:22 +0000
Subject: [GIT PULL] fbdev changes for 4.6
Message-Id: <56E8050E.4040805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qSj59Gg0xJ5fxQblU6bG9t9ej152R4XqX"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--qSj59Gg0xJ5fxQblU6bG9t9ej152R4XqX
Content-Type: multipart/mixed; boundary="0r3X7FGTaVdqulJJEaH4B8jeJPu50kTKb"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56E8050E.4040805@ti.com>
Subject: [GIT PULL] fbdev changes for 4.6

--0r3X7FGTaVdqulJJEaH4B8jeJPu50kTKb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 18558cae0272f8fd9647e69d3fec1565a79498=
65:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.6

for you to fetch changes up to 13aa38e291bdd4e4018f40dd2f75e464814dcbf3:

  xen kconfig: don't "select INPUT_XEN_KBDDEV_FRONTEND" (2016-03-11 13:37=
:02 +0200)

----------------------------------------------------------------
fbdev changes for 4.6

* Miscallaneous small fixes to various fbdev drivers
* Remove fb_rotate, which was never used
* pmag fb improvements

----------------------------------------------------------------
Andrzej Hajda (1):
      fbdev: exynos: fix IS_ERR_VALUE usage

Arnd Bergmann (2):
      video: exynos: fix modular build
      xen kconfig: don't "select INPUT_XEN_KBDDEV_FRONTEND"

Dan Carpenter (1):
      video: fbdev: metronomefb: two harmless off by one bugs

Daniel Wagner (1):
      video: Use bool instead int pointer for get_opt_bool() argument

Maciej W. Rozycki (8):
      video: fbdev: pmag-ba-fb: Fix the lower margin size
      video: fbdev: pmag-aa-fb: Adapt to current APIs
      video: fbdev: pmag-aa-fb: Enable building as a module
      video: fbdev: pmag-aa-fb: Report video timings
      video: fbdev: bt455: Remove unneeded colormap helpers for cursor su=
pport
      video: fbdev: pmag-ba-fb: Fix and rework Bt455 colormap handling
      video: fbdev: pmag-ba-fb: Optimize Bt455 colormap addressing
      video: fbdev: bt431: Correct cursor format control macro

Paul Gortmaker (3):
      drivers/video: make fbdev/sunxvr500.c explicitly non-modular
      drivers/video: make fbdev/sunxvr1000.c explicitly non-modular
      drivers/video: make fbdev/sunxvr2500.c explicitly non-modular

Rasmus Villemoes (1):
      fbdev: kill fb_rotate

Simon Horman (1):
      fbdev: sh_mobile_lcdc: Use ARCH_RENESAS

Sudip Mukherjee (2):
      fbdev: n411: check return value
      video: fbdev: sis: remove unused variable

Sushaanth Srirangapathi (1):
      fbdev: da8xx-fb: fix videomodes of lcd panels

 drivers/video/fbdev/Kconfig                  |   7 +-
 drivers/video/fbdev/atafb.c                  |   3 -
 drivers/video/fbdev/au1100fb.c               |  22 -
 drivers/video/fbdev/bf537-lq035.c            |  23 -
 drivers/video/fbdev/bt431.h                  |  43 +-
 drivers/video/fbdev/bt455.h                  |  68 ++-
 drivers/video/fbdev/da8xx-fb.c               |   7 +-
 drivers/video/fbdev/exynos/Kconfig           |   6 +-
 drivers/video/fbdev/exynos/Makefile          |   6 +-
 drivers/video/fbdev/exynos/exynos_mipi_dsi.c |   7 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c     |   2 +-
 drivers/video/fbdev/metronomefb.c            |   6 +-
 drivers/video/fbdev/n411.c                   |  12 +-
 drivers/video/fbdev/omap/omapfb_main.c       |  22 -
 drivers/video/fbdev/pmag-aa-fb.c             | 602 +++++++++------------=
------
 drivers/video/fbdev/pmag-ba-fb.c             |   2 +-
 drivers/video/fbdev/sis/init301.c            |  10 +-
 drivers/video/fbdev/skeletonfb.c             |  17 -
 drivers/video/fbdev/sunxvr1000.c             |  42 +-
 drivers/video/fbdev/sunxvr2500.c             |  39 +-
 drivers/video/fbdev/sunxvr500.c              |  42 +-
 include/linux/fb.h                           |   3 -
 22 files changed, 310 insertions(+), 681 deletions(-)


--0r3X7FGTaVdqulJJEaH4B8jeJPu50kTKb--

--qSj59Gg0xJ5fxQblU6bG9t9ej152R4XqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6AUOAAoJEPo9qoy8lh71yUwP/Ala9i1MencXndVhweIpXsOk
4N3gmsIboBi9ViBAvEfDmiWyBDvjEmMolaEse6WtWtekfig4LVGIckIwkQRkf8Cr
LABWtduxshEptVM+4ce1uueeA7XHfBq/Bl6Ev5ZpW8trHJ6V/qW7pNYVzBk1K3dG
Xgf0+14L+5A4R0q0BSIatsz0el6BbLRWajMU/GzcF/vVI611GhLR5hcOQnp+0kvN
wDO8nRIdE2SogwYo7zpc39ZxeTz0wY6nm5jnC9F+G8Q8oD4dsRS5l4AG33D8ZreD
5YWYnnlnFzRvMmgMXfzqfvdAC2J9t9JxhhnC/F5SiwRyyD0+G/muktqACvl0+D8h
nlRNRTGjSTL+DK+dvQU4PMXqR3/4zUzaZmP6qKu+VUQ2CzF59jRlxXyqm2BwGyB5
FL8QvGzIsh/VhGDMgExHgu4noMN7PSrE+MVedVZJxVzMo8iSyKy4L4V1QAiAbGD6
r2oR1/tCCEKKG9P7Qbn+48rHkmVQ2CnSe+rY94gVmciaO4mQWhDCmkl2knkcy2Ck
xIzVQmzFVpya6eqcPhg/ojNeAqGJV4B5PN24ymKKblSj+ky7ALhuWRASQ4Oyw9RG
8HjTb/OD9Ntt80Ox8Tt6DdvLMSUsYTvHhWB+UfT3nHe+dgC4Ue8VdstDJXc0PDLB
IZXJk+1C5DDFk2l0PUoh
=uNSB
-----END PGP SIGNATURE-----

--qSj59Gg0xJ5fxQblU6bG9t9ej152R4XqX--
