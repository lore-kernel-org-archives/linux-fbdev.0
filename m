From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 Sep 2016 21:25:34 +0000
Subject: [PATCH 5/6] ARM: dts: add PMU to the NHK15 device tree
Message-Id: <1473456335-22767-6-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The so-called Nomadik Power Mangament Unit is actually a set
of some power management registers and some miscellaneous
system control stuff like muxing of entire hardware units.
Add this as a system controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index d2d532a9d783..80a3c9ccccd9 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -168,6 +168,12 @@
 		};
 	};
 
+	/* Power Management Unit */
+	pmu: pmu@101e9000 {
+		compatible = "stericsson,nomadik-pmu", "syscon";
+		reg = <0x101e0000 0x1000>;
+	};
+
 	src: src@101e0000 {
 		compatible = "stericsson,nomadik-src";
 		reg = <0x101e0000 0x1000>;
-- 
2.7.4

