From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:52 +0000
Subject: [PATCH 9/9] drivers/video: fsl-diu-fb: merge diu_pool into fsl_diu_data
Message-Id: <1317775012-9797-9-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-9-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-9-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The diu_pool structure contains diu_addr objects for various objects
allocated in DMA space that are used by the DIU, but the only instance
of this structure is a global variable, 'pool'.  Eliminate 'pool' by
merging its fields into the fsl_diu_data structure, which is instantiated
on the heap for each DIU controller found.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   73 +++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index f9a95ab..3a5f547 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -55,13 +55,6 @@ struct diu_addr {
 	__u32 offset;
 };
 
-struct diu_pool {
-	struct diu_addr ad;
-	struct diu_addr gamma;
-	struct diu_addr pallete;
-	struct diu_addr cursor;
-};
-
 /*
  * List of supported video modes
  *
@@ -348,6 +341,11 @@ struct fsl_diu_data {
 	enum fsl_diu_monitor_port monitor_port;
 	struct diu __iomem *diu_reg;
 	spinlock_t reg_lock;
+	unsigned int mode;		/* DIU operation mode */
+	struct diu_addr ad;
+	struct diu_addr gamma;
+	struct diu_addr pallete;
+	struct diu_addr cursor;
 };
 
 enum mfb_index {
@@ -421,8 +419,6 @@ static struct mfb_info mfb_template[] = {
 	},
 };
 
-static struct diu_pool pool;
-
 /**
  * fsl_diu_name_to_port - convert a port name to a monitor port enum
  *
@@ -824,22 +820,23 @@ static void update_lcdc(struct fb_info *info)
 	hw = machine_data->diu_reg;
 
 	diu_ops.set_monitor_port(machine_data->monitor_port);
-	gamma_table_base = pool.gamma.vaddr;
-	cursor_base = pool.cursor.vaddr;
+	gamma_table_base = machine_data->gamma.vaddr;
+	cursor_base = machine_data->cursor.vaddr;
 	/* Prep for DIU init  - gamma table, cursor table */
 
 	for (i = 0; i <= 2; i++)
 		for (j = 0; j <= 255; j++)
 			*gamma_table_base++ = j;
 
-	diu_ops.set_gamma_table(machine_data->monitor_port, pool.gamma.vaddr);
+	diu_ops.set_gamma_table(machine_data->monitor_port,
+				machine_data->gamma.vaddr);
 
 	disable_lcdc(info);
 
 	/* Program DIU registers */
 
-	out_be32(&hw->gamma, pool.gamma.paddr);
-	out_be32(&hw->cursor, pool.cursor.paddr);
+	out_be32(&hw->gamma, machine_data->gamma.paddr);
+	out_be32(&hw->cursor, machine_data->cursor.paddr);
 
 	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
 	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
@@ -1560,27 +1557,27 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	machine_data->monitor_port = monitor_port;
 
 	/* Area descriptor memory pool aligns to 64-bit boundary */
-	if (allocate_buf(&pdev->dev, &pool.ad,
+	if (allocate_buf(&pdev->dev, &machine_data->ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8))
 		return -ENOMEM;
 
 	/* Get memory for Gamma Table  - 32-byte aligned memory */
-	if (allocate_buf(&pdev->dev, &pool.gamma, 768, 32)) {
+	if (allocate_buf(&pdev->dev, &machine_data->gamma, 768, 32)) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
 	/* For performance, cursor bitmap buffer aligns to 32-byte boundary */
-	if (allocate_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
-			 32)) {
+	if (allocate_buf(&pdev->dev, &machine_data->cursor,
+			 MAX_CURS * MAX_CURS * 2, 32)) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
 	i = ARRAY_SIZE(machine_data->fsl_diu_info);
-	machine_data->dummy_ad = (struct diu_ad *)
-			((u32)pool.ad.vaddr + pool.ad.offset) + i;
-	machine_data->dummy_ad->paddr = pool.ad.paddr +
+	machine_data->dummy_ad = (struct diu_ad *)((u32)machine_data->ad.vaddr +
+			machine_data->ad.offset) + i;
+	machine_data->dummy_ad->paddr = machine_data->ad.paddr +
 			i * sizeof(struct diu_ad);
 	machine_data->dummy_aoi_virt = fsl_diu_alloc(64, &dummy_ad_addr);
 	if (!machine_data->dummy_aoi_virt) {
@@ -1609,9 +1606,10 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
 		machine_data->fsl_diu_info[i]->fix.smem_start = 0;
 		mfbi = machine_data->fsl_diu_info[i]->par;
-		mfbi->ad = (struct diu_ad *)((u32)pool.ad.vaddr
-					+ pool.ad.offset) + i;
-		mfbi->ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
+		mfbi->ad = (struct diu_ad *)((u32)machine_data->ad.vaddr
+					+ machine_data->ad.offset) + i;
+		mfbi->ad->paddr +			machine_data->ad.paddr + i * sizeof(struct diu_ad);
 		ret = install_fb(machine_data->fsl_diu_info[i]);
 		if (ret) {
 			dev_err(&pdev->dev, "could not register fb %d\n", i);
@@ -1643,14 +1641,14 @@ error:
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
 		uninstall_fb(machine_data->fsl_diu_info[i]);
 
-	if (pool.ad.vaddr)
-		free_buf(&pdev->dev, &pool.ad,
+	if (machine_data->ad.vaddr)
+		free_buf(&pdev->dev, &machine_data->ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
-	if (pool.gamma.vaddr)
-		free_buf(&pdev->dev, &pool.gamma, 768, 32);
-	if (pool.cursor.vaddr)
-		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
-			 32);
+	if (machine_data->gamma.vaddr)
+		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
+	if (machine_data->cursor.vaddr)
+		free_buf(&pdev->dev, &machine_data->cursor,
+			 MAX_CURS * MAX_CURS * 2, 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
 	iounmap(machine_data->diu_reg);
@@ -1674,13 +1672,14 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	free_irq_local(machine_data);
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
 		uninstall_fb(machine_data->fsl_diu_info[i]);
-	if (pool.ad.vaddr)
-		free_buf(&pdev->dev, &pool.ad,
+	if (machine_data->ad.vaddr)
+		free_buf(&pdev->dev, &machine_data->ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
-	if (pool.gamma.vaddr)
-		free_buf(&pdev->dev, &pool.gamma, 768, 32);
-	if (pool.cursor.vaddr)
-		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2, 32);
+	if (machine_data->gamma.vaddr)
+		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
+	if (machine_data->cursor.vaddr)
+		free_buf(&pdev->dev, &machine_data->cursor,
+			 MAX_CURS * MAX_CURS * 2, 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
 	iounmap(machine_data->diu_reg);
-- 
1.7.4.4


