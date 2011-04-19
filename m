From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Apr 2011 09:22:16 +0000
Subject: [PATCH 13/19] OMAP: DSS2: DSI: ensure VDDS_DSI is disabled on exit
Message-Id: <1303204942-25450-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The panel drivers can leave the VDDS_DSI regulator enabled, even when
the panel is disabled, to ensure that the DSI pins are powered.

This patch ensures that VDDS_DSI is disabled on DSI module unload.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f1e14ca..9c5715a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4090,6 +4090,11 @@ err1:
 static void dsi_exit(void)
 {
 	if (dsi.vdds_dsi_reg != NULL) {
+		if (dsi.vdds_dsi_enabled) {
+			regulator_disable(dsi.vdds_dsi_reg);
+			dsi.vdds_dsi_enabled = false;
+		}
+
 		regulator_put(dsi.vdds_dsi_reg);
 		dsi.vdds_dsi_reg = NULL;
 	}
-- 
1.7.1

