From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Apr 2020 11:33:12 +0000
Subject: [PATCH 5/5] backlight: led_bl: rewrite led_bl_parse_levels()
Message-Id: <20200417113312.24340-5-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200417113312.24340-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

led_bl_parse_levels() is rather difficult to follow. Rewrite it with a
more obvious code flow.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/backlight/led_bl.c | 63 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index 021b5edd895c..7b3889035540 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -132,50 +132,51 @@ static int led_bl_parse_levels(struct device *dev,
 	int num_levels;
 	u32 value;
 	int ret;
+	int i;
+	u32 *levels;
 
 	if (!node)
 		return -ENODEV;
 
 	num_levels = of_property_count_u32_elems(node, "brightness-levels");
-	if (num_levels > 1) {
-		int i;
-		unsigned int db;
-		u32 *levels;
-
-		levels = devm_kzalloc(dev, sizeof(u32) * num_levels,
-				      GFP_KERNEL);
-		if (!levels)
-			return -ENOMEM;
-
-		ret = of_property_read_u32_array(node, "brightness-levels",
-						 levels,
-						 num_levels);
-		if (ret < 0)
-			return ret;
-
-		/*
-		 * Try to map actual LED brightness to backlight brightness
-		 * level
-		 */
-		db = priv->default_brightness;
+
+	if (num_levels < 0)
+		return 0;
+
+	if (num_levels = 0) {
+		dev_warn(dev, "No brightness-levels defined\n");
+		return -EINVAL;
+	}
+
+	levels = devm_kzalloc(dev, sizeof(u32) * num_levels,
+			      GFP_KERNEL);
+	if (!levels)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(node, "brightness-levels",
+					 levels,
+					 num_levels);
+	if (ret < 0)
+		return ret;
+
+	priv->max_brightness = num_levels - 1;
+	priv->levels = levels;
+
+	ret = of_property_read_u32(node, "default-brightness-level", &value);
+	if (!ret) {
+		priv->default_brightness = min(value, priv->max_brightness);
+	} else {
+		/* Map LED default-brightness to backlight brightness level */
+		unsigned int db = priv->default_brightness;
+
 		for (i = 0 ; i < num_levels; i++) {
 			if ((i = 0 || db > levels[i - 1]) && db <= levels[i])
 				break;
 		}
 
 		priv->default_brightness = i < num_levels ? i : 0;
-		priv->max_brightness = num_levels - 1;
-		priv->levels = levels;
-	} else if (num_levels >= 0) {
-		dev_warn(dev, "Not enough levels defined\n");
 	}
 
-	ret = of_property_read_u32(node, "default-brightness-level", &value);
-	if (!ret && value <= priv->max_brightness)
-		priv->default_brightness = value;
-	else if (!ret  && value > priv->max_brightness)
-		dev_warn(dev, "Invalid default brightness. Ignoring it\n");
-
 	return 0;
 }
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
