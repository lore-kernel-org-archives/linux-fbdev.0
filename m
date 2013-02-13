From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:10 +0000
Subject: [PATCH 07/11] OMAPDSS: lb035q02: use devm_kzalloc for allocating driver data
Message-Id: <1360764434-18788-8-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Steve Sakoman <steve@sakoman.com>

Use devm_kzalloc instead of kzalloc to allocate driver data for the lg phillips
panel driver. This simplifies the driver's probe and remove functions.

Cc: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 6e5abe8..8effea8 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -89,27 +89,21 @@ static void lb035q02_panel_power_off(struct omap_dss_device *dssdev)
 static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct lb035q02_data *ld;
-	int r;
 
 	dssdev->panel.timings = lb035q02_timings;
 
-	ld = kzalloc(sizeof(*ld), GFP_KERNEL);
-	if (!ld) {
-		r = -ENOMEM;
-		goto err;
-	}
+	ld = devm_kzalloc(&dssdev->dev, sizeof(*ld), GFP_KERNEL);
+	if (!ld)
+		return -ENOMEM;
+
 	mutex_init(&ld->lock);
 	dev_set_drvdata(&dssdev->dev, ld);
+
 	return 0;
-err:
-	return r;
 }
 
 static void lb035q02_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct lb035q02_data *ld = dev_get_drvdata(&dssdev->dev);
-
-	kfree(ld);
 }
 
 static int lb035q02_panel_enable(struct omap_dss_device *dssdev)
-- 
1.7.9.5

