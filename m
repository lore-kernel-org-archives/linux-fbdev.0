From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 14 Jun 2013 17:45:48 +0000
Subject: [RFC PATCH 2/5] ARM: dts: Add MIPI PHY node to exynos4.dtsi
Message-Id: <1371231951-1969-3-git-send-email-s.nawrocki@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add PHY provider node for the MIPI CSIS and MIPI DSIM PHYs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d505ece..4b7ce52 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -120,12 +120,20 @@
 		reg = <0x10010000 0x400>;
 	};
 
+	mipi_phy: video-phy {
+		compatible = "samsung,s5pv210-video-phy";
+		reg = <0x10020710 8>;
+		#phy-cells = <1>;
+	};
+
 	dsi_0: dsi@11C80000 {
 		compatible = "samsung,exynos4210-mipi-dsi";
 		reg = <0x11C80000 0x10000>;
 		interrupts = <0 79 0>;
 		samsung,phy-type = <0>;
 		samsung,power-domain = <&pd_lcd0>;
+		phys = <&mipi_phy 1>;
+		phy-names = "dsim";
 		clocks = <&clock 286>, <&clock 143>;
 		clock-names = "bus_clk", "pll_clk";
 		status = "disabled";
@@ -181,6 +189,8 @@
 			interrupts = <0 78 0>;
 			bus-width = <4>;
 			samsung,power-domain = <&pd_cam>;
+			phys = <&mipi_phy 0>;
+			phy-names = "csis";
 			status = "disabled";
 		};
 
@@ -190,6 +200,8 @@
 			interrupts = <0 80 0>;
 			bus-width = <2>;
 			samsung,power-domain = <&pd_cam>;
+			phys = <&mipi_phy 2>;
+			phy-names = "csis";
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5

