From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:11 +0000
Subject: [PATCH 08/11] OMAPDSS: picodlp: use devm_kzalloc for allocating driver data
Message-Id: <1360764434-18788-9-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Use devm_kzalloc instead of kzalloc to allocate driver data for the picodlp
panel driver. This simplifies the driver's probe and remove functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-picodlp.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 1b94018..3864299 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -423,11 +423,11 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
 	struct i2c_adapter *adapter;
 	struct i2c_client *picodlp_i2c_client;
-	int r = 0, picodlp_adapter_id;
+	int picodlp_adapter_id;
 
 	dssdev->panel.timings = pico_ls_timings;
 
-	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
+	picod = devm_kzalloc(&dssdev->dev, sizeof(*picod), GFP_KERNEL);
 	if (!picod)
 		return -ENOMEM;
 
@@ -438,25 +438,21 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 	adapter = i2c_get_adapter(picodlp_adapter_id);
 	if (!adapter) {
 		dev_err(&dssdev->dev, "can't get i2c adapter\n");
-		r = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	picodlp_i2c_client = i2c_new_device(adapter, &picodlp_i2c_board_info);
 	if (!picodlp_i2c_client) {
 		dev_err(&dssdev->dev, "can't add i2c device::"
 					 " picodlp_i2c_client is NULL\n");
-		r = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	picod->picodlp_i2c_client = picodlp_i2c_client;
 
 	dev_set_drvdata(&dssdev->dev, picod);
-	return r;
-err:
-	kfree(picod);
-	return r;
+
+	return 0;
 }
 
 static void picodlp_panel_remove(struct omap_dss_device *dssdev)
-- 
1.7.9.5

