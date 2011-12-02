From: Timur Tabi <timur@freescale.com>
Date: Fri, 02 Dec 2011 23:03:27 +0000
Subject: [PATCH] drivers/video: fsl-diu-fb: merge all allocated data into one block
Message-Id: <1322867007-14827-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The Freescale DIU driver allocates multiple blocks of memory, including
multiple DMA buffers.  Merge all of these blocks into one data structure.

Specifically:

1) struct fsl_diu_data now contains everything that needs to be allocated,
except for the framebuffers themselves.  DMA'able objects are aligned correctly
within the structure.

2) struct diu_addr is no longer needed, because we don't have to manage
multiple blocks of DMA memory.

3) Since there's no diu_addr any more, macro DMA_ADDR is used to calculate
the DMA address of any field in fsl_diu_data.

4) Functions allocate_buf() and free_buf() are no longer needed, because we
now assume that dma_alloc_coherent() will allocate a page-aligned block,
and everything is properly aligned with fsl_diu_data already, so we no longer
need to align any memory blocks ourselves.

5) The "dummy" area descriptor is now defined separately from the other
five ADs, so NUM_AOIS (previously called FSL_AOI_NUM) is now set to five
instead of six.  Previously, all six were combined together to avoid a
separate call to allocate_buf() just for the dummy AD.

6) framebuffer_alloc() and framebuffer_release() are no longer used.  The
framebuffer is initialized manually.

7) Error handling is simplified since there's only one memory buffer
allocated.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  326 +++++++++++++++++++-------------------------
 1 files changed, 139 insertions(+), 187 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index a16beeb..4d54188 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -36,8 +36,7 @@
 #include <linux/fsl-diu-fb.h>
 #include "edid.h"
 
-#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
-				/* 1 for plane 0, 2 for plane 1&2 each */
+#define NUM_AOIS	5	/* 1 for plane 0, 2 for planes 1 & 2 each */
 
 /* HW cursor parameters */
 #define MAX_CURS		32
@@ -49,12 +48,6 @@
 #define INT_PARERR	0x08	/* Display parameters error interrupt */
 #define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
 
