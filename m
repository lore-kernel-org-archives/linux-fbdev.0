From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:38 +0000
Subject: [PATCH 10/23] OMAPDSS: add OMAP_DSS_CHANNEL_WB to 'enum omap_channel'
Message-Id: <1449676791-26304-11-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'enum omap_channel' is missing the channel for writeback. Add that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f001a356fd98..0fedd93a639d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -87,6 +87,7 @@ enum omap_channel {
 	OMAP_DSS_CHANNEL_DIGIT	= 1,
 	OMAP_DSS_CHANNEL_LCD2	= 2,
 	OMAP_DSS_CHANNEL_LCD3	= 3,
+	OMAP_DSS_CHANNEL_WB	= 4,
 };
 
 enum omap_color_mode {
-- 
2.5.0

