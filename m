From: Karsten Merker <merker@debian.org>
Date: Sat, 24 Oct 2015 21:07:31 +0000
Subject: [PATCH] ARM: dts: sunxi: sun6i-a31s-primo81.dts: add touchscreen axis swapping property
Message-Id: <1445720851-2148-1-git-send-email-merker@debian.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151024205716.GA16644@excalibur.cnev.de>
In-Reply-To: <20151024205716.GA16644@excalibur.cnev.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The MSI Primo81 has a display in portrait mode but a touchscreen
in landscape mode.  To have both of them use the same coordinate
system, the touchscreen-swapped-x-y property has to be set
for the touchscreen.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 2d4250b..68b479b 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -83,6 +83,7 @@
 		reg = <0x5d>;
 		interrupt-parent = <&pio>;
 		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
+		touchscreen-swapped-x-y;
 	};
 };
 
-- 
2.1.4

