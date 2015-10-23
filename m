From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 23 Oct 2015 03:50:40 +0000
Subject: [PATCH v4 3/4] ARM: dts: sun6i: Add simplefb node labels to reference at board level
Message-Id: <1445572241-13259-4-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
In-Reply-To: <1445572241-13259-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Some boards, such as tablets, have regulators providing power to parts
of the display pipeline, like signal converters and LCD panels.

Add labels to the simplefb device nodes so that we can reference them
in the board dts files to add regulator supply properties.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 83c18798cae0..b6ad7850fac6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -61,7 +61,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer@0 {
+		simplefb_hdmi: framebuffer@0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
@@ -69,7 +69,7 @@
 			status = "disabled";
 		};
 
-		framebuffer@1 {
+		simplefb_lcd: framebuffer@1 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-- 
2.6.1

