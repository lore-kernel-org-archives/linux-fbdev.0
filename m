From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 24 Feb 2017 17:29:02 +0000
Subject: [GIT PULL] fbdev changes for v4.11
Message-Id: <1729730.vf6uWAbBdU@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170224172905epcas1p22a355c825bc44e158d3603ca5f38d992@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.11.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 4dcd19bfabaee8f9f4bcf203afba09b98ccbaf76:

  video: fbdev: cobalt_lcdfb: Handle return NULL error from devm_ioremap (2017-01-04 12:58:45 +0100)

are available in the git repository at:

  git://github.com/bzolnier/linux.git tags/fbdev-v4.11

for you to fetch changes up to 42f82367df2cb2b71ceead6164e4415851c51fa4:

  video: fbdev: fsl-diu-fb: fix spelling mistake "palette" (2017-02-20 13:51:07 +0100)

----------------------------------------------------------------
fbdev changes for v4.11:

- fix for font color when console is switched to another fb driver
- deferred probing fixes for simplefb driver
- preparations to add support of an optional GPIO to enable panel
  for ARM CLCD driver
- some improvements for ssd1307fb driver
- cleanups for OMAP fbdev LCD drivers
- misc fixes/cleanups for various fb drivers

----------------------------------------------------------------
Arnd Bergmann (1):
      fbdev: ssd1307fb: include linux/gpio/consumer.h

Arvind Yadav (1):
      video: fbdev: stifb: handle NULL return value from ioremap_nocache

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'fbdev-v4.10-rc2' of git://github.com/bzolnier/linux into fbdev-for-next

Bhumika Goyal (1):
      video: fbdev: maxinefb: add __initdata to maxinefb_fix

Colin Ian King (1):
      video: fbdev: fsl-diu-fb: fix spelling mistake "palette"

Dmitry Torokhov (1):
      video: fbdev: offb: switch to using for_each_node_by_type

Geliang Tang (1):
      video/mbx: use simple_open()

Hans de Goede (1):
      video: fbdev: simplefb: Separate clk / regulator get and enable steps

Jan Stourac (1):
      video/console: use setup_timer and mod_timer instead of init_timer

Julia Lawall (1):
      video: fbdev: wm8505fb use permission-specific DEVICE_ATTR variants

Jyri Sarha (3):
      fbdev: ssd1307fb: Start to use gpiod API for reset gpio
      fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
      fbdev: ssd1307fb: Make reset gpio devicetree property optional

Kees Cook (2):
      video: fbdev: sh_mobile_lcdcfb: use designated initializers
      video: fbdev: matroxfb: use designated initializers

Lars-Peter Clausen (3):
      fbdev: omap/lcd: Remove no-op driver callbacks
      fbdev: omap/lcd: Staticize non-exported lcd_panel structs
      fbdev: omap/lcd: Make callbacks optional

Maciej W. Rozycki (2):
      video: fbdev: pmag-ba-fb: Remove bad `__init' annotation
      video: fbdev: pmagb-b-fb: Remove bad `__init' annotation

Martin Kaiser (2):
      video: fbdev: imxfb: remove the macros for initializing the DMACR
      video: fbdev: imxfb: always allocate 256 entries for the color map

Sachin Shukla (2):
      video: fbdev: amifb: remove impossible condition
      video: fbdev: fsl-diu-fb: remove impossible condition

Takashi Iwai (1):
      fbcon: Fix vc attr at deinit

Tomi Valkeinen (2):
      fbdev/ssd1307fb: add support to enable VBAT
      fbdev/ssd1307fb: clear screen in probe

Vladimir Zapolskiy (3):
      video: ARM CLCD: sort included headers out alphabetically
      video: ARM CLCD: use panel device node for panel initialization
      video: ARM CLCD: use panel device node for getting backlight and mode

Wei Yongjun (1):
      video: fbdev: sh_mobile_lcdcfb: fix error return code in sh_mobile_lcdc_probe()

 .../devicetree/bindings/display/ssd1307fb.txt      |  5 +-
 drivers/video/console/fbcon.c                      | 75 +++++++++++++---------
 drivers/video/fbdev/amba-clcd-nomadik.c            |  9 +--
 drivers/video/fbdev/amba-clcd-nomadik.h            |  5 +-
 drivers/video/fbdev/amba-clcd-versatile.c          | 14 +---
 drivers/video/fbdev/amba-clcd-versatile.h          |  5 +-
 drivers/video/fbdev/amba-clcd.c                    | 51 ++++++---------
 drivers/video/fbdev/amifb.c                        |  8 +--
 drivers/video/fbdev/fsl-diu-fb.c                   | 13 +---
 drivers/video/fbdev/imxfb.c                        |  6 +-
 drivers/video/fbdev/matrox/matroxfb_DAC1064.c      | 10 ++-
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c       |  5 +-
 drivers/video/fbdev/maxinefb.c                     |  2 +-
 drivers/video/fbdev/mbx/mbxdebugfs.c               | 18 ++----
 drivers/video/fbdev/offb.c                         |  4 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c           | 25 --------
 drivers/video/fbdev/omap/lcd_h3.c                  | 37 +----------
 drivers/video/fbdev/omap/lcd_htcherald.c           | 51 +--------------
 drivers/video/fbdev/omap/lcd_inn1510.c             | 39 +----------
 drivers/video/fbdev/omap/lcd_inn1610.c             | 27 +-------
 drivers/video/fbdev/omap/lcd_osk.c                 | 38 +----------
 drivers/video/fbdev/omap/lcd_palmte.c              | 50 +--------------
 drivers/video/fbdev/omap/lcd_palmtt.c              | 43 +------------
 drivers/video/fbdev/omap/lcd_palmz71.c             | 45 +------------
 drivers/video/fbdev/omap/omapfb_main.c             | 31 +++++----
 drivers/video/fbdev/pmag-ba-fb.c                   |  2 +-
 drivers/video/fbdev/pmagb-b-fb.c                   |  2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             | 10 +--
 drivers/video/fbdev/simplefb.c                     | 56 +++++++++++-----
 drivers/video/fbdev/ssd1307fb.c                    | 56 ++++++++++------
 drivers/video/fbdev/stifb.c                        |  4 ++
 drivers/video/fbdev/wm8505fb.c                     |  2 +-
 include/linux/fsl-diu-fb.h                         |  4 +-
 include/linux/platform_data/video-imxfb.h          |  4 --
 34 files changed, 225 insertions(+), 531 deletions(-)

