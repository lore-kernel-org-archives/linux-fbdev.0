From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Sep 2012 08:25:46 +0000
Subject: [PATCH 08/17] OMAPDSS: TFP410: use devm_gpio_request_one
Message-Id: <1346833555-31258-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use devm_ version instead of the regular gpio_request_one to simplify
the error handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 4be9a59..383811c 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -119,8 +119,8 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 	}
 
 	if (gpio_is_valid(ddata->pd_gpio)) {
-		r = gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
-				"tfp410 pd");
+		r = devm_gpio_request_one(&dssdev->dev, ddata->pd_gpio,
+				GPIOF_OUT_INIT_LOW, "tfp410 pd");
 		if (r) {
 			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
 					ddata->pd_gpio);
@@ -135,8 +135,7 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		if (!adapter) {
 			dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
 					i2c_bus_num);
-			r = -EINVAL;
-			goto err_i2c;
+			return -EINVAL;
 		}
 
 		ddata->i2c_adapter = adapter;
@@ -145,10 +144,6 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 	dev_set_drvdata(&dssdev->dev, ddata);
 
 	return 0;
-err_i2c:
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_free(ddata->pd_gpio);
-	return r;
 }
 
 static void __exit tfp410_remove(struct omap_dss_device *dssdev)
@@ -160,9 +155,6 @@ static void __exit tfp410_remove(struct omap_dss_device *dssdev)
 	if (ddata->i2c_adapter)
 		i2c_put_adapter(ddata->i2c_adapter);
 
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_free(ddata->pd_gpio);
-
 	dev_set_drvdata(&dssdev->dev, NULL);
 
 	mutex_unlock(&ddata->lock);
-- 
1.7.9.5

