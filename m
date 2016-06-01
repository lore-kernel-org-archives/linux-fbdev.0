From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 01 Jun 2016 08:35:32 +0000
Subject: [PATCH v2 10/27] omapfb: encoder-tpd12s015: No need to include video/omap-panle-data.h
Message-Id: <20160601083549.10549-11-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

The driver does not support legacy (pdata) based probing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 677e2545fcbe..7939157af957 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -17,7 +17,6 @@
 #include <linux/gpio/consumer.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
-- 
2.8.3

