From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:49 +0000
Subject: [PATCH 8/9] drivers/video: fsl-diu-fb: don't touch registers for unused features
Message-Id: <1350426830-12140-8-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We don't use the writeback buffer, so don't initialize the registers for
that feature.

The default value for SYN_POL is already zero, so don't re-initialize it.

Writing the INT_STATUS register does nothing.

The value that we write to the PLUT register only makes sense on the
MPC8610 and P1022, so don't touch that register on the MPC5121.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 37175ac..0883bc4 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -825,12 +825,8 @@ static void update_lcdc(struct fb_info *info)
 	out_be32(&hw->gamma, DMA_ADDR(data, gamma));
 	out_be32(&hw->cursor, DMA_ADDR(data, cursor));
 
-	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
-	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
-	out_be32(&hw->disp_size, (var->yres << 16 | var->xres));
-						/* DISP SIZE */
-	out_be32(&hw->wb_size, 0); /* WB SIZE */
-	out_be32(&hw->wb_mem_addr, 0); /* WB MEM ADDR */
+	out_be32(&hw->bgnd, 0x007F7F7F); /* Set background to grey */
+	out_be32(&hw->disp_size, (var->yres << 16) | var->xres);
 
 	/* Horizontal and vertical configuration register */
 	temp = var->left_margin << 22 | /* BP_H */
@@ -847,9 +843,20 @@ static void update_lcdc(struct fb_info *info)
 
 	diu_ops.set_pixel_clock(var->pixclock);
 
-	out_be32(&hw->syn_pol, 0);	/* SYNC SIGNALS POLARITY */
-	out_be32(&hw->int_status, 0);	/* INTERRUPT STATUS */
+#ifndef CONFIG_PPC_MPC512x
+	/*
+	 * The PLUT register is defined differently on the MPC5121 than it
+	 * is on other SOCs.  Unfortunately, there's no documentation that
+	 * explains how it's supposed to be programmed, so for now, we leave
+	 * it at the default value on the MPC5121.
+	 *
+	 * For other SOCs, program it for the highest priority, which will
+	 * reduce the chance of underrun. Technically, we should scale the
+	 * priority to match the screen resolution, but doing that properly
+	 * requires delicate fine-tuning for each use-case.
+	 */
 	out_be32(&hw->plut, 0x01F5F666);
+#endif
 
 	/* Enable the DIU */
 	enable_lcdc(info);
-- 
1.7.3.4


