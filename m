From: Timur Tabi <timur@freescale.com>
Date: Thu, 08 Dec 2011 23:27:31 +0000
Subject: [PATCH] drivers/video: fsl-diu-fb: rename "machine_data_" to "data"
Message-Id: <1323386851-3480-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"machine_data" is too long and clunky, and the "machine" part doesn't make
much sense, anyway.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  236 ++++++++++++++++++++++----------------------
 1 files changed, 116 insertions(+), 120 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4d54188..408272c 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -509,8 +509,8 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
 	struct diu_ad *ad = mfbi->ad;
-	struct fsl_diu_data *machine_data = mfbi->parent;
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct fsl_diu_data *data = mfbi->parent;
+	struct diu __iomem *hw = data->diu_reg;
 
 	switch (mfbi->index) {
 	case PLANE0:
@@ -518,7 +518,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[0], ad->paddr);
 		break;
 	case PLANE1_AOI0:
-		cmfbi = &machine_data->mfb[2];
+		cmfbi = &data->mfb[2];
 		if (hw->desc[1] != ad->paddr) {	/* AOI0 closed */
 			if (cmfbi->count > 0)	/* AOI1 open */
 				ad->next_ad @@ -529,7 +529,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 		}
 		break;
 	case PLANE2_AOI0:
-		cmfbi = &machine_data->mfb[4];
+		cmfbi = &data->mfb[4];
 		if (hw->desc[2] != ad->paddr) {	/* AOI0 closed */
 			if (cmfbi->count > 0)	/* AOI1 open */
 				ad->next_ad @@ -540,17 +540,17 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 		}
 		break;
 	case PLANE1_AOI1:
-		pmfbi = &machine_data->mfb[1];
+		pmfbi = &data->mfb[1];
 		ad->next_ad = 0;
-		if (hw->desc[1] = machine_data->dummy_ad.paddr)
+		if (hw->desc[1] = data->dummy_ad.paddr)
 			wr_reg_wa(&hw->desc[1], ad->paddr);
 		else					/* AOI0 open */
 			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 		break;
 	case PLANE2_AOI1:
-		pmfbi = &machine_data->mfb[3];
+		pmfbi = &data->mfb[3];
 		ad->next_ad = 0;
-		if (hw->desc[2] = machine_data->dummy_ad.paddr)
+		if (hw->desc[2] = data->dummy_ad.paddr)
 			wr_reg_wa(&hw->desc[2], ad->paddr);
 		else				/* AOI0 was open */
 			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
@@ -562,52 +562,52 @@ static void fsl_diu_disable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
 	struct diu_ad *ad = mfbi->ad;
-	struct fsl_diu_data *machine_data = mfbi->parent;
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct fsl_diu_data *data = mfbi->parent;
+	struct diu __iomem *hw = data->diu_reg;
 
 	switch (mfbi->index) {
 	case PLANE0:
-		if (hw->desc[0] != machine_data->dummy_ad.paddr)
-			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad.paddr);
+		if (hw->desc[0] != data->dummy_ad.paddr)
+			wr_reg_wa(&hw->desc[0], data->dummy_ad.paddr);
 		break;
 	case PLANE1_AOI0:
-		cmfbi = &machine_data->mfb[2];
+		cmfbi = &data->mfb[2];
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[1], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
+			wr_reg_wa(&hw->desc[1], data->dummy_ad.paddr);
 					/* close AOI 0 */
 		break;
 	case PLANE2_AOI0:
-		cmfbi = &machine_data->mfb[4];
+		cmfbi = &data->mfb[4];
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[2], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
+			wr_reg_wa(&hw->desc[2], data->dummy_ad.paddr);
 					/* close AOI 0 */
 		break;
 	case PLANE1_AOI1:
