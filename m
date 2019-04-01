From: Brian Masney <masneyb@onstation.org>
Date: Mon, 01 Apr 2019 10:30:34 +0000
Subject: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-Id: <20190401103034.21062-4-masneyb@onstation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

Add device tree support to the lm3630a driver and allow configuring
independently on both banks the mapping mode (linear or exponential),
initial and maximum LED brightness.

Driver was tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/video/backlight/lm3630a_bl.c | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index ef2553f452ca..96fbc1273dda 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -35,6 +35,9 @@
 #define REG_MAX		0x50
 
 #define INT_DEBOUNCE_MSEC	10
+
+#define LM3630A_MAX_SOURCES	2
+
 struct lm3630a_chip {
 	struct device *dev;
 	struct delayed_work work;
@@ -364,6 +367,64 @@ static const struct regmap_config lm3630a_regmap = {
 	.max_register = REG_MAX,
 };
 
+static void lm3630a_parse_dt(struct lm3630a_chip *pchip)
+{
+	u32 sources[LM3630A_MAX_SOURCES], val;
+	struct device_node *child_node;
+	int num_sources, ret, i;
+	bool linear;
+
+	for_each_available_child_of_node(pchip->dev->of_node, child_node) {
+		num_sources = of_property_count_u32_elems(child_node,
+							  "led-sources");
+		if (num_sources < 0)
+			continue;
+
+		if (num_sources > LM3630A_MAX_SOURCES)
+			num_sources = LM3630A_MAX_SOURCES;
+
+		ret = of_property_read_u32_array(child_node, "led-sources",
+						 sources, num_sources);
+		if (ret) {
+			dev_err(pchip->dev,
+				"Error parsing led-sources node: %d\n", ret);
+			return;
+		}
+
+		linear = of_property_read_bool(child_node,
+					       "ti,linear-mapping-mode");
+
+		for (i = 0; i < num_sources; i++) {
+			if (sources[i] = 0)
+				pchip->pdata->leda_ctrl = linear ?
+					LM3630A_LEDA_ENABLE_LINEAR :
+					LM3630A_LEDA_ENABLE;
+			else if (sources[i] = 1)
+				pchip->pdata->ledb_ctrl = linear ?
+					LM3630A_LEDB_ENABLE_LINEAR :
+					LM3630A_LEDB_ENABLE;
+
+			ret = of_property_read_u32(child_node,
+						   "default-brightness", &val);
+			if (!ret) {
+				if (sources[i] = 0)
+					pchip->pdata->leda_init_brt = val;
+				else if (sources[i] = 1)
+					pchip->pdata->ledb_init_brt = val;
+			}
+
+			ret = of_property_read_u32(child_node, "max-brightness",
+						   &val);
+			if (!ret) {
+				if (sources[i] = 0)
+					pchip->pdata->leda_max_brt = val;
+				else if (sources[i] = 1)
+					pchip->pdata->ledb_max_brt = val;
+			}
+		}
+	};
+}
+
 static int lm3630a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -405,6 +466,7 @@ static int lm3630a_probe(struct i2c_client *client,
 		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
 	}
 	pchip->pdata = pdata;
+	lm3630a_parse_dt(pchip);
 
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);
@@ -470,11 +532,18 @@ static const struct i2c_device_id lm3630a_id[] = {
 	{}
 };
 
+static const struct of_device_id lm3630a_match_table[] = {
+	{ .compatible = "ti,lm3630a", },
+	{ },
+};
+
+
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
 
 static struct i2c_driver lm3630a_i2c_driver = {
 	.driver = {
 		   .name = LM3630A_NAME,
+		   .of_match_table = lm3630a_match_table,
 		   },
 	.probe = lm3630a_probe,
 	.remove = lm3630a_remove,
-- 
2.20.1
