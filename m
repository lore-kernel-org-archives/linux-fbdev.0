From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:18 +0000
Subject: [PATCH 09/11] ARM: PB11MPCore: define a standard VGA panel
Message-Id: <1454594660-7532-10-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Let's supply a standard VGA panel by default on the PB11MPCore,
this will work with most monitors. If more screen real estate is
desired, users can update the DPI definition.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 3d9b1b0f4ffc..9e744c83f5ee 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -629,16 +629,17 @@
 					};
 				};
 
+				/* Standard 640x480 VGA timings */
 				panel-timing {
-					clock-frequency = <63500127>;
-					hactive = <1024>;
-					hback-porch = <152>;
-					hfront-porch = <48>;
-					hsync-len = <104>;
-					vactive = <768>;
-					vback-porch = <23>;
-					vfront-porch = <3>;
-					vsync-len = <4>;
+					clock-frequency = <25175000>;
+					hactive = <640>;
+					hback-porch = <48>;
+					hfront-porch = <16>;
+					hsync-len = <96>;
+					vactive = <480>;
+					vback-porch = <33>;
+					vfront-porch = <10>;
+					vsync-len = <2>;
 				};
 			};
 		};
-- 
2.4.3

