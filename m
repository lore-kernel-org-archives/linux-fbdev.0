From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Dec 2013 14:56:11 +0000
Subject: [PATCHv2 04/27] OMAPDSS: add 'label' support for DT
Message-Id: <1387205794-32246-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support to get the label (i.e. a "nickname") for a display from the
DT data. If there is no label defined, use the display's alias (e.g.
'display0') as a name.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 669a81fdf58e..012ada38a29d 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -137,6 +138,14 @@ int omapdss_register_display(struct omap_dss_device *dssdev)
 	snprintf(dssdev->alias, sizeof(dssdev->alias),
 			"display%d", disp_num_counter++);
 
+	/* Use 'label' property for name, if it exists */
+	if (dssdev->dev->of_node)
+		of_property_read_string(dssdev->dev->of_node, "label",
+			&dssdev->name);
+
+	if (dssdev->name = NULL)
+		dssdev->name = dssdev->alias;
+
 	if (drv && drv->get_resolution = NULL)
 		drv->get_resolution = omapdss_default_get_resolution;
 	if (drv && drv->get_recommended_bpp = NULL)
-- 
1.8.3.2

