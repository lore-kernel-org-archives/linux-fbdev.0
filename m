From: Roger Quadros <roger.quadros@nokia.com>
Date: Thu, 15 Apr 2010 12:06:16 +0000
Subject: [PATCHv3 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Tomi,

Resending the patchset.

Checkpatch was not complaining at my end. Probably the mail server is
mangling the patches. I will send a tarball separately.

The only change in this version is that i've put the Video memory
initialization code in the board file.

The TSC2005 stuff is still thereas without it panel is not detected.
The merge conflict with TSC2005 patches if happens is very trivial to resolve.


regards,
-roger

These patches get the N900 LCD panel working.
Applys cleanly on 2.6.34-rc3

Changes since v2:
-Added Video mem init in board file
Changes since v1:
-Added Backlight control

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
  OMAP: RX51: Update board defconfig

 arch/arm/configs/rx51_defconfig                |   39 ++-
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
 arch/arm/mach-omap2/board-rx51-video.c         |  107 +++
 arch/arm/mach-omap2/board-rx51.c               |    2 +
 drivers/video/omap2/displays/Kconfig           |    6 +
 drivers/video/omap2/displays/Makefile          |    1 +
 drivers/video/omap2/displays/panel-acx565akm.c |  819 ++++++++++++++++++++++++
 8 files changed, 1017 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c

