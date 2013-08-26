From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 26 Aug 2013 08:56:32 +0000
Subject: [PATCH 1/3] phy: Add driver for Exynos DP PHY
Message-Id: <004001cea23a$29580400$7c080c00$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003e01cea23a$03aac850$0b0058f0$%han@samsung.com>
In-Reply-To: <003e01cea23a$03aac850$0b0058f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, 'devicetree' <devicetree@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Felipe Balbi' <balbi@ti.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add a PHY provider driver for the Samsung Exynos SoC Display Port PHY.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt        |    7 ++
 drivers/phy/Kconfig                                |    7 ++
 drivers/phy/Makefile                               |    7 +-
 drivers/phy/phy-exynos-dp-video.c                  |  111 ++++++++++++++++++++
 4 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung-phy.txt
 create mode 100644 drivers/phy/phy-exynos-dp-video.c

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
new file mode 100644
index 0000000..ee262238
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -0,0 +1,7 @@
+Samsung EXYNOS SoC series Display Port PHY
+-------------------------------------------------
+
+Required properties:
+- compatible : should be "samsung,exynos5250-dp-video-phy";
+- reg : offset and length of the Display Port PHY register set;
+- #phy-cells : from the generic PHY bindings, must be 0;
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index ac239ac..fed26a0 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -38,4 +38,11 @@ config TWL4030_USB
 	  This transceiver supports high and full speed devices plus,
 	  in host mode, low speed.
 
+config PHY_EXYNOS_DP_VIDEO
+	tristate "EXYNOS SoC series Display Port PHY driver"
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0dd8a98..433e685 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the phy drivers.
 #
 
-obj-$(CONFIG_GENERIC_PHY)	+= phy-core.o
-obj-$(CONFIG_OMAP_USB2)		+= phy-omap-usb2.o
-obj-$(CONFIG_TWL4030_USB)	+= phy-twl4030-usb.o
+obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
+obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
+obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
diff --git a/drivers/phy/phy-exynos-dp-video.c b/drivers/phy/phy-exynos-dp-video.c
new file mode 100644
index 0000000..1dbe6ce
--- /dev/null
+++ b/drivers/phy/phy-exynos-dp-video.c
@@ -0,0 +1,111 @@
+/*
+ * Samsung EXYNOS SoC series Display Port PHY driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* DPTX_PHY_CONTROL register */
+#define EXYNOS_DPTX_PHY_ENABLE		(1 << 0)
+
+struct exynos_dp_video_phy {
+	void __iomem *regs;
+};
+
+static int __set_phy_state(struct exynos_dp_video_phy *state, unsigned int on)
+{
+	u32 reg;
+
+	reg = readl(state->regs);
+	if (on)
+		reg |= EXYNOS_DPTX_PHY_ENABLE;
+	else
+		reg &= ~EXYNOS_DPTX_PHY_ENABLE;
+	writel(reg, state->regs);
+
+	return 0;
+}
+
+static int exynos_dp_video_phy_power_on(struct phy *phy)
+{
+	struct exynos_dp_video_phy *state = phy_get_drvdata(phy);
+
+	return __set_phy_state(state, 1);
+}
+
+static int exynos_dp_video_phy_power_off(struct phy *phy)
+{
+	struct exynos_dp_video_phy *state = phy_get_drvdata(phy);
+
+	return __set_phy_state(state, 0);
+}
+
+static struct phy_ops exynos_dp_video_phy_ops = {
+	.power_on	= exynos_dp_video_phy_power_on,
+	.power_off	= exynos_dp_video_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int exynos_dp_video_phy_probe(struct platform_device *pdev)
+{
+	struct exynos_dp_video_phy *state;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+
+	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	state->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(state->regs))
+		return PTR_ERR(state->regs);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	phy = devm_phy_create(dev, &exynos_dp_video_phy_ops, NULL);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create Display Port PHY\n");
+		return PTR_ERR(phy);
+	}
+	phy_set_drvdata(phy, state);
+
+	return 0;
+}
+
+static const struct of_device_id exynos_dp_video_phy_of_match[] = {
+	{ .compatible = "samsung,exynos5250-dp-video-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, exynos_dp_video_phy_of_match);
+
+static struct platform_driver exynos_dp_video_phy_driver = {
+	.probe	= exynos_dp_video_phy_probe,
+	.driver = {
+		.name	= "exynos-dp-video-phy",
+		.owner	= THIS_MODULE,
+		.of_match_table	= exynos_dp_video_phy_of_match,
+	}
+};
+module_platform_driver(exynos_dp_video_phy_driver);
+
+MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
+MODULE_DESCRIPTION("Samsung EXYNOS SoC DP PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4


