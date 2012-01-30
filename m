From: Archit Taneja <archit@ti.com>
Date: Mon, 30 Jan 2012 05:36:17 +0000
Subject: [PATCH 2/2] OMAPDSS: DISPC: Fix scaling constraints for OMAP4
Message-Id: <1327901057-29287-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, cmahapatra@ti.com, Archit Taneja <archit@ti.com>

The calculation of required DISPC_FCLK for downscaling is done by multplying the
pixel clock with an integer factor. This isn't true for OMAP4 where the required
clock is calculated using the exact ratio of downscaling done.

Fix this calculation for OMAP4. Also, do a minor clean up of calc_fclk().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3deb982..14b1f54 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1694,6 +1694,7 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
+	unsigned long pclk = dispc_mgr_pclk_rate(channel);
 
 	/*
 	 * FIXME how to determine the 'A' factor
@@ -1716,13 +1717,16 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 
 	if (cpu_is_omap24xx()) {
 		if (vf > 1 && hf > 1)
-			return dispc_mgr_pclk_rate(channel) * 4;
+			return pclk * 4;
 		else
-			return dispc_mgr_pclk_rate(channel) * 2;
+			return pclk * 2;
 	} else if (cpu_is_omap34xx()) {
-		return dispc_mgr_pclk_rate(channel) * vf * hf;
+		return pclk * vf * hf;
 	} else {
-		return dispc_mgr_pclk_rate(channel) * hf;
+		if (hf > 1)
+			return DIV_ROUND_UP(pclk, out_width) * width;
+		else
+			return pclk;
 	}
 }
 
-- 
1.7.4.1

