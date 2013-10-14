From: Marek Belisko <marek@goldelico.com>
Date: Mon, 14 Oct 2013 21:02:32 +0000
Subject: [PATCH 0/3] omapdss: venc: Add support for bypass and acbias.
Message-Id: <1381784555-18344-1-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patches is adding bypass and acbias functionality to omapdss venc driver.
In first patch we export updatin bypass and acbias in devconf1 register. Next patch
add handling for updating in venc driver and last patch add driver for opa362 which
is used on gta04 board and set bypass + acbias.

Marek Belisko (3):
  arm: omap2: Export devconf1 bypass and acbias.
  video: venc: Add new callback and handling for bypass and acbias
    setup.
  omapdss: Add OPA362 analog video amplifier driver.

 arch/arm/mach-omap2/Makefile                       |   2 +
 arch/arm/mach-omap2/control.h                      |   2 +
 arch/arm/mach-omap2/omap3-tvout.c                  |  36 +++
 drivers/video/omap2/displays-new/Kconfig           |   6 +
 drivers/video/omap2/displays-new/Makefile          |   1 +
 .../video/omap2/displays-new/amplifier-opa362.c    | 294 +++++++++++++++++++++
 drivers/video/omap2/dss/venc.c                     |  21 ++
 include/linux/omap-tvout.h                         |  14 +
 include/video/omap-panel-data.h                    |  17 ++
 include/video/omapdss.h                            |   2 +
 10 files changed, 395 insertions(+)
 create mode 100644 arch/arm/mach-omap2/omap3-tvout.c
 create mode 100644 drivers/video/omap2/displays-new/amplifier-opa362.c
 create mode 100644 include/linux/omap-tvout.h

-- 
1.8.1.2

