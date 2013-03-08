From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:51 +0000
Subject: [PATCH 16/20] OMAPDSS: omapdss.h: remove channel field from omap_dss_device (LATER)
Message-Id: <1362743515-10152-17-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8647646..cd028c8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -567,8 +567,6 @@ struct omap_dss_device {
 
 	enum omap_display_type type;
 
-	enum omap_channel channel;
-
 	union {
 		struct {
 			u8 data_lines;
-- 
1.7.10.4

