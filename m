From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Sep 2011 09:12:45 +0000
Subject: [PATCHv2 0/8] OMAP: DSS2: misc improvements
Message-Id: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some small DSS improvements, mostly HDMI related.

 Tomi

Changes in v2:
* Rebased on top of latest DSS changes
* Improved descriptions a bit


Tomi Valkeinen (8):
  OMAP: DSS2: DISPC: Fix minimum PCD value
  OMAP: DSS2: HDMI: use default dividers
  OMAP: DSS2: HDMI: change regn definition
  OMAP: DSS2: DSI: Add comment about regn
  OMAP: DSS2: DISPC: Add missing IRQ  definitions
  OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
  OMAP: DSS2: DISPC: improve dispc_mgr_enable_digit_out()
  OMAP: DSS2: HDMI: improve hdmi output enable

 arch/arm/mach-omap2/board-4430sdp.c       |    9 ----
 drivers/video/omap2/dss/dispc.c           |   63 ++++++++++++++++++-----------
 drivers/video/omap2/dss/dss.c             |   11 +++++
 drivers/video/omap2/dss/dss.h             |    1 +
 drivers/video/omap2/dss/dss_features.c    |    3 +
 drivers/video/omap2/dss/dss_features.h    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   23 ++++++++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    2 +-
 include/video/omapdss.h                   |    5 ++
 9 files changed, 78 insertions(+), 40 deletions(-)

-- 
1.7.4.1

