From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 15 Mar 2019 11:12:27 +0000
Subject: [GIT PULL] fbdev changes for v5.1
Message-Id: <4114bd4f-9c58-a295-c767-47720dcf2c37@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v5.1. Just a couple of small fixes and
cleanups (please see the signed tag description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.1

for you to fetch changes up to 9a9f1d1a81a972513636c333e26c542f8aebae55:

  fbdev: mbx: fix a misspelled variable name (2019-03-05 12:36:33 +0100)

----------------------------------------------------------------
fbdev changes for v5.1:

- fix memory access if logo is bigger than the screen (Manfred
  Schlaegl)

- silence fbcon logo on 'quiet' boots (Prarit Bhargava)

- use kvmalloc() for scrollback buffer in fbcon (Konstantin Khorenko)

- misc fixes (Colin Ian King, YueHaibing, Matteo Croce, Mathieu
  Malaterre, Anders Roxell, Arnd Bergmann)

- misc cleanups (Rob Herring, Lubomir Rintel, Greg Kroah-Hartman,
  Jani Nikula, Michal Vokáč)

----------------------------------------------------------------
Anders Roxell (1):
      fbdev: omap2: fix warnings in dss core

Arnd Bergmann (1):
      fbdev: mbx: fix a misspelled variable name

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v5.0-rc5' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (1):
      fbdev/via: fix spelling mistake "Expandsion" -> "Expansion"

Greg Kroah-Hartman (2):
      fbdev: omap2: no need to check return value of debugfs_create functions
      fbdev: mbx: fix up debugfs file creation

Jani Nikula (1):
      video/fbdev: refactor video= cmdline parsing

Konstantin Khorenko (1):
      fbcon: use kvmalloc() for scrollback buffer

Lubomir Rintel (1):
      video: fbdev: geode: remove ifdef OLPC noise

Manfred Schlaegl (1):
      fbdev: fbmem: fix memory access if logo is bigger than the screen

Mathieu Malaterre (1):
      video: offb: annotate implicit fall throughs

Matteo Croce (1):
      omapfb: fix typo

Michal Vokáč (3):
      dt-bindings: display: ssd1307fb: Remove reset-active-low from examples
      video: ssd1307fb: Do not hard code active-low reset sequence
      ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity

Prarit Bhargava (2):
      printk: Export console_printk
      fbcon: Silence fbcon logo on 'quiet' boots

Rob Herring (1):
      fbdev: Use of_node_name_eq for node name comparisons

YueHaibing (2):
      fbdev: chipsfb: remove set but not used variable 'size'
      video: fbdev: Fix potential NULL pointer dereference

 .../devicetree/bindings/display/ssd1307fb.txt      |  2 --
 arch/arm/boot/dts/imx28-cfa10036.dts               |  3 +-
 drivers/video/fbdev/aty/radeon_pm.c                |  6 ++--
 drivers/video/fbdev/cg14.c                         |  4 +--
 drivers/video/fbdev/cg3.c                          |  2 +-
 drivers/video/fbdev/chipsfb.c                      |  3 +-
 drivers/video/fbdev/core/fb_cmdline.c              | 23 ++++++-------
 drivers/video/fbdev/core/fbcon.c                   | 14 +++++---
 drivers/video/fbdev/core/fbmem.c                   |  3 ++
 drivers/video/fbdev/core/fbmon.c                   |  2 ++
 drivers/video/fbdev/ffb.c                          |  2 +-
 drivers/video/fbdev/geode/gxfb_core.c              | 13 ++-----
 drivers/video/fbdev/geode/lxfb_core.c              | 13 ++-----
 drivers/video/fbdev/imsttfb.c                      |  4 +--
 drivers/video/fbdev/mbx/mbxdebugfs.c               | 40 +++++++---------------
 drivers/video/fbdev/mbx/mbxfb.c                    |  2 +-
 drivers/video/fbdev/offb.c                         |  4 ++-
 drivers/video/fbdev/omap2/omapfb/dss/core.c        | 34 ++++--------------
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  4 +--
 drivers/video/fbdev/omap2/omapfb/dss/dss.h         |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |  2 +-
 drivers/video/fbdev/ssd1307fb.c                    |  4 +--
 drivers/video/fbdev/via/viafbdev.c                 |  2 +-
 kernel/printk/printk.c                             |  1 +
 24 files changed, 72 insertions(+), 117 deletions(-)
