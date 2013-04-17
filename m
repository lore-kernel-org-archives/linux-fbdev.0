From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:20 +0000
Subject: [RFC 08/10] video: Versatile Express MUXFPGA driver
Message-Id: <1366211842-21497-9-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

Versatile Express' DVI video output can be connected to one the three
sources - motherboard's CLCD controller or a video signal generated
by one of the daughterboards.

This driver provides a Common Display Framework driver for the
muxer FPGA, which acts as a switch selecting one of the video data
sources. The default source is selected basing on the priority
list (which itself can be modified via module paramter), but
the user can make his own decision about it using the device's
sysfs "source" attribute.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 .../testing/sysfs-driver-video-vexpress-muxfpga    |    5 +
 drivers/video/Makefile                             |    3 +
 drivers/video/vexpress-muxfpga.c                   |  228 ++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-video-vexpress-muxfpga
 create mode 100644 drivers/video/vexpress-muxfpga.c

diff --git a/Documentation/ABI/testing/sysfs-driver-video-vexpress-muxfpga b/Documentation/ABI/testing/sysfs-driver-video-vexpress-muxfpga
new file mode 100644
index 0000000..bfd568d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-video-vexpress-muxfpga
@@ -0,0 +1,5 @@
+What:		/sys/bus/platform/drivers/vexpress-muxfpga/<muxfpga device>/source
+Date:		April 2013
+Contant:	Pawel Moll <pawel.moll@arm.com>
+Description:	This file stores the id of the video signal source
+		supposed to be routed to the board's DVI output.
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index b989e8e..84c6083 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -176,3 +176,6 @@ obj-$(CONFIG_DISPLAY_TIMING) += display_timing.o
 obj-$(CONFIG_OF_DISPLAY_TIMING) += of_display_timing.o
 obj-$(CONFIG_VIDEOMODE) += videomode.o
 obj-$(CONFIG_OF_VIDEOMODE) += of_videomode.o
