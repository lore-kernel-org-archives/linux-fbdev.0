From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Mon, 24 Sep 2012 12:45:38 +0000
Subject: [PATCH V3] video: exynos_dp: Add device tree support to DP driver
Message-Id: <1348515385-22332-1-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com
Cc: FlorianSchandinat@gmx.de, thomas.ab@samsung.com

This patch enables device tree based discovery support for DP driver.
The driver is modified to handle platform data in both the cases:
with DT and non-DT.
Documentation is also added for the DT bindings.

DP-PHY should be regarded as a seperate device node while
being passed from device tree list, and device node for
DP should contain DP-PHY as child node with property name "dp-phy"
associated with it.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 .../devicetree/bindings/video/exynos_dp.txt        |   83 ++++++++++
 drivers/video/exynos/exynos_dp_core.c              |  168 ++++++++++++++++++--
 drivers/video/exynos/exynos_dp_core.h              |    2 +
 3 files changed, 239 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt

diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
new file mode 100644
index 0000000..c27f892
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -0,0 +1,83 @@
+Exynos Displayport driver should configure the displayport interface
+based on the type of panel connected to it.
+
+We use two nodes:
+	-dptx_phy node
+	-display-port-controller node
+
+For the dp-phy initialization, we use a dptx_phy node.
+Required properties for dptx_phy:
+	-compatible:
+		Should be "samsung,dp-phy".
+	-samsung,dptx_phy_reg:
+		Base address of DP PHY register.
+	-samsung,enable_bit:
+		The bit used to enable/disable DP PHY.
+
+For the Panel initialization, we read data from display-port-controller node.
+Required properties for display-port-controller:
+	-compatible:
+		Should be "samsung,exynos5-dp".
+	-reg:
+		physical base address of the controller and length
+		of memory mapped region.
+	-interrupts:
+		Internet combiner values.
+	-interrupt-parent:
+		Address of Interrupt combiner node.
+	-dp_phy:
+		Address of dptx_phy node.
+	-samsung,color_space:
+		input video data format.
+			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
+	-samsung,dynamic_range:
+		dynamic range for input video data.
+			VESA = 0, CEA = 1
+	-samsung,ycbcr_coeff:
+		YCbCr co-efficients for input video.
+			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
+	-samsung,color_depth:
+		Bit per color component.
+			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
+	-samsung,link_rate:
+		link rates supportd by the panel.
+			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
+	-samsung,lane_count:
+		number of lanes supported by the panel.
+			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
+	-samsung,interlaced:
+		Interlace scan mode.
+			Progressive if defined, Interlaced if not defined
+	-samsung,v_sync_polarity:
+		VSYNC polarity configuration.
+			High if defined, Low if not defined
+	-samsung,h_sync_polarity:
+		HSYNC polarity configuration.
+			High if defined, Low if not defined
+
+Example:
+
+SOC specific portion:
+	dptx_phy: dptx_phy@0x10040720 {
+		compatible = "samsung,dp-phy";
+		samsung,dptx_phy_reg = <0x10040720>;
+		samsung,enable_bit = <1>;
+	};
+
+	display-port-controller {
+		compatible = "samsung,exynos5-dp";
+		reg = <0x145B0000 0x10000>;
+		interrupts = <10 3>;
+		interrupt-parent = <&combiner>;
+		dp_phy = <&dptx_phy>;
+        };
+
+Board Specific portion:
+	display-port-controller {
+		samsung,color_space = <0>;
+		samsung,dynamic_range = <0>;
+		samsung,ycbcr_coeff = <0>;
+		samsung,color_depth = <1>;
+		samsung,link_rate = <0x0a>;
+		samsung,lane_count = <2>;
+	};
diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index cdc1398..bb0f10c 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <video/exynos_dp.h>
 
