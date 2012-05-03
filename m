From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 May 2012 13:57:41 +0000
Subject: [PATCH 05/25] OMAPDSS: TFP410: pdata rewrite
Message-Id: <1336053481-25433-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

To ease device tree adaptation in the future, rewrite TFP410 platform
data handling to be done inside probe(), so that probe() is the only
place where we need to handle the DT/pdata choice.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |   72 ++++++++++++++-------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 52637fa..f03964e 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -47,13 +47,9 @@ struct panel_drv_data {
 	struct mutex lock;
 
 	int pd_gpio;
-};
 
-static inline struct tfp410_platform_data
-*get_pdata(const struct omap_dss_device *dssdev)
-{
-	return dssdev->data;
-}
+	struct i2c_adapter *i2c_adapter;
+};
 
 static int tfp410_power_on(struct omap_dss_device *dssdev)
 {
@@ -90,11 +86,11 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
 
 static int tfp410_probe(struct omap_dss_device *dssdev)
 {
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
 	struct panel_drv_data *ddata;
 	int r;
+	int i2c_bus_num;
 
-	ddata = kzalloc(sizeof(*ddata), GFP_KERNEL);
+	ddata = devm_kzalloc(&dssdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
@@ -104,10 +100,15 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 	ddata->dssdev = dssdev;
 	mutex_init(&ddata->lock);
 
-	if (pdata)
+	if (dssdev->data) {
+		struct tfp410_platform_data *pdata = dssdev->data;
+
 		ddata->pd_gpio = pdata->power_down_gpio;
-	else
+		i2c_bus_num = pdata->i2c_bus_num;
+	} else {
 		ddata->pd_gpio = -1;
+		i2c_bus_num = -1;
+	}
 
 	if (gpio_is_valid(ddata->pd_gpio)) {
 		r = gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
@@ -115,13 +116,31 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		if (r) {
 			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
 					ddata->pd_gpio);
-			ddata->pd_gpio = -1;
+			return r;
 		}
 	}
 
+	if (i2c_bus_num != -1) {
+		struct i2c_adapter *adapter;
+
+		adapter = i2c_get_adapter(i2c_bus_num);
+		if (!adapter) {
+			dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
+					i2c_bus_num);
+			r = -EINVAL;
+			goto err_i2c;
+		}
+
+		ddata->i2c_adapter = adapter;
+	}
+
 	dev_set_drvdata(&dssdev->dev, ddata);
 
 	return 0;
+err_i2c:
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_free(ddata->pd_gpio);
+	return r;
 }
 
 static void __exit tfp410_remove(struct omap_dss_device *dssdev)
@@ -130,14 +149,15 @@ static void __exit tfp410_remove(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
+	if (ddata->i2c_adapter)
+		i2c_put_adapter(ddata->i2c_adapter);
+
 	if (gpio_is_valid(ddata->pd_gpio))
 		gpio_free(ddata->pd_gpio);
 
 	dev_set_drvdata(&dssdev->dev, NULL);
 
 	mutex_unlock(&ddata->lock);
-
-	kfree(ddata);
 }
 
 static int tfp410_enable(struct omap_dss_device *dssdev)
@@ -269,27 +289,17 @@ static int tfp410_read_edid(struct omap_dss_device *dssdev,
 		u8 *edid, int len)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
-	struct i2c_adapter *adapter;
 	int r, l, bytes_read;
 
 	mutex_lock(&ddata->lock);
 
-	if (pdata->i2c_bus_num = 0) {
+	if (!ddata->i2c_adapter) {
 		r = -ENODEV;
 		goto err;
 	}
 
-	adapter = i2c_get_adapter(pdata->i2c_bus_num);
-	if (!adapter) {
-		dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
-				pdata->i2c_bus_num);
-		r = -EINVAL;
-		goto err;
-	}
-
 	l = min(EDID_LENGTH, len);
-	r = tfp410_ddc_read(adapter, edid, l, 0);
+	r = tfp410_ddc_read(ddata->i2c_adapter, edid, l, 0);
 	if (r)
 		goto err;
 
@@ -299,7 +309,7 @@ static int tfp410_read_edid(struct omap_dss_device *dssdev,
 	if (len > EDID_LENGTH && edid[0x7e] > 0) {
 		l = min(EDID_LENGTH, len - EDID_LENGTH);
 
-		r = tfp410_ddc_read(adapter, edid + EDID_LENGTH,
+		r = tfp410_ddc_read(ddata->i2c_adapter, edid + EDID_LENGTH,
 				l, EDID_LENGTH);
 		if (r)
 			goto err;
@@ -319,21 +329,15 @@ err:
 static bool tfp410_detect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
-	struct i2c_adapter *adapter;
 	unsigned char out;
 	int r;
 
 	mutex_lock(&ddata->lock);
 
-	if (pdata->i2c_bus_num = 0)
-		goto out;
-
-	adapter = i2c_get_adapter(pdata->i2c_bus_num);
-	if (!adapter)
+	if (!ddata->i2c_adapter)
 		goto out;
 
-	r = tfp410_ddc_read(adapter, &out, 1, 0);
+	r = tfp410_ddc_read(ddata->i2c_adapter, &out, 1, 0);
 
 	mutex_unlock(&ddata->lock);
 
-- 
1.7.9.5

