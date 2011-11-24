From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Nov 2011 13:29:29 +0000
Subject: [PATCH 01/13] OMAPDSS: DSI: flush posted write when entering ULPS
Message-Id: <1322141381-5395-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Flush posted write between writing the ULPS enable bits and waiting for
the interrupt.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5abf8e7..1331f92 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3561,6 +3561,9 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2),
 		7, 5);
 
+	/* flush posted write and wait for SCP interface to finish the write */
+	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
+
 	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(1000)) = 0) {
 		DSSERR("ULPS enable timeout\n");
@@ -3575,6 +3578,9 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0 << 0) | (0 << 1) | (0 << 2),
 		7, 5);
 
+	/* flush posted write and wait for SCP interface to finish the write */
+	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ULPS);
 
 	dsi_if_enable(dsidev, false);
-- 
1.7.4.1

