From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:44 +0000
Subject: [PATCH 16/23] OMAPDSS: skip pclk check for WB mem2mem
Message-Id: <1449676791-26304-17-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

When doing mem-to-mem writeback, there's no pixelclock. However, the
code that calculates scaling factors check that there is a pixel clock.
We can just skip the check when doing mem-to-mem writeback.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 3cd78dcfefc5..837b1f508d79 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2477,7 +2477,7 @@ static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 	if (width = out_width && height = out_height)
 		return 0;
 
-	if (pclk = 0 || mgr_timings->pixelclock = 0) {
+	if (!mem_to_mem && (pclk = 0 || mgr_timings->pixelclock = 0)) {
 		DSSERR("cannot calculate scaling settings: pclk is zero\n");
 		return -EINVAL;
 	}
-- 
2.5.0

