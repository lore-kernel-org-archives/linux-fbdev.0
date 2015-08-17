From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 17 Aug 2015 07:59:17 +0000
Subject: [PATCH] backlight: sky81452: Remove unneeded use of IS_ERR_VALUE() macro
Message-Id: <1439798357.21881.1.camel@ingics.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

IS_ERR_VALUE() makes sense only *if* there could be valid values in
negative error range.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/video/backlight/sky81452-backlight.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 052fa1b..d414c7a 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -65,7 +65,7 @@ static int sky81452_bl_update_status(struct backlight_device *bd)
 
 	if (brightness > 0) {
 		ret = regmap_write(regmap, SKY81452_REG0, brightness - 1);
-		if (IS_ERR_VALUE(ret))
+		if (ret < 0)
 			return ret;
 
 		return regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
@@ -87,12 +87,12 @@ static ssize_t sky81452_bl_store_enable(struct device *dev,
 	int ret;
 
 	ret = kstrtoul(buf, 16, &value);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	ret = regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
 					value << CTZ(SKY81452_EN));
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	return count;
@@ -108,7 +108,7 @@ static ssize_t sky81452_bl_show_open_short(struct device *dev,
 
 	reg = !strcmp(attr->attr.name, "open") ? SKY81452_REG5 : SKY81452_REG4;
 	ret = regmap_read(regmap, reg, &value);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	if (value & SKY81452_SHRT) {
@@ -136,7 +136,7 @@ static ssize_t sky81452_bl_show_fault(struct device *dev,
 	int ret;
 
 	ret = regmap_read(regmap, SKY81452_REG4, &value);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	*buf = 0;
@@ -196,7 +196,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	pdata->gpio_enable = of_get_gpio(np, 0);
 
 	ret = of_property_count_u32_elems(np, "led-sources");
-	if (IS_ERR_VALUE(ret)) {
+	if (ret < 0) {
 		pdata->enable = SKY81452_EN >> CTZ(SKY81452_EN);
 	} else {
 		num_entry = ret;
@@ -205,7 +205,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 
 		ret = of_property_read_u32_array(np, "led-sources", sources,
 					num_entry);
-		if (IS_ERR_VALUE(ret)) {
+		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
 			return ERR_PTR(-EINVAL);
 		}
@@ -218,12 +218,12 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	ret = of_property_read_u32(np,
 			"skyworks,short-detection-threshold-volt",
 			&pdata->short_detection_threshold);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		pdata->short_detection_threshold = 7;
 
 	ret = of_property_read_u32(np, "skyworks,current-limit-mA",
 			&pdata->boost_current_limit);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		pdata->boost_current_limit = 2750;
 
 	of_node_put(np);
@@ -278,14 +278,14 @@ static int sky81452_bl_probe(struct platform_device *pdev)
 	if (gpio_is_valid(pdata->gpio_enable)) {
 		ret = devm_gpio_request_one(dev, pdata->gpio_enable,
 					GPIOF_OUT_INIT_HIGH, "sky81452-en");
-		if (IS_ERR_VALUE(ret)) {
+		if (ret < 0) {
 			dev_err(dev, "failed to request GPIO. err=%d\n", ret);
 			return ret;
 		}
 	}
 
 	ret = sky81452_bl_init_device(regmap, pdata);
-	if (IS_ERR_VALUE(ret)) {
+	if (ret < 0) {
 		dev_err(dev, "failed to initialize. err=%d\n", ret);
 		return ret;
 	}
@@ -302,8 +302,8 @@ static int sky81452_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bd);
 
-	ret  = sysfs_create_group(&bd->dev.kobj, &sky81452_bl_attr_group);
-	if (IS_ERR_VALUE(ret)) {
+	ret = sysfs_create_group(&bd->dev.kobj, &sky81452_bl_attr_group);
+	if (ret < 0) {
 		dev_err(dev, "failed to create attribute. err=%d\n", ret);
 		return ret;
 	}
-- 
2.1.0



