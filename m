From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 24 Sep 2013 14:23:16 +0000
Subject: [RFC PATCH 4/4] ARM: dts: exynos4210-trats: add panel and dsi nodes
Message-Id: <1380032596-18612-5-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380032596-18612-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380032596-18612-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

The patch adds mipi-dsi-exynos bus master node
and s6e8aa0 panel subnode to trats device.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Conflicts:
	arch/arm/boot/dts/exynos4210-trats.dts
---
 arch/arm/boot/dts/exynos4210-trats.dts | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 94eebff..6f1a034 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -301,4 +301,58 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	dsi_0: dsi@11C80000 {
+		samsung,pll-stable-time = <500>;
+		samsung,stop-holding-count = <0x7ff>;
+		samsung,bta-timeout = <0xff>;
+		samsung,rx-timeout = <0xffff>;
+		samsung,pll-clk-freq = <24000000>;
+		samsung,cmd-allow = <0xf>;
+		vdd11-supply = <&vusb_reg>;
+		vdd18-supply = <&vmipi_reg>;
+		status = "okay";
+
+		fimd0_lcd: panel {
+			compatible = "samsung,s6e8aa0";
+			reset-gpio = <&gpy4 5 0>;
+			power-on-delay= <50>;
+			reset-delay = <100>;
+			init-delay = <100>;
+			vdd3-supply = <&vcclcd_reg>;
+			vci-supply = <&vlcd_reg>;
+			video-source = <&dsi_0>;
+			flip-horizontal;
+			flip-vertical;
+			samsung,panel-width-mm = <58>;
+			samsung,panel-height-mm = <103>;
+
+			display-timings {
+				native-mode = <&timing0>;
+
+				timing0: timing-0 {
+					clock-frequency = <0>;
+					hactive = <720>;
+					vactive = <1280>;
+					hfront-porch = <5>;
+					hback-porch = <5>;
+					hsync-len = <5>;
+					vfront-porch = <13>;
+					vback-porch = <1>;
+					vsync-len = <2>;
+				};
+			};
+		};
+	};
+
+	fimd@11c00000 {
+		samsung,fimd-display = <&fimd0_lcd>;
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-vclk;
+		samsung,fimd-frame-rate = <60>;
+		samsung,default-window = <3>;
+		samsung,fimd-win-bpp = <32>;
+		status = "okay";
+	};
+
 };
-- 
1.8.1.2

