From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 22 Apr 2013 10:02:22 +0000
Subject: [PATCH 1/4] ARM: cfa10036: dt: Change i2c0 clock frequency
Message-Id: <1366624945-5708-2-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The OLED display can work faster. Change the i2c controller clock
frequency to remove the tearing effect that can be seen on the display.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 40488f5a8..a524caf 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -67,6 +67,7 @@
 			i2c0: i2c@80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_b>;
+				clock-frequency = <400000>;
 				status = "okay";
 
 				ssd1306: oled@3c {
-- 
1.7.10.4

