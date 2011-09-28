From: Timur Tabi <timur@freescale.com>
Date: Wed, 28 Sep 2011 21:19:54 +0000
Subject: [PATCH 8/9] drivers/video: fsl-diu-fb: merge diu_hw into fsl_diu_data
Message-Id: <1317244795-24671-8-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The diu_hw structure contains two fields used to access the DIU registers,
but the only instance of this structure is a global variable, 'dr'.
Eliminate 'dr' by merging its fields into the fsl_diu_data structure,
which is instantiated on the heap for each DIU controller found.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   71 ++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 41f767b..728cd9f 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -49,11 +49,6 @@
 #define INT_PARERR	0x08	/* Display parameters error interrupt */
 #define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
 
-struct diu_hw {
-	struct diu __iomem *diu_reg;
-	spinlock_t reg_lock;
-};
-
 struct diu_addr {
 	void *vaddr;		/* Virtual address */
 	dma_addr_t paddr;	/* Physical address */
@@ -351,6 +346,9 @@ struct fsl_diu_data {
 	unsigned int irq;
 	int fb_enabled;
 	enum fsl_diu_monitor_port monitor_port;
+	struct diu __iomem *diu_reg;
+	spinlock_t reg_lock;
+	unsigned int mode;		/* DIU operation mode */
 };
 
 enum mfb_index {
@@ -424,10 +422,6 @@ static struct mfb_info mfb_template[] = {
 	},
 };
 
-static struct diu_hw dr = {
-	.reg_lock = __SPIN_LOCK_UNLOCKED(diu_hw.reg_lock),
-};
-
 static struct diu_pool pool;
 
 /**
@@ -506,9 +500,9 @@ void wr_reg_wa(u32 *reg, u32 val)
 static void fsl_diu_enable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
-	struct diu *hw = dr.diu_reg;
 	struct diu_ad *ad = mfbi->ad;
 	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct diu __iomem *hw = machine_data->diu_reg;
 
 	switch (mfbi->index) {
 	case PLANE0:
@@ -559,9 +553,9 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 static void fsl_diu_disable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
-	struct diu *hw = dr.diu_reg;
 	struct diu_ad *ad = mfbi->ad;
 	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct diu __iomem *hw = machine_data->diu_reg;
 
 	switch (mfbi->index) {
 	case PLANE0:
@@ -613,9 +607,9 @@ static void fsl_diu_disable_panel(struct fb_info *info)
 
 static void enable_lcdc(struct fb_info *info)
 {
-	struct diu *hw = dr.diu_reg;
 	struct mfb_info *mfbi = info->par;
 	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct diu __iomem *hw = machine_data->diu_reg;
 
 	if (!machine_data->fb_enabled) {
 		out_be32(&hw->diu_mode, MFB_MODE1);
@@ -625,9 +619,9 @@ static void enable_lcdc(struct fb_info *info)
 
 static void disable_lcdc(struct fb_info *info)
 {
-	struct diu *hw = dr.diu_reg;
 	struct mfb_info *mfbi = info->par;
 	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct diu __iomem *hw = machine_data->diu_reg;
 
 	if (machine_data->fb_enabled) {
 		out_be32(&hw->diu_mode, 0);
@@ -822,13 +816,13 @@ static void update_lcdc(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
 	struct fsl_diu_data *machine_data = mfbi->parent;
-	struct diu *hw;
+	struct diu __iomem *hw;
 	int i, j;
 	char __iomem *cursor_base, *gamma_table_base;
 
 	u32 temp;
 
-	hw = dr.diu_reg;
+	hw = machine_data->diu_reg;
 
 	diu_ops.set_monitor_port(machine_data->monitor_port);
 	gamma_table_base = pool.gamma.vaddr;
@@ -939,9 +933,9 @@ static int fsl_diu_set_par(struct fb_info *info)
 	struct mfb_info *mfbi = info->par;
 	struct fsl_diu_data *machine_data = mfbi->parent;
 	struct diu_ad *ad = mfbi->ad;
-	struct diu *hw;
+	struct diu __iomem *hw;
 
-	hw = dr.diu_reg;
+	hw = machine_data->diu_reg;
 
 	set_fix(info);
 	mfbi->cursor_reset = 1;
@@ -1336,7 +1330,7 @@ static void uninstall_fb(struct fb_info *info)
 
 static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 {
-	struct diu *hw = dr.diu_reg;
+	struct diu __iomem *hw = dev_id;
 	unsigned int status = in_be32(&hw->int_status);
 
 	if (status) {
@@ -1362,18 +1356,16 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int request_irq_local(int irq)
+static int request_irq_local(struct fsl_diu_data *machine_data)
 {
+	struct diu __iomem *hw = machine_data->diu_reg;
 	u32 ints;
-	struct diu *hw;
 	int ret;
 
-	hw = dr.diu_reg;
-
 	/* Read to clear the status */
 	in_be32(&hw->int_status);
 
-	ret = request_irq(irq, fsl_diu_isr, 0, "fsl-diu-fb", NULL);
+	ret = request_irq(machine_data->irq, fsl_diu_isr, 0, "fsl-diu-fb", hw);
 	if (!ret) {
 		ints = INT_PARERR | INT_LS_BF_VS;
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
@@ -1388,14 +1380,14 @@ static int request_irq_local(int irq)
 	return ret;
 }
 
-static void free_irq_local(int irq)
+static void free_irq_local(struct fsl_diu_data *machine_data)
 {
-	struct diu *hw = dr.diu_reg;
+	struct diu __iomem *hw = machine_data->diu_reg;
 
 	/* Disable all LCDC interrupt */
 	out_be32(&hw->int_mask, 0x1f);
 
-	free_irq(irq, NULL);
+	free_irq(machine_data->irq, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -1513,6 +1505,9 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	if (!machine_data)
 		return -ENOMEM;
 
+	machine_data->mode = MFB_MODE1;
+	spin_lock_init(&machine_data->reg_lock);
+
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
 		machine_data->fsl_diu_info[i]  			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
@@ -1537,16 +1532,16 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		}
 	}
 
-	dr.diu_reg = of_iomap(np, 0);
-	if (!dr.diu_reg) {
+	machine_data->diu_reg = of_iomap(np, 0);
+	if (!machine_data->diu_reg) {
 		dev_err(&pdev->dev, "cannot map DIU registers\n");
 		ret = -EFAULT;
 		goto error2;
 	}
 
-	diu_mode = in_be32(&dr.diu_reg->diu_mode);
+	diu_mode = in_be32(&machine_data->diu_reg->diu_mode);
 	if (diu_mode = MFB_MODE0)
-		out_be32(&dr.diu_reg->diu_mode, 0);	/* disable DIU */
+		out_be32(&machine_data->diu_reg->diu_mode, 0); /* disable DIU */
 
 	/* Get the IRQ of the DIU */
 	machine_data->irq = irq_of_parse_and_map(np, 0);
@@ -1599,10 +1594,11 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	 * by the bootloader, set dummy area descriptor otherwise.
 	 */
 	if (diu_mode = MFB_MODE0)
-		out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
+		out_be32(&machine_data->diu_reg->desc[0],
+			 machine_data->dummy_ad->paddr);
 
-	out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->paddr);
-	out_be32(&dr.diu_reg->desc[2], machine_data->dummy_ad->paddr);
+	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad->paddr);
+	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad->paddr);
 
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
 		machine_data->fsl_diu_info[i]->fix.smem_start = 0;
@@ -1617,7 +1613,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (request_irq_local(machine_data->irq)) {
+	if (request_irq_local(machine_data)) {
 		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
@@ -1651,7 +1647,7 @@ error:
 			 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
-	iounmap(dr.diu_reg);
+	iounmap(machine_data->diu_reg);
 
 error2:
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
@@ -1669,7 +1665,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 
 	machine_data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(machine_data->fsl_diu_info[0]);
-	free_irq_local(machine_data->irq);
+	free_irq_local(machine_data);
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
 		uninstall_fb(machine_data->fsl_diu_info[i]);
 	if (pool.ad.vaddr)
@@ -1681,7 +1677,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2, 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
-	iounmap(dr.diu_reg);
+	iounmap(machine_data->diu_reg);
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
 		if (machine_data->fsl_diu_info[i])
 			framebuffer_release(machine_data->fsl_diu_info[i]);
@@ -1804,7 +1800,6 @@ static int __init fsl_diu_init(void)
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 		vfree(coherence_data);
 #endif
-		iounmap(dr.diu_reg);
 	}
 	return ret;
 }
-- 
1.7.3.4


