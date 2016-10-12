From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Oct 2016 09:13:46 +0000
Subject: [GIT PULL] fbdev changes for 4.9
Message-Id: <10971542-41f8-a419-d6fb-b498290dabb2@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mK3tAAXnHuDsUshERHoV3Q0Se2519PkoV"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--mK3tAAXnHuDsUshERHoV3Q0Se2519PkoV
Content-Type: multipart/mixed; boundary="fLeialjWssLPa3WVh9v5SQDHA7RJh7bEX";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <10971542-41f8-a419-d6fb-b498290dabb2@ti.com>
Subject: [GIT PULL] fbdev changes for 4.9

--fLeialjWssLPa3WVh9v5SQDHA7RJh7bEX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev changes for 4.9.

 Tomi

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7c=
fc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.9

for you to fetch changes up to c456a2f30de53e77a2eb8eeb4202d742516aa76b:

  video: smscufx: remove unused variable (2016-09-27 11:47:37 +0300)

----------------------------------------------------------------
fbdev changes for 4.9

Main changes:

- amba-cldc: DT backlight support, Nomadik support, Versatile improvement=
s, fixes
- efifb: fix fbcon RGB565 palette
- exynos: remove unused DSI driver

----------------------------------------------------------------
Arnd Bergmann (3):
      video: ARM CLCD: fix endpoint lookup logic
      video: ARM CLCD: export symbols for driver module
      video: fbdev: mb862xx: remove unused variable

Bhaktipriya Shridhar (2):
      omapfb: panel-dsi-cm: Remove deprecated create_singlethread_workque=
ue
      fbdev: Remove deprecated create_singlethread_workqueue

Chen-Yu Tsai (1):
      simplefb: Disable and release clocks and regulators in destroy call=
back

Colin Ian King (2):
      video: fbdev: add missing \n at end of printk error message
      video: fbdev: i810: add in missing white space in error message tex=
t

Dan Carpenter (2):
      video: fbdev: pxafb: potential NULL dereference on error
      fb: adv7393: off by one in probe function

Javier Martinez Canillas (1):
      fb: adv7393: Use IS_ENABLED() instead of checking for built-in or m=
odule

Julia Lawall (2):
      matroxfb: constify local structures
      video: fbdev: constify fb_fix_screeninfo and fb_var_screeninfo stru=
ctures

Krzysztof Kozlowski (3):
      video: s3c2410fb: Register cpufreq notifier only on S3C24xx
      video: fbdev: exynos: Remove old non-working MIPI driver
      ARM: exynos_defconfig: Remove old non-working MIPI driver

LABBE Corentin (2):
      fbdev: ssd1307fb: constify the device_info pointer
      fbdev: ssd1307fb: fix a possible NULL dereference

Linus Walleij (7):
      video: ARM CLCD: backlight support for OF
      video: ARM CLCD: support DT signal inversion flags
      video: ARM CLCD: support pads connected in reverse order
      video: ARM CLCD: support Nomadik variant
      video: ARM CLCD: add special board and panel hooks for Nomadik
      video: ARM CLCD: add special panel hook for Versatiles
      video: ARM CLCD: fix up Integrator support

Marek Vasut (1):
      video: mxsfb: Fix framebuffer corruption on mx6sx

Mark Brown (1):
      omapfb: Fix regulator API abuse in dss.c and hdmi4/5.c

Max Staudt (1):
      fbdev/efifb: Fix 16 color palette entry calculation

Nicholas Mc Guire (1):
      omapfb/dss: wait_for_completion_interruptible_timeout expects long

Oleg Drokin (1):
      mx3fb: Fix print format string

Sudip Mukherjee (3):
      video: fbdev: intelfb: remove impossible condition
      matroxfb: fix size of memcpy
      video: smscufx: remove unused variable

Tomi Valkeinen (1):
      MAINTAINERS: update fbdev entries

Vladimir Murzin (3):
      fbdev: vfb: add description to module parameters
      fbdev: vfb: add option for video mode
      fbdev: vfb: simplify memory management

Wei Yongjun (3):
      video: ARM CLCD: fix return value check in versatile_clcd_init_pane=
l()
      video: fbdev: pxafb: add missing of_node_put() in of_get_pxafb_mode=
_info()
      omapfb: fix return value check in dsi_bind()

Wolfram Sang (1):
      video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding a=
dapter fails

Yongji Xie (1):
      video: fbdev: offb: Call pci_enable_device() before using the PCI V=
GA device

 MAINTAINERS                                        |  12 -
 arch/arm/configs/exynos_defconfig                  |   2 -
 drivers/video/fbdev/Kconfig                        |   7 +-
 drivers/video/fbdev/Makefile                       |   3 +-
 drivers/video/fbdev/amba-clcd-nomadik.c            | 259 ++++++
 drivers/video/fbdev/amba-clcd-nomadik.h            |  24 +
 drivers/video/fbdev/amba-clcd-versatile.c          | 395 +++++++++
 drivers/video/fbdev/amba-clcd-versatile.h          |  17 +
 drivers/video/fbdev/amba-clcd.c                    | 190 ++++-
 drivers/video/fbdev/arcfb.c                        |   4 +-
 drivers/video/fbdev/asiliantfb.c                   |   4 +-
 drivers/video/fbdev/aty/aty128fb.c                 |   6 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   2 +-
 drivers/video/fbdev/aty/radeon_monitor.c           |   2 +-
 drivers/video/fbdev/bfin_adv7393fb.c               |   5 +-
 drivers/video/fbdev/efifb.c                        |   6 +-
 drivers/video/fbdev/exynos/Kconfig                 |  32 -
 drivers/video/fbdev/exynos/Makefile                |   9 -
 drivers/video/fbdev/exynos/exynos_mipi_dsi.c       | 574 -------------
 .../video/fbdev/exynos/exynos_mipi_dsi_common.c    | 880 ---------------=
