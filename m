From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 Sep 2016 21:25:30 +0000
Subject: [PATCH 1/6] ARM: dts: add STMPE PWM to the NHK15 device tree
Message-Id: <1473456335-22767-2-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds the STMPE PWM to the NHK15 device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index d35aa88791ad..3ec5c653ad56 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -140,6 +140,10 @@
 						0x03020067 // Up
 						0x0303006c>; // Down
 			};
+			stmpe0_pwm: stmpe_pwm {
+				compatible = "st,stmpe-pwm";
+				#pwm-cells = <2>;
+			};
 		};
 		stmpe1: stmpe2401@44 {
 			compatible = "st,stmpe2401";
@@ -183,4 +187,24 @@
 			wp-gpios = <&stmpe_gpio44 18 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&stmpe0_pwm 0 500000>;
+		pwm-names = "backlight";
+		brightness-levels = <
+			0  1  2  3  4  5  6  7  8  9
+			10 11 12 13 14 15 16 17 18 19
+			20 21 22 23 24 25 26 27 28 29
+			30 31 32 33 34 35 36 37 38 39
+			40 41 42 43 44 45 46 47 48 49
+			50 51 52 53 54 55 56 57 58 59
+			60 61 62 63 64 65 66 67 68 69
+			70 71 72 73 74 75 76 77 78 79
+			80 81 82 83 84 85 86 87 88 89
+			90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <100>;
+	};
 };
-- 
2.7.4

