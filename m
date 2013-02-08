From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 08 Feb 2013 07:35:59 +0000
Subject: [PATCH RESEND v2 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <1360308959-3096-2-git-send-email-agust@denx.de>
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

Registering the diu interrupt handler in probe() must happen before
install_fb() calls since this function registers framebuffer devices
and if fbcon tries to take over framebuffer after registering a frame
buffer device, it will call fb_open of the diu driver and enable the
interrupts. At this time the diu interrupt handler must be registered
already.

Disabling the interrupts in fsl_diu_release() must happen only if all
other AOIs are closed. Otherwise closing an overlay plane will disable
the interrupts even if the primary frame buffer plane is opened. Add
an appropriate check in the release function.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Timur Tabi <timur@tabi.org>
---
 This patch fixes a regression, it should be included in v3.8 since
 without it all mpc512x based boards (with DIU support enabled) do not
 boot
 
Changes in v2:
 - don't add can_handle_irq flag and do the interrupt registration
   before registering frame buffers instead, as pointed by Timur

 drivers/video/fsl-diu-fb.c |   58 +++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 1ca32c5..d33e872 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1232,6 +1232,16 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 	return 0;
 }
 
+static inline void fsl_diu_enable_interrupts(struct fsl_diu_data *data)
+{
+	u32 int_mask = INT_UNDRUN; /* enable underrun detection */
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
@@ -1251,19 +1261,7 @@ static int fsl_diu_open(struct fb_info *info, int user)
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
@@ -1283,9 +1281,18 @@ static int fsl_diu_release(struct fb_info *info, int user)
 	mfbi->count--;
 	if (mfbi->count = 0) {
 		struct fsl_diu_data *data = mfbi->parent;
+		bool disable = true;
+		int i;
 
-		/* Disable interrupts */
-		out_be32(&data->diu_reg->int_mask, 0xffffffff);
+		/* Disable interrupts only if all AOIs are closed */
+		for (i = 0; i < NUM_AOIS; i++) {
+			struct mfb_info *mi = data->fsl_diu_info[i].par;
+
+			if (mi->count)
+				disable = false;
+		}
+		if (disable)
+			out_be32(&data->diu_reg->int_mask, 0xffffffff);
 		fsl_diu_disable_panel(info);
 	}
 
@@ -1614,14 +1621,6 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	out_be32(&data->diu_reg->desc[1], data->dummy_ad.paddr);
 	out_be32(&data->diu_reg->desc[2], data->dummy_ad.paddr);
 
-	for (i = 0; i < NUM_AOIS; i++) {
-		ret = install_fb(&data->fsl_diu_info[i]);
-		if (ret) {
-			dev_err(&pdev->dev, "could not register fb %d\n", i);
-			goto error;
-		}
-	}
-
 	/*
 	 * Older versions of U-Boot leave interrupts enabled, so disable
 	 * all of them and clear the status register.
@@ -1630,12 +1629,21 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	in_be32(&data->diu_reg->int_status);
 
 	ret = request_irq(data->irq, fsl_diu_isr, 0, "fsl-diu-fb",
-			  &data->diu_reg);
+			  data->diu_reg);
 	if (ret) {
 		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
 
+	for (i = 0; i < NUM_AOIS; i++) {
+		ret = install_fb(&data->fsl_diu_info[i]);
+		if (ret) {
+			dev_err(&pdev->dev, "could not register fb %d\n", i);
+			free_irq(data->irq, data->diu_reg);
+			goto error;
+		}
+	}
+
 	sysfs_attr_init(&data->dev_attr.attr);
 	data->dev_attr.attr.name = "monitor";
 	data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
@@ -1667,7 +1675,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
-	free_irq(data->irq, &data->diu_reg);
+	free_irq(data->irq, data->diu_reg);
 
 	for (i = 0; i < NUM_AOIS; i++)
 		uninstall_fb(&data->fsl_diu_info[i]);
-- 
1.7.5.4

