From: Roger Quadros <roger.quadros@nokia.com>
Date: Tue, 23 Mar 2010 09:56:26 +0000
Subject: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tony@atomide.com
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

These patches get the N900 LCD panel working.
Apply's cleanly on 2.6.34-rc2

Pre-requisites:
https://patchwork.kernel.org/patch/86318/
https://patchwork.kernel.org/patch/86319/
https://patchwork.kernel.org/patch/86320/

---
Roger Quadros (5):
  OMAP: RX51: Add LCD Panel support
  OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
  OMAP: RX51: Add Touch Controller in SPI board info
  OMAP: DSS2: Add ACX565AKM Panel Driver
  OMAP: RX51: Add LCD Panel and framebuffer console to defconfig

 arch/arm/configs/rx51_defconfig                |   37 ++-
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
 arch/arm/mach-omap2/board-rx51-video.c         |   95 ++++
 drivers/video/omap2/displays/Kconfig           |    5 +
 drivers/video/omap2/displays/Makefile          |    1 +
 drivers/video/omap2/displays/panel-acx565akm.c |  551 ++++++++++++++++++++++++
 7 files changed, 732 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c

