From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 03 Jun 2016 11:03:21 +0000
Subject: [PATCH v3 19/27] omapdss: omap-panel-data.h: Remove connector_type from atv pdata
Message-Id: <20160603110329.9953-20-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

The driver only supports composite connection when booted in legacy mode
so the omap_dss_venc_type can be dropped from the pdata.
At the same time the video/omapdss.h include can be removed as it is no
longer needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/video/omap-panel-data.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 7b4fadf82cd5..e7003ee6e063 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -27,21 +27,18 @@
 #ifndef __OMAP_PANEL_DATA_H
 #define __OMAP_PANEL_DATA_H
 
-#include <video/omapdss.h>
 #include <video/display_timing.h>
 
 /**
  * connector_atv platform data
  * @name: name for this display entity
  * @source: name of the display entity used as a video source
- * @connector_type: composite/svideo
  * @invert_polarity: invert signal polarity
  */
 struct connector_atv_platform_data {
 	const char *name;
 	const char *source;
 
-	enum omap_dss_venc_type connector_type;
 	bool invert_polarity;
 };
 
-- 
2.8.3

