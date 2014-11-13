From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 09:31:45 +0000
Subject: [PATCH 3/7] ARM: dts: sun5i: Add simplefb node
Message-Id: <1415871109-28332-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a simplefb template node for u-boot to further fill and activate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 7089284..dcea088 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -24,6 +24,18 @@
 		serial3 = &uart3;
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer0 {
+			compatible = "simple-framebuffer";
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a8";
-- 
2.1.0

