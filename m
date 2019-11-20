From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 20 Nov 2019 09:57:15 +0000
Subject: [PATCH v1 4/5] fbtft: Make use of device property API
Message-Id: <20191120095716.26628-4-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Make use of device property API in this driver so that both OF based
system and ACPI based system can use this driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 105 ++++++++++++++++-------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ff8cb6670ea1..e87d839d86ac 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -22,8 +22,9 @@
 #include <linux/uaccess.h>
 #include <linux/backlight.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
-#include <linux/of.h>
+
 #include <video/mipi_display.h>
 
 #include "fbtft.h"
@@ -894,44 +895,53 @@ int fbtft_unregister_framebuffer(struct fb_info *fb_info)
 EXPORT_SYMBOL(fbtft_unregister_framebuffer);
 
 /**
- * fbtft_init_display_dt() - Device Tree init_display() function
+ * fbtft_init_display_from_property() - Device Tree init_display() function
  * @par: Driver data
  *
  * Return: 0 if successful, negative if error
  */
-static int fbtft_init_display_dt(struct fbtft_par *par)
+static int fbtft_init_display_from_property(struct fbtft_par *par)
 {
-	struct device_node *node = par->info->device->of_node;
-	struct property *prop;
-	const __be32 *p;
+	struct device *dev = par->info->device;
+	int buf[64], count, index, i, j, ret;
+	u32 *values;
 	u32 val;
-	int buf[64], i, j;
 
-	if (!node)
+	count = device_property_count_u32(dev, "init");
+	if (count < 0)
+		return count;
+	if (count = 0)
 		return -EINVAL;
 
-	prop = of_find_property(node, "init", NULL);
-	p = of_prop_next_u32(prop, NULL, &val);
-	if (!p)
-		return -EINVAL;
+	values = kmalloc_array(count, sizeof(*values), GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, "init", values, count);
+	if (ret)
+		goto out_free;
 
 	par->fbtftops.reset(par);
 	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
-	while (p) {
+	index = -1;
+	while (index < count) {
+		val = values[++index];
+
 		if (val & FBTFT_OF_INIT_CMD) {
 			val &= 0xFFFF;
 			i = 0;
-			while (p && !(val & 0xFFFF0000)) {
+			while ((index < count) && !(val & 0xFFFF0000)) {
 				if (i > 63) {
-					dev_err(par->info->device,
+					dev_err(dev,
 						"%s: Maximum register values exceeded\n",
 						__func__);
-					return -EINVAL;
+					ret = -EINVAL;
+					goto out_free;
 				}
 				buf[i++] = val;
-				p = of_prop_next_u32(prop, p, &val);
+				val = values[++index];
 			}
 			/* make debug message */
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
@@ -961,15 +971,17 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 				      "init: msleep(%u)\n", val & 0xFFFF);
 			msleep(val & 0xFFFF);
-			p = of_prop_next_u32(prop, p, &val);
+			val = values[++index];
 		} else {
-			dev_err(par->info->device, "illegal init value 0x%X\n",
-				val);
-			return -EINVAL;
+			dev_err(dev, "illegal init value 0x%X\n", val);
+			ret = -EINVAL;
+			goto out_free;
 		}
 	}
 
-	return 0;
+out_free:
+	kfree(values);
+	return ret;
 }
 
 /**
@@ -1132,25 +1144,24 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 }
 
 /* returns 0 if the property is not present */
-static u32 fbtft_of_value(struct device_node *node, const char *propname)
+static u32 fbtft_property_value(struct device *dev, const char *propname)
 {
 	int ret;
 	u32 val = 0;
 
-	ret = of_property_read_u32(node, propname, &val);
+	ret = device_property_read_u32(dev, propname, &val);
 	if (ret = 0)
-		pr_info("%s: %s = %u\n", __func__, propname, val);
+		dev_info(dev, "%s: %s = %u\n", __func__, propname, val);
 
 	return val;
 }
 
-static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
+static struct fbtft_platform_data *fbtft_properties_read(struct device *dev)
 {
-	struct device_node *node = dev->of_node;
 	struct fbtft_platform_data *pdata;
 
-	if (!node) {
-		dev_err(dev, "Missing platform data or DT\n");
+	if (!dev_fwnode(dev)) {
+		dev_err(dev, "Missing platform data or properties\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1158,24 +1169,24 @@ static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->display.width = fbtft_of_value(node, "width");
-	pdata->display.height = fbtft_of_value(node, "height");
-	pdata->display.regwidth = fbtft_of_value(node, "regwidth");
-	pdata->display.buswidth = fbtft_of_value(node, "buswidth");
-	pdata->display.backlight = fbtft_of_value(node, "backlight");
-	pdata->display.bpp = fbtft_of_value(node, "bpp");
-	pdata->display.debug = fbtft_of_value(node, "debug");
-	pdata->rotate = fbtft_of_value(node, "rotate");
-	pdata->bgr = of_property_read_bool(node, "bgr");
-	pdata->fps = fbtft_of_value(node, "fps");
-	pdata->txbuflen = fbtft_of_value(node, "txbuflen");
-	pdata->startbyte = fbtft_of_value(node, "startbyte");
-	of_property_read_string(node, "gamma", (const char **)&pdata->gamma);
-
-	if (of_find_property(node, "led-gpios", NULL))
+	pdata->display.width = fbtft_property_value(dev, "width");
+	pdata->display.height = fbtft_property_value(dev, "height");
+	pdata->display.regwidth = fbtft_property_value(dev, "regwidth");
+	pdata->display.buswidth = fbtft_property_value(dev, "buswidth");
+	pdata->display.backlight = fbtft_property_value(dev, "backlight");
+	pdata->display.bpp = fbtft_property_value(dev, "bpp");
+	pdata->display.debug = fbtft_property_value(dev, "debug");
+	pdata->rotate = fbtft_property_value(dev, "rotate");
+	pdata->bgr = device_property_read_bool(dev, "bgr");
+	pdata->fps = fbtft_property_value(dev, "fps");
+	pdata->txbuflen = fbtft_property_value(dev, "txbuflen");
+	pdata->startbyte = fbtft_property_value(dev, "startbyte");
+	device_property_read_string(dev, "gamma", (const char **)&pdata->gamma);
+
+	if (device_property_present(dev, "led-gpios"))
 		pdata->display.backlight = 1;
-	if (of_find_property(node, "init", NULL))
-		pdata->display.fbtftops.init_display = fbtft_init_display_dt;
+	if (device_property_present(dev, "init"))
+		pdata->display.fbtftops.init_display = fbtft_init_display_from_property;
 	pdata->display.fbtftops.request_gpios = fbtft_request_gpios;
 
 	return pdata;
@@ -1213,7 +1224,7 @@ int fbtft_probe_common(struct fbtft_display *display,
 
 	pdata = dev->platform_data;
 	if (!pdata) {
-		pdata = fbtft_probe_dt(dev);
+		pdata = fbtft_properties_read(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
-- 
2.24.0
