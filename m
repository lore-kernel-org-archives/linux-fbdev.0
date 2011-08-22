From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:26:08 +0000
Subject: [PATCH 0/3] OMAPDSS: Cleanup after HWMOD fixes
Message-Id: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

After the patch-set "[PATCHv2 0/5] OMAP DSS HWMOD fixes" we can revert the DSS
hacks added to circumvent broken HWMOD data, and clean up unneeded clock
handling.

Tomi

Tomi Valkeinen (3):
  Revert "HACK: OMAP: DSS2: clk hack for OMAP2/3"
  Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
  OMAP: DSS2: remove unneeded fck enable/disables

 drivers/video/omap2/dss/dispc.c |    2 --
 drivers/video/omap2/dss/dsi.c   |   12 +-----------
 drivers/video/omap2/dss/dss.c   |    7 -------
 drivers/video/omap2/dss/dss.h   |    2 --
 drivers/video/omap2/dss/hdmi.c  |   14 --------------
 drivers/video/omap2/dss/rfbi.c  |    5 +----
 drivers/video/omap2/dss/venc.c  |   19 +------------------
 7 files changed, 3 insertions(+), 58 deletions(-)

-- 
1.7.4.1

