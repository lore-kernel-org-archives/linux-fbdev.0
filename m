From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 08:15:40 +0000
Subject: [PATCHv2 1/8] Doc/DT: Add DT binding documentation for OMAP DSS
Message-Id: <1395130547-18633-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add device tree bindings for OMAP Display Subsystem for the following
SoCs: OMAP2, OMAP3, OMAP4.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/ti,omap-dss.txt      | 211 +++++++++++++++++++++
 .../devicetree/bindings/video/ti,omap2-dss.txt     |  54 ++++++
 .../devicetree/bindings/video/ti,omap3-dss.txt     |  83 ++++++++
 .../devicetree/bindings/video/ti,omap4-dss.txt     | 111 +++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap2-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap3-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap4-dss.txt

diff --git a/Documentation/devicetree/bindings/video/ti,omap-dss.txt b/Documentation/devicetree/bindings/video/ti,omap-dss.txt
new file mode 100644
index 000000000000..d5f1a3fe3109
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,omap-dss.txt
@@ -0,0 +1,211 @@
+Texas Instruments OMAP Display Subsystem
+====================
+
+Generic Description
+-------------------
+
+This document is a generic description of the OMAP Display Subsystem bindings.
+Binding details for each OMAP SoC version are described in respective binding
+documentation.
+
+The OMAP Display Subsystem (DSS) hardware consists of DSS Core, DISPC module and
+a number of encoder modules. All DSS versions contain DSS Core and DISPC, but
+the encoder modules vary.
+
+The DSS Core is the parent of the other DSS modules, and manages clock routing,
+integration to the SoC, etc.
+
+DISPC is the display controller, which reads pixels from the memory and outputs
+a RGB pixel stream to encoders.
+
+The encoder modules encode the received RGB pixel stream to a video output like
+HDMI, MIPI DPI, etc.
+
+Video Ports
+-----------
+
+The DSS Core and the encoders have video port outputs. The structure of the
+video ports is described in Documentation/devicetree/bindings/video/video-
+ports.txt, and the properties for the ports and endpoints for each encoder are
+described in the SoC's DSS binding documentation.
+
+The video ports are used to describe the connections to external hardware, like
+panels or external encoders.
+
+Aliases
+-------
+
+The board dts file may define aliases for displays to assign "displayX" style
+name for each display. If no aliases are defined, a semi-random number is used
+for the display.
+
+Example
+-------
+
+A shortened example of the DSS description for OMAP4, with non-relevant parts
+removed, defined in omap4.dtsi:
+
+dss: dss@58000000 {
+	compatible = "ti,omap4-dss";
+	reg = <0x58000000 0x80>;
+	status = "disabled";
+	ti,hwmods = "dss_core";
+	clocks = <&dss_dss_clk>;
+	clock-names = "fck";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	dispc@58001000 {
+		compatible = "ti,omap4-dispc";
+		reg = <0x58001000 0x1000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "dss_dispc";
+		clocks = <&dss_dss_clk>;
+		clock-names = "fck";
+	};
+
+	hdmi: encoder@58006000 {
+		compatible = "ti,omap4-hdmi";
+		reg = <0x58006000 0x200>,
+		      <0x58006200 0x100>,
+		      <0x58006300 0x100>,
+		      <0x58006400 0x1000>;
+		reg-names = "wp", "pll", "phy", "core";
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+		ti,hwmods = "dss_hdmi";
+		clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
+		clock-names = "fck", "sys_clk";
+	};
+};
+
+A shortened example of the board description for OMAP4 Panda board, defined in
+omap4-panda.dts.
+
+The Panda board has a DVI and a HDMI connector, and the board contains a TFP410
+chip (MIPI DPI to DVI encoder) and a TPD12S015 chip (HDMI ESD protection & level
+shifter). The video pipelines for the connectors are formed as follows:
+
+DSS Core --(MIPI DPI)--> TFP410 --(DVI)--> DVI Connector
+OMAP HDMI --(HDMI)--> TPD12S015 --(HDMI)--> HDMI Connector
+
+/ {
+	aliases {
+		display0 = &dvi0;
+		display1 = &hdmi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;	/* 0, power-down */
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tfp410_pins>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@0 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		i2c-bus = <&i2c3>;
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	tpd12s015: encoder@1 {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+			<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+			<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint@0 {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint@0 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@1 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tpd12s015_out>;
+			};
+		};
+	};
+};
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&tfp410_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&vdac>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&tpd12s015_in>;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/video/ti,omap2-dss.txt b/Documentation/devicetree/bindings/video/ti,omap2-dss.txt
new file mode 100644
index 000000000000..fa8bb2ed1170
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,omap2-dss.txt
@@ -0,0 +1,54 @@
+Texas Instruments OMAP2 Display Subsystem
+====================+
+See Documentation/devicetree/bindings/video/ti,omap-dss.txt for generic
+description about OMAP Display Subsystem bindings.
+
+DSS Core
+--------
+
+Required properties:
+- compatible: "ti,omap2-dss"
+- reg: address and length of the register space
+- ti,hwmods: "dss_core"
+
+Optional nodes:
+- Video port for DPI output
+
+DPI Endpoint required properties:
+- data-lines: number of lines used
+
+
+DISPC
+-----
+
+Required properties:
+- compatible: "ti,omap2-dispc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_dispc"
+- interrupts: the DISPC interrupt
+
+
+RFBI
+----
+
+Required properties:
+- compatible: "ti,omap2-rfbi"
+- reg: address and length of the register space
+- ti,hwmods: "dss_rfbi"
+
+
+VENC
+----
+
+Required properties:
+- compatible: "ti,omap2-venc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_venc"
+- vdda-supply: power supply for DAC
+
+VENC Endpoint required properties:
+
+Required properties:
+- ti,invert-polarity: invert the polarity of the video signal
+- ti,channels: 1 for composite, 2 for s-video
diff --git a/Documentation/devicetree/bindings/video/ti,omap3-dss.txt b/Documentation/devicetree/bindings/video/ti,omap3-dss.txt
new file mode 100644
index 000000000000..0023fa4b1328
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,omap3-dss.txt
@@ -0,0 +1,83 @@
+Texas Instruments OMAP3 Display Subsystem
+====================+
+See Documentation/devicetree/bindings/video/ti,omap-dss.txt for generic
+description about OMAP Display Subsystem bindings.
+
+DSS Core
+--------
+
+Required properties:
+- compatible: "ti,omap3-dss"
+- reg: address and length of the register space
+- ti,hwmods: "dss_core"
+- clocks: handle to fclk
+- clock-names: "fck"
+
+Optional nodes:
+- Video ports:
+	- Port 0: DPI output
+	- Port 1: SDI output
+
+DPI Endpoint required properties:
+- data-lines: number of lines used
+
+SDI Endpoint required properties:
+- datapairs: number of datapairs used
+
+
+DISPC
+-----
+
+Required properties:
+- compatible: "ti,omap3-dispc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_dispc"
+- interrupts: the DISPC interrupt
+- clocks: handle to fclk
+- clock-names: "fck"
+
+
+RFBI
+----
+
+Required properties:
+- compatible: "ti,omap3-rfbi"
+- reg: address and length of the register space
+- ti,hwmods: "dss_rfbi"
+- clocks: handles to fclk and iclk
+- clock-names: "fck", "ick"
+
+
+VENC
+----
+
+Required properties:
+- compatible: "ti,omap3-venc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_venc"
+- vdda-supply: power supply for DAC
+- clocks: handle to fclk
+- clock-names: "fck"
+
+VENC Endpoint required properties:
+- ti,invert-polarity: invert the polarity of the video signal
+- ti,channels: 1 for composite, 2 for s-video
+
+
+DSI
+---
+
+Required properties:
+- compatible: "ti,omap3-dsi"
+- reg: addresses and lengths of the register spaces for 'proto', 'phy' and 'pll'
+- reg-names: "proto", "phy", "pll"
+- interrupts: the DSI interrupt line
+- ti,hwmods: "dss_dsi1"
+- vdd-supply: power supply for DSI
+- clocks: handles to fclk and pll clock
+- clock-names: "fck", "sys_clk"
+
+DSI Endpoint required properties:
+- lanes: list of pin numbers for the DSI lanes: CLK+, CLK-, DATA0+, DATA0-,
+  DATA1+, DATA1-, ...
diff --git a/Documentation/devicetree/bindings/video/ti,omap4-dss.txt b/Documentation/devicetree/bindings/video/ti,omap4-dss.txt
new file mode 100644
index 000000000000..f85d6fcfa705
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,omap4-dss.txt
@@ -0,0 +1,111 @@
+Texas Instruments OMAP4 Display Subsystem
+====================+
+See Documentation/devicetree/bindings/video/ti,omap-dss.txt for generic
+description about OMAP Display Subsystem bindings.
+
+DSS Core
+--------
+
+Required properties:
+- compatible: "ti,omap4-dss"
+- reg: address and length of the register space
+- ti,hwmods: "dss_core"
+- clocks: handle to fclk
+- clock-names: "fck"
+
+Required nodes:
+- DISPC
+
+Optional nodes:
+- DSS Submodules: RFBI, VENC, DSI, HDMI
+- Video port for DPI output
+
+DPI Endpoint required properties:
+- data-lines: number of lines used
+
+
+DISPC
+-----
+
+Required properties:
+- compatible: "ti,omap4-dispc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_dispc"
+- interrupts: the DISPC interrupt
+- clocks: handle to fclk
+- clock-names: "fck"
+
+
+RFBI
+----
+
+Required properties:
+- compatible: "ti,omap4-rfbi"
+- reg: address and length of the register space
+- ti,hwmods: "dss_rfbi"
+- clocks: handles to fclk and iclk
+- clock-names: "fck", "ick"
+
+Optional nodes:
+- Video port for RFBI output
+- RFBI controlled peripherals
+
+
+VENC
+----
+
+Required properties:
+- compatible: "ti,omap4-venc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_venc"
+- vdda-supply: power supply for DAC
+- clocks: handle to fclk
+- clock-names: "fck"
+
+Optional nodes:
+- Video port for VENC output
+
+VENC Endpoint required properties:
+- ti,invert-polarity: invert the polarity of the video signal
+- ti,channels: 1 for composite, 2 for s-video
+
+
+DSI
+---
+
+Required properties:
+- compatible: "ti,omap4-dsi"
+- reg: addresses and lengths of the register spaces for 'proto', 'phy' and 'pll'
+- reg-names: "proto", "phy", "pll"
+- interrupts: the DSI interrupt line
+- ti,hwmods: "dss_dsi1" or "dss_dsi2"
+- vdd-supply: power supply for DSI
+- clocks: handles to fclk and pll clock
+- clock-names: "fck", "sys_clk"
+
+Optional nodes:
+- Video port for DSI output
+- DSI controlled peripherals
+
+DSI Endpoint required properties:
+- lanes: list of pin numbers for the DSI lanes: CLK+, CLK-, DATA0+, DATA0-,
+  DATA1+, DATA1-, ...
+
+
+HDMI
+----
+
+Required properties:
+- compatible: "ti,omap4-hdmi"
+- reg: addresses and lengths of the register spaces for 'wp', 'pll', 'phy',
+       'core'
+- reg-names: "wp", "pll", "phy", "core"
+- interrupts: the HDMI interrupt line
+- ti,hwmods: "dss_hdmi"
+- vdda-supply: vdda power supply
+- clocks: handles to fclk and pll clock
+- clock-names: "fck", "sys_clk"
+
+Optional nodes:
+- Video port for HDMI output
-- 
1.8.3.2

