From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Date: Sat, 10 Nov 2012 11:46:45 +0000
Subject: [PATCH 2/2] video: exynos-mipi-dsi: Adding DT support to exynos mipi driver
Message-Id: <1352547285-12302-3-git-send-email-shaik.ameer@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds the DT support for the exynos mipi-dsi driver.
for DT support mipi device node should supply the following
information to the mipi-dsi driver.
1] dsim_config information
2] d-phy setting information
3] lcd poweron, reset information
4] fb_videomode information

Change-Id: I93005636a7825b0c5ef4832dd17a2809d0aeda1d
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 .../devicetree/bindings/video/exynos/mipi-dsi.txt  |  185 +++++++
 drivers/video/exynos/exynos_mipi_dsi.c             |  573 +++++++++++++++++++-
 include/video/exynos_mipi_dsim.h                   |   27 +
 3 files changed, 765 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos/mipi-dsi.txt

diff --git a/Documentation/devicetree/bindings/video/exynos/mipi-dsi.txt b/Documentation/devicetree/bindings/video/exynos/mipi-dsi.txt
new file mode 100644
index 0000000..6445eac
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/exynos/mipi-dsi.txt
@@ -0,0 +1,185 @@
+* Samsung Exynos MIPI-DSI bindings
+
+Properties for MIPI-DSI node ::
+===============+- compatible: should be "samsung,exynos5-mipi"
+
+- reg: should contain mipi-dsi physical address location and length.
+
+- interrupts: should contain mipi-dsi interrupt number
+
+- enabled: Describes whether MIPI DSI got enabled in uboot
+
+- mipi-lcd: phandle to lcd specific information. It can be anything
+	specific to lcd driver.
+
+- mipi-phy: phandle to D-PHY node.
+
+- mipi-config: subnode for mipi config information
+	- auto_flush: enable or disable Auto flush of MD FIFO using VSYNC pulse
+	- eot_disable: enable or disable EoT packet in HS mode
+	- auto_vertical_cnt: specifies auto vertical count mode.
+		In Video mode, the vertical line transition uses line counter
+		configured by VSA, VBP, and Vertical resolution. If this bit is
+		set to '1', the line counter does not use VSA and VBP registers.
+		In command mode, this property is ignored.
+	- hse: set horizontal sync event mode.
+		In VSYNC pulse and Vporch area,	MIPI DSI master transfers only
+		HSYNC start packet to MIPI DSI slave at MIPI DSI spec1.1r02.
+		This bit transfers HSYNC end packet in VSYNC pulse and Vporch
+		area. In command mode, this property is ignored.
+	- hfp: specifies HFP disable mode.
+		If this property is set, DSI master ignores HFP area in
+		VIDEO mode. In command mode, this property is ignored.
+	- hbp: specifies HBP disable mode.
+		If this property is set, DSI master ignores HBP area in
+		VIDEO mode. In command mode, this property is ignored.
+	- hsa: specifies HSA disable mode.
+		If this property is set, DSI master ignores HSA area in
+		VIDEO mode. In command mode, this property is ignored.
+	- cmd_allow: specifies the number of horizontal lines, where command
+		packet transmission is allowed after Stable VFP period.
+	- e_interface: specifies interface to be used.(CPU or RGB interface)
+	- e_virtual_ch: specifies virtual channel number that main or
+		sub display uses.
+	- e_pixel_format: specifies pixel stream format for main or sub display.
+	- e_burst_mode: selects Burst mode in Video mode.
+		In Non-burst mode, RGB data area is filled with RGB data
+		and NULL packets, according to input bandwidth of RGB interface.
+		In Burst mode, RGB data area is filled with RGB data only.
+	- e_no_data_lane: specifies data lane count to be used by Master.
+	- e_byte_clk: select byte clock source. (it must be DSIM_PLL_OUT_DIV8)
+		DSIM_EXT_CLK_DIV8 and DSIM_EXT_CLK_BYPASSS are not supported.
+	- pll_stable_time: specifies the PLL Timer for stability of the
+		generated clock(System clock cycle base). If the timer value
+		goes to 0x00000000, the clock stable bit of status and interrupt
+		register is set.
+	- esc_clk: specifies escape clock frequency for getting the escape clock
+		prescaler value.
+	- stop_holding_cnt: specifies the interval value between transmitting
+		read packet(or write "set_tear_on" command) and BTA request.
+		after transmitting read packet or write "set_tear_on" command,
+		BTA requests to D-PHY automatically. this counter value
+		specifies the interval between them.
+	- bta_timeout: specifies the timer for BTA.
+		this register specifies time out from BTA request to change
+		the direction with respect to Tx escape clock.
+	- rx_timeout: specifies the timer for LP Rx mode timeout.
+		this register specifies time out on how long RxValid deasserts,
+		after RxLpdt asserts with respect to Tx escape clock.
+		- RxValid specifies Rx data valid indicator.
+		- RxLpdt specifies an indicator that D-PHY is under RxLpdt mode.
+		- RxValid and RxLpdt specifies signal from D-PHY.
+
+- display-mode: timing and resolution information of the panel used. As per
+	current exynos mipi-dsi driver need, only some fields from
+	struct fb_videomode are defined in this node.
+	- xres: horizontal resolution (active frame width)
+	- yres: vertical resolution (active frame height).
+	- left_margin: Horizontal Back Porch (Number of PIXCLK pulses between
+		HSYNC signal and the first valid pixel data.
+	- right_margin: Horizontal Front Porch (Number of PIXCLK between
+		last valid pixel data in the line and the next HSYNC pulse).
+	- upper_margin: Vertical Back Porch (Number of lines (HSYNC pulses)
+		from when a VSYNC signal is asserted and the first valid line).
+	- lower_margin: Vertical Front Porch (Number of lines (HSYNC pulses)
+		between last valid line of the frame and the next VSYNC Pulse).
+	- hsync_len: Hsync pulse width (Number of PIXCLK pulses when a HSYNC
+		signal is active).
+	- vsync_len: Vsync pulse width (Number of HSYNC pulses when a VSYNC
+		signal is active).
+
+Properties for D-PHY node ::
+==============+	Instead of passing D-PHY related callbacks as part of platform data,
+we can pass the phy nodes to the mipi driver. Depending on the type of PHY
+settings, we can implement multiple PHY node types and corresponding
+enable/disable/reset callbacks in the driver itself. Currently we support
+only one type of PHY node.
+
+D-PHY node type1:
+------------------
+- compatible: "samsung,exynos-mipi-phy-type1"
+- reg_enable_dphy: should contain physical address location of
+	D-PHY enable register
+- mask_enable_dphy: should contain the mask for D-PHY enable register
+- reg_reset_dsim: should contain physical address location of
+	D-PHY DSIM reset register
+- mask_reset_dsim: should contain the mask for D-PHY DSIM reset register
+
+MIPI-LCD node ::
+========+	Apart from the following three properties, driver specific
+properties can be sent through this node. The following example sends
+some more properties for driver's use.
+
+- lcd-name: name of the device to use with this device
+- id: id of device to be registered (default -1 in case not specified)
+- bus-id: bus id for identifing connected bus and this bus id should be
+	same as id of mipi_dsim_device (default -1 incase not specified)
+
+Example:
+--------
+	mipi_lcd: mipi-lcd@toshiba {
+		lcd-name = "tc358764";
+		id = <0>;
+		enabled = <1>;
+		reset-delay = <120>;
+		power-on-delay = <25>;
+		power-off-delay = <200>;
+		gpio-poweron = <&gpx1 5 0 0 0>;
+	};
+
+	mipi_dsim_phy: mipi-phy@exynos5250 {
+		compatible = "samsung-exynos,mipi-phy-type1";
+		reg_enable_dphy = <0x10040714>;
+		mask_enable_dphy = <0x00000001>;
+		reg_reset_dsim = <0x10040714>;
+		mask_reset_dsim = <0x00000004>;
+	};
+
+	mipi {
+		compatible = "samsung,exynos-mipi";
+		reg = <0x14500000 0x10000>;
+		interrupts = <0 82 0>;
+
+		mipi-lcd = <&mipi_lcd>;
+		mipi-phy = <&mipi_dsim_phy>;
+		enabled = <0>;
+
+		mipi-config {
+			e_interface = <1>;
+			e_pixel_format = <7>;
+			auto_flush = <0>;
+			eot_disable = <0>;
+			auto_vertical_cnt = <0>;
+			hse = <0>;
+			hfp = <0>;
+			hbp = <0>;
+			hsa = <0>;
+			e_no_data_lane = <3>;
+			e_byte_clk = <0>;
+			e_burst_mode = <3>;
+			p = <3>;
+			m = <115>;
+			s = <1>;
+			pll_stable_time = <500>;
+			esc_clk = <400000>;
+			stop_holding_cnt =<0x0f>;
+			bta_timeout = <0xff>;
+			rx_timeout = <0xffff>;
+			e_virtual_ch = <0>;
+			cmd_allow = <0xf>;
+		};
+
+		panel-info {
+			left_margin = <0x4>;
+			right_margin = <0x4>;
+			upper_margin = <0x4>;
+			lower_margin = <0x4>;
+			hsync_len = <0x4>;
+			vsync_len = <0x4>;
+			xres = <1280>;
+			yres = <800>;
+		};
+	};
diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index ae20bc3..667857b 100755
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -32,6 +32,7 @@
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/lcd.h>
 
 #include <video/exynos_mipi_dsim.h>
 
@@ -43,6 +44,8 @@
 struct mipi_dsim_ddi {
 	int				bus_id;
 	struct list_head		list;
+	struct device_node		*ofnode_dsim_lcd_dev;
+	struct device_node		*ofnode_dsim_dphy;
 	struct mipi_dsim_lcd_device	*dsim_lcd_dev;
 	struct mipi_dsim_lcd_driver	*dsim_lcd_drv;
 };
@@ -181,6 +184,36 @@ static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
 	return 0;
 }
 
+struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_driver(
+			struct mipi_dsim_lcd_device *lcd_dev)
+{
+	struct mipi_dsim_ddi *dsim_ddi, *next;
+	struct mipi_dsim_lcd_driver *lcd_drv;
+
+	mutex_lock(&mipi_dsim_lock);
+
+	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
+		if (!dsim_ddi)
+			goto out;
+
+		lcd_drv = dsim_ddi->dsim_lcd_drv;
+		if (!lcd_drv)
+			continue;
+
+		if ((strcmp(lcd_dev->name, lcd_drv->name)) = 0) {
+			mutex_unlock(&mipi_dsim_lock);
+			return dsim_ddi;
+		}
+
+		list_del(&dsim_ddi->list);
+		kfree(dsim_ddi);
+	}
+
+out:
+	mutex_unlock(&mipi_dsim_lock);
+	return NULL;
+}
+
 int exynos_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device *lcd_dev)
 {
 	struct mipi_dsim_ddi *dsim_ddi;
@@ -190,13 +223,17 @@ int exynos_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device *lcd_dev)
 		return -EFAULT;
 	}
 
-	dsim_ddi = kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
+	dsim_ddi = exynos_mipi_dsi_find_lcd_driver(lcd_dev);
 	if (!dsim_ddi) {
-		pr_err("failed to allocate dsim_ddi object.\n");
-		return -ENOMEM;
+		dsim_ddi = kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
+		if (!dsim_ddi) {
+			pr_err("failed to allocate dsim_ddi object.\n");
+			return -ENOMEM;
+		}
 	}
 
 	dsim_ddi->dsim_lcd_dev = lcd_dev;
