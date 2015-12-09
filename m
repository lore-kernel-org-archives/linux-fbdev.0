From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:34 +0000
Subject: [PATCH 06/23] OMAPDSS: fix DISPC_MFLAG_THRESHOLD_OFFSET for WB
Message-Id: <1449676791-26304-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

DISPC_MFLAG_THRESHOLD_OFFSET() is missing the offset for WB. Add the
offset.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.h b/drivers/video/fbdev/omap2/dss/dispc.h
index 3043d6e0a5f9..483744223dd1 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.h
+++ b/drivers/video/fbdev/omap2/dss/dispc.h
@@ -908,6 +908,8 @@ static inline u16 DISPC_MFLAG_THRESHOLD_OFFSET(enum omap_plane plane)
 		return 0x0868;
 	case OMAP_DSS_VIDEO3:
 		return 0x086c;
+	case OMAP_DSS_WB:
+		return 0x0870;
 	default:
 		BUG();
 		return 0;
-- 
2.5.0

