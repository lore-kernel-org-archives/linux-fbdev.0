From: Marko Kohtala <marko.kohtala@okoko.fi>
Date: Tue, 18 Jun 2019 07:41:10 +0000
Subject: [PATCH 5/6] dt-bindings: display: ssd1307fb: Add initialization properties
Message-Id: <20190618074111.9309-6-marko.kohtala@okoko.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190618074111.9309-1-marko.kohtala@okoko.fi>
In-Reply-To: <20190618074111.9309-1-marko.kohtala@okoko.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

Document new bindings for adapting ssd1307fb driver to new displays.

Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
---
 .../devicetree/bindings/display/ssd1307fb.txt          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index b67f8caa212c..27333b9551b3 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -27,6 +27,15 @@ Optional properties:
   - solomon,prechargep2: Length of precharge period (phase 2) in clock cycles.
                          This needs to be the higher, the higher the capacitance
                          of the OLED's pixels is
+  - solomon,dclk-div: Clock divisor 1 to 16
+  - solomon,dclk-frq: Clock frequency 0 to 15, higher value means higher
+                      frequency
+  - solomon,lookup-table: 8 bit value array of current drive pulse widths for
+                          BANK0, and colors A, B, and C. Each value in range
+                          of 31 to 63 for pulse widths of 32 to 64. Color D
+                          is always width 64.
+  - solomon,area-color-enable: Display uses color mode
+  - solomon,low-power. Display runs in low power mode
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 
@@ -46,4 +55,5 @@ ssd1306: oled@3c {
         solomon,com-lrremap;
         solomon,com-invdir;
         solomon,com-offset = <32>;
+        solomon,lookup-table = /bits/ 8 <0x3f 0x3f 0x3f 0x3f>;
 };
-- 
2.17.1
