From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 25 Jul 2019 22:02:05 +0000
Subject: [PATCH 01/11] MIPS: DTS: jz4740: Add missing nodes
Message-Id: <20190725220215.460-2-paul@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Paul Cercueil <paul@crapouillou.net>, Artur Rojek <contact@artur-rojek.eu>

Add nodes for the MMC, AIC, ADC, CODEC, MUSB, LCD, memory,
and BCH controllers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 3ffaf63f22dd..bceabf494af5 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -132,6 +132,35 @@
 		};
 	};
 
+	aic: audio-controller@10020000 {
+		compatible = "ingenic,jz4740-i2s";
+		reg = <0x10020000 0x38>;
+
+		#sound-dai-cells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		clocks = <&cgu JZ4740_CLK_AIC>,
+			 <&cgu JZ4740_CLK_I2S>,
+			 <&cgu JZ4740_CLK_EXT>,
+			 <&cgu JZ4740_CLK_PLL_HALF>;
+		clock-names = "aic", "i2s", "ext", "pll half";
+
+		dmas = <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
+		dma-names = "rx", "tx";
+	};
+
+	codec: audio-codec@100200a4 {
+		compatible = "ingenic,jz4740-codec";
+		reg = <0x10020080 0x8>;
+
+		#sound-dai-cells = <0>;
+
+		clocks = <&cgu JZ4740_CLK_AIC>;
+		clock-names = "aic";
+	};
+
 	mmc: mmc@10021000 {
 		compatible = "ingenic,jz4740-mmc";
 		reg = <0x10021000 0x1000>;
@@ -172,6 +201,38 @@
 		clock-names = "baud", "module";
 	};
 
+	adc: adc@10070000 {
+		compatible = "ingenic,jz4740-adc";
+		reg = <0x10070000 0x30>;
+		#io-channel-cells = <1>;
+
+		clocks = <&cgu JZ4740_CLK_ADC>;
+		clock-names = "adc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <12>;
+	};
+
+	nemc: memory-controller@13010000 {
+		compatible = "ingenic,jz4740-nemc";
+		reg = <0x13010000 0x54>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <1 0 0x18000000 0x4000000
+			  2 0 0x14000000 0x4000000
+			  3 0 0x0c000000 0x4000000
+			  4 0 0x08000000 0x4000000>;
+
+		clocks = <&cgu JZ4740_CLK_MCLK>;
+	};
+
+	ecc: ecc-controller@13010100 {
+		compatible = "ingenic,jz4740-ecc";
+		reg = <0x13010100 0x2C>;
+
+		clocks = <&cgu JZ4740_CLK_MCLK>;
+	};
+
 	dmac: dma-controller@13020000 {
 		compatible = "ingenic,jz4740-dma";
 		reg = <0x13020000 0xbc
@@ -197,4 +258,27 @@
 
 		status = "disabled";
 	};
+
+	udc: usb@13040000 {
+		compatible = "ingenic,jz4740-musb";
+		reg = <0x13040000 0x10000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <24>;
+		interrupt-names = "mc";
+
+		clocks = <&cgu JZ4740_CLK_UDC>;
+		clock-names = "udc";
+	};
+
+	lcd: lcd-controller@13050000 {
+		compatible = "ingenic,jz4740-lcd";
+		reg = <0x13050000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <30>;
+
+		clocks = <&cgu JZ4740_CLK_LCD_PCLK>, <&cgu JZ4740_CLK_LCD>;
+		clock-names = "lcd_pclk", "lcd";
+	};
 };
-- 
2.21.0.593.g511ec345e18
