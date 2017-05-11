From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 May 2017 12:50:58 +0000
Subject: [GIT PULL] fbdev changes for v4.12
Message-Id: <2158938.D33KXVnxhk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170511125101epcas5p4e5b8622fb9e51a0a5fb348da17ecab15@epcas5p4.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.12.  There is nothing really major here,
just a couple of small bugfixes, improvements and cleanups.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.12

for you to fetch changes up to 34bf129a7f068e3108dbb051b4b05674e2a270e7:

  fbdev: sti: don't select CONFIG_VT (2017-05-05 17:25:12 +0200)

----------------------------------------------------------------
fbdev changes for v4.12:

- fix handling of probing errors in omapfb (Arvind Yadav)
- remove incorrect __exit markups in few drivers (Dmitry Torokhov)
- fix boot time logo support for drivers using deferred probe (Takeshi Kihara)
- fix DMA allocation size for ARM CLCD driver (Liam Beguin)
- add support for specifying size via xenstore in xen-frontfb (Juergen Gross)
- support for AUS mode in imxfb driver (Martin Kaiser)
- fix buffer on stack usage in udlfb driver (Maksim Salau)
- probe failure path fixup in sm501fb driver (Alexey Khoroshilov)
- fix config dependency loop for stifb driver (Arnd Bergmann)
- misc cleanups
  (Joe Perches, Christophe Leroy, Karim Eshapa, Pushkar Jambhlekar)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      sm501fb: don't return zero on failure path in sm501fb_start()

Arnd Bergmann (1):
      fbdev: sti: don't select CONFIG_VT

Arvind Yadav (1):
      omapfb: dss: Handle return errors in dss_init_ports()

Christophe Leroy (1):
      video: console: Remove reference to CONFIG_8xx

Dmitry Torokhov (4):
      video: fbdev: pmag-ba-fb: remove incorrect __exit markups
      video: fbdev: pmagb-b-fb: remove incorrect __exit markups
      video: fbdev: pmag-aa-fb: remove incorrect __exit markups
      video: fbdev: i810: remove incorrect __exit markups

Joe Perches (1):
      drivers/video: Convert remaining uses of pr_warning to pr_warn

Juergen Gross (1):
      xen, fbfront: add support for specifying size via xenstore

Karim Eshapa (1):
      drivers/video/fbdev/omap/lcd_mipid.c: Use time comparison kernel macros

Liam Beguin (1):
      video: ARM CLCD: fix dma allocation size

Maksim Salau (1):
      video: fbdev: udlfb: Fix buffer on stack

Martin Kaiser (2):
      video: fbdev: imxfb: support AUS mode
      dt-bindings: display: imx: entry for AUS mode

Pushkar Jambhlekar (1):
      drivers/video/fbdev: Fixing coding guidelines in acornfb.c

Takeshi Kihara (1):
      video/logo: tidyup fb_logo_late_init initcall timing

 .../devicetree/bindings/display/imx/fsl,imx-fb.txt      |  2 ++
 drivers/video/Makefile                                  |  1 +
 drivers/video/console/Kconfig                           |  2 +-
 drivers/video/fbdev/Kconfig                             |  2 --
 drivers/video/fbdev/acornfb.c                           | 12 +++++-------
 drivers/video/fbdev/amba-clcd.c                         |  4 ++--
 drivers/video/fbdev/aty/radeon_base.c                   |  4 ++--
 drivers/video/fbdev/core/fbmon.c                        |  4 ++--
 drivers/video/fbdev/i810/i810_main.c                    |  6 +++---
 drivers/video/fbdev/imxfb.c                             | 17 +++++++++++++++++
 drivers/video/fbdev/omap/lcd_mipid.c                    |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c              | 16 +++++++++++-----
 drivers/video/fbdev/pmag-aa-fb.c                        |  4 ++--
 drivers/video/fbdev/pmag-ba-fb.c                        |  4 ++--
 drivers/video/fbdev/pmagb-b-fb.c                        |  4 ++--
 drivers/video/fbdev/pxafb.c                             |  7 +++----
 drivers/video/fbdev/sm501fb.c                           |  1 +
 drivers/video/fbdev/udlfb.c                             | 14 ++++++++++++--
 drivers/video/fbdev/xen-fbfront.c                       | 10 ++++++++++
 drivers/video/logo/logo.c                               |  2 +-
 include/linux/platform_data/video-imxfb.h               |  1 +
 21 files changed, 81 insertions(+), 38 deletions(-)

