From: Archit Taneja <archit@ti.com>
Date: Thu, 09 Aug 2012 09:19:05 +0000
Subject: [PATCH v2 0/5] OMAPDSS: Misc Cleanups/Fixes
Message-Id: <1344503230-18550-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

These are minor cleanups and fixes which make some of the future work of making
outputs less dependant a bit easier. Some patches remove a few omap_dss_device
references which aren't needed any more after the patch:

"OMAPDSS: move clock settings from dssdev to dss pdata"

The rest add locking required in the DPI driver and the generic dpi panel
driver.

The commits are on the tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git misc_cleanup_3_7

Changes since v2:
- Misc patches just taken out from the series which changes the way of passing
  timings from panel to interace driver.

Archit Taneja (5):
  OMAPDSS: APPLY: Constify timings argument in dss_mgr_set_timings
  OMAPDSS: DPI: Remove omap_dss_device arguments in
    dpi_set_dsi_clk/dpi_set_dispc_clk
  OMAPDSS: HDMI: Remove omap_dss_device argument from hdmi_compute_pll
  OMAPDSS: DPI: Add locking for DPI interface
  OMAPDSS: Displays: Add locking in generic DPI panel driver


 drivers/video/omap2/displays/panel-generic-dpi.c |   69 +++++++++++++++++++---
 drivers/video/omap2/dss/apply.c                  |    4 +-
 drivers/video/omap2/dss/dpi.c                    |   40 +++++++++----
 drivers/video/omap2/dss/dss.h                    |    2 +-
 drivers/video/omap2/dss/hdmi.c                   |    5 +-
 5 files changed, 97 insertions(+), 23 deletions(-)

-- 
1.7.9.5

