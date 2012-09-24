From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:30 +0000
Subject: [PATCH 0/9] OMAPDSS: OMAP5 related patches
Message-Id: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds basic OMAP5 DSS functionality, mainly related to DSS core, DPI
and DSI.

 Tomi

Archit Taneja (1):
  OMAPDSS: Add basic omap5 features to dss and dispc

Tomi Valkeinen (8):
  OMAPDSS: DSI: improve DSI clock calcs for DISPC
  OMAPDSS: move dss feats to the end of dss.c
  OMAPDSS: Add support for DPI source selection
  OMAPDSS: DSI: Add FEAT_DSI_PLL_SELFREQDCO
  OMAPDSS: DSI: Add FEAT_DSI_PLL_REFSEL
  OMAPDSS: DSI: Add new linebuffer size for OMAP5
  OMAPDSS: DSI: Add code to disable PHY DCC
  OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5

 drivers/video/omap2/dss/Kconfig        |    2 +-
 drivers/video/omap2/dss/dispc.c        |    2 +
 drivers/video/omap2/dss/dpi.c          |    5 +
 drivers/video/omap2/dss/dsi.c          |  167 +++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dss.c          |  121 ++++++++++++++++++-----
 drivers/video/omap2/dss/dss.h          |    1 +
 drivers/video/omap2/dss/dss_features.c |   96 ++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    3 +
 8 files changed, 337 insertions(+), 60 deletions(-)

-- 
1.7.9.5

