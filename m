From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 24 Sep 2013 14:23:13 +0000
Subject: [RFC PATCH 1/4] mipi-dsi-bus: add MIPI DSI bus support
Message-Id: <1380032596-18612-2-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380032596-18612-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380032596-18612-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

MIPI DSI is a high-speed serial interface to transmit
data from/to host to display module.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/display/Kconfig        |   4 +
 drivers/video/display/Makefile       |   1 +
 drivers/video/display/mipi-dsi-bus.c | 332 +++++++++++++++++++++++++++++++++++
 include/video/display.h              |   3 +
 include/video/mipi-dsi-bus.h         | 144 +++++++++++++++
 5 files changed, 484 insertions(+)
 create mode 100644 drivers/video/display/mipi-dsi-bus.c
 create mode 100644 include/video/mipi-dsi-bus.h

diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
index 9b482a8..619b05d 100644
--- a/drivers/video/display/Kconfig
+++ b/drivers/video/display/Kconfig
@@ -20,6 +20,10 @@ config DISPLAY_MIPI_DBI
 	tristate
 	default n
 
+config DISPLAY_MIPI_DSI
+	tristate
+	default n
+
 config DISPLAY_PANEL_DPI
 	tristate "DPI (Parallel) Display Panels"
 	---help---
diff --git a/drivers/video/display/Makefile b/drivers/video/display/Makefile
index d03c64a..b323fd4 100644
--- a/drivers/video/display/Makefile
+++ b/drivers/video/display/Makefile
@@ -3,6 +3,7 @@ display-y					:= display-core.o \
 obj-$(CONFIG_DISPLAY_CORE)			+= display.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_VGA)		+= con-vga.o
 obj-$(CONFIG_DISPLAY_MIPI_DBI)			+= mipi-dbi-bus.o
+obj-$(CONFIG_DISPLAY_MIPI_DSI)			+= mipi-dsi-bus.o
 obj-$(CONFIG_DISPLAY_PANEL_DPI)			+= panel-dpi.o
 obj-$(CONFIG_DISPLAY_PANEL_R61505)		+= panel-r61505.o
 obj-$(CONFIG_DISPLAY_PANEL_R61517)		+= panel-r61517.o
