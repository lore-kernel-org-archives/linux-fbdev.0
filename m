From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 24 Mar 2020 17:05:30 +0000
Subject: [PATCH v1 3/5] video: ssd1307fb: Make use of device properties
Message-Id: <20200324170532.44384-3-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/ssd1307fb.c | 40 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 84dfd7b0f682..7a6a44a0b7a6 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -12,8 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
@@ -592,7 +591,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	struct backlight_device *bl;
 	char bl_name[12];
 	struct fb_info *info;
-	struct device_node *node = client->dev.of_node;
 	struct fb_deferred_io *ssd1307fb_defio;
 	u32 vmem_size;
 	struct ssd1307fb_par *par;
@@ -607,7 +605,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	par->info = info;
 	par->client = client;
 
-	par->device_info = of_device_get_match_data(&client->dev);
+	par->device_info = device_get_match_data(dev);
 
 	par->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(par->reset)) {
@@ -627,44 +625,44 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		}
 	}
 
-	if (of_property_read_u32(node, "solomon,width", &par->width))
+	if (device_property_read_u32(dev, "solomon,width", &par->width))
 		par->width = 96;
 
-	if (of_property_read_u32(node, "solomon,height", &par->height))
+	if (device_property_read_u32(dev, "solomon,height", &par->height))
 		par->height = 16;
 
-	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
+	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
 		par->page_offset = 1;
 
-	if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
+	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-	if (of_property_read_u32(node, "solomon,prechargep1", &par->prechargep1))
+	if (device_property_read_u32(dev, "solomon,prechargep1", &par->prechargep1))
 		par->prechargep1 = 2;
 
-	if (of_property_read_u32(node, "solomon,prechargep2", &par->prechargep2))
+	if (device_property_read_u32(dev, "solomon,prechargep2", &par->prechargep2))
 		par->prechargep2 = 2;
 
-	if (!of_property_read_u8_array(node, "solomon,lookup-table",
-				       par->lookup_table,
-				       ARRAY_SIZE(par->lookup_table)))
+	if (!device_property_read_u8_array(dev, "solomon,lookup-table",
+					   par->lookup_table,
+					   ARRAY_SIZE(par->lookup_table)))
 		par->lookup_table_set = 1;
 
-	par->seg_remap = !of_property_read_bool(node, "solomon,segment-no-remap");
-	par->com_seq = of_property_read_bool(node, "solomon,com-seq");
-	par->com_lrremap = of_property_read_bool(node, "solomon,com-lrremap");
-	par->com_invdir = of_property_read_bool(node, "solomon,com-invdir");
+	par->seg_remap = !device_property_read_bool(dev, "solomon,segment-no-remap");
+	par->com_seq = device_property_read_bool(dev, "solomon,com-seq");
+	par->com_lrremap = device_property_read_bool(dev, "solomon,com-lrremap");
+	par->com_invdir = device_property_read_bool(dev, "solomon,com-invdir");
 	par->area_color_enable -		of_property_read_bool(node, "solomon,area-color-enable");
-	par->low_power = of_property_read_bool(node, "solomon,low-power");
+		device_property_read_bool(dev, "solomon,area-color-enable");
+	par->low_power = device_property_read_bool(dev, "solomon,low-power");
 
 	par->contrast = 127;
 	par->vcomh = par->device_info->default_vcomh;
 
 	/* Setup display timing */
-	if (of_property_read_u32(node, "solomon,dclk-div", &par->dclk_div))
+	if (device_property_read_u32(dev, "solomon,dclk-div", &par->dclk_div))
 		par->dclk_div = par->device_info->default_dclk_div;
-	if (of_property_read_u32(node, "solomon,dclk-frq", &par->dclk_frq))
+	if (device_property_read_u32(dev, "solomon,dclk-frq", &par->dclk_frq))
 		par->dclk_frq = par->device_info->default_dclk_frq;
 
 	vmem_size = DIV_ROUND_UP(par->width, 8) * par->height;
-- 
2.25.1
