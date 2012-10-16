From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:45 +0000
Subject: [PATCH 4/9] drivers/video: fsl-diu-fb: streamline enabling of interrupts
Message-Id: <1350426830-12140-4-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove functions request_irq_local() and free_irq_local(), and merge
their code into the functions that handle opening and closing the
framebuffer.  We also improve the way that interrupts are enabled.

Also implement a work-around for broken U-Boots that leave the DIU
interrupts enabled.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   73 ++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 9c40547..f388c3a 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1224,8 +1224,22 @@ static int fsl_diu_open(struct fb_info *info, int user)
 		res = fsl_diu_set_par(info);
 		if (res < 0)
 			mfbi->count--;
-		else
+		else {
+			struct fsl_diu_data *data = mfbi->parent;
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+			/*
+			 * Enable underrun detection and vertical sync
+			 * interrupts.
+			 */
+			clrbits32(&data->diu_reg->int_mask,
+				  INT_UNDRUN | INT_VSYNC);
+#else
+			/* Enable underrun detection */
+			clrbits32(&data->diu_reg->int_mask, INT_UNDRUN);
+#endif
 			fsl_diu_enable_panel(info);
+		}
 	}
 
 	spin_unlock(&diu_lock);
@@ -1241,8 +1255,13 @@ static int fsl_diu_release(struct fb_info *info, int user)
 
 	spin_lock(&diu_lock);
 	mfbi->count--;
-	if (mfbi->count = 0)
+	if (mfbi->count = 0) {
+		struct fsl_diu_data *data = mfbi->parent;
+
+		/* Disable interrupts */
+		out_be32(&data->diu_reg->int_mask, 0xffffffff);
 		fsl_diu_disable_panel(info);
+	}
 
 	spin_unlock(&diu_lock);
 	return res;
@@ -1380,7 +1399,7 @@ static void uninstall_fb(struct fb_info *info)
 static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 {
 	struct diu __iomem *hw = dev_id;
-	unsigned int status = in_be32(&hw->int_status);
+	uint32_t status = in_be32(&hw->int_status);
 
 	if (status) {
 		/* This is the workaround for underrun */
@@ -1405,40 +1424,6 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int request_irq_local(struct fsl_diu_data *data)
-{
-	struct diu __iomem *hw = data->diu_reg;
-	u32 ints;
-	int ret;
-
-	/* Read to clear the status */
-	in_be32(&hw->int_status);
-
-	ret = request_irq(data->irq, fsl_diu_isr, 0, "fsl-diu-fb", hw);
-	if (!ret) {
-		ints = INT_PARERR | INT_LS_BF_VS;
-#if !defined(CONFIG_NOT_COHERENT_CACHE)
-		ints |=	INT_VSYNC;
-#endif
-
-		/* Read to clear the status */
-		in_be32(&hw->int_status);
-		out_be32(&hw->int_mask, ints);
-	}
-
-	return ret;
-}
-
-static void free_irq_local(struct fsl_diu_data *data)
-{
-	struct diu __iomem *hw = data->diu_reg;
-
-	/* Disable all LCDC interrupt */
-	out_be32(&hw->int_mask, 0x1f);
-
-	free_irq(data->irq, NULL);
-}
-
 #ifdef CONFIG_PM
 /*
  * Power management hooks. Note that we won't be called from IRQ context,
@@ -1621,7 +1606,16 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (request_irq_local(data)) {
+	/*
+	 * Older versions of U-Boot leave interrupts enabled, so disable
+	 * all of them and clear the status register.
+	 */
+	out_be32(&data->diu_reg->int_mask, 0xffffffff);
+	in_be32(&data->diu_reg->int_status);
+
+	ret = request_irq(data->irq, fsl_diu_isr, 0, "fsl-diu-fb",
+			  &data->diu_reg);
+	if (ret) {
 		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
@@ -1656,7 +1650,8 @@ static int fsl_diu_remove(struct platform_device *pdev)
 
 	data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(&data->fsl_diu_info[0]);
-	free_irq_local(data);
+
+	free_irq(data->irq, &data->diu_reg);
 
 	for (i = 0; i < NUM_AOIS; i++)
 		uninstall_fb(&data->fsl_diu_info[i]);
-- 
1.7.3.4


