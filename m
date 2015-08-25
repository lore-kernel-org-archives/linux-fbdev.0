From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Aug 2015 11:34:00 +0000
Subject: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds basic support for a kernel driver to get a LED device.
This will be used by the led-backlight driver.

Only OF version is implemented for now, and the behavior is similar to
PWM's of_pwm_get() and pwm_put().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/leds/led-class.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/leds.h     |  4 +++
 2 files changed, 79 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index beabfbc6f7cd..0cb4fd7d71d6 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/of.h>
 #include "leds.h"
 
 static struct class *leds_class;
@@ -216,6 +217,80 @@ static int led_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
 
+/* find OF node for the given led_cdev */
+static struct device_node *find_led_of_node(struct led_classdev *led_cdev)
+{
+	struct device *led_dev = led_cdev->dev;
+	struct device_node *child;
+
+	for_each_child_of_node(led_dev->parent->of_node, child) {
+		if (of_property_match_string(child, "label", led_cdev->name) = 0)
+			return child;
+	}
+
+	return NULL;
+}
+
+static int led_match_led_node(struct device *led_dev, const void *data)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(led_dev);
+	const struct device_node *target_node = data;
+	struct device_node *led_node;
+
+	led_node = find_led_of_node(led_cdev);
+	if (!led_node)
+		return 0;
+
+	of_node_put(led_node);
+
+	return led_node = target_node ? 1 : 0;
+}
+
+/**
+ * of_led_get() - request a LED device via the LED framework
+ * @np: device node to get the LED device from
+ *
+ * Returns the LED device parsed from the phandle specified in the "leds"
+ * property of a device tree node or a negative error-code on failure.
+ */
+struct led_classdev *of_led_get(struct device_node *np)
+{
+	struct device *led_dev;
+	struct led_classdev *led_cdev;
+	struct device_node *led_node;
+
+	led_node = of_parse_phandle(np, "leds", 0);
+	if (!led_node)
+		return ERR_PTR(-ENODEV);
+
+	led_dev = class_find_device(leds_class, NULL, led_node,
+		led_match_led_node);
+	if (!led_dev) {
+		of_node_put(led_node);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	of_node_put(led_node);
+
+	led_cdev = dev_get_drvdata(led_dev);
+
+	if (!try_module_get(led_cdev->dev->parent->driver->owner))
+		return ERR_PTR(-ENODEV);
+
+	return led_cdev;
+}
+EXPORT_SYMBOL_GPL(of_led_get);
+
+/**
+ * led_put() - release a LED device
+ * @led_cdev: LED device
+ */
+void led_put(struct led_classdev *led_cdev)
+{
+	module_put(led_cdev->dev->parent->driver->owner);
+}
+EXPORT_SYMBOL_GPL(led_put);
+
 static int match_name(struct device *dev, const void *data)
 {
 	if (!dev_name(dev))
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b122eeafb5dc..efc9b28af564 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 
 struct device;
+struct device_node;
 /*
  * LED Core
  */
@@ -113,6 +114,9 @@ extern void devm_led_classdev_unregister(struct device *parent,
 extern void led_classdev_suspend(struct led_classdev *led_cdev);
 extern void led_classdev_resume(struct led_classdev *led_cdev);
 
+extern struct led_classdev *of_led_get(struct device_node *np);
+extern void led_put(struct led_classdev *led_cdev);
+
 /**
  * led_blink_set - set blinking with software fallback
  * @led_cdev: the LED to start blinking
-- 
2.1.4

