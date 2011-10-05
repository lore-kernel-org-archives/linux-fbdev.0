From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:50 +0000
Subject: [PATCH 7/9] drivers/video: fsl-diu-fb: only DIU modes 0 and 1 are supported
Message-Id: <1317775012-9797-7-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The Freescale DIU video controller supports five video "modes", but only
the first two are used by the driver.  The other three are special modes
that don't make sense for a framebuffer driver.  Therefore, there's no
point in keeping a global variable that indicates which mode we're
supposed to use.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    2 +-
 drivers/video/fsl-diu-fb.c                   |   11 +++--------
 include/linux/fsl-diu-fb.h                   |    8 ++++----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 3dc62f9..cfe958e 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -253,7 +253,7 @@ void __init mpc512x_init_diu(void)
 	}
 
 	mode = in_be32(&diu_reg->diu_mode);
-	if (mode != MFB_MODE1) {
+	if (mode = MFB_MODE0) {
 		pr_info("%s: DIU OFF\n", __func__);
 		goto out;
 	}
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0fd4c784..6539e70 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -52,7 +52,6 @@
 struct diu_hw {
 	struct diu __iomem *diu_reg;
 	spinlock_t reg_lock;
-	unsigned int mode;		/* DIU operation mode */
 };
 
 struct diu_addr {
@@ -426,7 +425,6 @@ static struct mfb_info mfb_template[] = {
 };
 
 static struct diu_hw dr = {
-	.mode = MFB_MODE1,
 	.reg_lock = __SPIN_LOCK_UNLOCKED(diu_hw.reg_lock),
 };
 
@@ -620,7 +618,7 @@ static void enable_lcdc(struct fb_info *info)
 	struct fsl_diu_data *machine_data = mfbi->parent;
 
 	if (!machine_data->fb_enabled) {
-		out_be32(&hw->diu_mode, dr.mode);
+		out_be32(&hw->diu_mode, MFB_MODE1);
 		machine_data->fb_enabled++;
 	}
 }
@@ -1390,9 +1388,6 @@ static int request_irq_local(int irq)
 		ints |=	INT_VSYNC;
 #endif
 
-		if (dr.mode = MFB_MODE2 || dr.mode = MFB_MODE3)
-			ints |= INT_VSYNC_WB;
-
 		/* Read to clear the status */
 		in_be32(&hw->int_status);
 		out_be32(&hw->int_mask, ints);
@@ -1558,7 +1553,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	}
 
 	diu_mode = in_be32(&dr.diu_reg->diu_mode);
-	if (diu_mode != MFB_MODE1)
+	if (diu_mode = MFB_MODE0)
 		out_be32(&dr.diu_reg->diu_mode, 0);	/* disable DIU */
 
 	/* Get the IRQ of the DIU */
@@ -1611,7 +1606,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	 * Let DIU display splash screen if it was pre-initialized
 	 * by the bootloader, set dummy area descriptor otherwise.
 	 */
-	if (diu_mode != MFB_MODE1)
+	if (diu_mode = MFB_MODE0)
 		out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
 
 	out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->paddr);
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 363d5e2..11c16a1 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -153,12 +153,12 @@ struct diu {
 	__be32 plut;
 } __attribute__ ((packed));
 
-/* Modes of operation of DIU */
+/*
+ * Modes of operation of DIU.  The DIU supports five different modes, but
+ * the driver only supports modes 0 and 1.
+ */
 #define MFB_MODE0	0	/* DIU off */
 #define MFB_MODE1	1	/* All three planes output to display */
-#define MFB_MODE2	2	/* Plane 1 to display, planes 2+3 written back*/
-#define MFB_MODE3	3	/* All three planes written back to memory */
-#define MFB_MODE4	4	/* Color bar generation */
 
 #endif /* __KERNEL__ */
 #endif /* __FSL_DIU_FB_H__ */
-- 
1.7.4.4


