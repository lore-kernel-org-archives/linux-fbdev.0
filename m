From: Martin Kaiser <martin@kaiser.cx>
Date: Fri, 21 Apr 2017 07:45:53 +0000
Subject: [PATCH 2/2 v3 resend] dt-bindings: display: imx: entry for AUS mode
Message-Id: <1492760753-8374-2-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <1492760753-8374-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1492760753-8374-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>

Allow setting the AUS mode for a display from the device tree.
Use an optional boolean property. AUS mode can be set only on imx21
and compatible chipsets.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Rob Herring <robh@kernel.org>
---
re-sending v3, rebased against current linux-next
it seems this got lost along the way, there was a bit of confusion
whether to split this in two patches or not

v3:
   use a boolean DT property instead of the register value
   separate patches for DT binding and code changes

v2:
   re-sending DT bindings and code changes as one patch

 Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
index 7a5c0e2..cacae0e 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
@@ -13,6 +13,8 @@ Required nodes:
 	Additional, the display node has to define properties:
 	- bits-per-pixel: Bits per pixel
 	- fsl,pcr: LCDC PCR value
+	A display node may optionally define
+	- fsl,aus_mode: boolean to enable AUS mode (only for imx21)
 
 Optional properties:
 - lcd-supply: Regulator for LCD supply voltage.
-- 
2.1.4

