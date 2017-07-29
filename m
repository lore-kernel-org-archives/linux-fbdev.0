From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:17:50 +0000
Subject: [PATCH 6/6] ARM: dts: da850-lego-ev3: Add node for LCD display
Message-Id: <1501355870-13960-7-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This adds a new node for the LEGO MINDSTORMS EV3 LCD display.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 45983c0..249b317 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -249,6 +249,15 @@
 			0x4c 0x00000080 0x000000f0
 		>;
 	};
+
+	ev3_lcd_pins: pinmux_lcd {
+		pinctrl-single,bits = <
+			/* SIMO, GP2[11], GP2[12], CLK */
+			0x14 0x00188100 0x00ffff00
+			/* GP5[0] */
+			0x30 0x80000000 0xf0000000
+		>;
+	};
 };
 
 &pinconf {
@@ -357,6 +366,21 @@
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&ev3_lcd_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+
+	display@0{
+		compatible = "lego,ev3-lcd";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &ehrpwm0 {
 	status = "okay";
 };
-- 
2.7.4

