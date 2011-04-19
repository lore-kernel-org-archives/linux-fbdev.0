From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Apr 2011 09:22:09 +0000
Subject: [PATCH 06/19] OMAP: DSS2: Add FEAT_DSI_REVERSE_TXCLKESC
Message-Id: <1303204942-25450-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP3430 has RESETDONETXCLKESCx bits in the order following bitnumber
order for lanes 0, 1, 2: 28, 27, 26. OMAP3630 and later have them in
saner order: 24, 25, 26 (and 27, 28 for OMAP4).

This patch adds a dss_feature that can be used to differentiate between
those two orders of RESETDONETXCLKESCx bits.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 5f3a7c4..502a953 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -253,7 +253,7 @@ static struct omap_dss_features omap3430_dss_features = {
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
-		FEAT_DSI_PLL_FREQSEL,
+		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 1093e8d..5668fec 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -45,6 +45,7 @@ enum dss_feat_id {
 	FEAT_DSI_PLL_FREQSEL		= 1 << 14,
 	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
 	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
+	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
 };
 
 /* DSS register field id */
-- 
1.7.1

