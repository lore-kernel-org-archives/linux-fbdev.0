From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Jun 2013 06:44:52 +0000
Subject: [PATCH] OMAPDSS: DPI: Fix wrong pixel clock limit
Message-Id: <1371019492-4582-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

DPI is supposed to skip odd dividers in the clock path when the pixel
clock is higher than 100MHz. The code, however, defines the pixel clock
limit as 1MHz. This causes the driver to skip valid clock dividers,
possibly making the pixel clock to be further away from the requested
one than necessary.

Fix the clock limit to 100MHz.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>
---

This is for 3.10.

 drivers/video/omap2/dss/dpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 757b57f..0bdcd41 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -129,7 +129,7 @@ static bool dpi_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
 	 * shifted. So skip all odd dividers when the pixel clock is on the
 	 * higher side.
 	 */
-	if (ctx->pck_min >= 1000000) {
+	if (ctx->pck_min >= 100000000) {
 		if (lckd > 1 && lckd % 2 != 0)
 			return false;
 
@@ -156,7 +156,7 @@ static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 	 * shifted. So skip all odd dividers when the pixel clock is on the
 	 * higher side.
 	 */
-	if (regm_dispc > 1 && regm_dispc % 2 != 0 && ctx->pck_min >= 1000000)
+	if (regm_dispc > 1 && regm_dispc % 2 != 0 && ctx->pck_min >= 100000000)
 		return false;
 
 	ctx->dsi_cinfo.regm_dispc = regm_dispc;
-- 
1.8.1.2

