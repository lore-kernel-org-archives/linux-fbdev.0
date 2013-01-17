From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 17 Jan 2013 20:28:38 +0000
Subject: [PATCH 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <1358454518-14032-2-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since commit f74de500 "drivers/video: fsl-diu-fb: streamline
enabling of interrupts" the interrupt handling in the driver
is broken. Enabling diu interrupt causes an interrupt storm and
results in system lockup.

The cookie for the interrupt handler function passed to request_irq()
is wrong (it must be a pointer to the diu struct, and not the address
of the pointer to the diu struct). As a result the interrupt handler
can not read diu registers and acknowledge the interrupt. Fix cookie
arguments for request_irq() and free_irq().

Masking the diu interrupts in probe() must happen before install_fb()
calls since this function registers framebuffer devices and if fbcon
tries to take over framebuffer after registering a framebuffer device,
it will call fb_open of the diu driver and enable the interrupts. But
at this time the diu interrupt handler is not registered yet. Therefore
we must mask the diu interrupts before registering the framebuffers
and enable the interrupts after registering the handler.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Timur Tabi <timur@tabi.org>
---
 drivers/video/fsl-diu-fb.c |   58 +++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4f8a2e4..b88cf78 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -378,6 +378,7 @@ struct fsl_diu_data {
 	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
+	bool can_handle_irq;
 } __aligned(32);
 
 /* Determine the DMA address of a member of the fsl_diu_data structure */
@@ -1232,6 +1233,19 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 	return 0;
 }
 
+static inline void fsl_diu_enable_interrupts(struct fsl_diu_data *data)
+{
+	u32 int_mask = INT_UNDRUN; /* enable underrun detection */
+
+	if (!data->can_handle_irq)
+		return;
+
+	if (IS_ENABLED(CONFIG_NOT_COHERENT_CACHE))
+		int_mask |= INT_VSYNC; /* enable vertical sync */
+
+	clrbits32(&data->diu_reg->int_mask, int_mask);
+}
+
 /* turn on fb if count = 1
  */
 static int fsl_diu_open(struct fb_info *info, int user)
@@ -1251,19 +1265,7 @@ static int fsl_diu_open(struct fb_info *info, int user)
 		if (res < 0)
 			mfbi->count--;
 		else {
-			struct fsl_diu_data *data = mfbi->parent;
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-			/*
-			 * Enable underrun detection and vertical sync
-			 * interrupts.
-			 */
-			clrbits32(&data->diu_reg->int_mask,
-				  INT_UNDRUN | INT_VSYNC);
-#else
-			/* Enable underrun detection */
-			clrbits32(&data->diu_reg->int_mask, INT_UNDRUN);
-#endif
+			fsl_diu_enable_interrupts(mfbi->parent);
 			fsl_diu_enable_panel(info);
 		}
 	}
@@ -1614,6 +1616,14 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	out_be32(&data->diu_reg->desc[1], data->dummy_ad.paddr);
 	out_be32(&data->diu_reg->desc[2], data->dummy_ad.paddr);
 
+	/*
+	 * Older versions of U-Boot leave interrupts enabled, so disable
+	 * all of them and clear the status register.
+	 */
+	out_be32(&data->diu_reg->int_mask, 0xffffffff);
+	in_be32(&data->diu_reg->int_status);
+	data->can_handle_irq = false;
+
 	for (i = 0; i < NUM_AOIS; i++) {
 		ret = install_fb(&data->fsl_diu_info[i]);
 		if (ret) {
@@ -1622,20 +1632,24 @@ static int fsl_diu_probe(struct platform_device *pdev)
 		}
 	}
 
-	/*
-	 * Older versions of U-Boot leave interrupts enabled, so disable
-	 * all of them and clear the status register.
-	 */
-	out_be32(&data->diu_reg->int_mask, 0xffffffff);
-	in_be32(&data->diu_reg->int_status);
-
 	ret = request_irq(data->irq, fsl_diu_isr, 0, "fsl-diu-fb",
-			  &data->diu_reg);
+			  data->diu_reg);
 	if (ret) {
 		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
 
+	data->can_handle_irq = true;
+
+	/* if an AOI is opened (i.e. by fbcon), enable the interrupts */
+	for (i = 0; i < NUM_AOIS; i++) {
+		struct fb_info *info = &data->fsl_diu_info[i];
+
+		mfbi = info->par;
+		if (mfbi->count)
+			fsl_diu_enable_interrupts(data);
+	}
+
 	sysfs_attr_init(&data->dev_attr.attr);
 	data->dev_attr.attr.name = "monitor";
 	data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
@@ -1667,7 +1681,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
-	free_irq(data->irq, &data->diu_reg);
+	free_irq(data->irq, data->diu_reg);
 
 	for (i = 0; i < NUM_AOIS; i++)
 		uninstall_fb(&data->fsl_diu_info[i]);
-- 
1.7.5.4

