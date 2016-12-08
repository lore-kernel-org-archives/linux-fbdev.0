From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 08 Dec 2016 00:57:44 +0000
Subject: [PATCH 03/12] ARM: dts: imx6qdl: add video capture devices and connections
Message-Id: <1481158673-15937-4-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, tomi.valkeinen@ti.com, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steve Longerbeam <steve_longerbeam@mentor.com>

From: Philipp Zabel <p.zabel@pengutronix.de>

This patch adds the IPU subunit devices involved in video capture and
image conversion, and defines all the possible hardware connections
between them via OF graphs.

External to the IPU:

Video input multiplexers are defined that multiplex inputs from camera
sensors and the MIPI-CSI2 gasket, to the IPU CSIs.

On i.MX6Q/D two two-input multiplexers in front of IPU1 CSI0 and IPU2 CSI1
allow to select between CSI0/1 parallel input pads and the MIPI CSI-2 virtual
channels 0/3.

On i.MX6DL/S two five-input multiplexers in front of IPU1 CSI0 and IPU1 CSI1
allow to select between CSI0/1 parallel input pads and any of the four MIPI
CSI-2 virtual channels.

Internal to the IPU:

The IPU CSI, SMFC, IC-PRPENC, IC-PRPVF, and IC-PP subunits are added
as children of the IPUs, along with the hardware-supported connections
between them.

Finally, a media device node is defined. A video camera interface
and mem2mem device are defined as children of the media device.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi  | 190 ++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi   | 487 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi | 368 +++++++++++++++++++++++++++++++
 3 files changed, 1045 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 1ade195..4bab076 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -109,6 +109,120 @@
 		compatible = "fsl,imx-gpu-subsystem";
 		cores = <&gpu_2d>, <&gpu_3d>;
 	};
