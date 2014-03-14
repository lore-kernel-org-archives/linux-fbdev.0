From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 10:55:52 +0000
Subject: [PATCH v15][ 2/3] video: imxfb: Add DT default contrast control register property.
Message-Id: <1394794553-14719-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394794553-14719-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394794553-14719-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
ChangeLog v14->v15:
- Moved the Cc into git send-email.
- Rebased.

ChangeLog v5->v14:
- Remove people not concerned by this patch from the Cc list.
- Changed the property name to match the register name and function.
- Updated the documentation, code and commit message accordingly.
---
 .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
 drivers/video/fbdev/imxfb.c                        |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
index e6b1ee9..0329f60 100644
--- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
@@ -18,6 +18,9 @@ Optional properties:
 - lcd-supply: Regulator for LCD supply voltage.
 - fsl,dmacr: DMA Control Register value. This is optional. By default, the
 	register is not modified as recommended by the datasheet.
+- fsl,lpccr: Contrast Control Register value. This property provides the
+	default value for the contrast control register.
+	If that property is ommited, the register is zeroed.
 - fsl,lscr1: LCDC Sharp Configuration Register value.
 
 Example:
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 086e024..f6e6216 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -670,6 +670,9 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 		fbi->cmap_static = of_property_read_bool(np, "cmap-static");
 
 		fbi->lscr1 = IMXFB_LSCR1_DEFAULT;
+
+		of_property_read_u32(np, "fsl,lpccr", &fbi->pwmr);
+
 		of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
 
 		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
-- 
1.7.9.5

