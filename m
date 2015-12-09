From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:47 +0000
Subject: [PATCH 19/23] OMAPDSS: add setup for WB capture mode in dispc_wb_setup()
Message-Id: <1449676791-26304-20-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

dispc_wb_setup() handles configuration only for mem-to-mem case. This
patch adds the necessary configuration to handle also display capture
mode.

We need to set CAPTUREMODE to 0 (continuous capture), and WBDELAYCOUNT
according to the vertical timings of the display, so that the WB FIFO
has time to flush before the next frame starts.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 6018518c1b25..c3ba555737b8 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2859,8 +2859,23 @@ int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 	l = FLD_MOD(l, mem_to_mem, 19, 19);	/* WRITEBACKMODE */
 	if (mem_to_mem)
 		l = FLD_MOD(l, 1, 26, 24);	/* CAPTUREMODE */
+	else
+		l = FLD_MOD(l, 0, 26, 24);	/* CAPTUREMODE */
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), l);
 
+	if (mem_to_mem) {
+		/* WBDELAYCOUNT */
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 7, 0);
+	} else {
+		int wbdelay;
+
+		wbdelay = min(mgr_timings->vfp + mgr_timings->vsw +
+			mgr_timings->vbp, 255);
+
+		/* WBDELAYCOUNT */
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), wbdelay, 7, 0);
+	}
+
 	return r;
 }
 
-- 
2.5.0

