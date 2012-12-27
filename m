From: Tomasz Figa <t.figa@samsung.com>
Date: Thu, 27 Dec 2012 14:43:34 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <2529718.glQX8guWfJ@amdc1227>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <7255068.DBf2OgseHL@amdc1227> <3445117.L94DmxEvrl@avalon>
In-Reply-To: <3445117.L94DmxEvrl@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Vikas Sajjan <vikas.sajjan@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tom Gall <tom.gall@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Clark <rob.clark@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, sunil joshi <joshi@samsung.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

Hi Laurent,

On Monday 24 of December 2012 15:12:28 Laurent Pinchart wrote:
> Hi Tomasz,
>=20
> On Friday 21 December 2012 11:00:52 Tomasz Figa wrote:
> > On Tuesday 18 of December 2012 08:31:30 Vikas Sajjan wrote:
> > > On 17 December 2012 20:55, Laurent Pinchart wrote:
> > > > Hi Vikas,
> > > >=20
> > > > Sorry for the late reply. I now have more time to work on CDF, so
> > > > delays should be much shorter.
> > > >=20
> > > > On Thursday 06 December 2012 10:51:15 Vikas Sajjan wrote:
> > > > > Hi Laurent,
> > > > >=20
> > > > > I was thinking of porting CDF to samsung EXYNOS 5250 platform,
> > > > > what
> > > > > I found is that, the exynos display controller is MIPI DSI based
> > > > > controller.
> > > > >=20
> > > > > But if I look at CDF patches, it has only support for MIPI DBI
> > > > > based
> > > > > Display controller.
> > > > >=20
> > > > > So my question is, do we have any generic framework for MIPI DSI
> > > > > based display controller? basically I wanted to know, how to go
> > > > > about
> > > > > porting CDF for such kind of display controller.
> > > >=20
> > > > MIPI DSI support is not available yet. The only reason for that is
> > > > that I don't have any MIPI DSI hardware to write and test the code
> > > > with :-)
> > > >=20
> > > > The common display framework should definitely support MIPI DSI. I
> > > > think the existing MIPI DBI code could be used as a base, so the
> > > > implementation shouldn't be too high.
> > > >=20
> > > > Yeah, i was also thinking in similar lines, below is my though for
> > > > MIPI DSI support in CDF.
> > >=20
> > > o   MIPI DSI support as part of CDF framework will expose
> > > =A7  mipi_dsi_register_device(mpi_device) (will be called
> > > mach-xxx-dt.c
> > > file )
> > > =A7  mipi_dsi_register_driver(mipi_driver, bus ops) (will be called
> > > from
> > > platform specific init driver call )
> > > =B7    bus ops will be
> > > o   read data
> > > o   write data
> > > o   write command
> > > =A7  MIPI DSI will be registered as bus_register()
> > >=20
> > > When MIPI DSI probe is called, it (e.g., Exynos or OMAP MIPI DSI)
> > > will
> > > initialize the MIPI DSI HW IP.
> > >=20
> > > This probe will also parse the DT file for MIPI DSI based panel, add
> > > the panel device (device_add() ) to kernel and register the display
> > > entity with its control and  video ops with CDF.
> > >=20
> > > I can give this a try.
> >=20
> > I am currently in progress of reworking Exynos MIPI DSIM code and
> > s6e8ax0 LCD driver to use the v2 RFC of Common Display Framework. I
> > have most of the work done, I have just to solve several remaining
> > problems.
> Do you already have code that you can publish ? I'm particularly
> interested (and I think Tomi Valkeinen would be as well) in looking at
> the DSI operations you expose to DSI sinks (panels, transceivers, ...).

Well, I'm afraid this might be little below your expectations, but here's=20
an initial RFC of the part defining just the DSI bus. I need a bit more=20
time for patches for Exynos MIPI DSI master and s6e8ax0 LCD.

The implementation is very simple and heavily based on your MIPI DBI=20
support and existing Exynos MIPI DSIM framework. Provided operation set is =

based on operation set used by Exynos s6e8ax0 LCD driver. Unfortunately=20
this is my only source of information about MIPI DSI.

Best regards,
--=20
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

From bad07d8bdce0ff76cbc81a9da597c0d01e5244f7 Mon Sep 17 00:00:00 2001
From: Tomasz Figa <t.figa@samsung.com>
Date: Thu, 27 Dec 2012 12:36:15 +0100
Subject: [RFC] video: display: Add generic MIPI DSI bus

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/video/display/Kconfig        |   4 +
 drivers/video/display/Makefile       |   1 +
 drivers/video/display/mipi-dsi-bus.c | 214=20
+++++++++++++++++++++++++++++++++++
 include/video/display.h              |   1 +
 include/video/mipi-dsi-bus.h         |  98 ++++++++++++++++
 5 files changed, 318 insertions(+)
 create mode 100644 drivers/video/display/mipi-dsi-bus.c
 create mode 100644 include/video/mipi-dsi-bus.h

diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
index 13b6aaf..dbaff9d 100644
--- a/drivers/video/display/Kconfig
+++ b/drivers/video/display/Kconfig
@@ -9,6 +9,10 @@ config DISPLAY_MIPI_DBI
 	tristate
 	default n
=20
+config DISPLAY_MIPI_DSI
+	tristate
+	default n
+
 config DISPLAY_PANEL_DPI
 	tristate "DPI (Parallel) Display Panels"
 	---help---
diff --git a/drivers/video/display/Makefile=20
b/drivers/video/display/Makefile
index 482bec7..429b3ac8 100644
--- a/drivers/video/display/Makefile
+++ b/drivers/video/display/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_DISPLAY_CORE) +=3D display-core.o
 obj-$(CONFIG_DISPLAY_MIPI_DBI) +=3D mipi-dbi-bus.o
+obj-$(CONFIG_DISPLAY_MIPI_DSI) +=3D mipi-dsi-bus.o
 obj-$(CONFIG_DISPLAY_PANEL_DPI) +=3D panel-dpi.o
 obj-$(CONFIG_DISPLAY_PANEL_R61505) +=3D panel-r61505.o
 obj-$(CONFIG_DISPLAY_PANEL_R61517) +=3D panel-r61517.o
diff --git a/drivers/video/display/mipi-dsi-bus.c=20
b/drivers/video/display/mipi-dsi-bus.c
new file mode 100644
index 0000000..2998522
--- /dev/null
+++ b/drivers/video/display/mipi-dsi-bus.c
@@ -0,0 +1,214 @@
+/*
+ * MIPI DSI Bus
+ *
+ * Copyright (C) 2012 Samsung Electronics Co., Ltd.
+ * Contacts: Tomasz Figa <t.figa@samsung.com>
+ *
+ * Heavily based ond mipi-dbi-bus.c.
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
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+
+#include <video/mipi-dsi-bus.h>
+
+/*=20
---------------------------------------------------------------------------=
--
+ * Bus operations
+ */
+
+int mipi_dsi_write_command(struct mipi_dsi_device *dev, unsigned int cmd,
+				const unsigned char *buf, unsigned int len)
+{
+	return dev->bus->ops->write_command(dev->bus, dev, cmd, buf, len);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_write_command);
+
+int mipi_dsi_read_command(struct mipi_dsi_device *dev, unsigned int cmd,
+		unsigned int addr, unsigned char *buf, unsigned int len)
+{
+	return dev->bus->ops->read_command(dev->bus, dev, cmd, addr, buf,=20
len);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_read_command);
+
+/*=20
---------------------------------------------------------------------------=
--
+ * Bus type
+ */
+
+static const struct mipi_dsi_device_id *
+mipi_dsi_match_id(const struct mipi_dsi_device_id *id,
+		  struct mipi_dsi_device *dev)
+{
+	while (id->name[0]) {
+		if (strcmp(dev->name, id->name) =3D 0) {
+			dev->id_entry =3D id;
+			return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+static int mipi_dsi_match(struct device *_dev, struct device_driver=20
*_drv)
+{
+	struct mipi_dsi_device *dev =3D to_mipi_dsi_device(_dev);
+	struct mipi_dsi_driver *drv =3D to_mipi_dsi_driver(_drv);
+
+	if (drv->id_table)
+		return mipi_dsi_match_id(drv->id_table, dev) !=3D NULL;
+
+	return (strcmp(dev->name, _drv->name) =3D 0);
+}
+
+static ssize_t modalias_show(struct device *_dev, struct device_attribute =

*a,
+			     char *buf)
+{
+	struct mipi_dsi_device *dev =3D to_mipi_dsi_device(_dev);
+	int len =3D snprintf(buf, PAGE_SIZE, MIPI_DSI_MODULE_PREFIX "%s\n",
+			   dev->name);
+
+	return (len >=3D PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+}
+
+static struct device_attribute mipi_dsi_dev_attrs[] =3D {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int mipi_dsi_uevent(struct device *_dev, struct kobj_uevent_env=20
*env)
+{
+	struct mipi_dsi_device *dev =3D to_mipi_dsi_device(_dev);
+
+	add_uevent_var(env, "MODALIAS=3D%s%s", MIPI_DSI_MODULE_PREFIX,
+		       dev->name);
+	return 0;
+}
+
+static const struct dev_pm_ops mipi_dsi_dev_pm_ops =3D {
+	.runtime_suspend =3D pm_generic_runtime_suspend,
+	.runtime_resume =3D pm_generic_runtime_resume,
+	.runtime_idle =3D pm_generic_runtime_idle,
+	.suspend =3D pm_generic_suspend,
+	.resume =3D pm_generic_resume,
+	.freeze =3D pm_generic_freeze,
+	.thaw =3D pm_generic_thaw,
+	.poweroff =3D pm_generic_poweroff,
+	.restore =3D pm_generic_restore,
+};
+
+static struct bus_type mipi_dsi_bus_type =3D {
+	.name		=3D "mipi-dsi",
+	.dev_attrs	=3D mipi_dsi_dev_attrs,
+	.match		=3D mipi_dsi_match,
+	.uevent		=3D mipi_dsi_uevent,
+	.pm		=3D &mipi_dsi_dev_pm_ops,
+};
+
+/*=20
---------------------------------------------------------------------------=
--
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
+	dev->bus =3D bus;
+	dev->dev.bus =3D &mipi_dsi_bus_type;
+	dev->dev.parent =3D bus->dev;
+
+	if (dev->id !=3D -1)
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
+	struct mipi_dsi_driver *drv =3D to_mipi_dsi_driver(_dev->driver);
+	struct mipi_dsi_device *dev =3D to_mipi_dsi_device(_dev);
+
+	return drv->probe(dev);
+}
+
+static int mipi_dsi_drv_remove(struct device *_dev)
+{
+	struct mipi_dsi_driver *drv =3D to_mipi_dsi_driver(_dev->driver);
+	struct mipi_dsi_device *dev =3D to_mipi_dsi_device(_dev);
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
+	drv->driver.bus =3D &mipi_dsi_bus_type;
+	if (drv->probe)
+		drv->driver.probe =3D mipi_dsi_drv_probe;
+	if (drv->remove)
+		drv->driver.remove =3D mipi_dsi_drv_remove;
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
+/*=20
---------------------------------------------------------------------------=
--
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
+MODULE_AUTHOR("Tomasz Figa <t.figa@samsung.com>");
+MODULE_DESCRIPTION("MIPI DSI Bus");
+MODULE_LICENSE("GPL");
diff --git a/include/video/display.h b/include/video/display.h
index 75ba270..f86ea6e 100644
--- a/include/video/display.h
+++ b/include/video/display.h
@@ -70,6 +70,7 @@ enum display_entity_stream_state {
 enum display_entity_interface_type {
 	DISPLAY_ENTITY_INTERFACE_DPI,
 	DISPLAY_ENTITY_INTERFACE_DBI,
+	DISPLAY_ENTITY_INTERFACE_DSI,
 };
=20
 struct display_entity_interface_params {
diff --git a/include/video/mipi-dsi-bus.h b/include/video/mipi-dsi-bus.h
new file mode 100644
index 0000000..3efcb39
--- /dev/null
+++ b/include/video/mipi-dsi-bus.h
@@ -0,0 +1,98 @@
+/*
+ * MIPI DSI Bus
+ *
+ * Copyright (C) 2012 Samsung Electronics Co., Ltd.
+ * Contacts: Tomasz Figa <t.figa@samsung.com>
+ *
+ * Heavily based ond mipi-dbi-bus.h.
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
+
+struct mipi_dsi_bus;
+struct mipi_dsi_device;
+
+struct mipi_dsi_bus_ops {
+	int (*write_command)(struct mipi_dsi_bus *bus,
+				struct mipi_dsi_device *dev, unsigned int cmd,
+				const unsigned char *buf, unsigned int len);
+	int (*read_command)(struct mipi_dsi_bus *bus,
+				struct mipi_dsi_device *dev, unsigned int cmd,
+				unsigned int addr, unsigned char *buf,
+				unsigned int len);
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
+	const char *name;
+	int id;
+	struct device dev;
+
+	const struct mipi_dsi_device_id *id_entry;
+	struct mipi_dsi_bus *bus;
+};
+
+#define to_mipi_dsi_device(d)	container_of(d, struct mipi_dsi_device,=20
dev)
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
+#define to_mipi_dsi_driver(d)	container_of(d, struct mipi_dsi_driver,=20
driver)
+
+int mipi_dsi_driver_register(struct mipi_dsi_driver *drv);
+void mipi_dsi_driver_unregister(struct mipi_dsi_driver *drv);
+
+static inline void *mipi_dsi_get_drvdata(const struct mipi_dsi_device=20
*dev)
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
+/* module_mipi_dsi_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_mipi_dsi_driver(__mipi_dsi_driver) \
+	module_driver(__mipi_dsi_driver, mipi_dsi_driver_register, \
+			mipi_dsi_driver_unregister)
+
+int mipi_dsi_write_command(struct mipi_dsi_device *dev, unsigned int cmd,
+				const unsigned char *buf, unsigned int len);
+int mipi_dsi_read_command(struct mipi_dsi_device *dev, unsigned int cmd,
+		unsigned int addr, unsigned char *buf, unsigned int len);
+
+#endif /* __MIPI_DSI_BUS__ */
--=20
1.8.0.2


