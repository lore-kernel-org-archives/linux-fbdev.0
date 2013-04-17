From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:21 +0000
Subject: [RFC 09/10] video: Versatile Express DVI mode driver
Message-Id: <1366211842-21497-10-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

Versatile Express DVI output is driven by a Sii9022 chip. It can be
controller to a limited extend by the Motherboard Config Controller,
and that's what the driver is doing now. It is a temporary measure
till there's a full I2C driver for the chip.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/video/Makefile           |    1 +
 drivers/video/vexpress-dvimode.c |  158 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 drivers/video/vexpress-dvimode.c

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 84c6083..9347e00 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -179,3 +179,4 @@ obj-$(CONFIG_OF_VIDEOMODE) += of_videomode.o
 
 # platform specific output drivers
 obj-$(CONFIG_VEXPRESS_CONFIG)	  += vexpress-muxfpga.o
+obj-$(CONFIG_VEXPRESS_CONFIG)	  += vexpress-dvimode.o
diff --git a/drivers/video/vexpress-dvimode.c b/drivers/video/vexpress-dvimode.c
new file mode 100644
index 0000000..85d5608
--- /dev/null
+++ b/drivers/video/vexpress-dvimode.c
@@ -0,0 +1,158 @@
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
+#define pr_fmt(fmt) "vexpress-dvimode: " fmt
+
+#include <linux/fb.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/vexpress.h>
+#include <video/display.h>
+#include <video/videomode.h>
+
+
+static struct vexpress_config_func *vexpress_dvimode_func;
+
+
+static int vexpress_dvimode_display_update(struct display_entity *display,
+		const struct videomode *mode)
+{
+	static const struct {
+		u32 hactive, vactive, dvimode;
+	} dvimodes[] = {
+		{ 640, 480, 0 }, /* VGA */
+		{ 800, 600, 1 }, /* SVGA */
+		{ 1024, 768, 2 }, /* XGA */
+		{ 1280, 1024, 3 }, /* SXGA */
+		{ 1600, 1200, 4 }, /* UXGA */
+		{ 1920, 1080, 5 }, /* HD1080 */
+	};
+	int err = -ENOENT;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dvimodes); i++) {
+		if (dvimodes[i].hactive == mode->hactive &&
+				dvimodes[i].vactive == mode->vactive) {
+			pr_debug("mode: %ux%u = %d\n", mode->hactive,
+					mode->vactive, dvimodes[i].dvimode);
+			err = vexpress_config_write(vexpress_dvimode_func, 0,
+					dvimodes[i].dvimode);
+			break;
+		}
+	}
+
+	if (err)
+		pr_warn("Failed to set %ux%u mode! (%d)\n", mode->hactive,
+				mode->vactive, err);
+
+	return err;
+}
+
+static int vexpress_dvimode_display_get_modes(struct display_entity *display,
+		const struct videomode **modes)
+{
+	static const struct videomode m[] = {
+		{
+			/* VGA */
+			.pixelclock	= 25175000,
+			.hactive	= 640,
+			.hback_porch	= 40,
+			.hfront_porch	= 24,
+			.vfront_porch	= 11,
+			.hsync_len	= 96,
+			.vactive	= 480,
+			.vback_porch	= 32,
+			.vsync_len	= 2,
+		}, {
+			/* XGA */
+			.pixelclock	= 63500127,
+			.hactive	= 1024,
+			.hback_porch	= 152,
+			.hfront_porch	= 48,
+			.hsync_len	= 104,
+			.vactive	= 768,
+			.vback_porch	= 23,
+			.vfront_porch	= 3,
+			.vsync_len	= 4,
+		}, {
+			/* SXGA */
+			.pixelclock	= 108000000,
+			.hactive	= 1280,
+			.hback_porch	= 248,
+			.hfront_porch	= 48,
+			.hsync_len	= 112,
+			.vactive	= 1024,
+			.vback_porch	= 38,
+			.vfront_porch	= 1,
+			.vsync_len	= 3,
+		},
+	};
+
+	*modes = m;
+
+	return ARRAY_SIZE(m);
+}
+
+static int vexpress_dvimode_display_get_params(struct display_entity *display,
+		struct display_entity_interface_params *params)
+{
+	params->type = DISPLAY_ENTITY_INTERFACE_TFT_PARALLEL;
+	params->p.tft_parallel.r_bits = 8;
+	params->p.tft_parallel.g_bits = 8;
+	params->p.tft_parallel.b_bits = 8;
+	params->p.tft_parallel.r_b_swapped = 0;
+
+	return 0;
+}
+
+static const struct display_entity_control_ops vexpress_dvimode_display_ops = {
+	.update = vexpress_dvimode_display_update,
+	.get_modes = vexpress_dvimode_display_get_modes,
+	.get_params = vexpress_dvimode_display_get_params,
+};
+
+static struct display_entity vexpress_dvimode_display = {
+	.ops.ctrl = &vexpress_dvimode_display_ops,
+};
+
+static struct of_device_id vexpress_dvimode_of_match[] = {
+	{ .compatible = "arm,vexpress-dvimode", },
+	{}
+};
+
+static int vexpress_dvimode_probe(struct platform_device *pdev)
+{
+	vexpress_dvimode_func = vexpress_config_func_get_by_dev(&pdev->dev);
+
+	vexpress_dvimode_display.dev = &pdev->dev;
+	display_entity_register(&vexpress_dvimode_display);
+	of_display_entity_add_provider(pdev->dev.of_node,
+			of_display_entity_provider_simple_get,
+			&vexpress_dvimode_display);
+
+	return 0;
+}
+
+static struct platform_driver vexpress_dvimode_driver = {
+	.probe = vexpress_dvimode_probe,
+	.driver = {
+		.name = "vexpress-dvimode",
+		.of_match_table = vexpress_dvimode_of_match,
+	},
+};
+
+static int __init vexpress_dvimode_init(void)
+{
+	return platform_driver_register(&vexpress_dvimode_driver);
+}
+device_initcall(vexpress_dvimode_init);
-- 
1.7.10.4