-struct diu_addr {
-	void *vaddr;		/* Virtual address */
-	dma_addr_t paddr;	/* Physical address */
-	__u32 offset;
-};
-
 /*
  * List of supported video modes
  *
@@ -330,23 +323,6 @@ static unsigned int d_cache_line_size;
 
 static DEFINE_SPINLOCK(diu_lock);
 
-struct fsl_diu_data {
-	struct fb_info *fsl_diu_info[FSL_AOI_NUM - 1];
-				/*FSL_AOI_NUM has one dummy AOI */
-	struct device_attribute dev_attr;
-	struct diu_ad *dummy_ad;
-	void *dummy_aoi_virt;
-	unsigned int irq;
-	int fb_enabled;
-	enum fsl_diu_monitor_port monitor_port;
-	struct diu __iomem *diu_reg;
-	spinlock_t reg_lock;
-	struct diu_addr ad;
-	struct diu_addr gamma;
-	struct diu_addr pallete;
-	struct diu_addr cursor;
-};
-
 enum mfb_index {
 	PLANE0 = 0,	/* Plane 0, only one AOI that fills the screen */
 	PLANE1_AOI0,	/* Plane 1, first AOI */
@@ -370,6 +346,44 @@ struct mfb_info {
 	u8 *edid_data;
 };
 
+/**
+ * struct fsl_diu_data - per-DIU data structure
+ * @dma_addr: DMA address of this structure
+ * @fsl_diu_info: fb_info objects, one per AOI
+ * @dev_attr: sysfs structure
+ * @irq: IRQ
+ * @fb_enabled: TRUE if the DIU is enabled, FALSE if not
+ * @monitor_port: the monitor port this DIU is connected to
+ * @diu_reg: pointer to the DIU hardware registers
+ * @reg_lock: spinlock for register access
+ * @dummy_aoi: video buffer for the 4x4 32-bit dummy AOI
+ * dummy_ad: DIU Area Descriptor for the dummy AOI
+ * @ad[]: Area Descriptors for each real AOI
+ * @gamma: gamma color table
+ * @cursor: hardware cursor data
+ *
+ * This data structure must be allocated with 32-byte alignment, so that the
+ * internal fields can be aligned properly.
+ */
+struct fsl_diu_data {
+	dma_addr_t dma_addr;
+	struct fb_info fsl_diu_info[NUM_AOIS];
+	struct mfb_info mfb[NUM_AOIS];
+	struct device_attribute dev_attr;
+	unsigned int irq;
+	int fb_enabled;
+	enum fsl_diu_monitor_port monitor_port;
+	struct diu __iomem *diu_reg;
+	spinlock_t reg_lock;
+	u8 dummy_aoi[4 * 4 * 4];
+	struct diu_ad dummy_ad __aligned(8);
+	struct diu_ad ad[NUM_AOIS] __aligned(8);
+	u8 gamma[256 * 3] __aligned(32);
+	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
+} __aligned(32);
+
+/* Determine the DMA address of a member of the fsl_diu_data structure */
+#define DMA_ADDR(p, f) ((p)->dma_addr + offsetof(struct fsl_diu_data, f))
 
 static struct mfb_info mfb_template[] = {
 	{
@@ -504,7 +518,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[0], ad->paddr);
 		break;
 	case PLANE1_AOI0:
-		cmfbi = machine_data->fsl_diu_info[2]->par;
+		cmfbi = &machine_data->mfb[2];
 		if (hw->desc[1] != ad->paddr) {	/* AOI0 closed */
 			if (cmfbi->count > 0)	/* AOI1 open */
 				ad->next_ad @@ -515,7 +529,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 		}
 		break;
 	case PLANE2_AOI0:
-		cmfbi = machine_data->fsl_diu_info[4]->par;
+		cmfbi = &machine_data->mfb[4];
 		if (hw->desc[2] != ad->paddr) {	/* AOI0 closed */
 			if (cmfbi->count > 0)	/* AOI1 open */
 				ad->next_ad @@ -526,17 +540,17 @@ static void fsl_diu_enable_panel(struct fb_info *info)
 		}
 		break;
 	case PLANE1_AOI1:
-		pmfbi = machine_data->fsl_diu_info[1]->par;
+		pmfbi = &machine_data->mfb[1];
 		ad->next_ad = 0;
-		if (hw->desc[1] = machine_data->dummy_ad->paddr)
+		if (hw->desc[1] = machine_data->dummy_ad.paddr)
 			wr_reg_wa(&hw->desc[1], ad->paddr);
 		else					/* AOI0 open */
 			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 		break;
 	case PLANE2_AOI1:
-		pmfbi = machine_data->fsl_diu_info[3]->par;
+		pmfbi = &machine_data->mfb[3];
 		ad->next_ad = 0;
-		if (hw->desc[2] = machine_data->dummy_ad->paddr)
+		if (hw->desc[2] = machine_data->dummy_ad.paddr)
 			wr_reg_wa(&hw->desc[2], ad->paddr);
 		else				/* AOI0 was open */
 			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
@@ -553,47 +567,47 @@ static void fsl_diu_disable_panel(struct fb_info *info)
 
 	switch (mfbi->index) {
 	case PLANE0:
-		if (hw->desc[0] != machine_data->dummy_ad->paddr)
-			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad->paddr);
+		if (hw->desc[0] != machine_data->dummy_ad.paddr)
+			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad.paddr);
 		break;
 	case PLANE1_AOI0:
-		cmfbi = machine_data->fsl_diu_info[2]->par;
+		cmfbi = &machine_data->mfb[2];
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[1], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
 					/* close AOI 0 */
 		break;
 	case PLANE2_AOI0:
-		cmfbi = machine_data->fsl_diu_info[4]->par;
+		cmfbi = &machine_data->mfb[4];
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[2], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
 					/* close AOI 0 */
 		break;
 	case PLANE1_AOI1:
-		pmfbi = machine_data->fsl_diu_info[1]->par;
+		pmfbi = &machine_data->mfb[1];
 		if (hw->desc[1] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
 			if (pmfbi->count > 0)
 					/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else			/* AOI1 is the first in the chain */
-			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
 					/* close AOI 1 */
 		break;
 	case PLANE2_AOI1:
-		pmfbi = machine_data->fsl_diu_info[3]->par;
+		pmfbi = &machine_data->mfb[3];
 		if (hw->desc[2] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
 			if (pmfbi->count > 0)
 				/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else		/* AOI1 is the first in the chain */
-			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
 				/* close AOI 1 */
 		break;
 	}
@@ -633,8 +647,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 	int lower_aoi_is_open, upper_aoi_is_open;
 	__u32 base_plane_width, base_plane_height, upper_aoi_height;
 
-	base_plane_width = machine_data->fsl_diu_info[0]->var.xres;
-	base_plane_height = machine_data->fsl_diu_info[0]->var.yres;
+	base_plane_width = machine_data->fsl_diu_info[0].var.xres;
+	base_plane_height = machine_data->fsl_diu_info[0].var.yres;
 
 	if (mfbi->x_aoi_d < 0)
 		mfbi->x_aoi_d = 0;
@@ -649,7 +663,7 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI0:
 	case PLANE2_AOI0:
-		lower_aoi_mfbi = machine_data->fsl_diu_info[index+1]->par;
+		lower_aoi_mfbi = machine_data->fsl_diu_info[index+1].par;
 		lower_aoi_is_open = lower_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
 			var->xres = base_plane_width;
@@ -667,9 +681,9 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI1:
 	case PLANE2_AOI1:
-		upper_aoi_mfbi = machine_data->fsl_diu_info[index-1]->par;
+		upper_aoi_mfbi = machine_data->fsl_diu_info[index-1].par;
 		upper_aoi_height -				machine_data->fsl_diu_info[index-1]->var.yres;
+				machine_data->fsl_diu_info[index-1].var.yres;
 		upper_aoi_bottom = upper_aoi_mfbi->y_aoi_d + upper_aoi_height;
 		upper_aoi_is_open = upper_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
@@ -812,15 +826,15 @@ static void update_lcdc(struct fb_info *info)
 	struct fsl_diu_data *machine_data = mfbi->parent;
 	struct diu __iomem *hw;
 	int i, j;
-	char __iomem *cursor_base, *gamma_table_base;
+	u8 *gamma_table_base;
 
 	u32 temp;
 
 	hw = machine_data->diu_reg;
 
 	diu_ops.set_monitor_port(machine_data->monitor_port);
-	gamma_table_base = machine_data->gamma.vaddr;
-	cursor_base = machine_data->cursor.vaddr;
+	gamma_table_base = machine_data->gamma;
+
 	/* Prep for DIU init  - gamma table, cursor table */
 
 	for (i = 0; i <= 2; i++)
@@ -828,14 +842,14 @@ static void update_lcdc(struct fb_info *info)
 			*gamma_table_base++ = j;
 
 	diu_ops.set_gamma_table(machine_data->monitor_port,
-				machine_data->gamma.vaddr);
+		machine_data->gamma);
 
 	disable_lcdc(info);
 
 	/* Program DIU registers */
 
-	out_be32(&hw->gamma, machine_data->gamma.paddr);
-	out_be32(&hw->cursor, machine_data->cursor.paddr);
+	out_be32(&hw->gamma, DMA_ADDR(machine_data, gamma));
+	out_be32(&hw->cursor, DMA_ADDR(machine_data, cursor));
 
 	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
 	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
@@ -1423,37 +1437,6 @@ static int fsl_diu_resume(struct platform_device *ofdev)
 #define fsl_diu_resume NULL
 #endif				/* CONFIG_PM */
 
-/* Align to 64-bit(8-byte), 32-byte, etc. */
-static int allocate_buf(struct device *dev, struct diu_addr *buf, u32 size,
-			u32 bytes_align)
-{
-	u32 offset;
-	dma_addr_t mask;
-
-	buf->vaddr -		dma_alloc_coherent(dev, size + bytes_align, &buf->paddr,
-				   GFP_DMA | __GFP_ZERO);
-	if (!buf->vaddr)
-		return -ENOMEM;
-
-	mask = bytes_align - 1;
-	offset = buf->paddr & mask;
-	if (offset) {
-		buf->offset = bytes_align - offset;
-		buf->paddr = buf->paddr + offset;
-	} else
-		buf->offset = 0;
-
-	return 0;
-}
-
-static void free_buf(struct device *dev, struct diu_addr *buf, u32 size,
-		     u32 bytes_align)
-{
-	dma_free_coherent(dev, size + bytes_align, buf->vaddr,
-			  buf->paddr - buf->offset);
-}
-
 static ssize_t store_monitor(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -1468,11 +1451,10 @@ static ssize_t store_monitor(struct device *device,
 		/* All AOIs need adjust pixel format
 		 * fsl_diu_set_par only change the pixsel format here
 		 * unlikely to fail. */
-		fsl_diu_set_par(machine_data->fsl_diu_info[0]);
-		fsl_diu_set_par(machine_data->fsl_diu_info[1]);
-		fsl_diu_set_par(machine_data->fsl_diu_info[2]);
-		fsl_diu_set_par(machine_data->fsl_diu_info[3]);
-		fsl_diu_set_par(machine_data->fsl_diu_info[4]);
+		unsigned int i;
+
+		for (i=0; i < NUM_AOIS; i++)
+			fsl_diu_set_par(&machine_data->fsl_diu_info[i]);
 	}
 	return count;
 }
@@ -1499,28 +1481,52 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
-	phys_addr_t dummy_ad_addr = 0;
-	int ret, i, error = 0;
 	struct fsl_diu_data *machine_data;
 	int diu_mode;
+	dma_addr_t dma_addr; /* DMA addr of machine_data struct */
+	unsigned int i;
+	int ret;
 
-	machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
+	machine_data = dma_alloc_coherent(&pdev->dev,
+		sizeof(struct fsl_diu_data), &dma_addr, GFP_DMA | __GFP_ZERO);
 	if (!machine_data)
 		return -ENOMEM;
+	machine_data->dma_addr = dma_addr;
+
+	/*
+	 * dma_alloc_coherent() uses a page allocator, so the address is
+	 * always page-aligned.  We need the memory to be 32-byte aligned,
+	 * so that's good.  However, if one day the allocator changes, we
+	 * need to catch that.  It's not worth the effort to handle unaligned
+	 * alloctions now because it's highly unlikely to ever be a problem.
+	 */
+	if ((unsigned long)machine_data & 31) {
+		dev_err(&pdev->dev, "misaligned allocation");
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	spin_lock_init(&machine_data->reg_lock);
 
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
-		machine_data->fsl_diu_info[i] -			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
-		if (!machine_data->fsl_diu_info[i]) {
-			dev_err(&pdev->dev, "cannot allocate memory\n");
-			ret = -ENOMEM;
-			goto error2;
-		}
-		mfbi = machine_data->fsl_diu_info[i]->par;
+	for (i = 0; i < NUM_AOIS; i++) {
+		struct fb_info *info = &machine_data->fsl_diu_info[i];
+
+		info->device = &pdev->dev;
+		info->par = &machine_data->mfb[i];
+
+		/*
+		 * We store the physical address of the AD in the reserved
+		 * 'paddr' field of the AD itself.
+		 */
+		machine_data->ad[i].paddr = DMA_ADDR(machine_data, ad[i]);
+
+		info->fix.smem_start = 0;
+
+		/* Initialize the AOI data structure */
+		mfbi = info->par;
 		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
 		mfbi->parent = machine_data;
+		mfbi->ad = &machine_data->ad[i];
 
 		if (mfbi->index = PLANE0) {
 			const u8 *prop;
@@ -1538,7 +1544,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	if (!machine_data->diu_reg) {
 		dev_err(&pdev->dev, "cannot map DIU registers\n");
 		ret = -EFAULT;
-		goto error2;
+		goto error;
 	}
 
 	diu_mode = in_be32(&machine_data->diu_reg->diu_mode);
@@ -1555,41 +1561,16 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	}
 	machine_data->monitor_port = monitor_port;
 
-	/* Area descriptor memory pool aligns to 64-bit boundary */
-	if (allocate_buf(&pdev->dev, &machine_data->ad,
-			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8))
-		return -ENOMEM;
-
-	/* Get memory for Gamma Table  - 32-byte aligned memory */
-	if (allocate_buf(&pdev->dev, &machine_data->gamma, 768, 32)) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* For performance, cursor bitmap buffer aligns to 32-byte boundary */
-	if (allocate_buf(&pdev->dev, &machine_data->cursor,
-			 MAX_CURS * MAX_CURS * 2, 32)) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	i = ARRAY_SIZE(machine_data->fsl_diu_info);
-	machine_data->dummy_ad = (struct diu_ad *)((u32)machine_data->ad.vaddr +
-			machine_data->ad.offset) + i;
-	machine_data->dummy_ad->paddr = machine_data->ad.paddr +
-			i * sizeof(struct diu_ad);
-	machine_data->dummy_aoi_virt = fsl_diu_alloc(64, &dummy_ad_addr);
-	if (!machine_data->dummy_aoi_virt) {
-		ret = -ENOMEM;
-		goto error;
-	}
-	machine_data->dummy_ad->addr = cpu_to_le32(dummy_ad_addr);
-	machine_data->dummy_ad->pix_fmt = 0x88882317;
-	machine_data->dummy_ad->src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
-	machine_data->dummy_ad->aoi_size = cpu_to_le32((4 << 16) |  2);
-	machine_data->dummy_ad->offset_xyi = 0;
-	machine_data->dummy_ad->offset_xyd = 0;
-	machine_data->dummy_ad->next_ad = 0;
+	/* Initialize the dummy Area Descriptor */
+	machine_data->dummy_ad.addr +		cpu_to_le32(DMA_ADDR(machine_data, dummy_aoi));
+	machine_data->dummy_ad.pix_fmt = 0x88882317;
+	machine_data->dummy_ad.src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
+	machine_data->dummy_ad.aoi_size = cpu_to_le32((4 << 16) |  2);
+	machine_data->dummy_ad.offset_xyi = 0;
+	machine_data->dummy_ad.offset_xyd = 0;
+	machine_data->dummy_ad.next_ad = 0;
+	machine_data->dummy_ad.paddr = DMA_ADDR(machine_data, dummy_ad);
 
 	/*
 	 * Let DIU display splash screen if it was pre-initialized
@@ -1597,19 +1578,13 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	 */
 	if (diu_mode = MFB_MODE0)
 		out_be32(&machine_data->diu_reg->desc[0],
-			 machine_data->dummy_ad->paddr);
-
-	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad->paddr);
-	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad->paddr);
-
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
-		machine_data->fsl_diu_info[i]->fix.smem_start = 0;
-		mfbi = machine_data->fsl_diu_info[i]->par;
-		mfbi->ad = (struct diu_ad *)((u32)machine_data->ad.vaddr
-					+ machine_data->ad.offset) + i;
-		mfbi->ad->paddr -			machine_data->ad.paddr + i * sizeof(struct diu_ad);
-		ret = install_fb(machine_data->fsl_diu_info[i]);
+			 machine_data->dummy_ad.paddr);
+
+	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad.paddr);
+	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad.paddr);
+
+	for (i = 0; i < NUM_AOIS; i++) {
+		ret = install_fb(&machine_data->fsl_diu_info[i]);
 		if (ret) {
 			dev_err(&pdev->dev, "could not register fb %d\n", i);
 			goto error;
@@ -1626,9 +1601,8 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	machine_data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
 	machine_data->dev_attr.show = show_monitor;
 	machine_data->dev_attr.store = store_monitor;
-	error = device_create_file(machine_data->fsl_diu_info[0]->dev,
-				  &machine_data->dev_attr);
-	if (error) {
+	ret = device_create_file(&pdev->dev, &machine_data->dev_attr);
+	if (ret) {
 		dev_err(&pdev->dev, "could not create sysfs file %s\n",
 			machine_data->dev_attr.attr.name);
 	}
@@ -1637,26 +1611,13 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
-		uninstall_fb(machine_data->fsl_diu_info[i]);
-
-	if (machine_data->ad.vaddr)
-		free_buf(&pdev->dev, &machine_data->ad,
-			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
-	if (machine_data->gamma.vaddr)
-		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
-	if (machine_data->cursor.vaddr)
-		free_buf(&pdev->dev, &machine_data->cursor,
-			 MAX_CURS * MAX_CURS * 2, 32);
-	if (machine_data->dummy_aoi_virt)
-		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
+	for (i = 0; i < NUM_AOIS; i++)
+		uninstall_fb(&machine_data->fsl_diu_info[i]);
+
 	iounmap(machine_data->diu_reg);
 
-error2:
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
-		if (machine_data->fsl_diu_info[i])
-			framebuffer_release(machine_data->fsl_diu_info[i]);
-	kfree(machine_data);
+	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
+		machine_data, machine_data->dma_addr);
 
 	return ret;
 }
@@ -1667,25 +1628,16 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	machine_data = dev_get_drvdata(&pdev->dev);
-	disable_lcdc(machine_data->fsl_diu_info[0]);
+	disable_lcdc(&machine_data->fsl_diu_info[0]);
 	free_irq_local(machine_data);
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
-		uninstall_fb(machine_data->fsl_diu_info[i]);
-	if (machine_data->ad.vaddr)
-		free_buf(&pdev->dev, &machine_data->ad,
-			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
-	if (machine_data->gamma.vaddr)
-		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
-	if (machine_data->cursor.vaddr)
-		free_buf(&pdev->dev, &machine_data->cursor,
-			 MAX_CURS * MAX_CURS * 2, 32);
-	if (machine_data->dummy_aoi_virt)
-		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
+
+	for (i = 0; i < NUM_AOIS; i++)
+		uninstall_fb(&machine_data->fsl_diu_info[i]);
+
 	iounmap(machine_data->diu_reg);
-	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
-		if (machine_data->fsl_diu_info[i])
-			framebuffer_release(machine_data->fsl_diu_info[i]);
-	kfree(machine_data);
+
+	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
+		machine_data, machine_data->dma_addr);
 
 	return 0;
 }
-- 
1.7.3.4


