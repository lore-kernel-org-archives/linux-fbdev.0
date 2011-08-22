From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:26:35 +0000
Subject: [PATCH 0/4] OMAPDSS: DSI related improvements
Message-Id: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

These patches add support for the second DSI module on OMAP4 by fixing the DSI device naming and adding necessary powers. Also DSI pad muxing is improved to support OMAP4.

 Tomi

Tomi Valkeinen (4):
  OMAP: DSS2: Change DSI device naming
  OMAP4: TWL: Add common omapdss supplies
  OMAP: DSS2: DSI: Improve dsi_mux_pads parameters
  OMAP: DSS2: Implement dsi_mux_pads for OMAP4

 arch/arm/mach-omap2/board-devkit8000.c   |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/display.c            |   60 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/twl-common.c         |   11 ++++-
 drivers/video/omap2/dss/dsi.c            |   67 ++++++++++++++++++-----------
 include/video/omapdss.h                  |    3 +-
 6 files changed, 112 insertions(+), 33 deletions(-)

-- 
1.7.4.1

