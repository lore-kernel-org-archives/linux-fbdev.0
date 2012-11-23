From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 23 Nov 2012 16:35:10 +0000
Subject: [PATCH 0/5] Backlight drivers for SH and ARM SH-Mobile boards
Message-Id: <1353688515-30458-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

Here are two backlight drivers used by SH and ARM SH-Mobile boards.

The first driver supports simple GPIO-controlled backlights that are turned on
or off by a single GPIO (either active high or active low).

The second driver supports the Sanyo LV5207LP LED driver
(http://www.onsemi.com/pub_link/Collateral/ENA0943-D.PDF) and exposes the main
LED only as a backlight device, as that's all the board I need to driver for
uses.

The last three patches port the ARM SH-Mobile Mackerel, SH Ecovec24 and SH
KFR2R09 boards to use the new backlight drivers. The code has been compile
tested on all three platforms and runtime tested on Mackerel only as I don't
have access to the SH boards.

Laurent Pinchart (5):
  backlight: Add GPIO-based backlight driver
  backlight: Add Sanyo LV5207LP backlight driver
  ARM: mach-shmobile: mackerel: Use gpio-backlight
  sh: ecovec24: Use gpio-backlight
  sh: kfr2r09: Use lv5207lp backlight

 arch/arm/mach-shmobile/board-mackerel.c     |   34 +++---
 arch/sh/boards/mach-ecovec24/setup.c        |   37 +++---
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   48 --------
 arch/sh/boards/mach-kfr2r09/setup.c         |   19 ++-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    2 -
 drivers/video/backlight/Kconfig             |   13 ++
 drivers/video/backlight/Makefile            |    2 +
 drivers/video/backlight/gpio_backlight.c    |  158 +++++++++++++++++++++++++
 drivers/video/backlight/lv5207lp.c          |  171 +++++++++++++++++++++++++++
 include/linux/platform_data/lv5207lp.h      |   20 +++
 include/video/gpio_backlight.h              |   21 ++++
 11 files changed, 436 insertions(+), 89 deletions(-)
 create mode 100644 drivers/video/backlight/gpio_backlight.c
 create mode 100644 drivers/video/backlight/lv5207lp.c
 create mode 100644 include/linux/platform_data/lv5207lp.h
 create mode 100644 include/video/gpio_backlight.h

-- 
Regards,

Laurent Pinchart

