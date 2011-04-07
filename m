From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Apr 2011 18:42:57 +0000
Subject: [GIT PULL] fbdev fixes for 2.6.39-rc3
Message-Id: <20110407184257.GA30115@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Alexandre Courbot (4):
      sh: mach-ecovec24: support for main lcd backlight
      sh: mach-ap325rxa: move backlight control code
      fbdev: sh_mobile_lcdcfb: add blanking support
      fbdev: sh_mobile_lcdcfb: fix module lock acquisition

Davidlohr Bueso (1):
      efifb: support AMD Radeon HD 6490

Florian Tobias Schandinat (2):
      viafb: refresh rate bug collection
      viafb: initialize margins correct

Jingoo Han (1):
      video: s3c-fb: fix checkpatch errors and warning

Julia Lawall (1):
      drivers/video/bfin-lq035q1-fb.c: introduce missing kfree

Matthew Garrett (2):
      fb: Reduce priority of resource conflict message
      efifb: Add override for 11" Macbook Air 3,1

Ondrej Zary (1):
      s3fb: fix Virge/GX2

Peter Jones (1):
      efifb: Support overriding fields FW tells us with the DMI data.

Sergey Senozhatsky (1):
      fbcon: Remove unused 'display *p' variable from fb_flashcursor()

Tormod Volden (3):
      savagefb: Replace magic register address with define
      savagefb: Set up I2C based on chip family instead of card id
      savagefb: Remove obsolete else clause in savage_setup_i2c_bus

 arch/sh/boards/mach-ap325rxa/setup.c |   32 +++++--
 arch/sh/boards/mach-ecovec24/setup.c |   18 ++++
 drivers/video/bfin-lq035q1-fb.c      |    4 +-
 drivers/video/console/fbcon.c        |    2 -
 drivers/video/efifb.c                |  154 +++++++++++++++++++++-------------
 drivers/video/fbmem.c                |    2 +-
 drivers/video/s3c-fb.c               |    8 +-
 drivers/video/s3fb.c                 |   48 ++++++++---
 drivers/video/savage/savagefb-i2c.c  |   14 ++--
 drivers/video/sh_mobile_lcdcfb.c     |   52 +++++++++++-
 drivers/video/sh_mobile_lcdcfb.h     |    1 +
 drivers/video/via/chip.h             |    1 -
 drivers/video/via/hw.c               |   17 ++--
 drivers/video/via/hw.h               |    3 +-
 drivers/video/via/viafbdev.c         |   74 ++++++++--------
 15 files changed, 280 insertions(+), 150 deletions(-)