@@ -856,6 +857,106 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
+{
+	struct device_node *dp_node = dev->of_node;
+	struct exynos_dp_platdata *pd;
+	struct video_info *dp_video_config;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "memory allocation for pdata failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	dp_video_config = devm_kzalloc(dev,
+				sizeof(*dp_video_config), GFP_KERNEL);
+
+	if (!dp_video_config) {
+		dev_err(dev, "memory allocation for video config failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	pd->video_info = dp_video_config;
+
+	if (of_get_property(dp_node, "samsung,h-sync-polarity", NULL))
+		dp_video_config->h_sync_polarity = 1;
+
+	if (of_get_property(dp_node, "samsung,v-sync-polarity", NULL))
+		dp_video_config->v_sync_polarity = 1;
+
+	if (of_get_property(dp_node, "samsung,interlaced", NULL))
+		dp_video_config->interlaced = 1;
+
+	of_property_read_u32(dp_node, "samsung,color_space",
+				&dp_video_config->color_space);
+
+	of_property_read_u32(dp_node, "samsung,dynamic_range",
+				&dp_video_config->dynamic_range);
+
+	of_property_read_u32(dp_node, "samsung,ycbcr_coeff",
+				&dp_video_config->ycbcr_coeff);
+
+	of_property_read_u32(dp_node, "samsung,color_depth",
+				&dp_video_config->color_depth);
+
+	of_property_read_u32(dp_node, "samsung,link_rate",
+				&dp_video_config->link_rate);
+
+	of_property_read_u32(dp_node, "samsung,lane_count",
+				&dp_video_config->lane_count);
+	return pd;
+}
+
+void exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
+{
+	struct device_node *dp_phy_node;
+	const __be32 *parp;
+	u32 phy_base;
+	void *virt_phy_base;
+
+	parp = of_get_property(dp->dev->of_node, "dp_phy", NULL);
+	if (!parp) {
+		dp->dp_phy_addr = NULL;
+		return;
+	}
+
+	dp_phy_node = of_find_node_by_phandle(be32_to_cpup(parp));
+	if (!dp_phy_node) {
+		dp->dp_phy_addr = NULL;
+		return;
+	}
+
+	of_property_read_u32(dp_phy_node, "samsung,dptx_phy_reg", &phy_base);
+	of_property_read_u32(dp_phy_node, "samsung,enable_bit",
+							&dp->enable_bit);
+	virt_phy_base = ioremap(phy_base, SZ_4);
+	if (!virt_phy_base) {
+		dev_err(dp->dev, "failed to ioremap dp-phy\n");
+		dp->dp_phy_addr = NULL;
+		return;
+	}
+	dp->dp_phy_addr = virt_phy_base;
+}
+
+void exynos_dp_phy_init(struct exynos_dp_device *dp)
+{
+	u32 reg;
+
+	reg = __raw_readl(dp->dp_phy_addr);
+	reg |= dp->enable_bit;
+	__raw_writel(reg, dp->dp_phy_addr);
+}
+
+void exynos_dp_phy_exit(struct exynos_dp_device *dp)
+{
+	u32 reg;
+
+	reg = __raw_readl(dp->dp_phy_addr);
+	reg &= ~(dp->enable_bit);
+	__raw_writel(reg, dp->dp_phy_addr);
+}
+#endif /* CONFIG_OF */
+
 static int __devinit exynos_dp_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -864,12 +965,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 
 	int ret = 0;
 
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
 	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
 				GFP_KERNEL);
 	if (!dp) {
@@ -879,6 +974,21 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 
 	dp->dev = &pdev->dev;
 
+	if (pdev->dev.of_node) {
+		pdata = exynos_dp_dt_parse_pdata(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+
+		exynos_dp_dt_parse_phydata(dp);
+	} else {
+		pdata = pdev->dev.platform_data;
+	}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -EINVAL;
+	}
+
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
@@ -909,8 +1019,14 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	}
 
 	dp->video_info = pdata->video_info;
-	if (pdata->phy_init)
-		pdata->phy_init();
+
+	if (pdev->dev.of_node) {
+		if (dp->dp_phy_addr)
+			exynos_dp_phy_init(dp);
+	} else {
+		if (pdata->phy_init)
+			pdata->phy_init();
+	}
 
 	exynos_dp_init_dp(dp);
 
@@ -953,8 +1069,13 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit();
+	if (pdev->dev.of_node) {
+		if (dp->dp_phy_addr)
+			exynos_dp_phy_exit(dp);
+	} else {
+		if (pdata && pdata->phy_exit)
+			pdata->phy_exit();
+	}
 
 	clk_disable(dp->clock);
 
@@ -968,8 +1089,13 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit();
+	if (dev->of_node) {
+		if (dp->dp_phy_addr)
+			exynos_dp_phy_exit(dp);
+	} else {
+		if (pdata && pdata->phy_exit)
+			pdata->phy_exit();
+	}
 
 	clk_disable(dp->clock);
 
@@ -982,8 +1108,13 @@ static int exynos_dp_resume(struct device *dev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
-	if (pdata && pdata->phy_init)
-		pdata->phy_init();
+	if (dev->of_node) {
+		if (dp->dp_phy_addr)
+			exynos_dp_phy_init(dp);
+	} else {
+		if (pdata && pdata->phy_init)
+			pdata->phy_init();
+	}
 
 	clk_enable(dp->clock);
 
@@ -1013,6 +1144,14 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_dp_suspend, exynos_dp_resume)
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos_dp_match[] = {
+	{ .compatible = "samsung,exynos5-dp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_dp_match);
+#endif
+
 static struct platform_driver exynos_dp_driver = {
 	.probe		= exynos_dp_probe,
 	.remove		= __devexit_p(exynos_dp_remove),
@@ -1020,6 +1159,7 @@ static struct platform_driver exynos_dp_driver = {
 		.name	= "exynos-dp",
 		.owner	= THIS_MODULE,
 		.pm	= &exynos_dp_pm_ops,
+		.of_match_table = of_match_ptr(exynos_dp_match),
 	},
 };
 
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 57b8a65..c9f8c97 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -29,6 +29,8 @@ struct exynos_dp_device {
 	struct clk		*clock;
 	unsigned int		irq;
 	void __iomem		*reg_base;
+	void __iomem		*dp_phy_addr;
+	unsigned int		enable_bit;
 
 	struct video_info	*video_info;
 	struct link_train	link_train;
-- 
1.7.0.4

