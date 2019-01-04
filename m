From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 04 Jan 2019 12:09:05 +0000
Subject: [GIT PULL] fbdev changes for v4.21
Message-Id: <8389e508-e1ac-dc96-9535-49fcfe3a404a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190104120907eucas1p1cde1273265b78d7dccbe26728b717602@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.21. This time the pull request is
really small. The most notable changes are fixing fbcon to not cause
crash on unregister_framebuffer() operation when there is more than
one framebuffer, adding config option to center the bootup logo and
making FB_BACKLIGHT config option tristate (which in turn uncovered
incorrect FB_BACKLIGHT usage by DRM's nouveau driver). Please see
the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.21

for you to fetch changes up to 399382f8018204407174f0229b4087d40e1cdc82:

  drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig (2019-01-02 18:47:37 +0100)

----------------------------------------------------------------
fbdev changes for v4.21:

- fix fbcon to not cause crash on unregister_framebuffer()
  when there is more than one framebuffer (Noralf Trønnes)

- improve support for small rotated displays (Peter Rosin)

- fix probe failure handling in udlfb driver (Dan Carpenter)

- add config option to center the bootup logo (Peter Rosin)

- make FB_BACKLIGHT config option tristate (Rob Clark)

- remove superfluous HAS_DMA dependency for goldfishfb driver
  (Geert Uytterhoeven)

- misc fixes (Alexey Khoroshilov, YueHaibing, Colin Ian King,
  Lubomir Rintel)

- misc cleanups (Yangtao Li, Wen Yang)

also there is DRM's nouveau driver fix for wrong FB_BACKLIGHT
config option usage (FB_BACKLIGHT is for internal fbdev
subsystem use only)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      video: clps711x-fb: release disp device node in probe()

Bartlomiej Zolnierkiewicz (2):
      Merge tag 'v4.20-rc7' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig

Colin Ian King (1):
      fbdev: uvesafb: fix spelling mistake "memoery" -> "memory"

Dan Carpenter (1):
      udlfb: fix some inconsistent NULL checking

Geert Uytterhoeven (1):
      fbdev: Remove depends on HAS_DMA in case of platform dependency

Lubomir Rintel (1):
      pxa168fb: trivial typo fix

Noralf Trønnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Peter Rosin (3):
      fbdev: fbmem: behave better with small rotated displays and many CPUs
      fbdev: fbmem: make fb_show_logo_line return the end instead of the height
      fbdev: fbmem: add config option to center the bootup logo

Rob Clark (1):
      fbdev: make FB_BACKLIGHT a tristate

Wen Yang (1):
      fbdev: fsl-diu: remove redundant null check on cmap

Yangtao Li (1):
      fbdev: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE

YueHaibing (1):
      video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"

 drivers/gpu/drm/nouveau/Kconfig             |  3 ++-
 drivers/video/fbdev/Kconfig                 |  5 ++--
 drivers/video/fbdev/clps711x-fb.c           |  5 +++-
 drivers/video/fbdev/core/fbcon.c            |  2 +-
 drivers/video/fbdev/core/fbmem.c            | 39 ++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbsysfs.c          |  8 +++---
 drivers/video/fbdev/fsl-diu-fb.c            |  3 +--
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 18 +++----------
 drivers/video/fbdev/pxa168fb.c              |  2 +-
 drivers/video/fbdev/pxafb.c                 |  4 +--
 drivers/video/fbdev/udlfb.c                 | 14 +++++------
 drivers/video/fbdev/uvesafb.c               |  2 +-
 drivers/video/logo/Kconfig                  |  9 +++++++
 include/linux/fb.h                          |  2 +-
 include/uapi/linux/fb.h                     |  2 --
 15 files changed, 71 insertions(+), 47 deletions(-)