+	dsim_ddi->bus_id = lcd_dev->bus_id;
 
 	mutex_lock(&mipi_dsim_lock);
 	list_add_tail(&dsim_ddi->list, &dsim_ddi_list);
@@ -253,11 +290,26 @@ int exynos_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
 
 	dsim_ddi = exynos_mipi_dsi_find_lcd_device(lcd_drv);
 	if (!dsim_ddi) {
-		pr_err("mipi_dsim_ddi object not found.\n");
-		return -EFAULT;
-	}
+		/*
+		 * If driver specific device is not registered then create a
+		 * dsim_ddi object, fill the driver information and add to the
+		 * end of the dsim_ddi_list list
+		 */
+		dsim_ddi = kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
+		if (!dsim_ddi) {
+			pr_err("failed to allocate dsim_ddi object.\n");
+			return -ENOMEM;
+		}
+
+		dsim_ddi->dsim_lcd_drv = lcd_drv;
 
-	dsim_ddi->dsim_lcd_drv = lcd_drv;
+		mutex_lock(&mipi_dsim_lock);
+		list_add_tail(&dsim_ddi->list, &dsim_ddi_list);
+		mutex_unlock(&mipi_dsim_lock);
+
+	} else {
+		dsim_ddi->dsim_lcd_drv = lcd_drv;
+	}
 
 	pr_info("registered panel driver(%s) to mipi-dsi driver.\n",
 		lcd_drv->name);
@@ -329,6 +381,372 @@ static struct mipi_dsim_master_ops master_ops = {
 	.set_blank_mode			= exynos_mipi_dsi_blank_mode,
 };
 
