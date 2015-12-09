From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:35 +0000
Subject: [PATCH 07/23] OMAPDSS: add WB to register dump
Message-Id: <1449676791-26304-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add dumping of the writeback registers to the register dump function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index ced6050666cc..0cccff2ffd4e 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3455,6 +3455,7 @@ static void dispc_dump_regs(struct seq_file *s)
 		[OMAP_DSS_VIDEO1]	= "VID1",
 		[OMAP_DSS_VIDEO2]	= "VID2",
 		[OMAP_DSS_VIDEO3]	= "VID3",
+		[OMAP_DSS_WB]		= "WB",
 	};
 	const char **p_names;
 
@@ -3561,6 +3562,35 @@ static void dispc_dump_regs(struct seq_file *s)
 			DUMPREG(i, DISPC_OVL_ATTRIBUTES2);
 	}
 
+	if (dss_feat_get_num_wbs()) {
+		i = OMAP_DSS_WB;
+		DUMPREG(i, DISPC_OVL_BA0);
+		DUMPREG(i, DISPC_OVL_BA1);
+		DUMPREG(i, DISPC_OVL_SIZE);
+		DUMPREG(i, DISPC_OVL_ATTRIBUTES);
+		DUMPREG(i, DISPC_OVL_FIFO_THRESHOLD);
+		DUMPREG(i, DISPC_OVL_FIFO_SIZE_STATUS);
+		DUMPREG(i, DISPC_OVL_ROW_INC);
+		DUMPREG(i, DISPC_OVL_PIXEL_INC);
+
+		if (dss_has_feature(FEAT_MFLAG))
+			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
+
+		DUMPREG(i, DISPC_OVL_FIR);
+		DUMPREG(i, DISPC_OVL_PICTURE_SIZE);
+		DUMPREG(i, DISPC_OVL_ACCU0);
+		DUMPREG(i, DISPC_OVL_ACCU1);
+		if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+			DUMPREG(i, DISPC_OVL_BA0_UV);
+			DUMPREG(i, DISPC_OVL_BA1_UV);
+			DUMPREG(i, DISPC_OVL_FIR2);
+			DUMPREG(i, DISPC_OVL_ACCU2_0);
+			DUMPREG(i, DISPC_OVL_ACCU2_1);
+		}
+		if (dss_has_feature(FEAT_ATTR2))
+			DUMPREG(i, DISPC_OVL_ATTRIBUTES2);
+	}
+
 #undef DISPC_REG
 #undef DUMPREG
 
-- 
2.5.0