diff --git a/drivers/video/display/mipi-dsi-bus.c b/drivers/video/display/mipi-dsi-bus.c
new file mode 100644
index 0000000..a194d92
--- /dev/null
+++ b/drivers/video/display/mipi-dsi-bus.c
@@ -0,0 +1,332 @@
+/*
+ * MIPI DSI Bus
+ *
+ * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
+ * Andrzej Hajda <a.hajda@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <video/mipi_display.h>
+#include <video/mipi-dsi-bus.h>
+
+/* -----------------------------------------------------------------------------
+ * Bus operations
+ */
+
+int mipi_dsi_set_power(struct mipi_dsi_device *dev, bool on)
+{
+	const struct mipi_dsi_bus_ops *ops = dev->bus->ops;
+
+	if (!ops->set_power)
+		return 0;
+
+	return ops->set_power(dev->bus, dev, on);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_set_power);
+
+int mipi_dsi_set_stream(struct mipi_dsi_device *dev, bool on)
+{
+	const struct mipi_dsi_bus_ops *ops = dev->bus->ops;
+
+	if (!ops->set_stream)
+		return 0;
+
+	return ops->set_stream(dev->bus, dev, on);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_set_stream);
+
+int mipi_dsi_dcs_write(struct mipi_dsi_device *dev, int channel, const u8 *data,
+		       size_t len)
+{
+	const struct mipi_dsi_bus_ops *ops = dev->bus->ops;
+	u8 type = channel << 6;
+
+	if (!ops->transfer)
+		return -EINVAL;
+
+	switch (len) {
+	case 0:
+		return -EINVAL;
+	case 1:
+		type |= MIPI_DSI_DCS_SHORT_WRITE;
+		break;
+	case 2:
+		type |= MIPI_DSI_DCS_SHORT_WRITE_PARAM;
+		break;
+	default:
+		type |= MIPI_DSI_DCS_LONG_WRITE;
+	}
+
+	return ops->transfer(dev->bus, dev, type, data, len, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_dcs_write);
+
+int mipi_dsi_dcs_read(struct mipi_dsi_device *dev, int channel, u8 cmd,
+		      u8 *data, size_t len)
+{
+	const struct mipi_dsi_bus_ops *ops = dev->bus->ops;
+	u8 type = MIPI_DSI_DCS_READ | (channel << 6);
+
+	if (!ops->transfer)
+		return -EINVAL;
+
+	return ops->transfer(dev->bus, dev, type, &cmd, 1, data, len);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_dcs_read);
+
+/* -----------------------------------------------------------------------------
+ * Bus type
+ */
+
+static const struct mipi_dsi_device_id *
+mipi_dsi_match_id(const struct mipi_dsi_device_id *id,
+		  struct mipi_dsi_device *dev)
+{
+	while (id->name[0]) {
+		if (strcmp(dev->name, id->name) = 0) {
+			dev->id_entry = id;
+			return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+static int mipi_dsi_match(struct device *_dev, struct device_driver *_drv)
+{
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(_drv);
+
+	if (of_driver_match_device(_dev, _drv))
+		return 1;
+
+	if (drv->id_table)
+		return mipi_dsi_match_id(drv->id_table, dev) != NULL;
+
+	return (strcmp(dev->name, _drv->name) = 0);
+}
+
+static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
+			     char *buf)
+{
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+	int len = snprintf(buf, PAGE_SIZE, MIPI_DSI_MODULE_PREFIX "%s\n",
+			   dev->name);
+
+	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+}
+
+static struct device_attribute mipi_dsi_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int mipi_dsi_uevent(struct device *_dev, struct kobj_uevent_env *env)
+{
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+
+	add_uevent_var(env, "MODALIAS=%s%s", MIPI_DSI_MODULE_PREFIX,
+		       dev->name);
+	return 0;
+}
+
+static const struct dev_pm_ops mipi_dsi_dev_pm_ops = {
+	.runtime_suspend = pm_generic_runtime_suspend,
+	.runtime_resume = pm_generic_runtime_resume,
+	.suspend = pm_generic_suspend,
+	.resume = pm_generic_resume,
+	.freeze = pm_generic_freeze,
+	.thaw = pm_generic_thaw,
+	.poweroff = pm_generic_poweroff,
+	.restore = pm_generic_restore,
+};
+
+static struct bus_type mipi_dsi_bus_type = {
+	.name		= "mipi-dsi",
+	.dev_attrs	= mipi_dsi_dev_attrs,
+	.match		= mipi_dsi_match,
+	.uevent		= mipi_dsi_uevent,
+	.pm		= &mipi_dsi_dev_pm_ops,
+};
+
+void mipi_dsi_dev_release(struct device *_dev)
+{
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+	kfree(dev);
+}
+
+static struct device_type mipi_dsi_dev_type = {
+	.release	= mipi_dsi_dev_release,
+};
+
+
+/* -----------------------------------------------------------------------------
+ * Device and driver (un)registration
+ */
+
+/**
+ * mipi_dsi_device_register - register a DSI device
+ * @dev: DSI device we're registering
+ */
+int mipi_dsi_device_register(struct mipi_dsi_device *dev,
+			      struct mipi_dsi_bus *bus)
+{
+	device_initialize(&dev->dev);
+
+	dev->bus = bus;
+	dev->dev.bus = &mipi_dsi_bus_type;
+	dev->dev.parent = bus->dev;
+	dev->dev.type = &mipi_dsi_dev_type;
+
+	if (dev->id != -1)
+		dev_set_name(&dev->dev, "%s.%d", dev->name,  dev->id);
+	else
+		dev_set_name(&dev->dev, "%s", dev->name);
+
+	return device_add(&dev->dev);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_device_register);
+
+/**
+ * mipi_dsi_device_unregister - unregister a DSI device
+ * @dev: DSI device we're unregistering
+ */
+void mipi_dsi_device_unregister(struct mipi_dsi_device *dev)
+{
+	device_del(&dev->dev);
+	put_device(&dev->dev);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_device_unregister);
+
+static int mipi_dsi_drv_probe(struct device *_dev)
+{
+	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(_dev->driver);
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+
+	return drv->probe(dev);
+}
+
+static int mipi_dsi_drv_remove(struct device *_dev)
+{
+	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(_dev->driver);
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+
+	return drv->remove(dev);
+}
+
+/**
+ * mipi_dsi_driver_register - register a driver for DSI devices
+ * @drv: DSI driver structure
+ */
+int mipi_dsi_driver_register(struct mipi_dsi_driver *drv)
+{
+	drv->driver.bus = &mipi_dsi_bus_type;
+	if (drv->probe)
+		drv->driver.probe = mipi_dsi_drv_probe;
+	if (drv->remove)
+		drv->driver.remove = mipi_dsi_drv_remove;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_driver_register);
+
+/**
+ * mipi_dsi_driver_unregister - unregister a driver for DSI devices
+ * @drv: DSI driver structure
+ */
+void mipi_dsi_driver_unregister(struct mipi_dsi_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_driver_unregister);
+
+struct mipi_dsi_device *of_mipi_dsi_register_device(struct mipi_dsi_bus *bus,
+						    struct device_node *node)
+{
+	struct mipi_dsi_device *d = NULL;
+	int ret;
+
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return ERR_PTR(-ENOMEM);
+
+	ret = of_modalias_node(node, d->name, sizeof(d->name));
+	if (ret) {
+		dev_err(bus->dev, "modalias failure on %s\n", node->full_name);
+		goto err_free;
+	}
+
+	d->dev.of_node = of_node_get(node);
+	if (!d->dev.of_node)
+		goto err_free;
+
+	ret = mipi_dsi_device_register(d, bus);
+
+	if (!ret)
+		return d;
+
+	of_node_put(node);
+err_free:
+	kfree(d);
+
+	return ERR_PTR(ret);
+}
+
+int of_mipi_dsi_register_devices(struct mipi_dsi_bus *bus)
+{
+	struct device_node *n;
+
+	for_each_child_of_node(bus->dev->of_node, n)
+		of_mipi_dsi_register_device(bus, n);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_mipi_dsi_register_devices);
+
+static int mipi_dsi_remove_device_fn(struct device *_dev, void *priv)
+{
+	struct mipi_dsi_device *dev = to_mipi_dsi_device(_dev);
+
+	mipi_dsi_device_unregister(dev);
+
+	return 0;
+}
+
+void mipi_dsi_unregister_devices(struct mipi_dsi_bus *bus)
+{
+	device_for_each_child(bus->dev, bus, mipi_dsi_remove_device_fn);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_unregister_devices);
+/* -----------------------------------------------------------------------------
+ * Init/exit
+ */
+
+static int __init mipi_dsi_init(void)
+{
+	return bus_register(&mipi_dsi_bus_type);
+}
+
+static void __exit mipi_dsi_exit(void)
+{
+	bus_unregister(&mipi_dsi_bus_type);
+}
+
+module_init(mipi_dsi_init);
+module_exit(mipi_dsi_exit)
+
+MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
+MODULE_DESCRIPTION("MIPI DSI Bus");
+MODULE_LICENSE("GPL v2");
diff --git a/include/video/display.h b/include/video/display.h
index 3138401..7faca0f 100644
--- a/include/video/display.h
+++ b/include/video/display.h
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <media/media-entity.h>
 #include <video/mipi-dbi-bus.h>
+#include <video/mipi-dsi-bus.h>
 
 #define DISPLAY_PIXEL_CODING(option, type, from, to, variant) \
 	(((option) << 17) | ((type) << 13) | ((variant) << 10) | \
@@ -184,6 +185,7 @@ enum display_entity_stream_state {
 enum display_entity_interface_type {
 	DISPLAY_ENTITY_INTERFACE_DPI,
 	DISPLAY_ENTITY_INTERFACE_DBI,
+	DISPLAY_ENTITY_INTERFACE_DSI,
 	DISPLAY_ENTITY_INTERFACE_LVDS,
 	DISPLAY_ENTITY_INTERFACE_VGA,
 };
@@ -192,6 +194,7 @@ struct display_entity_interface_params {
 	enum display_entity_interface_type type;
 	union {
 		struct mipi_dbi_interface_params dbi;
+		struct mipi_dsi_interface_params dsi;
 	} p;
 };
 
diff --git a/include/video/mipi-dsi-bus.h b/include/video/mipi-dsi-bus.h
new file mode 100644
index 0000000..a78792d
--- /dev/null
+++ b/include/video/mipi-dsi-bus.h
@@ -0,0 +1,144 @@
+/*
+ * MIPI DSI Bus
+ *
+ * Copyright (C) 2013, Samsung Electronics, Co., Ltd.
+ * Andrzej Hajda <a.hajda@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MIPI_DSI_BUS_H__
+#define __MIPI_DSI_BUS_H__
+
+#include <linux/device.h>
+#include <video/videomode.h>
+
+struct mipi_dsi_bus;
+struct mipi_dsi_device;
+
+struct mipi_dsi_bus_ops {
+	int (*set_power)(struct mipi_dsi_bus *bus, struct mipi_dsi_device *dev,
+			 bool on);
+	int (*set_stream)(struct mipi_dsi_bus *bus, struct mipi_dsi_device *dev,
+			  bool on);
+	int (*transfer)(struct mipi_dsi_bus *bus, struct mipi_dsi_device *dev,
+			u8 type, const u8 *tx_buf, size_t tx_len, u8 *rx_buf,
+			size_t rx_len);
+};
+
+#define DSI_MODE_VIDEO			(1 << 0)
+#define DSI_MODE_VIDEO_BURST		(1 << 1)
+#define DSI_MODE_VIDEO_SYNC_PULSE	(1 << 2)
+#define DSI_MODE_VIDEO_AUTO_VERT	(1 << 3)
+#define DSI_MODE_VIDEO_HSE		(1 << 4)
+#define DSI_MODE_VIDEO_HFP		(1 << 5)
+#define DSI_MODE_VIDEO_HBP		(1 << 6)
+#define DSI_MODE_VIDEO_HSA		(1 << 7)
+#define DSI_MODE_VSYNC_FLUSH		(1 << 8)
+#define DSI_MODE_EOT_PACKET		(1 << 9)
+
+enum mipi_dsi_pixel_format {
+	DSI_FMT_RGB888,
+	DSI_FMT_RGB666,
+	DSI_FMT_RGB666_PACKED,
+	DSI_FMT_RGB565,
+};
+
+struct mipi_dsi_interface_params {
+	enum mipi_dsi_pixel_format format;
+	unsigned long mode;
+	unsigned long hs_clk_freq;
+	unsigned long esc_clk_freq;
+	unsigned char data_lanes;
+	unsigned char cmd_allow;
+};
+
+struct mipi_dsi_bus {
+	struct device *dev;
+	const struct mipi_dsi_bus_ops *ops;
+};
+
+#define MIPI_DSI_MODULE_PREFIX		"mipi-dsi:"
+#define MIPI_DSI_NAME_SIZE		32
+
+struct mipi_dsi_device_id {
+	char name[MIPI_DSI_NAME_SIZE];
+	__kernel_ulong_t driver_data	/* Data private to the driver */
+			__aligned(sizeof(__kernel_ulong_t));
+};
+
+struct mipi_dsi_device {
+	char name[MIPI_DSI_NAME_SIZE];
+	int id;
+	struct device dev;
+
+	const struct mipi_dsi_device_id *id_entry;
+	struct mipi_dsi_bus *bus;
+	struct videomode vm;
+	struct mipi_dsi_interface_params params;
+};
+
+#define to_mipi_dsi_device(d)	container_of(d, struct mipi_dsi_device, dev)
+
+int mipi_dsi_device_register(struct mipi_dsi_device *dev,
+			     struct mipi_dsi_bus *bus);
+void mipi_dsi_device_unregister(struct mipi_dsi_device *dev);
+
+struct mipi_dsi_driver {
+	int(*probe)(struct mipi_dsi_device *);
+	int(*remove)(struct mipi_dsi_device *);
+	struct device_driver driver;
+	const struct mipi_dsi_device_id *id_table;
+};
+
+#define to_mipi_dsi_driver(d)	container_of(d, struct mipi_dsi_driver, driver)
+
+int mipi_dsi_driver_register(struct mipi_dsi_driver *drv);
+void mipi_dsi_driver_unregister(struct mipi_dsi_driver *drv);
+
+static inline void *mipi_dsi_get_drvdata(const struct mipi_dsi_device *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void mipi_dsi_set_drvdata(struct mipi_dsi_device *dev,
+					void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
+
+int of_mipi_dsi_register_devices(struct mipi_dsi_bus *bus);
+void mipi_dsi_unregister_devices(struct mipi_dsi_bus *bus);
+
+/* module_mipi_dsi_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_mipi_dsi_driver(__mipi_dsi_driver) \
+	module_driver(__mipi_dsi_driver, mipi_dsi_driver_register, \
+			mipi_dsi_driver_unregister)
+
+int mipi_dsi_set_power(struct mipi_dsi_device *dev, bool on);
+int mipi_dsi_set_stream(struct mipi_dsi_device *dev, bool on);
+int mipi_dsi_dcs_write(struct mipi_dsi_device *dev, int channel, const u8 *data,
+		       size_t len);
+int mipi_dsi_dcs_read(struct mipi_dsi_device *dev, int channel, u8 cmd,
+		      u8 *data, size_t len);
+
+#define mipi_dsi_dcs_write_seq(dev, channel, seq...) \
+({\
+	const u8 d[] = { seq };\
+	BUILD_BUG_ON_MSG(ARRAY_SIZE(d) > 64, "DCS sequence too long for stack");\
+	mipi_dsi_dcs_write(dev, channel, d, ARRAY_SIZE(d));\
+})
+
+#define mipi_dsi_dcs_write_static_seq(dev, channel, seq...) \
+({\
+	static const u8 d[] = { seq };\
+	mipi_dsi_dcs_write(dev, channel, d, ARRAY_SIZE(d));\
+})
+
+#endif /* __MIPI_DSI_BUS__ */
-- 
1.8.1.2

