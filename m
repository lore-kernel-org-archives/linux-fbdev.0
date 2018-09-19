From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Date: Wed, 19 Sep 2018 13:17:29 +0000
Subject: [PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <1537363049-48399-3-git-send-email-michal.vokac@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>

The reset signal of the SSD1306 OLED display is actually active-low.
Adapt the DT to reflect the real world.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v2 changes: New patch in the series

 arch/arm/boot/dts/imx28-cfa10036.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index e54f5ab..be3406e 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "imx28.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Crystalfontz CFA-10036 Board";
@@ -95,7 +96,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&ssd1306_cfa10036>;
 					reg = <0x3c>;
-					reset-gpios = <&gpio2 7 0>;
+					reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
 					solomon,height = <32>;
 					solomon,width = <128>;
 					solomon,page-offset = <0>;
-- 
2.1.4