+struct device_node *exynos_mipi_find_ofnode_dsim_phy(
+				struct platform_device *pdev)
+{
+	struct device_node *dn, *dn_dphy;
+	const __be32 *prop;
+
+	dn = pdev->dev.of_node;
+	prop = of_get_property(dn, "mipi-phy", NULL);
+	if (NULL = prop) {
+		dev_err(&pdev->dev, "Could not find property mipi-phy\n");
+		return NULL;
+	}
+
+	dn_dphy = of_find_node_by_phandle(be32_to_cpup(prop));
+	if (NULL = dn_dphy) {
+		dev_err(&pdev->dev, "Could not find node\n");
+		return NULL;
+	}
+
+	return dn_dphy;
+}
+
+struct device_node *exynos_mipi_find_ofnode_lcd_device(
+			struct platform_device *pdev)
+{
+	struct device_node *dn, *dn_lcd_panel;
+	const __be32 *prop;
+
+	dn = pdev->dev.of_node;
+	prop = of_get_property(dn, "mipi-lcd", NULL);
+	if (NULL = prop) {
+		dev_err(&pdev->dev, "could not find property mipi-lcd\n");
+		return NULL;
+	}
+
+	dn_lcd_panel = of_find_node_by_phandle(be32_to_cpup(prop));
+	if (NULL = dn_lcd_panel) {
+		dev_err(&pdev->dev, "could not find node\n");
+		return NULL;
+	}
+
+	return dn_lcd_panel;
+}
+
+static void exynos_mipi_dsim_enable_d_phy_type1(
+			struct platform_device *pdev,
+			bool enable)
+{
+	struct mipi_dsim_device *dsim = (struct mipi_dsim_device *)
+					platform_get_drvdata(pdev);
+	struct mipi_dsim_phy_config_type1 *dphy_cfg_type1 +					&dsim->dsim_phy_config->phy_cfg_type1;
+	u32 reg_enable;
+
+	reg_enable = __raw_readl(dphy_cfg_type1->reg_enable_dphy);
+	reg_enable &= ~(dphy_cfg_type1->ctrlbit_enable_dphy);
+
+	if (enable)
+		reg_enable |= dphy_cfg_type1->ctrlbit_enable_dphy;
+
+	__raw_writel(reg_enable, dphy_cfg_type1->reg_enable_dphy);
+}
+
+static void exynos_mipi_dsim_reset_type1(
+			struct platform_device *pdev,
+			bool enable)
+{
+	struct mipi_dsim_device *dsim = (struct mipi_dsim_device *)
+					platform_get_drvdata(pdev);
+	struct mipi_dsim_phy_config_type1 *dphy_cfg_type1 +					&dsim->dsim_phy_config->phy_cfg_type1;
+	u32 reg_reset;
+
+	reg_reset = __raw_readl(dphy_cfg_type1->reg_reset_dsim);
+	reg_reset &= ~(dphy_cfg_type1->ctrlbit_reset_dsim);
+
+	if (enable)
+		reg_reset |= dphy_cfg_type1->ctrlbit_reset_dsim;
+
+	__raw_writel(reg_reset, dphy_cfg_type1->reg_reset_dsim);
+}
+
+static int exynos_mipi_dsim_phy_init_type1(
+			struct platform_device *pdev,
+			bool on_off)
+{
+	exynos_mipi_dsim_enable_d_phy_type1(pdev, on_off);
+	exynos_mipi_dsim_reset_type1(pdev, on_off);
+	return 0;
+}
+
+static int parse_u32_property(struct device_node *np, char *name,
+				u32 *result)
+{
+	if (of_property_read_u32(np, name, result)) {
+		pr_err("not able to find property: %s\n", name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int exynos_mipi_parse_ofnode_dsim_phy_type1(
+		struct platform_device *pdev,
+		struct mipi_dsim_phy_config_type1 *dphy_cfg_type1,
+		struct device_node *np)
+{
+	struct mipi_dsim_device *dsim = (struct mipi_dsim_device *)
+					platform_get_drvdata(pdev);
+	u32 paddr_phy_enable, paddr_dsim_reset;
+	int ret = 0;
+
+	ret |= parse_u32_property(np, "reg_enable_dphy", &paddr_phy_enable);
+	ret |= parse_u32_property(np, "reg_reset_dsim", &paddr_dsim_reset);
+	ret |= parse_u32_property(np, "mask_enable_dphy",
+					&dphy_cfg_type1->ctrlbit_enable_dphy);
+	ret |= parse_u32_property(np, "mask_reset_dsim",
+					&dphy_cfg_type1->ctrlbit_reset_dsim);
+
+	if (ret) {
+		pr_err("%s: error reading phy node properties\n", __func__);
+		return -EINVAL;
+	}
+
+	dphy_cfg_type1->reg_enable_dphy = ioremap(paddr_phy_enable, SZ_4);
+	if (!dphy_cfg_type1->reg_enable_dphy)
+		return -EINVAL;
+
+	dphy_cfg_type1->reg_reset_dsim = ioremap(paddr_dsim_reset, SZ_4);
+	if (!dphy_cfg_type1->reg_reset_dsim)
+		goto err_ioremap;
+
+	dsim->pd->phy_enable = exynos_mipi_dsim_phy_init_type1;
+
+	return 0;
+
+err_ioremap:
+	iounmap(dphy_cfg_type1->reg_enable_dphy);
+	return -EINVAL;
+}
+
+static struct mipi_dsim_phy_config *exynos_mipi_parse_ofnode_dsim_phy(
+		struct platform_device *pdev,
+		struct device_node *np)
+{
+	struct mipi_dsim_phy_config *mipi_dphy_config;
+	const char *compatible;
+
+	mipi_dphy_config = devm_kzalloc(&pdev->dev,
+			sizeof(struct mipi_dsim_phy_config), GFP_KERNEL);
+	if (!mipi_dphy_config) {
+		dev_err(&pdev->dev,
+			"failed to allocate mipi_dsim_phy_config object.\n");
+		return NULL;
+	}
+
+	if (of_property_read_string(np, "compatible", &compatible)) {
+		dev_err(&pdev->dev, "compatible property not found");
+		return NULL;
+	}
+
+	/* try to find the phy node type from compatible string */
+	if (!strcmp(compatible, "samsung-exynos,mipi-phy-type1"))
+		mipi_dphy_config->type = MIPI_DSIM_PHY_CONFIG_TYPE1;
+	else
+		mipi_dphy_config->type = -1;
+
+	/* parse the phy node as per its type */
+	switch (mipi_dphy_config->type) {
+	case MIPI_DSIM_PHY_CONFIG_TYPE1:
+		if (exynos_mipi_parse_ofnode_dsim_phy_type1(
+			pdev, &mipi_dphy_config->phy_cfg_type1, np))
+			return NULL;
+		break;
+	default:
+		dev_err(&pdev->dev, "mipi phy - unknown type");
+		return NULL;
+	}
+
+	return mipi_dphy_config;
+}
+
+static struct mipi_dsim_lcd_device *exynos_mipi_parse_ofnode_lcd(
+		struct platform_device *pdev, struct device_node *np)
+{
+	struct mipi_dsim_lcd_device *active_mipi_dsim_lcd_device;
+	struct lcd_platform_data *active_lcd_platform_data;
+	const char *lcd_name;
+
+	active_mipi_dsim_lcd_device = devm_kzalloc(&pdev->dev,
+			sizeof(struct mipi_dsim_lcd_device), GFP_KERNEL);
+	if (!active_mipi_dsim_lcd_device) {
+		dev_err(&pdev->dev,
+		"failed to allocate active_mipi_dsim_lcd_device object.\n");
+		return NULL;
+	}
+
+	if (of_property_read_string(np, "lcd-name", &lcd_name)) {
+		dev_err(&pdev->dev, "lcd name property not found");
+		return NULL;
+	}
+
+	active_mipi_dsim_lcd_device->name = (char *)lcd_name;
+
+	if (of_property_read_u32(np, "id", &active_mipi_dsim_lcd_device->id))
+		active_mipi_dsim_lcd_device->id = -1;
+
+	if (of_property_read_u32(np, "bus-id",
+					&active_mipi_dsim_lcd_device->bus_id))
+		active_mipi_dsim_lcd_device->bus_id = -1;
+
+	active_lcd_platform_data = devm_kzalloc(&pdev->dev,
+				sizeof(struct lcd_platform_data), GFP_KERNEL);
+	if (!active_lcd_platform_data) {
+		dev_err(&pdev->dev,
+		"failed to allocate active_lcd_platform_data object.\n");
+		return NULL;
+	}
+
+	/* store the lcd node pointer for futher use in lcd driver */
+	active_lcd_platform_data->pdata = (void *) np;
+	active_mipi_dsim_lcd_device->platform_data +				(void *)active_lcd_platform_data;
+
+	return active_mipi_dsim_lcd_device;
+}
+
+static int exynos_mipi_parse_ofnode_config(struct platform_device *pdev,
+		struct device_node *np, struct mipi_dsim_config *dsim_config)
+{
+	unsigned int u32Val;
+
+	if (parse_u32_property(np, "e_interface", &u32Val))
+		return -EINVAL;
+	dsim_config->e_interface = (enum mipi_dsim_interface_type)u32Val;
+
+	if (parse_u32_property(np, "e_pixel_format", &u32Val))
+		return -EINVAL;
+	dsim_config->e_pixel_format = (enum mipi_dsim_pixel_format)u32Val;
+
+	if (parse_u32_property(np, "auto_flush", &u32Val))
+		return -EINVAL;
+	dsim_config->auto_flush = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "eot_disable", &u32Val))
+		return -EINVAL;
+	dsim_config->eot_disable = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "auto_vertical_cnt", &u32Val))
+		return -EINVAL;
+	dsim_config->auto_vertical_cnt = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "hse", &u32Val))
+		return -EINVAL;
+	dsim_config->hse = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "hfp", &u32Val))
+		return -EINVAL;
+	dsim_config->hfp = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "hbp", &u32Val))
+		return -EINVAL;
+	dsim_config->hbp = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "hsa", &u32Val))
+		return -EINVAL;
+	dsim_config->hsa = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "e_no_data_lane", &u32Val))
+		return -EINVAL;
+	dsim_config->e_no_data_lane = (enum mipi_dsim_no_of_data_lane)u32Val;
+
+	if (parse_u32_property(np, "e_byte_clk", &u32Val))
+		return -EINVAL;
+	dsim_config->e_byte_clk = (enum mipi_dsim_byte_clk_src)u32Val;
+
+	if (parse_u32_property(np, "e_burst_mode", &u32Val))
+		return -EINVAL;
+	dsim_config->e_burst_mode = (enum mipi_dsim_burst_mode_type)u32Val;
+
+	if (parse_u32_property(np, "p", &u32Val))
+		return -EINVAL;
+	dsim_config->p = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "m", &u32Val))
+		return -EINVAL;
+	dsim_config->m = (unsigned short)u32Val;
+
+	if (parse_u32_property(np, "s", &u32Val))
+		return -EINVAL;
+	dsim_config->s = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "pll_stable_time", &u32Val))
+		return -EINVAL;
+	dsim_config->pll_stable_time = (unsigned int)u32Val;
+
+	if (parse_u32_property(np, "esc_clk", &u32Val))
+		return -EINVAL;
+	dsim_config->esc_clk = (unsigned long)u32Val;
+
+	if (parse_u32_property(np, "stop_holding_cnt", &u32Val))
+		return -EINVAL;
+	dsim_config->stop_holding_cnt = (unsigned short)u32Val;
+
+	if (parse_u32_property(np, "bta_timeout", &u32Val))
+		return -EINVAL;
+	dsim_config->bta_timeout = (unsigned char)u32Val;
+
+	if (parse_u32_property(np, "rx_timeout", &u32Val))
+		return -EINVAL;
+	dsim_config->rx_timeout = (unsigned short)u32Val;
+
+	if (parse_u32_property(np, "e_virtual_ch", &u32Val))
+		return -EINVAL;
+	dsim_config->e_virtual_ch = (enum mipi_dsim_virtual_ch_no)u32Val;
+
+	if (parse_u32_property(np, "cmd_allow", &u32Val))
+		return -EINVAL;
+	dsim_config->cmd_allow = (unsigned char)u32Val;
+
+	return 0;
+}
+
+static int exynos_mipi_parse_ofnode_panel_info(struct platform_device *pdev,
+		struct device_node *np, struct fb_videomode *vm)
+{
+	int ret = 0;
+
+	ret |= parse_u32_property(np, "left_margin", &vm->left_margin);
+	ret |= parse_u32_property(np, "right_margin", &vm->right_margin);
+	ret |= parse_u32_property(np, "upper_margin", &vm->upper_margin);
+	ret |= parse_u32_property(np, "lower_margin", &vm->lower_margin);
+	ret |= parse_u32_property(np, "hsync_len", &vm->hsync_len);
+	ret |= parse_u32_property(np, "vsync_len", &vm->vsync_len);
+	ret |= parse_u32_property(np, "xres", &vm->xres);
+	ret |= parse_u32_property(np, "yres", &vm->yres);
+	if (ret)
+		pr_err("%s: error reading fb_videomodeproperties\n", __func__);
+
+	return ret;
+}
+
+static int exynos_mipi_parse_ofnode(struct platform_device *pdev,
+	struct mipi_dsim_config *dsim_config, struct fb_videomode *panel_info)
+{
+	struct device_node *np_dsim_config, *np_panel_info;
+	struct device_node *np = pdev->dev.of_node;
+
+	np_dsim_config = of_find_node_by_name(np, "mipi-config");
+	if (!np_dsim_config)
+		return -EINVAL;
+
+	if (exynos_mipi_parse_ofnode_config(pdev, np_dsim_config, dsim_config))
+		return -EINVAL;
+
+	np_panel_info = of_find_node_by_name(np, "display-mode");
+	if (!np_panel_info)
+		return -EINVAL;
+
+	if (exynos_mipi_parse_ofnode_panel_info(pdev,
+					np_panel_info, panel_info))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -336,6 +754,12 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	struct mipi_dsim_config *dsim_config;
 	struct mipi_dsim_platform_data *dsim_pd;
 	struct mipi_dsim_ddi *dsim_ddi;
+	struct device_node *ofnode_lcd = NULL;
+	struct device_node *ofnode_dphy = NULL;
+	struct mipi_dsim_lcd_device *active_mipi_dsim_lcd_device = NULL;
+	struct mipi_dsim_phy_config *mipi_dphy_config;
+	struct fb_videomode *panel_info;
+	unsigned int u32Val;
 	int ret = -EINVAL;
 
 	dsim = devm_kzalloc(&pdev->dev,
@@ -345,23 +769,87 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (pdev->dev.of_node) {
+		ofnode_lcd = exynos_mipi_find_ofnode_lcd_device(pdev);
+		if (!ofnode_lcd)
+			return -EINVAL;
+
+		active_mipi_dsim_lcd_device +				exynos_mipi_parse_ofnode_lcd(pdev, ofnode_lcd);
+
+		if (NULL = active_mipi_dsim_lcd_device)
+			return -EINVAL;
+
+		if (NULL = exynos_mipi_dsi_find_lcd_driver
+					(active_mipi_dsim_lcd_device))
+			return -ENXIO;
+
+		exynos_mipi_dsi_register_lcd_device(
+						active_mipi_dsim_lcd_device);
+	}
+
 	dsim->pd = to_dsim_plat(pdev);
 	dsim->dev = &pdev->dev;
 	dsim->id = pdev->id;
 
-	/* get mipi_dsim_platform_data. */
-	dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
-	if (dsim_pd = NULL) {
-		dev_err(&pdev->dev, "failed to get platform data for dsim.\n");
-		return -EFAULT;
-	}
-	/* get mipi_dsim_config. */
-	dsim_config = dsim_pd->dsim_config;
-	if (dsim_config = NULL) {
-		dev_err(&pdev->dev, "failed to get dsim config data.\n");
-		return -EFAULT;
-	}
+	if (pdev->dev.of_node) {
+		dsim_config = devm_kzalloc(&pdev->dev,
+			sizeof(struct mipi_dsim_config), GFP_KERNEL);
+		if (!dsim_config) {
+			dev_err(&pdev->dev,
+				"failed to allocate dsim_config object.\n");
+			return -ENOMEM;
+		}
 
+		panel_info = devm_kzalloc(&pdev->dev,
+				sizeof(struct fb_videomode), GFP_KERNEL);
+		if (!panel_info) {
+			dev_err(&pdev->dev,
+				"failed to allocate fb_videomode object.\n");
+			return -ENOMEM;
+		}
+
+		/* parse the mipi of_node for dism_config and panel info. */
+		if (exynos_mipi_parse_ofnode(pdev, dsim_config, panel_info)) {
+			dev_err(&pdev->dev,
+				"failed to read mipi-config, display-mode\n");
+			return -EINVAL;
+		}
+
+		dsim_pd = devm_kzalloc(&pdev->dev,
+			sizeof(struct mipi_dsim_platform_data), GFP_KERNEL);
+		if (!dsim_pd) {
+			dev_err(&pdev->dev,
+				"failed to allocate mipi_dsim_platform_data\n");
+			return -ENOMEM;
+		}
+
+		if (of_property_read_u32(pdev->dev.of_node, "enabled", &u32Val))
+			dev_err(&pdev->dev, "enabled property not found\n");
+		else
+			dsim_pd->enabled = !(!u32Val);
+
+		dsim_pd->lcd_panel_info = (void *)panel_info;
+		dsim_pd->dsim_config = dsim_config;
+		dsim->pd = dsim_pd;
+
+	} else {
+		/* get mipi_dsim_platform_data. */
+		dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
+		if (dsim_pd = NULL) {
+			dev_err(&pdev->dev,
+				"failed to get platform data for dsim.\n");
+			return -EFAULT;
+		}
+
+		/* get mipi_dsim_config. */
+		dsim_config = dsim_pd->dsim_config;
+		if (dsim_config = NULL) {
+			dev_err(&pdev->dev,
+				"failed to get dsim config data.\n");
+			return -EFAULT;
+		}
+	}
 	dsim->dsim_config = dsim_config;
 	dsim->master_ops = &master_ops;
 
@@ -394,11 +882,21 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	mutex_init(&dsim->lock);
 
 	/* bind lcd ddi matched with panel name. */
-	dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim, dsim_pd->lcd_panel_name);
+	if (pdev->dev.of_node) {
+		dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim,
+					active_mipi_dsim_lcd_device->name);
+	} else {
+		dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim,
+					dsim_pd->lcd_panel_name);
+	}
+
 	if (!dsim_ddi) {
 		dev_err(&pdev->dev, "mipi_dsim_ddi object not found.\n");
 		ret = -ENXIO;
 		goto cleanup_clk;
+	} else if (pdev->dev.of_node) {
+		dsim_ddi->ofnode_dsim_lcd_dev = ofnode_lcd;
+		dsim_ddi->ofnode_dsim_dphy = ofnode_dphy;
 	}
 
 	dsim->irq = platform_get_irq(pdev, 0);
