From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2011 16:24:08 +0000
Subject: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
Message-Id: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are some smallish fixes and cleanups I made while porting N800's display
driver to DSS2. 

 Tomi

Tomi Valkeinen (8):
  OMAP: DSS2: Add missing dummy functions
  OMAPFB: fix wrong clock aliases and device name
  OMAP: DSS2: RFBI: add rfbi_bus_lock
  OMAP: DSS2: RFIB: clock enable/disable changes
  OMAP: DSS2: RFBI: add omap_rfbi_configure
  OMAP: DSS2: RFIB: cleanup
  OMAP: DSS2: OMAPFB: remove dead code
  OMAP: DSS2: OMAPFB: Reduce stack usage

 arch/arm/plat-omap/include/plat/display.h |    4 +
 drivers/video/omap/dispc.c                |    4 +-
 drivers/video/omap/omapfb_main.c          |    2 +-
 drivers/video/omap/rfbi.c                 |    2 +-
 drivers/video/omap2/dss/dss.h             |   28 ++++-
 drivers/video/omap2/dss/rfbi.c            |  174 +++++------------------------
 drivers/video/omap2/omapfb/omapfb-main.c  |   78 +++++--------
 7 files changed, 86 insertions(+), 206 deletions(-)

-- 
1.7.4.1

