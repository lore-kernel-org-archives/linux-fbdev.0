From: Mans Rullgard <mans@mansr.com>
Date: Tue, 12 Jan 2016 10:22:20 +0000
Subject: [RESEND PATCH 1/2] devicetree: mxsfb: add reset-active property
Message-Id: <1452594141-26073-1-git-send-email-mans@mansr.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Some boards connect the LCD_RESET pin to a reset input on the
display panel.  On these boards, this pin must be set to the
proper level for the display to function.

This adds an optional "reset-active" property to the "display"
subnode such that devicetrees can specify the desired polarity
of the LCD_RESET pin.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index 96ec5179c8a0..cb7212a6bdf2 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -13,6 +13,11 @@ Required properties:
 - bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
 - bus-width : number of data lines.  Could be <8>, <16>, <18> or <24>.
 
+Optional properties:
+- reset-active : <0>: reset pin is active low
+                 <1>: reset pin is active high
+                 omitted: reset pin not used
+
 Required sub-node:
 - display-timings : Refer to binding doc display-timing.txt for details.
 
-- 
2.7.0

