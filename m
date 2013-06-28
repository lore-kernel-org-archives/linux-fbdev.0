From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 28 Jun 2013 13:43:07 +0000
Subject: [PATCH v4 1/5] ARM: dts: Add MIPI PHY node to exynos4.dtsi
Message-Id: <1372426991-2482-2-git-send-email-s.nawrocki@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372426991-2482-1-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1372426991-2482-1-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add PHY provider node for the MIPI CSIS and MIPI DSIM PHYs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 4d61120..1750511 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -49,6 +49,12 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	mipi_phy: video-phy@10020710 {
+		compatible = "samsung,s5pv210-mipi-video-phy";
+		reg = <0x10020710 8>;
+		#phy-cells = <1>;
+	};
+
 	pd_mfc: mfc-power-domain@10023C40 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C40 0x20>;
@@ -147,6 +153,8 @@
 			interrupts = <0 78 0>;
 			bus-width = <4>;
 			samsung,power-domain = <&pd_cam>;
+			phys = <&mipi_phy 0>;
+			phy-names = "csis";
 			status = "disabled";
 		};
 
@@ -156,6 +164,8 @@
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

