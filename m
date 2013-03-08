From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:52:35 +0000
Subject: [PATCH 00/14] OMAPDSS: new clock calculation + DSI VM
Message-Id: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here's a series for improving omapdss clock calculation, and also automatically
calculating DSI videomode parameters, instead of requiring them to be
precalculated and passed to omapdss. These are based on the previous misc
patches series.

 Tomi

Tomi Valkeinen (14):
  OMAPDSS: DISPC: store core clk rate
  OMAPDSS: DSI: fix wrong unsigned long long use
  OMAPDSS: DSI: simplify dsi configuration
  OMAPDSS: DSI: get line buffer size at probe
  OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
  OMAPDSS: DSI remove unneeded clk source setup code
  OMAPDSS: DISPC: add new clock calculation code
  OMAPDSS: DSS: add new clock calculation code
  OMAPDSS: DSI: add new clock calculation code
  OMAPDSS: SDI: use new clock calculation code
  OMAPDSS: DPI: use new clock calculation code
  OMAPDSS: DSI: use new clock calculation code
  OMAPDSS: remove unused old clock calculation code
  OMAPDSS: remove dsi videomode from dssdev

 drivers/video/omap2/displays/panel-taal.c |   19 +-
 drivers/video/omap2/dss/dispc.c           |  124 ++--
 drivers/video/omap2/dss/dpi.c             |  212 +++++--
 drivers/video/omap2/dss/dsi.c             |  959 +++++++++++++++++------------
 drivers/video/omap2/dss/dss.c             |  151 ++---
 drivers/video/omap2/dss/dss.h             |   36 +-
 drivers/video/omap2/dss/sdi.c             |   68 +-
 include/video/omapdss.h                   |   51 +-
 8 files changed, 977 insertions(+), 643 deletions(-)

-- 
1.7.10.4