-----
 .../video/fbdev/exynos/exynos_mipi_dsi_common.h    |  46 --
 .../video/fbdev/exynos/exynos_mipi_dsi_lowlevel.c  | 618 --------------
 .../video/fbdev/exynos/exynos_mipi_dsi_lowlevel.h  | 112 ---
 drivers/video/fbdev/exynos/exynos_mipi_dsi_regs.h  | 149 ----
 drivers/video/fbdev/exynos/s6e8ax0.c               | 887 ---------------=
------
 drivers/video/fbdev/hecubafb.c                     |   4 +-
 drivers/video/fbdev/hgafb.c                        |   2 +-
 drivers/video/fbdev/i740fb.c                       |   2 +-
 drivers/video/fbdev/i810/i810_main.c               |   2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |   5 -
 drivers/video/fbdev/kyro/fbdev.c                   |   2 +-
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c       |   2 +-
 drivers/video/fbdev/matrox/matroxfb_g450.c         |   2 +-
 drivers/video/fbdev/mb862xx/mb862xx-i2c.c          |   9 +-
 drivers/video/fbdev/mx3fb.c                        |   2 +-
 drivers/video/fbdev/mxsfb.c                        |   9 +-
 drivers/video/fbdev/offb.c                         |  15 +
 drivers/video/fbdev/omap/lcd_mipid.c               |   9 +-
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |  14 +-
 .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |   7 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |  12 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |   8 -
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |   8 -
 drivers/video/fbdev/pm2fb.c                        |   2 +-
 drivers/video/fbdev/pxafb.c                        |   3 +-
 drivers/video/fbdev/s1d13xxxfb.c                   |   4 +-
 drivers/video/fbdev/s3c2410fb.c                    |   2 +-
 drivers/video/fbdev/s3c2410fb.h                    |   2 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |   2 +-
 drivers/video/fbdev/simplefb.c                     |  13 +-
 drivers/video/fbdev/sm712fb.c                      |   2 +-
 drivers/video/fbdev/smscufx.c                      |   2 -
 drivers/video/fbdev/ssd1307fb.c                    |   9 +-
 drivers/video/fbdev/tdfxfb.c                       |   4 +-
 drivers/video/fbdev/uvesafb.c                      |   2 +-
 drivers/video/fbdev/vfb.c                          | 129 +--
 drivers/video/fbdev/vga16fb.c                      |   2 +-
 include/linux/amba/clcd.h                          |  63 +-
 include/video/exynos_mipi_dsim.h                   | 358 ---------
 59 files changed, 1042 insertions(+), 3916 deletions(-)
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 create mode 100644 drivers/video/fbdev/amba-clcd-versatile.h
 delete mode 100644 drivers/video/fbdev/exynos/Kconfig
 delete mode 100644 drivers/video/fbdev/exynos/Makefile
 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi.c
 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi_common.h
 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi_lowlevel.c=

 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi_lowlevel.h=

 delete mode 100644 drivers/video/fbdev/exynos/exynos_mipi_dsi_regs.h
 delete mode 100644 drivers/video/fbdev/exynos/s6e8ax0.c
 delete mode 100644 include/video/exynos_mipi_dsim.h


--fLeialjWssLPa3WVh9v5SQDHA7RJh7bEX--

--mK3tAAXnHuDsUshERHoV3Q0Se2519PkoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/f7KAAoJEPo9qoy8lh715EQQAIjocWSFxiXXtVETO8F1NH5S
qRUn3ca6qcmpF+7QrQ+GeizvKmUGewASxfCqFi4zmnUqq/QQx3ETwbA/Ge5PyA+O
CQzsLOOEecTmHspl2BLgzydMNLIXJWDvRtZ5Nc2fy+RBNkGKQ/f2M004DXyhqm1m
fpDloD+hpRp2X7X2DlHs+bCUx0FVwi6PocXoip3fNFJ2K7pFQAfNBAd2klUhAd4Y
YlH/DkoPuWR8K079hb1TZ1BR/7LeWnJP8jU6+2oiWjJyVRyyzAOBCq4+RjkCt0d4
uVSOPiMMyPKpUNHChQc6AxyNo3tpMLHsbhxbLC0j4DgPTRwGO15zLtI4pDX/l4DD
kYuUcMo0sI7O1zZo7AVmHCRLlcXt/Jx5q8YI+pCzjvh4VTFLZoQDPtwd00Y2TlD8
Ihq8Jtafv7dD0EW165ob9apNX4zJvUHrvPzRsN3un/6kb80wCQLOBlkQQ4p008o8
EP1+G4bDDRdeqoSppGveYXiynhPRm/xhDugaIx0F8Dv87R/89SL1SJ9kIxjETb6R
VVFyREKcVlIKyNXg+Q15MzjIcANerh0GUabJz9NtWyqIE6kMUvBMUcHidrP0+yRo
iZfdKgFdBfzWO+WjFkz1YWpxV7+UNl8XiwhuW6Om5/w9tfcrzP/rRSQS7Q+3enUU
UaFsge6VNA90lS8AcZdU
=AcWu
-----END PGP SIGNATURE-----

--mK3tAAXnHuDsUshERHoV3Q0Se2519PkoV--
