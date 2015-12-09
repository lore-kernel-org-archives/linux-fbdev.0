From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:46 +0000
Subject: [PATCH 18/23] OMAPDSS: set WB capturemode for m2m mode
Message-Id: <1449676791-26304-19-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In mem-to-mem mode WB CAPTUREMODE needs to be set to 1 (capture one
frame).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index c50bb0124d87..6018518c1b25 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2857,6 +2857,8 @@ int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 	l = FLD_MOD(l, truncation, 10, 10);	/* TRUNCATIONENABLE */
 	l = FLD_MOD(l, mem_to_mem, 19, 19);	/* WRITEBACKMODE */
+	if (mem_to_mem)
+		l = FLD_MOD(l, 1, 26, 24);	/* CAPTUREMODE */
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), l);
 
 	return r;
-- 
2.5.0

