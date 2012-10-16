From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:48 +0000
Subject: [PATCH 7/9] drivers/video: fsl-diu-fb: clean up reset of primary display
Message-Id: <1350426830-12140-7-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 4b5006ec ("shared DIU framebuffer support") added the ability to
retain the splash screen until the framebuffer is opened by user space.
Clean up this code to eliminate redundant writes to registers, and eliminate
the use of dummy area descriptor.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index fa7f200..37175ac 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -496,8 +496,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 
 	switch (mfbi->index) {
 	case PLANE0:
-		if (hw->desc[0] != ad->paddr)
-			wr_reg_wa(&hw->desc[0], ad->paddr);
+		wr_reg_wa(&hw->desc[0], ad->paddr);
 		break;
 	case PLANE1_AOI0:
 		cmfbi = &data->mfb[2];
@@ -549,8 +548,7 @@ static void fsl_diu_disable_panel(struct fb_info *info)
 
 	switch (mfbi->index) {
 	case PLANE0:
-		if (hw->desc[0] != data->dummy_ad.paddr)
-			wr_reg_wa(&hw->desc[0], data->dummy_ad.paddr);
+		wr_reg_wa(&hw->desc[0], 0);
 		break;
 	case PLANE1_AOI0:
 		cmfbi = &data->mfb[2];
@@ -1519,7 +1517,6 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
 	struct fsl_diu_data *data;
-	int diu_mode;
 	dma_addr_t dma_addr; /* DMA addr of fsl_diu_data struct */
 	unsigned int i;
 	int ret;
@@ -1584,10 +1581,6 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	diu_mode = in_be32(&data->diu_reg->diu_mode);
-	if (diu_mode = MFB_MODE0)
-		out_be32(&data->diu_reg->diu_mode, 0); /* disable DIU */
-
 	/* Get the IRQ of the DIU */
 	data->irq = irq_of_parse_and_map(np, 0);
 
@@ -1609,11 +1602,11 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	data->dummy_ad.paddr = DMA_ADDR(data, dummy_ad);
 
 	/*
-	 * Let DIU display splash screen if it was pre-initialized
-	 * by the bootloader, set dummy area descriptor otherwise.
+	 * Let DIU continue to display splash screen if it was pre-initialized
+	 * by the bootloader; otherwise, clear the display.
 	 */
-	if (diu_mode = MFB_MODE0)
-		out_be32(&data->diu_reg->desc[0], data->dummy_ad.paddr);
+	if (in_be32(&data->diu_reg->diu_mode) = MFB_MODE0)
+		out_be32(&data->diu_reg->desc[0], 0);
 
 	out_be32(&data->diu_reg->desc[1], data->dummy_ad.paddr);
 	out_be32(&data->diu_reg->desc[2], data->dummy_ad.paddr);
-- 
1.7.3.4