-		pmfbi = &machine_data->mfb[1];
+		pmfbi = &data->mfb[1];
 		if (hw->desc[1] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
 			if (pmfbi->count > 0)
 					/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else			/* AOI1 is the first in the chain */
-			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
+			wr_reg_wa(&hw->desc[1], data->dummy_ad.paddr);
 					/* close AOI 1 */
 		break;
 	case PLANE2_AOI1:
-		pmfbi = &machine_data->mfb[3];
+		pmfbi = &data->mfb[3];
 		if (hw->desc[2] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
 			if (pmfbi->count > 0)
 				/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else		/* AOI1 is the first in the chain */
-			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
+			wr_reg_wa(&hw->desc[2], data->dummy_ad.paddr);
 				/* close AOI 1 */
 		break;
 	}
@@ -616,24 +616,24 @@ static void fsl_diu_disable_panel(struct fb_info *info)
 static void enable_lcdc(struct fb_info *info)
 {
 	struct mfb_info *mfbi = info->par;
-	struct fsl_diu_data *machine_data = mfbi->parent;
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct fsl_diu_data *data = mfbi->parent;
+	struct diu __iomem *hw = data->diu_reg;
 
-	if (!machine_data->fb_enabled) {
+	if (!data->fb_enabled) {
 		out_be32(&hw->diu_mode, MFB_MODE1);
-		machine_data->fb_enabled++;
+		data->fb_enabled++;
 	}
 }
 
 static void disable_lcdc(struct fb_info *info)
 {
 	struct mfb_info *mfbi = info->par;
-	struct fsl_diu_data *machine_data = mfbi->parent;
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct fsl_diu_data *data = mfbi->parent;
+	struct diu __iomem *hw = data->diu_reg;
 
-	if (machine_data->fb_enabled) {
+	if (data->fb_enabled) {
 		out_be32(&hw->diu_mode, 0);
-		machine_data->fb_enabled = 0;
+		data->fb_enabled = 0;
 	}
 }
 
@@ -641,14 +641,14 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
 	struct mfb_info *lower_aoi_mfbi, *upper_aoi_mfbi, *mfbi = info->par;
-	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct fsl_diu_data *data = mfbi->parent;
 	int available_height, upper_aoi_bottom;
 	enum mfb_index index = mfbi->index;
 	int lower_aoi_is_open, upper_aoi_is_open;
 	__u32 base_plane_width, base_plane_height, upper_aoi_height;
 
-	base_plane_width = machine_data->fsl_diu_info[0].var.xres;
-	base_plane_height = machine_data->fsl_diu_info[0].var.yres;
+	base_plane_width = data->fsl_diu_info[0].var.xres;
+	base_plane_height = data->fsl_diu_info[0].var.yres;
 
 	if (mfbi->x_aoi_d < 0)
 		mfbi->x_aoi_d = 0;
@@ -663,7 +663,7 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI0:
 	case PLANE2_AOI0:
-		lower_aoi_mfbi = machine_data->fsl_diu_info[index+1].par;
+		lower_aoi_mfbi = data->fsl_diu_info[index+1].par;
 		lower_aoi_is_open = lower_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
 			var->xres = base_plane_width;
@@ -681,9 +681,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI1:
 	case PLANE2_AOI1:
-		upper_aoi_mfbi = machine_data->fsl_diu_info[index-1].par;
-		upper_aoi_height -				machine_data->fsl_diu_info[index-1].var.yres;
+		upper_aoi_mfbi = data->fsl_diu_info[index-1].par;
+		upper_aoi_height = data->fsl_diu_info[index-1].var.yres;
 		upper_aoi_bottom = upper_aoi_mfbi->y_aoi_d + upper_aoi_height;
 		upper_aoi_is_open = upper_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
@@ -823,17 +822,17 @@ static void update_lcdc(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
-	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct fsl_diu_data *data = mfbi->parent;
 	struct diu __iomem *hw;
 	int i, j;
 	u8 *gamma_table_base;
 
 	u32 temp;
 
-	hw = machine_data->diu_reg;
+	hw = data->diu_reg;
 
-	diu_ops.set_monitor_port(machine_data->monitor_port);
-	gamma_table_base = machine_data->gamma;
+	diu_ops.set_monitor_port(data->monitor_port);
+	gamma_table_base = data->gamma;
 
 	/* Prep for DIU init  - gamma table, cursor table */
 
@@ -841,15 +840,14 @@ static void update_lcdc(struct fb_info *info)
 		for (j = 0; j <= 255; j++)
 			*gamma_table_base++ = j;
 
-	diu_ops.set_gamma_table(machine_data->monitor_port,
-		machine_data->gamma);
+	diu_ops.set_gamma_table(data->monitor_port, data->gamma);
 
 	disable_lcdc(info);
 
 	/* Program DIU registers */
 
-	out_be32(&hw->gamma, DMA_ADDR(machine_data, gamma));
-	out_be32(&hw->cursor, DMA_ADDR(machine_data, cursor));
+	out_be32(&hw->gamma, DMA_ADDR(data, gamma));
+	out_be32(&hw->cursor, DMA_ADDR(data, cursor));
 
 	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
 	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
@@ -940,11 +938,11 @@ static int fsl_diu_set_par(struct fb_info *info)
 	unsigned long len;
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
-	struct fsl_diu_data *machine_data = mfbi->parent;
+	struct fsl_diu_data *data = mfbi->parent;
 	struct diu_ad *ad = mfbi->ad;
 	struct diu __iomem *hw;
 
-	hw = machine_data->diu_reg;
+	hw = data->diu_reg;
 
 	set_fix(info);
 	mfbi->cursor_reset = 1;
@@ -962,7 +960,7 @@ static int fsl_diu_set_par(struct fb_info *info)
 		}
 	}
 
-	ad->pix_fmt = diu_ops.get_pixel_format(machine_data->monitor_port,
+	ad->pix_fmt = diu_ops.get_pixel_format(data->monitor_port,
 					       var->bits_per_pixel);
 	ad->addr    = cpu_to_le32(info->fix.smem_start);
 	ad->src_size_g_alpha = cpu_to_le32((var->yres_virtual << 12) |
@@ -1373,16 +1371,16 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int request_irq_local(struct fsl_diu_data *machine_data)
+static int request_irq_local(struct fsl_diu_data *data)
 {
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct diu __iomem *hw = data->diu_reg;
 	u32 ints;
 	int ret;
 
 	/* Read to clear the status */
 	in_be32(&hw->int_status);
 
-	ret = request_irq(machine_data->irq, fsl_diu_isr, 0, "fsl-diu-fb", hw);
+	ret = request_irq(data->irq, fsl_diu_isr, 0, "fsl-diu-fb", hw);
 	if (!ret) {
 		ints = INT_PARERR | INT_LS_BF_VS;
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
@@ -1397,14 +1395,14 @@ static int request_irq_local(struct fsl_diu_data *machine_data)
 	return ret;
 }
 
-static void free_irq_local(struct fsl_diu_data *machine_data)
+static void free_irq_local(struct fsl_diu_data *data)
 {
-	struct diu __iomem *hw = machine_data->diu_reg;
+	struct diu __iomem *hw = data->diu_reg;
 
 	/* Disable all LCDC interrupt */
 	out_be32(&hw->int_mask, 0x1f);
 
-	free_irq(machine_data->irq, NULL);
+	free_irq(data->irq, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -1414,20 +1412,20 @@ static void free_irq_local(struct fsl_diu_data *machine_data)
  */
 static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 {
-	struct fsl_diu_data *machine_data;
+	struct fsl_diu_data *data;
 
-	machine_data = dev_get_drvdata(&ofdev->dev);
-	disable_lcdc(machine_data->fsl_diu_info[0]);
+	data = dev_get_drvdata(&ofdev->dev);
+	disable_lcdc(data->fsl_diu_info[0]);
 
 	return 0;
 }
 
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
-	struct fsl_diu_data *machine_data;
+	struct fsl_diu_data *data;
 
-	machine_data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(machine_data->fsl_diu_info[0]);
+	data = dev_get_drvdata(&ofdev->dev);
+	enable_lcdc(data->fsl_diu_info[0]);
 
 	return 0;
 }
@@ -1441,20 +1439,20 @@ static ssize_t store_monitor(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	enum fsl_diu_monitor_port old_monitor_port;
-	struct fsl_diu_data *machine_data +	struct fsl_diu_data *data  		container_of(attr, struct fsl_diu_data, dev_attr);
 
-	old_monitor_port = machine_data->monitor_port;
-	machine_data->monitor_port = fsl_diu_name_to_port(buf);
+	old_monitor_port = data->monitor_port;
+	data->monitor_port = fsl_diu_name_to_port(buf);
 
-	if (old_monitor_port != machine_data->monitor_port) {
+	if (old_monitor_port != data->monitor_port) {
 		/* All AOIs need adjust pixel format
 		 * fsl_diu_set_par only change the pixsel format here
 		 * unlikely to fail. */
 		unsigned int i;
 
 		for (i=0; i < NUM_AOIS; i++)
-			fsl_diu_set_par(&machine_data->fsl_diu_info[i]);
+			fsl_diu_set_par(&data->fsl_diu_info[i]);
 	}
 	return count;
 }
@@ -1462,10 +1460,10 @@ static ssize_t store_monitor(struct device *device,
 static ssize_t show_monitor(struct device *device,
 	struct device_attribute *attr, char *buf)
 {
-	struct fsl_diu_data *machine_data +	struct fsl_diu_data *data  		container_of(attr, struct fsl_diu_data, dev_attr);
 
-	switch (machine_data->monitor_port) {
+	switch (data->monitor_port) {
 	case FSL_DIU_PORT_DVI:
 		return sprintf(buf, "DVI\n");
 	case FSL_DIU_PORT_LVDS:
@@ -1481,17 +1479,17 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
-	struct fsl_diu_data *machine_data;
+	struct fsl_diu_data *data;
 	int diu_mode;
-	dma_addr_t dma_addr; /* DMA addr of machine_data struct */
+	dma_addr_t dma_addr; /* DMA addr of fsl_diu_data struct */
 	unsigned int i;
 	int ret;
 
-	machine_data = dma_alloc_coherent(&pdev->dev,
-		sizeof(struct fsl_diu_data), &dma_addr, GFP_DMA | __GFP_ZERO);
-	if (!machine_data)
+	data = dma_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
+				  &dma_addr, GFP_DMA | __GFP_ZERO);
+	if (!data)
 		return -ENOMEM;
-	machine_data->dma_addr = dma_addr;
+	data->dma_addr = dma_addr;
 
 	/*
 	 * dma_alloc_coherent() uses a page allocator, so the address is
@@ -1500,33 +1498,33 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	 * need to catch that.  It's not worth the effort to handle unaligned
 	 * alloctions now because it's highly unlikely to ever be a problem.
 	 */
-	if ((unsigned long)machine_data & 31) {
+	if ((unsigned long)data & 31) {
 		dev_err(&pdev->dev, "misaligned allocation");
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	spin_lock_init(&machine_data->reg_lock);
+	spin_lock_init(&data->reg_lock);
 
 	for (i = 0; i < NUM_AOIS; i++) {
-		struct fb_info *info = &machine_data->fsl_diu_info[i];
+		struct fb_info *info = &data->fsl_diu_info[i];
 
 		info->device = &pdev->dev;
-		info->par = &machine_data->mfb[i];
+		info->par = &data->mfb[i];
 
 		/*
 		 * We store the physical address of the AD in the reserved
 		 * 'paddr' field of the AD itself.
 		 */
-		machine_data->ad[i].paddr = DMA_ADDR(machine_data, ad[i]);
+		data->ad[i].paddr = DMA_ADDR(data, ad[i]);
 
 		info->fix.smem_start = 0;
 
 		/* Initialize the AOI data structure */
 		mfbi = info->par;
 		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
-		mfbi->parent = machine_data;
-		mfbi->ad = &machine_data->ad[i];
+		mfbi->parent = data;
+		mfbi->ad = &data->ad[i];
 
 		if (mfbi->index = PLANE0) {
 			const u8 *prop;
@@ -1540,104 +1538,102 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		}
 	}
 
-	machine_data->diu_reg = of_iomap(np, 0);
-	if (!machine_data->diu_reg) {
+	data->diu_reg = of_iomap(np, 0);
+	if (!data->diu_reg) {
 		dev_err(&pdev->dev, "cannot map DIU registers\n");
 		ret = -EFAULT;
 		goto error;
 	}
 
-	diu_mode = in_be32(&machine_data->diu_reg->diu_mode);
+	diu_mode = in_be32(&data->diu_reg->diu_mode);
 	if (diu_mode = MFB_MODE0)
-		out_be32(&machine_data->diu_reg->diu_mode, 0); /* disable DIU */
+		out_be32(&data->diu_reg->diu_mode, 0); /* disable DIU */
 
 	/* Get the IRQ of the DIU */
-	machine_data->irq = irq_of_parse_and_map(np, 0);
+	data->irq = irq_of_parse_and_map(np, 0);
 
-	if (!machine_data->irq) {
+	if (!data->irq) {
 		dev_err(&pdev->dev, "could not get DIU IRQ\n");
 		ret = -EINVAL;
 		goto error;
 	}
-	machine_data->monitor_port = monitor_port;
+	data->monitor_port = monitor_port;
 
 	/* Initialize the dummy Area Descriptor */
-	machine_data->dummy_ad.addr -		cpu_to_le32(DMA_ADDR(machine_data, dummy_aoi));
-	machine_data->dummy_ad.pix_fmt = 0x88882317;
-	machine_data->dummy_ad.src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
-	machine_data->dummy_ad.aoi_size = cpu_to_le32((4 << 16) |  2);
-	machine_data->dummy_ad.offset_xyi = 0;
-	machine_data->dummy_ad.offset_xyd = 0;
-	machine_data->dummy_ad.next_ad = 0;
-	machine_data->dummy_ad.paddr = DMA_ADDR(machine_data, dummy_ad);
+	data->dummy_ad.addr = cpu_to_le32(DMA_ADDR(data, dummy_aoi));
+	data->dummy_ad.pix_fmt = 0x88882317;
+	data->dummy_ad.src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
+	data->dummy_ad.aoi_size = cpu_to_le32((4 << 16) |  2);
+	data->dummy_ad.offset_xyi = 0;
+	data->dummy_ad.offset_xyd = 0;
+	data->dummy_ad.next_ad = 0;
+	data->dummy_ad.paddr = DMA_ADDR(data, dummy_ad);
 
 	/*
 	 * Let DIU display splash screen if it was pre-initialized
 	 * by the bootloader, set dummy area descriptor otherwise.
 	 */
 	if (diu_mode = MFB_MODE0)
-		out_be32(&machine_data->diu_reg->desc[0],
-			 machine_data->dummy_ad.paddr);
+		out_be32(&data->diu_reg->desc[0], data->dummy_ad.paddr);
 
-	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad.paddr);
-	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad.paddr);
+	out_be32(&data->diu_reg->desc[1], data->dummy_ad.paddr);
+	out_be32(&data->diu_reg->desc[2], data->dummy_ad.paddr);
 
 	for (i = 0; i < NUM_AOIS; i++) {
-		ret = install_fb(&machine_data->fsl_diu_info[i]);
+		ret = install_fb(&data->fsl_diu_info[i]);
 		if (ret) {
 			dev_err(&pdev->dev, "could not register fb %d\n", i);
 			goto error;
 		}
 	}
 
-	if (request_irq_local(machine_data)) {
+	if (request_irq_local(data)) {
 		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
 
-	sysfs_attr_init(&machine_data->dev_attr.attr);
-	machine_data->dev_attr.attr.name = "monitor";
-	machine_data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
-	machine_data->dev_attr.show = show_monitor;
-	machine_data->dev_attr.store = store_monitor;
-	ret = device_create_file(&pdev->dev, &machine_data->dev_attr);
+	sysfs_attr_init(&data->dev_attr.attr);
+	data->dev_attr.attr.name = "monitor";
+	data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
+	data->dev_attr.show = show_monitor;
+	data->dev_attr.store = store_monitor;
+	ret = device_create_file(&pdev->dev, &data->dev_attr);
 	if (ret) {
 		dev_err(&pdev->dev, "could not create sysfs file %s\n",
-			machine_data->dev_attr.attr.name);
+			data->dev_attr.attr.name);
 	}
 
-	dev_set_drvdata(&pdev->dev, machine_data);
+	dev_set_drvdata(&pdev->dev, data);
 	return 0;
 
 error:
 	for (i = 0; i < NUM_AOIS; i++)
-		uninstall_fb(&machine_data->fsl_diu_info[i]);
+		uninstall_fb(&data->fsl_diu_info[i]);
 
-	iounmap(machine_data->diu_reg);
+	iounmap(data->diu_reg);
 
-	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
-		machine_data, machine_data->dma_addr);
+	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data), data,
+			  data->dma_addr);
 
 	return ret;
 }
 
 static int fsl_diu_remove(struct platform_device *pdev)
 {
-	struct fsl_diu_data *machine_data;
+	struct fsl_diu_data *data;
 	int i;
 
-	machine_data = dev_get_drvdata(&pdev->dev);
-	disable_lcdc(&machine_data->fsl_diu_info[0]);
-	free_irq_local(machine_data);
+	data = dev_get_drvdata(&pdev->dev);
+	disable_lcdc(&data->fsl_diu_info[0]);
+	free_irq_local(data);
 
 	for (i = 0; i < NUM_AOIS; i++)
-		uninstall_fb(&machine_data->fsl_diu_info[i]);
+		uninstall_fb(&data->fsl_diu_info[i]);
 
-	iounmap(machine_data->diu_reg);
+	iounmap(data->diu_reg);
 
-	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
-		machine_data, machine_data->dma_addr);
+	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data), data,
+			  data->dma_addr);
 
 	return 0;
 }
-- 
1.7.3.4


