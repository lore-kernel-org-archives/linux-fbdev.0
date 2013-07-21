From: Alexander Shiyan <shc_work@mail.ru>
Date: Sun, 21 Jul 2013 08:35:09 +0000
Subject: [PATCH 2/2] video: imxfb: Add feature to setup PWM Contrast Control Register
Message-Id: <1374395709-20898-2-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374395709-20898-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1374395709-20898-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds feature to setup PWM Contrast Control Register.
This register is used to control the signal output at the contrast pin,
which controls contrast of the LCD panel.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/video/fsl,imx-fb.txt | 1 +
 drivers/video/imxfb.c                                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
index 46da08d..be10c65 100644
--- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
@@ -18,6 +18,7 @@ Optional properties:
 - fsl,dmacr: DMA Control Register value. This is optional. By default, the
 	register is not modified as recommended by the datasheet.
 - fsl,lscr1: LCDC Sharp Configuration Register value.
+- fsl,pwmr: LCDC PWM Contrast Control Register value.
 
 Example:
 
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 8e104c4..d98299a 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -806,8 +806,8 @@ static int imxfb_init_fbinfo(struct platform_device *pdev,
 
 		fbi->lscr1 = IMXFB_LSCR1_DEFAULT;
 		of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
-
 		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
+		of_property_read_u32(np, "fsl,pwmr", &fbi->pwmr);
 
 		/* These two function pointers could be used by some specific
 		 * platforms. */
-- 
1.8.1.5

