From: cailiwei <cailiwei@hisilicon.com>
Date: Tue, 07 Feb 2017 02:35:59 +0000
Subject: [PATCH 8/8] fb: hisilicon: Add framebuffer driver for hi3660 SoC
Message-Id: <20170207023559.79455-8-cailiwei@hisilicon.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170207023559.79455-1-cailiwei@hisilicon.com>
In-Reply-To: <20170207023559.79455-1-cailiwei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, guodong.xu@linaro.org
Cc: suzhuangluan@hisilicon.com, dengqingshan@hisilicon.com, xuhongtao8@hisilicon.com, zhengwanchun@hisilicon.com, shizongxuan@huawei.com, cailiwei@hisilicon.com

From: Levy-Cai <cailiwei@hisilicon.com>

Add framebuffer driver for hi3660 SoC, this driver include lcd
driver & Hdmi adv7533/adv7535 driver, support lcd display at
1080p@60 and hdmi display at 1080p@60.

Signed-off-by: cailiwei <cailiwei@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 mode change 100644 => 100755 arch/arm64/boot/dts/hisilicon/hi3660.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
old mode 100644
new mode 100755
index 5389799ff371..2ad11800dd67
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -132,6 +132,54 @@
 		clock-frequency = <1920000>;
 	};
 
+	/* display start */
+	framebuffer@E8600000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "hisilicon,hisifb";
+		fastboot_enable_flag = <0>;
+		fake_lcd_flag = <0>;
+		dss_base_phy = <0xE8600000>;
+		// DSS, PERI_CRG, SCTRL, PCTRL, NOC_DSS_Service_Target, MMBUF_CFG
+		reg = <0 0xE8600000 0 0x80000>, <0 0xFFF35000 0 0x1000>, <0 0xFFF0A000 0 0x1000>, <0 0xE8A09000 0 0x1000>,
+				<0 0xE86C0000 0 0x10000>, <0 0xFFF02000 0 0x1000>, <0 0xFFF31000 0 0x1000>;
+		// dss-pdp, dss-sdp, dss-adp, dss-dsi0, dss-dsi1 irq
+		interrupts = <0 245 4>, <0 246 4>, <0 247 4>, <0 251 4>, <0 252 4>;
+		//regulator_dsssubsys-supply = <&dsssubsys>;
+		//regulator_mmbuf-supply = <&mmbuf>;
+		clocks = <&crg_ctrl HI3660_ACLK_GATE_DSS>, <&crg_ctrl HI3660_PCLK_GATE_DSS>, <&crg_ctrl HI3660_CLK_GATE_EDC0>,
+				<&crg_ctrl HI3660_CLK_GATE_LDI0>, <&crg_ctrl HI3660_CLK_GATE_LDI1>, <&sctrl HI3660_CLK_GATE_DSS_AXI_MM>,
+				<&sctrl HI3660_PCLK_GATE_MMBUF>, <&crg_ctrl HI3660_CLK_GATE_TXDPHY0_REF>, <&crg_ctrl HI3660_CLK_GATE_TXDPHY1_REF>,
+				<&crg_ctrl HI3660_CLK_GATE_TXDPHY0_CFG>, <&crg_ctrl HI3660_CLK_GATE_TXDPHY1_CFG>, <&crg_ctrl HI3660_PCLK_GATE_DSI0>,
+				<&crg_ctrl HI3660_PCLK_GATE_DSI1>;//, <&crg_ctrl HI3660_PCLK_GATE_PCTRL>;
+		clock-names = "aclk_dss", "pclk_dss", "clk_edc0", "clk_ldi0", "clk_ldi1",
+				"clk_dss_axi_mm", "pclk_mmbuf",
+				"clk_txdphy0_ref", "clk_txdphy1_ref", "clk_txdphy0_cfg", "clk_txdphy1_cfg",
+				"pclk_dsi0", "pclk_dsi1";//, "pclk_pctrl";
+		status = "ok";
+		fpga_flag = <0>;
+
+		/*iommu_info {
+			start-addr = <0x8000>;
+			size = <0xbfff8000>;
+		};*/
+	};
+
+	panel_lcd_hikey {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "hisilicon,mipi_hikey";
+		lcd-bl-type = <0>;
+		lcd-display-type = <8>;
+		//vdd-supply = <&ldo3>;
+		lcd-ifbc-type = <0>;
+		gpios = <&gpio27 0 0>, <&gpio27 2 0>, <&gpio22 6 0>, <&gpio2 4 0>;
+		gpio_nums = <216 218 182 20>;
+		fpga_flag = <0>;
+		status = "disabled";
+	};
+	/* display end */
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.12.0-rc0