+
+	ipu1_csi0_mux: ipu1_csi0_mux@34 {
+		compatible = "imx-video-mux";
+		reg = <0x34 0x07>;
+		gpr = <&gpr>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <5>;
+
+		port@0 {
+			reg = <0>;
+
+			ipu1_csi0_mux_from_mipi_vc0: endpoint {
+				remote-endpoint = <&mipi_vc0_to_ipu1_csi0_mux>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			ipu1_csi0_mux_from_mipi_vc1: endpoint {
+				remote-endpoint = <&mipi_vc1_to_ipu1_csi0_mux>;
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+
+			ipu1_csi0_mux_from_mipi_vc2: endpoint {
+				remote-endpoint = <&mipi_vc2_to_ipu1_csi0_mux>;
+			};
+		};
+
+		port@3 {
+			reg = <3>;
+
+			ipu1_csi0_mux_from_mipi_vc3: endpoint {
+				remote-endpoint = <&mipi_vc3_to_ipu1_csi0_mux>;
+			};
+		};
+
+		port@4 {
+			reg = <4>;
+
+			ipu1_csi0_mux_from_parallel_sensor: endpoint {
+			};
+		};
+
+		port@5 {
+			reg = <5>;
+
+			ipu1_csi0_mux_to_ipu1_csi0: endpoint {
+				remote-endpoint = <&ipu1_csi0_from_ipu1_csi0_mux>;
+			};
+		};
+	};
+
+	ipu1_csi1_mux: ipu1_csi1_mux@34 {
+		compatible = "imx-video-mux";
+		reg = <0x34 0x38>;
+		gpr = <&gpr>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <5>;
+
+		port@0 {
+			reg = <0>;
+
+			ipu1_csi1_mux_from_mipi_vc0: endpoint {
+				remote-endpoint = <&mipi_vc0_to_ipu1_csi1_mux>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			ipu1_csi1_mux_from_mipi_vc1: endpoint {
+				remote-endpoint = <&mipi_vc1_to_ipu1_csi1_mux>;
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+
+			ipu1_csi1_mux_from_mipi_vc2: endpoint {
+				remote-endpoint = <&mipi_vc2_to_ipu1_csi1_mux>;
+			};
+		};
+
+		port@3 {
+			reg = <3>;
+
+			ipu1_csi1_mux_from_mipi_vc3: endpoint {
+				remote-endpoint = <&mipi_vc3_to_ipu1_csi1_mux>;
+			};
+		};
+
+		port@4 {
+			reg = <4>;
+
+			ipu1_csi1_mux_from_parallel_sensor: endpoint {
+			};
+		};
+
+		port@5 {
+			reg = <5>;
+
+			ipu1_csi1_mux_to_ipu1_csi1: endpoint {
+				remote-endpoint = <&ipu1_csi1_from_ipu1_csi1_mux>;
+			};
+		};
+	};
 };
 
 &gpio1 {
@@ -184,3 +298,79 @@
 &vpu {
 	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
 };
+
+&ipu1_csi1 {
+	port@0 {
+		reg = <0>;
+		ipu1_csi1_from_ipu1_csi1_mux: endpoint {
+			remote-endpoint = <&ipu1_csi1_mux_to_ipu1_csi1>;
+		};
+	};
+};
+
+&mipi_csi {
+	sink-ports = <1>;
+
+	port@0 {
+		reg = <0>;
+
+		mipi_csi_from_mipi_sensor: endpoint {
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mipi_vc0_to_ipu1_csi0_mux: endpoint@0 {
+			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc0>;
+		};
+
+		mipi_vc0_to_ipu1_csi1_mux: endpoint@1 {
+			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc0>;
+		};
+	};
+
+	port@2 {
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mipi_vc1_to_ipu1_csi0_mux: endpoint@0 {
+			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc1>;
+		};
+
+		mipi_vc1_to_ipu1_csi1_mux: endpoint@1 {
+			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc1>;
+		};
+	};
+
+	port@3 {
+		reg = <3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mipi_vc2_to_ipu1_csi0_mux: endpoint@0 {
+			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc2>;
+		};
+
+		mipi_vc2_to_ipu1_csi1_mux: endpoint@1 {
+			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc2>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mipi_vc3_to_ipu1_csi0_mux: endpoint@0 {
+			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc3>;
+		};
+
+		mipi_vc3_to_ipu1_csi1_mux: endpoint@1 {
+			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc3>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 2b261ba..a0602c5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -142,11 +142,270 @@
 			resets = <&src 4>;
 
 			ipu2_csi0: ipu2_csi@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
 				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_csi0_from_mipi_vc2: endpoint {
+						remote-endpoint = <&mipi_vc2_to_ipu2_csi0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_csi0_to_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu2_smfc0_from_csi0>;
+					};
+					ipu2_csi0_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_from_csi0>;
+					};
+					ipu2_csi0_to_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu2_ic_prpenc_from_csi0>;
+					};
+				};
 			};
 
 			ipu2_csi1: ipu2_csi@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
 				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_csi1_from_ipu2_csi1_mux: endpoint {
+						remote-endpoint = <&ipu2_csi1_mux_to_ipu2_csi1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_csi1_to_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu2_smfc1_from_csi1>;
+					};
+					ipu2_csi1_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_from_csi1>;
+					};
+					ipu2_csi1_to_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu2_ic_prpenc_from_csi1>;
+					};
+				};
+			};
+
+			ipu2_smfc0: ipu2_smfc@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_smfc0_from_csi0: endpoint {
+						remote-endpoint = <&ipu2_csi0_to_smfc0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_smfc0_to_ic_pp1: pp-endpoint {
+						remote-endpoint = <&ipu2_ic_pp1_from_smfc0>;
+					};
+					ipu2_smfc0_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_from_smfc0>;
+					};
+					ipu2_smfc0_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_smfc0>;
+					};
+					ipu2_smfc0_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_smfc0>;
+					};
+				};
+			};
+
+			ipu2_smfc1: ipu2_smfc@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_smfc1_from_csi1: endpoint {
+						remote-endpoint = <&ipu2_csi1_to_smfc1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_smfc1_to_ic_pp2: pp-endpoint {
+						remote-endpoint = <&ipu2_ic_pp2_from_smfc1>;
+					};
+					ipu2_smfc1_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_from_smfc1>;
+					};
+					ipu2_smfc1_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_smfc1>;
+					};
+					ipu2_smfc1_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_smfc1>;
+					};
+				};
+			};
+
+			ipu2_ic_prpenc: ipu2_ic_prpenc@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_ic_prpenc_from_csi0: csi0-endpoint {
+						remote-endpoint = <&ipu2_csi0_to_ic_prpenc>;
+					};
+					ipu2_ic_prpenc_from_csi1: csi1-endpoint {
+						remote-endpoint = <&ipu2_csi1_to_ic_prpenc>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_ic_prpenc_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_ic_prpenc>;
+					};
+					ipu2_ic_prpenc_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_ic_prpenc>;
+					};
+				};
+			};
+
+			ipu2_ic_prpvf: ipu2_ic_prpvf@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_ic_prpvf_from_csi0: csi0-endpoint {
+						remote-endpoint = <&ipu2_csi0_to_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_from_csi1: csi1-endpoint {
+						remote-endpoint = <&ipu2_csi1_to_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu2_smfc0_to_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu2_smfc1_to_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_from_m2m1: m2m1-endpoint {
+						remote-endpoint = <&m2m1_to_ic_prpvf>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_ic_prpvf_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_to_ic_pp0: pp0-endpoint {
+						remote-endpoint = <&ipu2_ic_pp0_from_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_to_ic_pp1: pp1-endpoint {
+						remote-endpoint = <&ipu2_ic_pp1_from_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_to_ic_pp2: pp2-endpoint {
+						remote-endpoint = <&ipu2_ic_pp2_from_ic_prpvf>;
+					};
+					ipu2_ic_prpvf_to_m2m1: m2m1-endpoint {
+						remote-endpoint = <&m2m1_from_ic_prpvf>;
+					};
+				};
+			};
+
+			ipu2_ic_pp0: ipu2_ic_pp@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_ic_pp0_from_m2m1: m2m1-endpoint {
+						remote-endpoint = <&m2m1_to_ic_pp0>;
+					};
+					ipu2_ic_pp0_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_to_ic_pp0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_ic_pp0_to_m2m1: endpoint {
+						remote-endpoint = <&m2m1_from_ic_pp0>;
+					};
+				};
+			};
+
+			ipu2_ic_pp1: ipu2_ic_pp@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_ic_pp1_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu2_smfc0_to_ic_pp1>;
+					};
+					ipu2_ic_pp1_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_to_ic_pp1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_ic_pp1_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_ic_pp1>;
+					};
+					ipu2_ic_pp1_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_ic_pp1>;
+					};
+				};
+			};
+
+			ipu2_ic_pp2: ipu2_ic_pp@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <2>;
+
+				port@0 {
+					reg = <0>;
+					ipu2_ic_pp2_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu2_smfc1_to_ic_pp2>;
+					};
+					ipu2_ic_pp2_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu2_ic_prpvf_to_ic_pp2>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu2_ic_pp2_to_camif2: camif2-endpoint {
+						remote-endpoint = <&camif2_from_ic_pp2>;
+					};
+					ipu2_ic_pp2_to_camif3: camif3-endpoint {
+						remote-endpoint = <&camif3_from_ic_pp2>;
+					};
+				};
 			};
 
 			ipu2_di0: ipu2_di@0 {
@@ -207,6 +466,73 @@
 		compatible = "fsl,imx-gpu-subsystem";
 		cores = <&gpu_2d>, <&gpu_3d>, <&gpu_vg>;
 	};
