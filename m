From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:12 +0000
Subject: [PATCH 0/4] OMAPDSS: misc minor fixes
Message-Id: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some minor fixes for DSS. 

 Tomi

Tomi Valkeinen (4):
  OMAP: OMAPFB: make omapfb start even when a display is missing a
    driver
  OMAP: DSS2: fix clock sources on error and uninit
  OMAP: DSS2: Handle manager change in apply
  OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig

 drivers/video/omap2/dss/Kconfig          |    2 +-
 drivers/video/omap2/dss/dispc.c          |    4 +++-
 drivers/video/omap2/dss/dpi.c            |    4 +++-
 drivers/video/omap2/dss/dsi.c            |    3 +++
 drivers/video/omap2/dss/dss.h            |    2 --
 drivers/video/omap2/dss/manager.c        |    5 +++++
 drivers/video/omap2/dss/overlay.c        |    9 ++-------
 drivers/video/omap2/omapfb/Kconfig       |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++--
 include/video/omapdss.h                  |    1 +
 10 files changed, 22 insertions(+), 15 deletions(-)

-- 
1.7.4.1

