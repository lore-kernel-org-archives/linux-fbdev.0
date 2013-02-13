From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:09 +0000
Subject: [PATCH 06/11] OMAPDSS: Generic DPI Panel: use devm_kzalloc for allocating driver data
Message-Id: <1360764434-18788-7-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Use devm_kzalloc instead of kzalloc to allocate driver data for the generic dpi
panel driver. This simplifies the driver's probe and remove functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 54ca8ae..6cb2fe0 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -632,7 +632,7 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.timings = panel_config->timings;
 
-	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
+	drv_data = devm_kzalloc(&dssdev->dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
@@ -648,12 +648,8 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 
 static void __exit generic_dpi_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-
 	dev_dbg(&dssdev->dev, "remove\n");
 
-	kfree(drv_data);
-
 	dev_set_drvdata(&dssdev->dev, NULL);
 }
 
-- 
1.7.9.5

