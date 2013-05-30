From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:26 +0000
Subject: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Message-Id: <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When using DT, dss device does not have platform data. However,
dss_get_ctx_loss_count() uses dss device's platform data to find the
get_ctx_loss_count function pointer.

To fix this, dss_get_ctx_loss_count() needs to be changed to get the
platform data from the omapdss device, which is a "virtual" device and
always has platform data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 94f66f9..bd01608 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -157,7 +157,8 @@ static void dss_restore_context(void)
 
 int dss_get_ctx_loss_count(void)
 {
-	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
+	struct platform_device *core_pdev = dss_get_core_pdev();
+	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
 	int cnt;
 
 	if (!board_data->get_context_loss_count)
-- 
1.8.1.2

