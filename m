From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:40 +0000
Subject: [PATCH 12/23] OMAPDSS: handle WB channel in dispc_set/get_channel_out
Message-Id: <1449676791-26304-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add handling of OMAP_DSS_CHANNEL_WB to dispc_ovl_set_channel_out() and
dispc_ovl_get_channel_out().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 678a1928a9b5..4126d6225faf 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -974,6 +974,10 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 				return;
 			}
 			break;
+		case OMAP_DSS_CHANNEL_WB:
+			chan = 0;
+			chan2 = 3;
+			break;
 		default:
 			BUG();
 			return;
@@ -1023,6 +1027,8 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 		return OMAP_DSS_CHANNEL_LCD2;
 	case 2:
 		return OMAP_DSS_CHANNEL_LCD3;
+	case 3:
+		return OMAP_DSS_CHANNEL_WB;
 	}
 }
 
-- 
2.5.0

