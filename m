From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 09 Oct 2012 12:30:23 +0000
Subject: [PATCHv2 0/3] OMAP: VRFB: convert to platform device
Message-Id: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This is second version of the patch series. The changes to v1 are:
* request mem region for VRFB registers
* declare VRFB resources with names
* remove unused VRFB code from sdrc
* vrfb is now tristate, so that it can be built as a module

 Tomi

Tomi Valkeinen (3):
  OMAP: VRFB: convert vrfb to platform device
  OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
  OMAP: SDRC: remove VRFB code

 arch/arm/mach-omap2/sdrc.c                |   16 ----
 arch/arm/plat-omap/fb.c                   |   59 ++++++++++++++
 arch/arm/plat-omap/include/plat/sdrc.h    |    7 --
 arch/arm/plat-omap/include/plat/vrfb.h    |   66 ---------------
 drivers/media/video/omap/omap_vout.c      |    2 +-
 drivers/media/video/omap/omap_vout_vrfb.c |    2 +-
 drivers/media/video/omap/omap_voutdef.h   |    2 +-
 drivers/video/omap2/Kconfig               |    2 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    2 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    2 +-
 drivers/video/omap2/vrfb.c                |  126 ++++++++++++++++++++++++-----
 include/video/omapvrfb.h                  |   66 +++++++++++++++
 13 files changed, 237 insertions(+), 117 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/vrfb.h
 create mode 100644 include/video/omapvrfb.h

-- 
1.7.9.5