@@ -412,6 +910,21 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	init_completion(&dsim_rd_comp);
 	platform_set_drvdata(pdev, dsim);
 
+	/* update dsim phy config node */
+	if (pdev->dev.of_node) {
+		ofnode_dphy = exynos_mipi_find_ofnode_dsim_phy(pdev);
+		if (!ofnode_dphy)
+			return -EINVAL;
+
+		mipi_dphy_config = exynos_mipi_parse_ofnode_dsim_phy(pdev,
+								ofnode_dphy);
+
+		if (NULL = mipi_dphy_config)
+			return -EINVAL;
+
+		dsim->dsim_phy_config = mipi_dphy_config;
+	}
+
 	ret = devm_request_irq(&pdev->dev, dsim->irq,
 			exynos_mipi_dsi_interrupt_handler,
 			IRQF_SHARED, dev_name(&pdev->dev), dsim);
@@ -557,13 +1070,33 @@ static const struct dev_pm_ops exynos_mipi_dsi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_mipi_dsi_suspend, exynos_mipi_dsi_resume)
 };
 
+static struct platform_device_id exynos_mipi_driver_ids[] = {
+	{
+		.name		= "exynos-mipi",
+		.driver_data	= NULL,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, exynos_mipi_driver_ids);
+
+static const struct of_device_id exynos_mipi_match[] = {
+	{
+		.compatible = "samsung,exynos5-mipi",
+		.data = NULL,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_mipi_match);
+
 static struct platform_driver exynos_mipi_dsi_driver = {
 	.probe = exynos_mipi_dsi_probe,
 	.remove = __devexit_p(exynos_mipi_dsi_remove),
+	.id_table = exynos_mipi_driver_ids,
 	.driver = {
 		   .name = "exynos-mipi-dsim",
 		   .owner = THIS_MODULE,
 		   .pm = &exynos_mipi_dsi_pm_ops,
+		   .of_match_table = exynos_mipi_match,
 	},
 };
 
diff --git a/include/video/exynos_mipi_dsim.h b/include/video/exynos_mipi_dsim.h
index 772c770..6d9b01d 100644
--- a/include/video/exynos_mipi_dsim.h
+++ b/include/video/exynos_mipi_dsim.h
@@ -230,6 +230,7 @@ struct mipi_dsim_device {
 	struct mipi_dsim_master_ops	*master_ops;
 	struct mipi_dsim_lcd_device	*dsim_lcd_dev;
 	struct mipi_dsim_lcd_driver	*dsim_lcd_drv;
+	struct mipi_dsim_phy_config	*dsim_phy_config;
 
 	unsigned int			state;
 	unsigned int			data_lane;
@@ -295,6 +296,32 @@ struct mipi_dsim_master_ops {
 };
 
 /*
+ * phy node structure for mipi-dsim.
+ *
+ * @reg_enable_dphy	: base address to memory mapped D-PHY enable register
+ * @ctrlbit_enable_dphy : control bit for enabling D-PHY
+ * @reg_reset_dsim	: base address to memory mapped DSIM reset register
+ * @ctrlbit_reset_dsim	: control bit for resetting DSIM
+ */
+struct mipi_dsim_phy_config_type1 {
+	void __iomem	*reg_enable_dphy;
+	int		ctrlbit_enable_dphy;
+	void __iomem	*reg_reset_dsim;
+	int		ctrlbit_reset_dsim;
+};
+
+enum mipi_dsim_phy_config_type {
+	MIPI_DSIM_PHY_CONFIG_TYPE1,
+};
+
+struct mipi_dsim_phy_config {
+	enum mipi_dsim_phy_config_type type;
+	union {
+		struct mipi_dsim_phy_config_type1 phy_cfg_type1;
+	};
+};
+
+/*
  * device structure for mipi-dsi based lcd panel.
  *
  * @name: name of the device to use with this device, or an
-- 
1.7.0.4

