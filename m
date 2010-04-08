From: Roger Quadros <roger.quadros@nokia.com>
Date: Thu, 08 Apr 2010 12:21:02 +0000
Subject: [PATCHv2 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <1270729267-27553-1-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Tomi,

Please take these in your DSS branch if they are OK.
Tony is fine if you take the board stuff too.

regards,
-roger

These patches get the N900 LCD panel working.
Apply's cleanly on 2.6.34-rc3

Pre-requisites:
https://patchwork.kernel.org/patch/86318/
https://patchwork.kernel.org/patch/86319/
https://patchwork.kernel.org/patch/86320/

Changes since v1:
-Added Backlight control

---
Roger Quadros (5):
  OMAP: RX51: Add LCD Panel support
  OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
  OMAP: RX51: Add Touch Controller in SPI board info
  OMAP: DSS2: Add ACX565AKM Panel Driver
  OMAP: RX51: Update board defconfig

 arch/arm/configs/rx51_defconfig                |   39 ++-
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
 arch/arm/mach-omap2/board-rx51-video.c         |   95 +++
 drivers/video/omap2/displays/Kconfig           |    6 +
 drivers/video/omap2/displays/Makefile          |    1 +
 drivers/video/omap2/displays/panel-acx565akm.c |  819 ++++++++++++++++++++++++
 7 files changed, 1003 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c

