From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:16 +0000
Subject: [PATCH 08/32] OMAPDSS: DISPC: use WARN_ON() in dispc_mgr_go
Message-Id: <1352995120-3288-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_go() should never be called with manager output disabled or if
the GO bit is already set. Change the current silent returns to
WARN_ONs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 662bf56..e219eda 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -565,20 +565,8 @@ bool dispc_mgr_go_busy(enum omap_channel channel)
 
 void dispc_mgr_go(enum omap_channel channel)
 {
-	bool enable_bit, go_bit;
-
-	/* if the channel is not enabled, we don't need GO */
-	enable_bit = mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE) = 1;
-
-	if (!enable_bit)
-		return;
-
-	go_bit = mgr_fld_read(channel, DISPC_MGR_FLD_GO) = 1;
-
-	if (go_bit) {
-		DSSERR("GO bit not down for channel %d\n", channel);
-		return;
-	}
+	WARN_ON(dispc_mgr_is_enabled(channel) = false);
+	WARN_ON(dispc_mgr_go_busy(channel));
 
 	DSSDBG("GO %s\n", mgr_desc[channel].name);
 
-- 
1.7.10.4

