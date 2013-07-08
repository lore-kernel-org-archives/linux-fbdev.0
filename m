From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 08 Jul 2013 02:55:45 +0000
Subject: [PATCH V5 1/4] ARM: dts: Add DP PHY node to exynos5250.dtsi
Message-Id: <001c01ce7b86$a4872f00$ed958d00$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add PHY provider node for the DP PHY.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index ef57277..2c1e73c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -614,6 +614,12 @@
 		interrupts = <0 94 0>;
 	};
 
+	dp_phy: video-phy@10040720 {
+		compatible = "samsung,exynos5250-dp-video-phy";
+		reg = <0x10040720 4>;
+		#phy-cells = <0>;
+	};
+
 	dp-controller {
 		compatible = "samsung,exynos5-dp";
 		reg = <0x145b0000 0x1000>;
@@ -623,11 +629,8 @@
 		clock-names = "dp";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		dptx-phy {
-			reg = <0x10040720>;
-			samsung,enable-mask = <1>;
-		};
+		phys = <&dp_phy>;
+		phy-names = "dp";
 	};
 
 	fimd {
-- 
1.7.10.4


