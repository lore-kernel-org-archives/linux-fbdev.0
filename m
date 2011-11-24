From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Nov 2011 13:29:41 +0000
Subject: [PATCH 13/13] OMAPDSS: DSI: disable DDR_CLK_ALWAYS_ON when entering ULPS
Message-Id: <1322141381-5395-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

ULPS cannot be entered if the DDR clk is enabled. Thus disable the DDR
clk before entering ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a01a011..9bcb5c2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3544,9 +3544,11 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	if (dsi->ulps_enabled)
 		return 0;
 
+	/* DDR_CLK_ALWAYS_ON */
 	if (REG_GET(dsidev, DSI_CLK_CTRL, 13, 13)) {
-		DSSERR("DDR_CLK_ALWAYS_ON enabled when entering ULPS\n");
-		return -EIO;
+		dsi_if_enable(dsidev, 0);
+		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 13, 13);
+		dsi_if_enable(dsidev, 1);
 	}
 
 	dsi_sync_vc(dsidev, 0);
-- 
1.7.4.1

