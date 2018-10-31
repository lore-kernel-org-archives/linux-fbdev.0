From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 31 Oct 2018 14:31:13 +0000
Subject: [GIT PULL] fbdev changes for v4.20
Message-Id: <c0f72f36-5fdf-4207-03a5-fd903ae4d278@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.20. No major changes to the subsystem
itself, mainly fb drivers fixes & cleanups (atyfb & udlfb updates stand
out from the rest) + removal of no longer needed old clps711xfb driver.
Please see the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.20

for you to fetch changes up to 217188d9f985bd3ce8c9a0cd50ca35be62d0f8c6:

  video: fbdev: remove redundant 'default n' from Kconfig-s (2018-10-24 11:26:32 +0200)

----------------------------------------------------------------
fbdev changes for v4.20:

- update atyfb driver - improvements for ATI Mach64 chips: detect
  the dot clock divider correctly on Sparc, fix display corruptions
  (due to endianness issues and improper reading of accelerator
  registers), optimize scrolling performance and also fix debugging
  printks (Mikulas Patocka)

- rewrite USB unplug handling in udlfb driver using framebuffer
  subsystem reference counting (Mikulas Patocka)

- fix support for native-mode display-timings in atmel_lcdfb driver
  (Sam Ravnborg)

- fix information leak & add missing access_ok() checks in sbuslib
  (Dan Carpenter)

- allow using GPIO expanders that can sleep in ssd1307fb driver
  (Michal Vokáč)

- convert omapfb driver to use GPIO descriptors instead of GPIO
  numbers for Amstrad Delta board (Janusz Krzysztofik)

- fix broken Kconfig menu dependencies (Randy Dunlap)

- convert fbdev subsystem to use %pOFn instead of device_node.name
  (Rob Herring)

- remove the dead old CLPS711x LCD support driver (the new CLPS711x
  LCD support driver is still available)

- misc fixes (Jia-Ju Bai, Gustavo A. R. Silva)

- misc cleanups (Mehdi Bounya, Nathan Chancellor, YueHaibing)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (4):
      Merge tag 'v4.19-rc7' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      Revert "video: ssd1307fb: Do not hard code active-low reset sequence"
      video: fbdev: remove dead old CLPS711x LCD support driver
      video: fbdev: remove redundant 'default n' from Kconfig-s

Dan Carpenter (2):
      fbdev: sbuslib: use checked version of put_user()
      fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()

Gustavo A. R. Silva (1):
      video: fbdev: arcfb: mark expected switch fall-through

Janusz Krzysztofik (1):
      video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table

Jia-Ju Bai (1):
      video: fbdev: add the dependency of broadsheetfb in Kconfig

Mehdi Bounya (1):
      Video: vgastate: fixed a spacing coding style

Michal Vokáč (2):
      video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
      video: ssd1307fb: Do not hard code active-low reset sequence

Mikulas Patocka (6):
      udlfb: handle unplug properly
      mach64: detect the dot clock divider correctly on sparc
      mach64: fix display corruption on big endian machines
      mach64: fix image corruption due to reading accelerator registers
      mach64: optimize wait_for_fifo
      atyfb: fix debugging printks

Nathan Chancellor (1):
      video: fbdev: sis: Remove unnecessary parentheses and commented code

Randy Dunlap (1):
      fbdev: fix broken menu dependencies

Rob Herring (1):
      fbdev: Convert to using %pOFn instead of device_node.name

Sam Ravnborg (1):
      atmel_lcdfb: support native-mode display-timings

YueHaibing (1):
      pxa168fb: remove set but not used variables 'mi'

 drivers/video/fbdev/Kconfig                  |  59 +----
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/arcfb.c                  |   2 +
 drivers/video/fbdev/atmel_lcdfb.c            |  43 +---
 drivers/video/fbdev/aty/atyfb.h              |  15 +-
 drivers/video/fbdev/aty/atyfb_base.c         |  43 ++--
 drivers/video/fbdev/aty/mach64_accel.c       |  32 ++-
 drivers/video/fbdev/aty/mach64_ct.c          |  10 +-
 drivers/video/fbdev/cg14.c                   |   4 +-
 drivers/video/fbdev/cg3.c                    |   2 +-
 drivers/video/fbdev/clps711xfb.c             | 314 ---------------------------
 drivers/video/fbdev/core/fbmon.c             |   4 +-
 drivers/video/fbdev/imsttfb.c                |   2 +-
 drivers/video/fbdev/leo.c                    |   2 +-
 drivers/video/fbdev/mmp/hw/Kconfig           |   1 -
 drivers/video/fbdev/mmp/panel/Kconfig        |   1 -
 drivers/video/fbdev/offb.c                   |  12 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c     |  55 ++---
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig |   7 -
 drivers/video/fbdev/p9100.c                  |   2 +-
 drivers/video/fbdev/pxa168fb.c               |   3 -
 drivers/video/fbdev/sbuslib.c                |  28 +--
 drivers/video/fbdev/sis/init301.c            |   4 +-
 drivers/video/fbdev/ssd1307fb.c              |   4 +-
 drivers/video/fbdev/udlfb.c                  | 141 ++++--------
 drivers/video/of_display_timing.c            |   2 +-
 drivers/video/vgastate.c                     |   2 +-
 include/video/udlfb.h                        |   3 -
 28 files changed, 169 insertions(+), 629 deletions(-)
 delete mode 100644 drivers/video/fbdev/clps711xfb.c
