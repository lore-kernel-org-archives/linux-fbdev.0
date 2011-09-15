From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:46 +0000
Subject: [PATCH 01/13] drivers/video: fsl-diu-fb: clean up whitespace and formatting
Message-Id: <1316123098-30967-2-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix various indentation and line length problems in the Freescale
DIU framebuffer driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  104 +++++++++++++++++++++++---------------------
 1 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0f1933b..dbb4cb7 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -223,53 +223,53 @@ struct mfb_info {
 
 static struct mfb_info mfb_template[] = {
 	{		/* AOI 0 for plane 0 */
-	.index = 0,
-	.type = MFB_TYPE_OUTPUT,
-	.id = "Panel0",
-	.registered = 0,
-	.count = 0,
-	.x_aoi_d = 0,
-	.y_aoi_d = 0,
+		.index = 0,
+		.type = MFB_TYPE_OUTPUT,
+		.id = "Panel0",
+		.registered = 0,
+		.count = 0,
+		.x_aoi_d = 0,
+		.y_aoi_d = 0,
 	},
 	{		/* AOI 0 for plane 1 */
-	.index = 1,
-	.type = MFB_TYPE_OUTPUT,
-	.id = "Panel1 AOI0",
-	.registered = 0,
-	.g_alpha = 0xff,
-	.count = 0,
-	.x_aoi_d = 0,
-	.y_aoi_d = 0,
+		.index = 1,
+		.type = MFB_TYPE_OUTPUT,
+		.id = "Panel1 AOI0",
+		.registered = 0,
+		.g_alpha = 0xff,
+		.count = 0,
+		.x_aoi_d = 0,
+		.y_aoi_d = 0,
 	},
 	{		/* AOI 1 for plane 1 */
-	.index = 2,
-	.type = MFB_TYPE_OUTPUT,
-	.id = "Panel1 AOI1",
-	.registered = 0,
-	.g_alpha = 0xff,
-	.count = 0,
-	.x_aoi_d = 0,
-	.y_aoi_d = 480,
+		.index = 2,
+		.type = MFB_TYPE_OUTPUT,
+		.id = "Panel1 AOI1",
+		.registered = 0,
+		.g_alpha = 0xff,
+		.count = 0,
+		.x_aoi_d = 0,
+		.y_aoi_d = 480,
 	},
 	{		/* AOI 0 for plane 2 */
-	.index = 3,
-	.type = MFB_TYPE_OUTPUT,
-	.id = "Panel2 AOI0",
-	.registered = 0,
-	.g_alpha = 0xff,
-	.count = 0,
-	.x_aoi_d = 640,
-	.y_aoi_d = 0,
+		.index = 3,
+		.type = MFB_TYPE_OUTPUT,
+		.id = "Panel2 AOI0",
+		.registered = 0,
+		.g_alpha = 0xff,
+		.count = 0,
+		.x_aoi_d = 640,
+		.y_aoi_d = 0,
 	},
 	{		/* AOI 1 for plane 2 */
-	.index = 4,
-	.type = MFB_TYPE_OUTPUT,
-	.id = "Panel2 AOI1",
-	.registered = 0,
-	.g_alpha = 0xff,
-	.count = 0,
-	.x_aoi_d = 640,
-	.y_aoi_d = 480,
+		.index = 4,
+		.type = MFB_TYPE_OUTPUT,
+		.id = "Panel2 AOI1",
+		.registered = 0,
+		.g_alpha = 0xff,
+		.count = 0,
+		.x_aoi_d = 640,
+		.y_aoi_d = 480,
 	},
 };
 
@@ -715,8 +715,8 @@ static void update_lcdc(struct fb_info *info)
 	/* Prep for DIU init  - gamma table, cursor table */
 
 	for (i = 0; i <= 2; i++)
-	   for (j = 0; j <= 255; j++)
-	      *gamma_table_base++ = j;
+		for (j = 0; j <= 255; j++)
+			*gamma_table_base++ = j;
 
 	diu_ops.set_gamma_table(machine_data->monitor_port, pool.gamma.vaddr);
 
@@ -887,7 +887,7 @@ static int fsl_diu_set_par(struct fb_info *info)
 
 static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
 {
-	return ((val<<width) + 0x7FFF - val)>>16;
+	return ((val << width) + 0x7FFF - val) >> 16;
 }
 
 /*
@@ -899,8 +899,9 @@ static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
  * pseudo_palette in struct fb_info. For pseudocolor mode we have a limited
  * color palette.
  */
-static int fsl_diu_setcolreg(unsigned regno, unsigned red, unsigned green,
-			   unsigned blue, unsigned transp, struct fb_info *info)
+static int fsl_diu_setcolreg(unsigned int regno, unsigned int red,
+			     unsigned int green, unsigned int blue,
+			     unsigned int transp, struct fb_info *info)
 {
 	int ret = 1;
 
@@ -1350,6 +1351,7 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 		else if (status & INT_VSYNC) {
 			unsigned int i;
+
 			for (i = 0; i < coherence_data_size;
 				i += d_cache_line_size)
 				__asm__ __volatile__ (
@@ -1381,6 +1383,7 @@ static int request_irq_local(int irq)
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
 		ints |=	INT_VSYNC;
 #endif
+
 		if (dr.mode = MFB_MODE2 || dr.mode = MFB_MODE3)
 			ints |= INT_VSYNC_WB;
 
@@ -1388,6 +1391,7 @@ static int request_irq_local(int irq)
 		status = in_be32(&hw->int_status);
 		out_be32(&hw->int_mask, ints);
 	}
+
 	return ret;
 }
 
@@ -1454,15 +1458,15 @@ static int allocate_buf(struct device *dev, struct diu_addr *buf, u32 size,
 		buf->paddr = (u32)buf->paddr + offset;
 	} else
 		buf->offset = 0;
+
 	return 0;
 }
 
 static void free_buf(struct device *dev, struct diu_addr *buf, u32 size,
 		     u32 bytes_align)
 {
-	dma_free_coherent(dev, size + bytes_align,
-				buf->vaddr, (buf->paddr - buf->offset));
-	return;
+	dma_free_coherent(dev, size + bytes_align, buf->vaddr,
+			  buf->paddr - buf->offset);
 }
 
 static ssize_t store_monitor(struct device *device,
@@ -1798,8 +1802,9 @@ static int __init fsl_diu_init(void)
 		return -ENODEV;
 	}
 
-	/* Freescale PLRU requires 13/8 times the cache size to do a proper
-	   displacement flush
+	/*
+	 * Freescale PLRU requires 13/8 times the cache size to do a proper
+	 * displacement flush
 	 */
 	coherence_data_size = *prop * 13;
 	coherence_data_size /= 8;
@@ -1816,6 +1821,7 @@ static int __init fsl_diu_init(void)
 	if (!coherence_data)
 		return -ENOMEM;
 #endif
+
 	ret = platform_driver_register(&fsl_diu_driver);
 	if (ret) {
 		printk(KERN_ERR
-- 
1.7.3.4


