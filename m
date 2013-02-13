From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:12 +0000
Subject: [PATCH 09/11] OMAPDSS: remove unnecessary DSI external TE pin platform info from omap_dss_device
Message-Id: <1360764434-18788-10-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device provides platform related parameters ext_te and ext_te_gpio
for DSI command mode panels. These parameters are now owned by a panel driver's
platform_data instead.

Remove these fields as they aren't used anymore.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d5dcd50..ec68769 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -579,9 +579,6 @@ struct omap_dss_device {
 
 		struct {
 			int module;
-
-			bool ext_te;
-			u8 ext_te_gpio;
 		} dsi;
 
 		struct {
-- 
1.7.9.5

