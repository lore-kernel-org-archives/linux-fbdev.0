From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2011 10:10:57 +0000
Subject: [PATCH 0/9] Miscellaneous OMAP DSS patches
Message-Id: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Some miscellaneous DSS patches. Quite minor fixes/cleanups, except "Remove
implicit display update on unblank" which does have some functional impact. 

Jani Nikula (2):
  OMAP: DSS2: Add method for querying display dimensions from DSS
    drivers
  OMAP: DSS2: OMAPFB: Remove implicit display update on unblank

Tomi Valkeinen (7):
  OMAP: DSS2: move dss device clock configuration
  OMAP: DSS2: remove non-working msleep(40) workaround
  OMAP: DSS2: make 50ms bug-fix sleep optional
  OMAP: DSS2: VENC: make 20ms venc bug-fix sleep optional
  OMAP: DSS2: VENC: Remove sleeps at venc enable/disable
  OMAP: DSS2: OMAPFB: Handle errors when initializing panel
  OMAP: DSS2: VENC: Add missing start/stop_device calls

 arch/arm/mach-omap2/board-4430sdp.c       |   14 +++--
 arch/arm/plat-omap/include/plat/display.h |   30 +++++---
 drivers/video/omap2/dss/Kconfig           |   23 ++++++
 drivers/video/omap2/dss/dsi.c             |   14 ++--
 drivers/video/omap2/dss/dss.c             |    5 ++
 drivers/video/omap2/dss/overlay.c         |   19 +++--
 drivers/video/omap2/dss/venc.c            |   21 ++++--
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   12 +++-
 drivers/video/omap2/omapfb/omapfb-main.c  |  105 +++++++++++++++++++----------
 9 files changed, 168 insertions(+), 75 deletions(-)

