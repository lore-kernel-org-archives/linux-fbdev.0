From: Marek Belisko <marek@goldelico.com>
Date: Wed, 12 Nov 2014 22:10:47 +0000
Subject: [PATCH v2 5/5] arm: dts: omap3-gta04: Add static configuration for devconf1 register
Message-Id: <1415830247-31633-6-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1415830247-31633-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
Add pinctrl single entry and enable it.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b50dc10..0015316 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -497,3 +497,14 @@
 		};
 	};
 };
+
+&control_devconf1 {
+	pinctrl-name = "default";
+	pinctrl-0 = <&tv_acbias_pins>;
+
+	tv_acbias_pins: pinmux_tv_acbias_pins {
+		pinctrl-single,bits = <
+			0 0x40800 0x40800
+		>;
+	};
+};
-- 
1.9.1

