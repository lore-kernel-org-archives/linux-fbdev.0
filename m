From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:07 +0000
Subject: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
Message-Id: <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b99ec25b748..9e7581eaeb23 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -434,6 +434,13 @@
 	pinctrl-0 = <&i2c5_pins>;
 
 	clock-frequency = <400000>;
+
+	tca6424a: tca6424a@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcbsp3 {
-- 
1.9.1