+
+
+	ipu1_csi0_mux: ipu1_csi0_mux@4 {
+		compatible = "imx-video-mux";
+		reg = <0x04 0x80000>;
+		gpr = <&gpr>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <2>;
+
+		port@0 {
+			reg = <0>;
+
+			ipu1_csi0_mux_from_mipi_vc0: endpoint {
+				remote-endpoint = <&mipi_vc0_to_ipu1_csi0_mux>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			ipu1_csi0_mux_from_parallel_sensor: endpoint {
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+
+			ipu1_csi0_mux_to_ipu1_csi0: endpoint {
+				remote-endpoint = <&ipu1_csi0_from_ipu1_csi0_mux>;
+			};
+		};
+	};
+
+	ipu2_csi1_mux: ipu2_csi1_mux@4 {
+		compatible = "imx-video-mux";
+		reg = <0x04 0x100000>;
+		gpr = <&gpr>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <2>;
+
+		port@0 {
+			reg = <0>;
+
+			ipu2_csi1_mux_from_mipi_vc3: endpoint {
+				remote-endpoint = <&mipi_vc3_to_ipu2_csi1_mux>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			ipu2_csi1_mux_from_parallel_sensor: endpoint {
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+
+			ipu2_csi1_mux_to_ipu2_csi1: endpoint {
+				remote-endpoint = <&ipu2_csi1_from_ipu2_csi1_mux>;
+			};
+		};
+	};
 };
 
 &gpio1 {
@@ -266,6 +592,15 @@
 	};
 };
 
+&ipu1_csi1 {
+	port@0 {
+		reg = <0>;
+		ipu1_csi1_from_mipi_vc1: endpoint {
+			remote-endpoint = <&mipi_vc1_to_ipu1_csi1>;
+		};
+	};
+};
+
 &ldb {
 	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
 		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
@@ -312,6 +647,49 @@
 	};
 };
 
+&mipi_csi {
+	sink-ports = <1>;
+
+	port@0 {
+		reg = <0>;
+
+		mipi_csi_from_mipi_sensor: endpoint {
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+
+		mipi_vc0_to_ipu1_csi0_mux: endpoint {
+			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc0>;
+		};
+	};
+
+	port@2 {
+		reg = <2>;
+
+		mipi_vc1_to_ipu1_csi1: endpoint {
+			remote-endpoint = <&ipu1_csi1_from_mipi_vc1>;
+		};
+	};
+
+	port@3 {
+		reg = <3>;
+
+		mipi_vc2_to_ipu2_csi0: endpoint {
+			remote-endpoint = <&ipu2_csi0_from_mipi_vc2>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+
+		mipi_vc3_to_ipu2_csi1_mux: endpoint {
+			remote-endpoint = <&ipu2_csi1_mux_from_mipi_vc3>;
+		};
+	};
+};
+
 &mipi_dsi {
 	ports {
 		port@2 {
@@ -335,3 +713,112 @@
 &vpu {
 	compatible = "fsl,imx6q-vpu", "cnm,coda960";
 };
+
+&media0 {
+	m2m1: m2m@1 {
+		compatible = "fsl,imx-media-mem2mem";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <2>;
+		reg = <1>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+			m2m1_from_ic_pp0: endpoint {
+				remote-endpoint = <&ipu2_ic_pp0_to_m2m1>;
+			};
+			m2m1_from_ic_prpvf: prpvf-endpoint {
+				remote-endpoint = <&ipu2_ic_prpvf_to_m2m1>;
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+			m2m1_to_ic_prpvf: prpvf-endpoint {
+				remote-endpoint = <&ipu2_ic_prpvf_from_m2m1>;
+			};
+			m2m1_to_ic_pp0: pp0-endpoint {
+				remote-endpoint = <&ipu2_ic_pp0_from_m2m1>;
+			};
+		};
+
+		port@3 {
+			reg = <3>;
+		};
+	};
+
+	camif2: camif@2 {
+		compatible = "fsl,imx-media-camif";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <1>;
+		reg = <2>;
+
+		port@0 {
+			reg = <0>;
+			camif2_from_smfc0: smfc0-endpoint {
+				remote-endpoint = <&ipu2_smfc0_to_camif2>;
+			};
+			camif2_from_smfc1: smfc1-endpoint {
+				remote-endpoint = <&ipu2_smfc1_to_camif2>;
+			};
+			camif2_from_ic_prpenc: prpenc-endpoint {
+				remote-endpoint = <&ipu2_ic_prpenc_to_camif2>;
+			};
+			camif2_from_ic_prpvf: prpvf-endpoint {
+				remote-endpoint = <&ipu2_ic_prpvf_to_camif2>;
+			};
+			camif2_from_ic_pp1: pp1-endpoint {
+				remote-endpoint = <&ipu2_ic_pp1_to_camif2>;
+			};
+			camif2_from_ic_pp2: pp2-endpoint {
+				remote-endpoint = <&ipu2_ic_pp2_to_camif2>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+		};
+	};
+
+	camif3: camif@3 {
+		compatible = "fsl,imx-media-camif";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		sink-ports = <1>;
+		reg = <3>;
+
+		port@0 {
+			reg = <0>;
+			camif3_from_smfc0: smfc0-endpoint {
+				remote-endpoint = <&ipu2_smfc0_to_camif3>;
+			};
+			camif3_from_smfc1: smfc1-endpoint {
+				remote-endpoint = <&ipu2_smfc1_to_camif3>;
+			};
+			camif3_from_ic_prpenc: prpenc-endpoint {
+				remote-endpoint = <&ipu2_ic_prpenc_to_camif3>;
+			};
+			camif3_from_ic_prpvf: prpvf-endpoint {
+				remote-endpoint = <&ipu2_ic_prpvf_to_camif3>;
+			};
+			camif3_from_ic_pp1: pp1-endpoint {
+				remote-endpoint = <&ipu2_ic_pp1_to_camif3>;
+			};
+			camif3_from_ic_pp2: pp2-endpoint {
+				remote-endpoint = <&ipu2_ic_pp2_to_camif3>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2465187..ea1e2f3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1123,6 +1123,8 @@
 			mipi_csi: mipi@021dc000 {
 				compatible = "fsl,imx-mipi-csi2";
 				reg = <0x021dc000 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <0 100 0x04>, <0 101 0x04>;
 				clocks = <&clks IMX6QDL_CLK_HSI_TX>,
 					 <&clks IMX6QDL_CLK_VIDEO_27M>,
@@ -1227,11 +1229,263 @@
 			resets = <&src 2>;
 
 			ipu1_csi0: ipu1_csi@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
 				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_csi0_from_ipu1_csi0_mux: endpoint {
+						remote-endpoint = <&ipu1_csi0_mux_to_ipu1_csi0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_csi0_to_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu1_smfc0_from_csi0>;
+					};
+					ipu1_csi0_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_from_csi0>;
+					};
+					ipu1_csi0_to_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu1_ic_prpenc_from_csi0>;
+					};
+				};
 			};
 
 			ipu1_csi1: ipu1_csi@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <1>;
+
+				port@1 {
+					reg = <1>;
+					ipu1_csi1_to_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu1_smfc1_from_csi1>;
+					};
+					ipu1_csi1_to_ic_prpvf: prendpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_from_csi1>;
+					};
+					ipu1_csi1_to_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu1_ic_prpenc_from_csi1>;
+					};
+				};
+			};
+
+			ipu1_smfc0: ipu1_smfc@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_smfc0_from_csi0: endpoint {
+						remote-endpoint = <&ipu1_csi0_to_smfc0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_smfc0_to_ic_pp1: pp-endpoint {
+						remote-endpoint = <&ipu1_ic_pp1_from_smfc0>;
+					};
+					ipu1_smfc0_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_from_smfc0>;
+					};
+					ipu1_smfc0_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_smfc0>;
+					};
+					ipu1_smfc0_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_smfc0>;
+					};
+				};
+			};
+
+			ipu1_smfc1: ipu1_smfc@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
 				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_smfc1_from_csi1: endpoint {
+						remote-endpoint = <&ipu1_csi1_to_smfc1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_smfc1_to_ic_pp2: pp-endpoint {
+						remote-endpoint = <&ipu1_ic_pp2_from_smfc1>;
+					};
+					ipu1_smfc1_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_from_smfc1>;
+					};
+					ipu1_smfc1_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_smfc1>;
+					};
+					ipu1_smfc1_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_smfc1>;
+					};
+				};
+			};
+
+			ipu1_ic_prpenc: ipu1_ic_prpenc@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_ic_prpenc_from_csi0: csi0-endpoint {
+						remote-endpoint = <&ipu1_csi0_to_ic_prpenc>;
+					};
+					ipu1_ic_prpenc_from_csi1: csi1-endpoint {
+						remote-endpoint = <&ipu1_csi1_to_ic_prpenc>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_ic_prpenc_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_ic_prpenc>;
+					};
+					ipu1_ic_prpenc_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_ic_prpenc>;
+					};
+				};
+			};
+
+			ipu1_ic_prpvf: ipu1_ic_prpvf@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_ic_prpvf_from_csi0: csi0-endpoint {
+						remote-endpoint = <&ipu1_csi0_to_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_from_csi1: csi1-endpoint {
+						remote-endpoint = <&ipu1_csi1_to_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu1_smfc0_to_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu1_smfc1_to_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_from_m2m0: m2m0-endpoint {
+						remote-endpoint = <&m2m0_to_ic_prpvf>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_ic_prpvf_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_to_ic_pp0: pp0-endpoint {
+						remote-endpoint = <&ipu1_ic_pp0_from_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_to_ic_pp1: pp1-endpoint {
+						remote-endpoint = <&ipu1_ic_pp1_from_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_to_ic_pp2: pp2-endpoint {
+						remote-endpoint = <&ipu1_ic_pp2_from_ic_prpvf>;
+					};
+					ipu1_ic_prpvf_to_m2m0: m2m0-endpoint {
+						remote-endpoint = <&m2m0_from_ic_prpvf>;
+					};
+				};
+			};
+
+			ipu1_ic_pp0: ipu1_ic_pp@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_ic_pp0_from_m2m0: m2m0-endpoint {
+						remote-endpoint = <&m2m0_to_ic_pp0>;
+					};
+					ipu1_ic_pp0_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_ic_pp0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_ic_pp0_to_m2m0: endpoint {
+						remote-endpoint = <&m2m0_from_ic_pp0>;
+					};
+				};
+			};
+
+			ipu1_ic_pp1: ipu1_ic_pp@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_ic_pp1_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu1_smfc0_to_ic_pp1>;
+					};
+					ipu1_ic_pp1_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_ic_pp1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_ic_pp1_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_ic_pp1>;
+					};
+					ipu1_ic_pp1_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_ic_pp1>;
+					};
+				};
+			};
+
+			ipu1_ic_pp2: ipu1_ic_pp@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sink-ports = <1>;
+				reg = <2>;
+
+				port@0 {
+					reg = <0>;
+					ipu1_ic_pp2_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu1_smfc1_to_ic_pp2>;
+					};
+					ipu1_ic_pp2_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_ic_pp2>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ipu1_ic_pp2_to_camif0: camif0-endpoint {
+						remote-endpoint = <&camif0_from_ic_pp2>;
+					};
+					ipu1_ic_pp2_to_camif1: camif1-endpoint {
+						remote-endpoint = <&camif1_from_ic_pp2>;
+					};
+				};
 			};
 
 			ipu1_di0: ipu1_di@0 {
@@ -1284,5 +1538,119 @@
 				};
 			};
 		};
