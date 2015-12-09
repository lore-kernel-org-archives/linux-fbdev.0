From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:39 +0000
Subject: [PATCH 11/23] OMAPDSS: refactor dispc_ovl_get_channel_out
Message-Id: <1449676791-26304-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Refactor dispc_ovl_get_channel_out() to a bit cleaner form, which makes
it easier to add support for writeback in the following patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index aa74b3da3718..678a1928a9b5 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -992,7 +992,6 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 {
 	int shift;
 	u32 val;
-	enum omap_channel channel;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -1010,23 +1009,21 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 
 	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 
-	if (dss_has_feature(FEAT_MGR_LCD3)) {
-		if (FLD_GET(val, 31, 30) = 0)
-			channel = FLD_GET(val, shift, shift);
-		else if (FLD_GET(val, 31, 30) = 1)
-			channel = OMAP_DSS_CHANNEL_LCD2;
-		else
-			channel = OMAP_DSS_CHANNEL_LCD3;
-	} else if (dss_has_feature(FEAT_MGR_LCD2)) {
-		if (FLD_GET(val, 31, 30) = 0)
-			channel = FLD_GET(val, shift, shift);
-		else
-			channel = OMAP_DSS_CHANNEL_LCD2;
-	} else {
-		channel = FLD_GET(val, shift, shift);
-	}
+	if (FLD_GET(val, shift, shift) = 1)
+		return OMAP_DSS_CHANNEL_DIGIT;
+
+	if (!dss_has_feature(FEAT_MGR_LCD2))
+		return OMAP_DSS_CHANNEL_LCD;
 
-	return channel;
+	switch (FLD_GET(val, 31, 30)) {
+	case 0:
+	default:
+		return OMAP_DSS_CHANNEL_LCD;
+	case 1:
+		return OMAP_DSS_CHANNEL_LCD2;
+	case 2:
+		return OMAP_DSS_CHANNEL_LCD3;
+	}
 }
 
 void dispc_wb_set_channel_in(enum dss_writeback_channel channel)
-- 
2.5.0