+
+# platform specific output drivers
+obj-$(CONFIG_VEXPRESS_CONFIG)	  += vexpress-muxfpga.o
diff --git a/drivers/video/vexpress-muxfpga.c b/drivers/video/vexpress-muxfpga.c
new file mode 100644
index 0000000..1731ad0
--- /dev/null
+++ b/drivers/video/vexpress-muxfpga.c
@@ -0,0 +1,228 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2013 ARM Limited
+ */
+
+#define pr_fmt(fmt) "vexpress-muxfpga: " fmt
+
+#include <linux/fb.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/vexpress.h>
+#include <video/display.h>
+#include <video/videomode.h>
+
+
+static struct vexpress_config_func *vexpress_muxfpga_func;
+static struct display_entity *vexpress_muxfpga_output;
+
+
+static struct vexpress_muxfpga_source {
+	struct display_entity display;
+	struct videomode mode;
+	bool updated;
+} vexpress_muxfpga_sources[__VEXPRESS_SITE_LAST];
+static u32 vexpress_muxfpga_source_site = VEXPRESS_SITE_MB;
+static bool vexpress_muxfpga_source_stored;
+
+
+static int vexpress_muxfpga_set_site(u32 site)
+{
+	int err;
+
+	if (site >= ARRAY_SIZE(vexpress_muxfpga_sources))
+		return -EINVAL;
+
+	err = vexpress_config_write(vexpress_muxfpga_func, 0, site);
+	if (!err) {
+		pr_debug("Selected site %d as source\n", site);
+		vexpress_muxfpga_source_site = site;
+	} else {
+		pr_warn("Failed to select site %d as source! (%d)\n",
+				site, err);
+	}
+
+	return err;
+}
+
+static unsigned int vexpress_muxfpga_preferred_sites[] = {
+	VEXPRESS_SITE_MASTER,
+	VEXPRESS_SITE_DB1,
+	VEXPRESS_SITE_DB2,
+	VEXPRESS_SITE_MB,
+};
+static unsigned int vexpress_muxfpga_preferred_sites_num =
+		ARRAY_SIZE(vexpress_muxfpga_preferred_sites);
+module_param_array_named(preferred_sites, vexpress_muxfpga_preferred_sites,
+		uint, &vexpress_muxfpga_preferred_sites_num, S_IRUGO);
+MODULE_PARM_DESC(preferred_sites, "Preferred order of MUXFPGA (DVI output) "
+		"sources; values can be a daughterboard site ID (1-2), the "
+		"motherboard ID (0) or a value describing the master site "
+		"(0xf).");
+
+static int vexpress_muxfpga_get_priority(u32 site)
+{
+	int i;
+
+	for (i = 0; i < vexpress_muxfpga_preferred_sites_num; i++) {
+		u32 preference = vexpress_muxfpga_preferred_sites[i];
+
+		if (site == vexpress_get_site(preference))
+			return i;
+	}
+
+	return INT_MAX;
+}
+
+static void vexpress_muxfpga_set_preffered_site(u32 site)
+{
+	int current_priority = vexpress_muxfpga_get_priority(
+			vexpress_muxfpga_source_site);
+	int new_priority = vexpress_muxfpga_get_priority(site);
+
+	if (new_priority <= current_priority)
+		vexpress_muxfpga_set_site(site);
+}
+
+
+static int vexpress_muxfpga_display_update(struct display_entity *display,
+		const struct videomode *mode)
+{
+	int err = display_entity_update(vexpress_muxfpga_output, mode);
+
+	if (!err) {
+		struct vexpress_muxfpga_source *source = container_of(display,
+				struct vexpress_muxfpga_source, display);
+
+		source->updated = true;
+		source->mode = *mode;
+	}
+
+	return err;
+}
+
+static int vexpress_muxfpga_display_get_modes(struct display_entity *display,
+		const struct videomode **modes)
+{
+	return display_entity_get_modes(vexpress_muxfpga_output, modes);
+}
+
+static int vexpress_muxfpga_display_get_params(struct display_entity *display,
+		struct display_entity_interface_params *params)
+{
+	return display_entity_get_params(vexpress_muxfpga_output, params);
+}
+
+static const struct display_entity_control_ops vexpress_muxfpga_display_ops = {
+	.update = vexpress_muxfpga_display_update,
+	.get_modes = vexpress_muxfpga_display_get_modes,
+	.get_params = vexpress_muxfpga_display_get_params,
+};
+
+
+static ssize_t vexpress_muxfpga_show_source(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+
+	return sprintf(buf, "%u\n", vexpress_muxfpga_source_site);
+}
+
+static ssize_t vexpress_muxfpga_store_source(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	u32 site;
+	int err = kstrtou32(buf, 0, &site);
+
+	if (!err) {
+		site = vexpress_get_site(site);
+		err = vexpress_muxfpga_set_site(site);
+	}
+
+	if (!err)
+		vexpress_muxfpga_source_stored = true;
+
+	if (!err && vexpress_muxfpga_sources[site].updated)
+		vexpress_muxfpga_display_update(
+				&vexpress_muxfpga_sources[site].display,
+				&vexpress_muxfpga_sources[site].mode);
+
+	return err ? err : count;
+}
+
+DEVICE_ATTR(source, S_IRUGO | S_IWUSR, vexpress_muxfpga_show_source,
+		vexpress_muxfpga_store_source);
+
+static struct display_entity *vexpress_muxfpga_display_get(
+		struct of_phandle_args *spec, void *data)
+{
+	u32 site = vexpress_get_site(spec->args[0]);
+
+	if (WARN_ON(spec->args_count != 1 ||
+			site >= ARRAY_SIZE(vexpress_muxfpga_sources)))
+		return NULL;
+
+	/* Skip source selection if the user made his choice */
+	if (!vexpress_muxfpga_source_stored)
+		vexpress_muxfpga_set_preffered_site(site);
+
+	return &vexpress_muxfpga_sources[site].display;
+}
+
+
+static struct of_device_id vexpress_muxfpga_of_match[] = {
+	{ .compatible = "arm,vexpress-muxfpga", },
+	{}
+};
+
+static int vexpress_muxfpga_probe(struct platform_device *pdev)
+{
+	struct display_entity_interface_params params;
+	int i;
+
+	vexpress_muxfpga_output = of_display_entity_get(pdev->dev.of_node, 0);
+	if (!vexpress_muxfpga_output)
+		return -EPROBE_DEFER;
+
+	if (display_entity_get_params(vexpress_muxfpga_output, &params) != 0 ||
+			params.type != DISPLAY_ENTITY_INTERFACE_TFT_PARALLEL)
+		return -EINVAL;
+
+	vexpress_muxfpga_func = vexpress_config_func_get_by_dev(&pdev->dev);
+
+	for (i = 0; i < ARRAY_SIZE(vexpress_muxfpga_sources); i++) {
+		struct vexpress_muxfpga_source *source =
+			&vexpress_muxfpga_sources[i];
+
+		source->display.dev = &pdev->dev;
+		source->display.ops.ctrl = &vexpress_muxfpga_display_ops;
+		WARN_ON(display_entity_register(&source->display));
+		of_display_entity_add_provider(pdev->dev.of_node,
+				vexpress_muxfpga_display_get, NULL);
+	}
+
+	device_create_file(&pdev->dev, &dev_attr_source);
+
+	return 0;
+}
+
+static struct platform_driver vexpress_muxfpga_driver = {
+	.probe = vexpress_muxfpga_probe,
+	.driver = {
+		.name = "vexpress-muxfpga",
+		.of_match_table = vexpress_muxfpga_of_match,
+	},
+};
+
+static int __init vexpress_muxfpga_init(void)
+{
+	return platform_driver_register(&vexpress_muxfpga_driver);
+}
+device_initcall(vexpress_muxfpga_init);
-- 
1.7.10.4


