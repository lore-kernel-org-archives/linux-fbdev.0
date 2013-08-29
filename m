From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Aug 2013 13:31:47 +0000
Subject: [PATCH 02/15] OMAPDSS: remove omap_dss_device->channel field
Message-Id: <1377783120-14001-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The 'channel' field in struct omap_dss_device is no longer used, and can
be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b394635..3b68dc2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -765,9 +765,6 @@ struct omap_dss_device {
 	enum omap_display_type type;
 	enum omap_display_type output_type;
 
-	/* obsolete, to be removed */
-	enum omap_channel channel;
-
 	union {
 		struct {
 			u8 data_lines;
-- 
1.8.1.2

