From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 09 Jun 2016 09:44:30 +0000
Subject: [RFC v4 13/14] ARM: dts: exynos: Switch the buck8 to GPIO mode on Odroid U3
Message-Id: <1465465471-28740-14-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switch the control of buck8 to GPIO mode. It is faster than I2C/register
mode and it is the easiest way to disable it (regulator state is a
logical OR state of GPIO and register value).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index d73aa6c58fe3..31cdc036fda4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -74,6 +74,7 @@
 	regulator-name = "BUCK8_P3V3";
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
+	maxim,ena-gpios = <&gpa1 1 GPIO_ACTIVE_HIGH>;
 };
 
 /* VDDQ for MSHC (eMMC card) */
-- 
1.9.1

