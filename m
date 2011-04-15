From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 15 Apr 2011 08:11:06 +0000
Subject: [PATCH 0/5] OMAP: DSS: fixes for rc
Message-Id: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some small fixes to OMAP DSS for the next rc.

I will send a pull request to Paul Mundt soon if there are no problems with the
patches.

Note that DSS doesn't still work for OMAP4. It needs a clock patch which has
been discussed on l-o, and Paul Walmsley will handle that patch.

 Tomi

Archit Taneja (1):
  OMAP: DSS2: Fix: Return correct lcd clock source for OMAP2/3

Tomi Valkeinen (4):
  OMAP: DSS2: DSI: fix use_sys_clk & highfreq
  OMAP: DSS2: DSI: fix dsi_dump_clocks()
  OMAP: DSS2: DSI: Fix DSI PLL power bug
  OMAP: DSS2: fix panel Kconfig dependencies

 drivers/video/omap2/displays/Kconfig   |    9 +++++----
 drivers/video/omap2/dss/dsi.c          |   14 +++++++++-----
 drivers/video/omap2/dss/dss.c          |   10 ++++++++--
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 ++
 5 files changed, 25 insertions(+), 12 deletions(-)

