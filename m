From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 07 Feb 2018 15:08:09 +0000
Subject: [GIT PULL] fbdev changes for v4.16
Message-Id: <3114277.dUeCUFPaAu@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180207150811epcas1p3a2777b685e023aa843a3ecf2c32fd7dc@epcas1p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.16.  There is nothing really major here
(please see the signed tag description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 464e1d5f23cca236b930ef068c328a64cab78fb1:

  Linux 4.15-rc5 (2017-12-23 20:47:16 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16

for you to fetch changes up to 5865889fe4319415e439095391dda52f23030d60:

  video: udlfb: Switch from the pr_*() to the dev_*() logging functions (2018-01-16 16:35:20 +0100)

----------------------------------------------------------------
fbdev changes for v4.16:

- fix display-timings lookup in the Device Tree in atmel_lcdfb
  driver (Johan Hovold)

- fix video mode and line_length to be set correctly in vfb driver
  (Pieter "PoroCYon" Sluys)

- fix returning nonsensical values to the user-space on GIO_FONTX
  ioctl when using dummy console (Nicolas Pitre)

- add missing license tag to mmpfb driver (Arnd Bergmann)

- convert radeonfb and pxa3xx_gcu drivers to use ktime_get[_ts64]()
  instead of the deprecated do_gettimeofday() (Arnd Bergmann)

- switch udlfb driver from using the pr_*() logging functions to
  the dev_*() ones + related cleanups (Ladislav Michl)

- use __raw I/O accessors also on arm64 (Ji Zhang)

- fix Kconfig help text for intelfb driver (Randy Dunlap)

- do not duplicate features data in omapfb driver (Ladislav Michl)

- misc cleanups (Colin Ian King, Markus Elfring, Rasmus Villemoes,
  Vasyl Gomonovych, Himanshu Jha, Michael Trimarchi)

----------------------------------------------------------------
Arnd Bergmann (3):
      fbdev: radeon: use ktime_get() for HZ calibration
      fbdev: pxa3xx: use ktime_get_ts64 for time stamps
      video: fbdev/mmp: add MODULE_LICENSE

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.15-rc5' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (1):
      video: fbdev: remove redundant self assignment of 'height'

Himanshu Jha (1):
      fbdev: auo_k190x: Use zeroing memory allocator instead of allocator/memset

Ji Zhang (1):
      fbdev: arm64 use __raw I/O memory api

Johan Hovold (1):
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Ladislav Michl (7):
      omapfb: dss: Do not duplicate features data
      video: udlfb: Remove unnecessary local variable
      video: udlfb: Remove redundant gdev variable
      video: udlfb: Remove noisy warnings
      video: udlfb: Do not name private data 'dev'
      video: udlfb: Constify read only data
      video: udlfb: Switch from the pr_*() to the dev_*() logging functions

Markus Elfring (5):
      video/fbdev/wm8505fb: Delete an error message for a failed memory allocation in wm8505fb_probe()
      video/fbdev/vt8500lcdfb: Delete an error message for a failed memory allocation in vt8500lcd_probe()
      video: udlfb: Improve a size determination in dlfb_alloc_urb_list()
      video: udlfb: Delete an unnecessary return statement in two functions
      video: smscufx: Improve a size determination in two functions

Michael Trimarchi (1):
      fbdev: mxsfb: use framebuffer_alloc in the correct way

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Randy Dunlap (1):
      fb: intelfb: fix Kconfig symbol info in help text

Rasmus Villemoes (1):
      fbdev: au1200fb: delete duplicate header contents

Vasyl Gomonovych (1):
      video: fbdev: omap2: Use PTR_ERR_OR_ZERO()

 drivers/video/console/dummycon.c                |   1 -
 drivers/video/fbdev/Kconfig                     |   2 +-
 drivers/video/fbdev/atmel_lcdfb.c               |   8 +-
 drivers/video/fbdev/aty/radeon_base.c           |  18 +-
 drivers/video/fbdev/au1200fb.h                  | 286 -----------
 drivers/video/fbdev/auo_k190x.c                 |   3 +-
 drivers/video/fbdev/mmp/core.c                  |   5 +
 drivers/video/fbdev/mxsfb.c                     |  45 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c    |  39 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c      |  45 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c    |   5 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c |  31 +-
 drivers/video/fbdev/pxa3xx-gcu.c                |  16 +-
 drivers/video/fbdev/smscufx.c                   |   5 +-
 drivers/video/fbdev/udlfb.c                     | 655 ++++++++++++------------
 drivers/video/fbdev/vfb.c                       |  17 +
 drivers/video/fbdev/vga16fb.c                   |   1 -
 drivers/video/fbdev/vt8500lcdfb.c               |   4 +-
 drivers/video/fbdev/wm8505fb.c                  |   4 +-
 include/linux/fb.h                              |   5 +-
 include/video/udlfb.h                           |   3 +-
 21 files changed, 421 insertions(+), 777 deletions(-)