+
+		media0: media@0 {
+			compatible = "fsl,imx-media", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+
+			m2m0: m2m@0 {
+				compatible = "fsl,imx-media-mem2mem";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+				sink-ports = <2>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+					m2m0_from_ic_pp0: endpoint {
+						remote-endpoint = <&ipu1_ic_pp0_to_m2m0>;
+					};
+					m2m0_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_m2m0>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					m2m0_to_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_from_m2m0>;
+					};
+					m2m0_to_ic_pp0: pp0-endpoint {
+						remote-endpoint = <&ipu1_ic_pp0_from_m2m0>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+				};
+			};
+
+			camif0: camif@0 {
+				compatible = "fsl,imx-media-camif";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+				sink-ports = <1>;
+				reg = <0>;
+
+				port@0 {
+					reg = <0>;
+					camif0_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu1_smfc0_to_camif0>;
+					};
+					camif0_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu1_smfc1_to_camif0>;
+					};
+					camif0_from_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu1_ic_prpenc_to_camif0>;
+					};
+					camif0_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_camif0>;
+					};
+					camif0_from_ic_pp1: pp1-endpoint {
+						remote-endpoint = <&ipu1_ic_pp1_to_camif0>;
+					};
+					camif0_from_ic_pp2: pp2-endpoint {
+						remote-endpoint = <&ipu1_ic_pp2_to_camif0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+
+			camif1: camif@1 {
+				compatible = "fsl,imx-media-camif";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+				sink-ports = <1>;
+				reg = <1>;
+
+				port@0 {
+					reg = <0>;
+					camif1_from_smfc0: smfc0-endpoint {
+						remote-endpoint = <&ipu1_smfc0_to_camif1>;
+					};
+					camif1_from_smfc1: smfc1-endpoint {
+						remote-endpoint = <&ipu1_smfc1_to_camif1>;
+					};
+					camif1_from_ic_prpenc: prpenc-endpoint {
+						remote-endpoint = <&ipu1_ic_prpenc_to_camif1>;
+					};
+					camif1_from_ic_prpvf: prpvf-endpoint {
+						remote-endpoint = <&ipu1_ic_prpvf_to_camif1>;
+					};
+					camif1_from_ic_pp1: pp1-endpoint {
+						remote-endpoint = <&ipu1_ic_pp1_to_camif1>;
+					};
+					camif1_from_ic_pp2: pp2-endpoint {
+						remote-endpoint = <&ipu1_ic_pp2_to_camif1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
 	};
 };
-- 
2.7.4

