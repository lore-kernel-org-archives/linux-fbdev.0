From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Jan 2019 12:38:44 +0000
Subject: [GIT PULL] fbdev fixes for v5.0-rc3
Message-Id: <2bb72d22-590c-958f-1dd1-fe44f264091b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190118123845eucas1p25b20e2175991a620437c338a0001f03a@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev fixes for v5.0-rc3 (please see the signed tag
description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 399382f8018204407174f0229b4087d40e1cdc82:

  drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig (2019-01-02 18:47:37 +0100)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.0-rc3

for you to fetch changes up to 890d14d2d4b57ff5a149309da3ed36c8a529987f:

  fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line option (2019-01-16 17:42:35 +0100)

----------------------------------------------------------------
fbdev fixes for v5.0-rc3:

- fix stack memory leak in omap2fb driver (Vlad Tsyrklevich)

- fix OF node name handling v4.20 regression in offb driver (Rob Herring)

- convert CONFIG_FB_LOGO_CENTER config option added in v5.0-rc1 into
  a kernel parameter (Peter Rosin)

----------------------------------------------------------------
Peter Rosin (1):
      fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line option

Rob Herring (1):
      fbdev: offb: Fix OF node name handling

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

 Documentation/fb/fbcon.txt                      |  8 ++++++++
 drivers/video/fbdev/core/fbcon.c                |  7 +++++++
 drivers/video/fbdev/core/fbmem.c                | 19 ++++++++++---------
 drivers/video/fbdev/offb.c                      | 18 +++++++++---------
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  2 ++
 drivers/video/logo/Kconfig                      |  9 ---------
 include/linux/fb.h                              |  1 +
 7 files changed, 37 insertions(+), 27 deletions(-)
