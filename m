From: Timur Tabi <timur@freescale.com>
Date: Tue, 13 Sep 2011 16:05:09 +0000
Subject: [REPOST][PATCH 2/2] video: miscellaneous minor changes to the Freescale DIU driver
Message-Id: <1315929909-26311-2-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make several minor, miscellaneous changes to the Freescale DIU framebuffer
driver.  These changes "lighten" the code by removing crud, fixing small
bugs, and fixing some coding style problems.  These changes will make it
easier to make more substantial fixes in the future.

1. Fix incorrect indentation and spacing with some code.
2. Remove debug printks (they don't actually help in debugging the code).
3. Clean up some other printks (e.g. use pr_xxx, clean up the text, etc).
4. Remove the "default" videomode object since it's just a dupe of the
   first element in the videomode array.
5. Remove some superfluous local variables.
6. Rename ofdev to pdev, since it's a platform device not an OF device.
7. Fix some device tree operations.
8. Fix some build warnings.
9. Removed some unused structures from the header file.
10. Other minor bug fixes and changes.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  362 +++++++++++++++-----------------------------
 include/linux/fsl-diu-fb.h |   12 +--
 2 files changed, 125 insertions(+), 249 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0f1933b..1470581 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -36,26 +36,10 @@
 #include "edid.h"
 
 /*
- * These parameters give default parameters
- * for video output 1024x768,
- * FIXME - change timing to proper amounts
- * hsync 31.5kHz, vsync 60Hz
+ * List of supported video modes
+ *
+ * The first entry is the default video mode
  */
-static struct fb_videomode __devinitdata fsl_diu_default_mode = {
-	.refresh	= 60,
-	.xres		= 1024,
-	.yres		= 768,
-	.pixclock	= 15385,
-	.left_margin	= 160,
-	.right_margin	= 24,
-	.upper_margin	= 29,
-	.lower_margin	= 3,
-	.hsync_len	= 136,
-	.vsync_len	= 6,
-	.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.vmode		= FB_VMODE_NONINTERLACED
-};
-
 static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 	{
 		.name		= "1024x768-60",
@@ -217,59 +201,59 @@ struct mfb_info {
 	int x_aoi_d;		/* aoi display x offset to physical screen */
 	int y_aoi_d;		/* aoi display y offset to physical screen */
 	struct fsl_diu_data *parent;
-	u8 *edid_data;
+	void *edid_data;
 };
 
 
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
 
@@ -322,14 +306,9 @@ static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
 {
 	void *virt;
 
-	pr_debug("size=%zu\n", size);
-
 	virt = alloc_pages_exact(size, GFP_DMA | __GFP_ZERO);
-	if (virt) {
+	if (virt)
 		*phys = virt_to_phys(virt);
-		pr_debug("virt=%p phys=%llx\n", virt,
-			(unsigned long long)*phys);
-	}
 
 	return virt;
 }
@@ -343,8 +322,6 @@ static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
  */
 static void fsl_diu_free(void *virt, size_t size)
 {
-	pr_debug("virt=%p size=%zu\n", virt, size);
-
 	if (virt && size)
 		free_pages_exact(virt, size);
 }
@@ -368,7 +345,6 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	struct fsl_diu_data *machine_data = mfbi->parent;
 	int res = 0;
 
-	pr_debug("enable_panel index %d\n", mfbi->index);
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
@@ -585,9 +561,6 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 static int fsl_diu_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
-	pr_debug("check_var xres: %d\n", var->xres);
-	pr_debug("check_var yres: %d\n", var->yres);
-
 	if (var->xres_virtual < var->xres)
 		var->xres_virtual = var->xres;
 	if (var->yres_virtual < var->yres)
@@ -682,7 +655,7 @@ static void set_fix(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
 
-	strncpy(fix->id, mfbi->id, strlen(mfbi->id));
+	strncpy(fix->id, mfbi->id, sizeof(fix->id));
 	fix->line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->accel = FB_ACCEL_NONE;
@@ -715,12 +688,11 @@ static void update_lcdc(struct fb_info *info)
 	/* Prep for DIU init  - gamma table, cursor table */
 
 	for (i = 0; i <= 2; i++)
-	   for (j = 0; j <= 255; j++)
-	      *gamma_table_base++ = j;
+		for (j = 0; j <= 255; j++)
+			*gamma_table_base++ = j;
 
 	diu_ops.set_gamma_table(machine_data->monitor_port, pool.gamma.vaddr);
 
-	pr_debug("update-lcdc: HW - %p\n Disabling DIU\n", hw);
 	disable_lcdc(info);
 
 	/* Program DIU registers */
@@ -732,9 +704,6 @@ static void update_lcdc(struct fb_info *info)
 	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
 	out_be32(&hw->disp_size, (var->yres << 16 | var->xres));
 						/* DISP SIZE */
-	pr_debug("DIU xres: %d\n", var->xres);
-	pr_debug("DIU yres: %d\n", var->yres);
-
 	out_be32(&hw->wb_size, 0); /* WB SIZE */
 	out_be32(&hw->wb_mem_addr, 0); /* WB MEM ADDR */
 
@@ -751,15 +720,6 @@ static void update_lcdc(struct fb_info *info)
 
 	out_be32(&hw->vsyn_para, temp);
 
-	pr_debug("DIU right_margin - %d\n", var->right_margin);
-	pr_debug("DIU left_margin - %d\n", var->left_margin);
-	pr_debug("DIU hsync_len - %d\n", var->hsync_len);
-	pr_debug("DIU upper_margin - %d\n", var->upper_margin);
-	pr_debug("DIU lower_margin - %d\n", var->lower_margin);
-	pr_debug("DIU vsync_len - %d\n", var->vsync_len);
-	pr_debug("DIU HSYNC - 0x%08x\n", hw->hsyn_para);
-	pr_debug("DIU VSYNC - 0x%08x\n", hw->vsyn_para);
-
 	diu_ops.set_pixel_clock(var->pixclock);
 
 	out_be32(&hw->syn_pol, 0);	/* SYNC SIGNALS POLARITY */
@@ -776,14 +736,9 @@ static int map_video_memory(struct fb_info *info)
 	phys_addr_t phys;
 	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
 
-	pr_debug("info->var.xres_virtual = %d\n", info->var.xres_virtual);
-	pr_debug("info->var.yres_virtual = %d\n", info->var.yres_virtual);
-	pr_debug("info->fix.line_length  = %d\n", info->fix.line_length);
-	pr_debug("MAP_VIDEO_MEMORY: smem_len = %u\n", smem_len);
-
 	info->screen_base = fsl_diu_alloc(smem_len, &phys);
 	if (info->screen_base = NULL) {
-		printk(KERN_ERR "Unable to allocate fb memory\n");
+		dev_err(info->dev, "unable to allocate fb memory\n");
 		return -ENOMEM;
 	}
 	mutex_lock(&info->mm_lock);
@@ -792,10 +747,6 @@ static int map_video_memory(struct fb_info *info)
 	mutex_unlock(&info->mm_lock);
 	info->screen_size = info->fix.smem_len;
 
-	pr_debug("Allocated fb @ paddr=0x%08lx, size=%d.\n",
-		 info->fix.smem_start, info->fix.smem_len);
-	pr_debug("screen base %p\n", info->screen_base);
-
 	return 0;
 }
 
@@ -852,11 +803,10 @@ static int fsl_diu_set_par(struct fb_info *info)
 	if (len != info->fix.smem_len) {
 		if (info->fix.smem_start)
 			unmap_video_memory(info);
-		pr_debug("SET PAR: smem_len = %d\n", info->fix.smem_len);
 
 		/* Memory allocation for framebuffer */
 		if (map_video_memory(info)) {
-			printk(KERN_ERR "Unable to allocate fb memory 1\n");
+			dev_err(info->dev, "unable to allocate fb memory 1\n");
 			return -ENOMEM;
 		}
 	}
@@ -887,7 +837,7 @@ static int fsl_diu_set_par(struct fb_info *info)
 
 static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
 {
-	return ((val<<width) + 0x7FFF - val)>>16;
+	return ((val << width) + 0x7FFF - val) >> 16;
 }
 
 /*
@@ -899,8 +849,9 @@ static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
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
 
@@ -935,9 +886,6 @@ static int fsl_diu_setcolreg(unsigned regno, unsigned red, unsigned green,
 			ret = 0;
 		}
 		break;
-	case FB_VISUAL_STATIC_PSEUDOCOLOR:
-	case FB_VISUAL_PSEUDOCOLOR:
-		break;
 	}
 
 	return ret;
@@ -1022,21 +970,17 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
 			return -EFAULT;
 		ad->pix_fmt = pix_fmt;
-		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
 		break;
 	case MFB_GET_PIXFMT:
 		pix_fmt = ad->pix_fmt;
 		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
 			return -EFAULT;
-		pr_debug("get pixel format 0x%08x\n", ad->pix_fmt);
 		break;
 	case MFB_SET_AOID:
 		if (copy_from_user(&aoi_d, buf, sizeof(aoi_d)))
 			return -EFAULT;
 		mfbi->x_aoi_d = aoi_d.x_aoi_d;
 		mfbi->y_aoi_d = aoi_d.y_aoi_d;
-		pr_debug("set AOI display offset of index %d to (%d,%d)\n",
-				 mfbi->index, aoi_d.x_aoi_d, aoi_d.y_aoi_d);
 		fsl_diu_check_var(&info->var, info);
 		fsl_diu_set_aoi(info);
 		break;
@@ -1045,14 +989,11 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		aoi_d.y_aoi_d = mfbi->y_aoi_d;
 		if (copy_to_user(buf, &aoi_d, sizeof(aoi_d)))
 			return -EFAULT;
-		pr_debug("get AOI display offset of index %d (%d,%d)\n",
-				mfbi->index, aoi_d.x_aoi_d, aoi_d.y_aoi_d);
 		break;
 	case MFB_GET_ALPHA:
 		global_alpha = mfbi->g_alpha;
 		if (copy_to_user(buf, &global_alpha, sizeof(global_alpha)))
 			return -EFAULT;
-		pr_debug("get global alpha of index %d\n", mfbi->index);
 		break;
 	case MFB_SET_ALPHA:
 		/* set panel information */
@@ -1061,7 +1002,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		ad->src_size_g_alpha = (ad->src_size_g_alpha & (~0xff)) |
 							(global_alpha & 0xff);
 		mfbi->g_alpha = global_alpha;
-		pr_debug("set global alpha for index %d\n", mfbi->index);
 		break;
 	case MFB_SET_CHROMA_KEY:
 		/* set panel winformation */
@@ -1089,7 +1029,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 			ad->ckmin_g = ck.green_min;
 			ad->ckmin_b = ck.blue_min;
 		}
-		pr_debug("set chroma key\n");
 		break;
 	case FBIOGET_GWINFO:
 		if (mfbi->type = MFB_TYPE_OFF)
@@ -1098,18 +1037,9 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_to_user(buf, ad, sizeof(*ad)))
 			return -EFAULT;
 		break;
-	case FBIOGET_HWCINFO:
-		pr_debug("FBIOGET_HWCINFO:0x%08x\n", FBIOGET_HWCINFO);
-		break;
-	case FBIOPUT_MODEINFO:
-		pr_debug("FBIOPUT_MODEINFO:0x%08x\n", FBIOPUT_MODEINFO);
-		break;
-	case FBIOGET_DISPINFO:
-		pr_debug("FBIOGET_DISPINFO:0x%08x\n", FBIOGET_DISPINFO);
-		break;
 
 	default:
-		printk(KERN_ERR "Unknown ioctl command (0x%08X)\n", cmd);
+		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
 		return -ENOIOCTLCMD;
 	}
 
@@ -1130,7 +1060,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
 	spin_lock(&diu_lock);
 	mfbi->count++;
 	if (mfbi->count = 1) {
-		pr_debug("open plane index %d\n", mfbi->index);
 		fsl_diu_check_var(&info->var, info);
 		res = fsl_diu_set_par(info);
 		if (res < 0)
@@ -1156,7 +1085,6 @@ static int fsl_diu_release(struct fb_info *info, int user)
 	spin_lock(&diu_lock);
 	mfbi->count--;
 	if (mfbi->count = 0) {
-		pr_debug("release plane index %d\n", mfbi->index);
 		res = fsl_diu_disable_panel(info);
 		if (res < 0)
 			mfbi->count++;
@@ -1221,26 +1149,9 @@ static int __devinit install_fb(struct fb_info *info)
 	} else {
 		aoi_mode = init_aoi_mode;
 	}
-	pr_debug("mode used = %s\n", aoi_mode);
-	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize,
-			  &fsl_diu_default_mode, default_bpp);
-	switch (rc) {
-	case 1:
-		pr_debug("using mode specified in @mode\n");
-		break;
-	case 2:
-		pr_debug("using mode specified in @mode "
-			"with ignored refresh rate\n");
-		break;
-	case 3:
-		pr_debug("using mode default mode\n");
-		break;
-	case 4:
-		pr_debug("using mode from list\n");
-		break;
-	default:
-		pr_debug("rc = %d\n", rc);
-		pr_debug("failed to find mode\n");
+	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize, NULL,
+			  default_bpp);
+	if (!rc) {
 		/*
 		 * For plane 0 we continue and look into
 		 * driver's internal modedb.
@@ -1249,15 +1160,12 @@ static int __devinit install_fb(struct fb_info *info)
 			has_default_mode = 0;
 		else
 			return -EINVAL;
-		break;
 	}
 
 	if (!has_default_mode) {
 		rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
-				  ARRAY_SIZE(fsl_diu_mode_db),
-				  &fsl_diu_default_mode,
-				  default_bpp);
-		if (rc > 0 && rc < 5)
+			ARRAY_SIZE(fsl_diu_mode_db), NULL, default_bpp);
+		if (rc)
 			has_default_mode = 1;
 	}
 
@@ -1285,33 +1193,27 @@ static int __devinit install_fb(struct fb_info *info)
 		fb_videomode_to_var(&info->var, modedb);
 	}
 
-	pr_debug("xres_virtual %d\n", info->var.xres_virtual);
-	pr_debug("bits_per_pixel %d\n", info->var.bits_per_pixel);
-
-	pr_debug("info->var.yres_virtual = %d\n", info->var.yres_virtual);
-	pr_debug("info->fix.line_length = %d\n", info->fix.line_length);
-
 	if (mfbi->type = MFB_TYPE_OFF)
 		mfbi->blank = FB_BLANK_NORMAL;
 	else
 		mfbi->blank = FB_BLANK_UNBLANK;
 
 	if (fsl_diu_check_var(&info->var, info)) {
-		printk(KERN_ERR "fb_check_var failed");
+		dev_err(info->dev, "fsl_diu_check_var failed\n");
+		unmap_video_memory(info);
 		fb_dealloc_cmap(&info->cmap);
 		return -EINVAL;
 	}
 
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR "register_framebuffer failed");
+		dev_err(info->dev, "register_framebuffer failed\n");
 		unmap_video_memory(info);
 		fb_dealloc_cmap(&info->cmap);
 		return -EINVAL;
 	}
 
 	mfbi->registered = 1;
-	printk(KERN_INFO "fb%d: %s fb device registered successfully.\n",
-		 info->node, info->fix.id);
+	dev_info(info->dev, "%s registered successfully\n", mfbi->id);
 
 	return 0;
 }
@@ -1343,13 +1245,13 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 		/* This is the workaround for underrun */
 		if (status & INT_UNDRUN) {
 			out_be32(&hw->diu_mode, 0);
-			pr_debug("Err: DIU occurs underrun!\n");
 			udelay(1);
 			out_be32(&hw->diu_mode, 1);
 		}
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 		else if (status & INT_VSYNC) {
 			unsigned int i;
+
 			for (i = 0; i < coherence_data_size;
 				i += d_cache_line_size)
 				__asm__ __volatile__ (
@@ -1364,30 +1266,30 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 
 static int request_irq_local(int irq)
 {
-	unsigned long status, ints;
+	u32 ints;
 	struct diu *hw;
 	int ret;
 
 	hw = dr.diu_reg;
 
 	/* Read to clear the status */
-	status = in_be32(&hw->int_status);
+	in_be32(&hw->int_status);
 
-	ret = request_irq(irq, fsl_diu_isr, 0, "diu", NULL);
-	if (ret)
-		pr_info("Request diu IRQ failed.\n");
-	else {
+	ret = request_irq(irq, fsl_diu_isr, 0, "fsl-diu-fb", NULL);
+	if (!ret) {
 		ints = INT_PARERR | INT_LS_BF_VS;
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
 		ints |=	INT_VSYNC;
 #endif
+
 		if (dr.mode = MFB_MODE2 || dr.mode = MFB_MODE3)
 			ints |= INT_VSYNC_WB;
 
 		/* Read to clear the status */
-		status = in_be32(&hw->int_status);
+		in_be32(&hw->int_status);
 		out_be32(&hw->int_mask, ints);
 	}
+
 	return ret;
 }
 
@@ -1435,34 +1337,31 @@ static int fsl_diu_resume(struct platform_device *ofdev)
 static int allocate_buf(struct device *dev, struct diu_addr *buf, u32 size,
 			u32 bytes_align)
 {
-	u32 offset, ssize;
-	u32 mask;
-	dma_addr_t paddr = 0;
+	u32 offset;
+	dma_addr_t mask;
 
-	ssize = size + bytes_align;
-	buf->vaddr = dma_alloc_coherent(dev, ssize, &paddr, GFP_DMA |
-							     __GFP_ZERO);
+	buf->vaddr +		dma_alloc_coherent(dev, size + bytes_align, &buf->paddr,
+				   GFP_DMA | __GFP_ZERO);
 	if (!buf->vaddr)
 		return -ENOMEM;
 
-	buf->paddr = (__u32) paddr;
-
 	mask = bytes_align - 1;
-	offset = (u32)buf->paddr & mask;
+	offset = buf->paddr & mask;
 	if (offset) {
 		buf->offset = bytes_align - offset;
-		buf->paddr = (u32)buf->paddr + offset;
+		buf->paddr = buf->paddr + offset;
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
@@ -1506,13 +1405,12 @@ static ssize_t show_monitor(struct device *device,
 	return 0;
 }
 
-static int __devinit fsl_diu_probe(struct platform_device *ofdev)
+static int __devinit fsl_diu_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
-	phys_addr_t dummy_ad_addr;
+	phys_addr_t dummy_ad_addr = 0;
 	int ret, i, error = 0;
-	struct resource res;
 	struct fsl_diu_data *machine_data;
 	int diu_mode;
 
@@ -1522,9 +1420,9 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
 		machine_data->fsl_diu_info[i] -			framebuffer_alloc(sizeof(struct mfb_info), &ofdev->dev);
+			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
 		if (!machine_data->fsl_diu_info[i]) {
-			dev_err(&ofdev->dev, "cannot allocate memory\n");
+			dev_err(&pdev->dev, "cannot allocate memory\n");
 			ret = -ENOMEM;
 			goto error2;
 		}
@@ -1544,20 +1442,9 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 		}
 	}
 
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&ofdev->dev, "could not obtain DIU address\n");
-		goto error;
-	}
-	if (!res.start) {
-		dev_err(&ofdev->dev, "invalid DIU address\n");
-		goto error;
-	}
-	dev_dbg(&ofdev->dev, "%s, res.start: 0x%08x\n", __func__, res.start);
-
-	dr.diu_reg = ioremap(res.start, sizeof(struct diu));
+	dr.diu_reg = of_iomap(np, 0);
 	if (!dr.diu_reg) {
-		dev_err(&ofdev->dev, "Err: can't map DIU registers!\n");
+		dev_err(&pdev->dev, "cannot map DIU registers\n");
 		ret = -EFAULT;
 		goto error2;
 	}
@@ -1570,25 +1457,25 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 	machine_data->irq = irq_of_parse_and_map(np, 0);
 
 	if (!machine_data->irq) {
-		dev_err(&ofdev->dev, "could not get DIU IRQ\n");
+		dev_err(&pdev->dev, "could not get DIU IRQ\n");
 		ret = -EINVAL;
 		goto error;
 	}
 	machine_data->monitor_port = monitor_port;
 
 	/* Area descriptor memory pool aligns to 64-bit boundary */
-	if (allocate_buf(&ofdev->dev, &pool.ad,
+	if (allocate_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8))
 		return -ENOMEM;
 
 	/* Get memory for Gamma Table  - 32-byte aligned memory */
-	if (allocate_buf(&ofdev->dev, &pool.gamma, 768, 32)) {
+	if (allocate_buf(&pdev->dev, &pool.gamma, 768, 32)) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
 	/* For performance, cursor bitmap buffer aligns to 32-byte boundary */
-	if (allocate_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
+	if (allocate_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
 			 32)) {
 		ret = -ENOMEM;
 		goto error;
@@ -1630,16 +1517,13 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 		mfbi->ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
 		ret = install_fb(machine_data->fsl_diu_info[i]);
 		if (ret) {
-			dev_err(&ofdev->dev,
-				"Failed to register framebuffer %d\n",
-				i);
+			dev_err(&pdev->dev, "could not register fb %d\n", i);
 			goto error;
 		}
 	}
 
 	if (request_irq_local(machine_data->irq)) {
-		dev_err(machine_data->fsl_diu_info[0]->dev,
-			"could not request irq for diu.");
+		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
 
@@ -1651,25 +1535,24 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 	error = device_create_file(machine_data->fsl_diu_info[0]->dev,
 				  &machine_data->dev_attr);
 	if (error) {
-		dev_err(machine_data->fsl_diu_info[0]->dev,
-			"could not create sysfs %s file\n",
+		dev_err(&pdev->dev, "could not create sysfs file %s\n",
 			machine_data->dev_attr.attr.name);
 	}
 
-	dev_set_drvdata(&ofdev->dev, machine_data);
+	dev_set_drvdata(&pdev->dev, machine_data);
 	return 0;
 
 error:
-	for (i = ARRAY_SIZE(machine_data->fsl_diu_info);
-		i > 0; i--)
-		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
+	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
+		uninstall_fb(machine_data->fsl_diu_info[i]);
+
 	if (pool.ad.vaddr)
-		free_buf(&ofdev->dev, &pool.ad,
+		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
 	if (pool.gamma.vaddr)
-		free_buf(&ofdev->dev, &pool.gamma, 768, 32);
+		free_buf(&pdev->dev, &pool.gamma, 768, 32);
 	if (pool.cursor.vaddr)
-		free_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
+		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
 			 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
@@ -1684,25 +1567,23 @@ error2:
 	return ret;
 }
 
-
-static int fsl_diu_remove(struct platform_device *ofdev)
+static int fsl_diu_remove(struct platform_device *pdev)
 {
 	struct fsl_diu_data *machine_data;
 	int i;
 
-	machine_data = dev_get_drvdata(&ofdev->dev);
+	machine_data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(machine_data->fsl_diu_info[0]);
 	free_irq_local(machine_data->irq);
-	for (i = ARRAY_SIZE(machine_data->fsl_diu_info); i > 0; i--)
-		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
+	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
+		uninstall_fb(machine_data->fsl_diu_info[i]);
 	if (pool.ad.vaddr)
-		free_buf(&ofdev->dev, &pool.ad,
+		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
 	if (pool.gamma.vaddr)
-		free_buf(&ofdev->dev, &pool.gamma, 768, 32);
+		free_buf(&pdev->dev, &pool.gamma, 768, 32);
 	if (pool.cursor.vaddr)
-		free_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
-			 32);
+		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2, 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
 	iounmap(dr.diu_reg);
@@ -1754,7 +1635,7 @@ MODULE_DEVICE_TABLE(of, fsl_diu_match);
 
 static struct platform_driver fsl_diu_driver = {
 	.driver = {
-		.name = "fsl_diu",
+		.name = "fsl-diu-fb",
 		.owner = THIS_MODULE,
 		.of_match_table = fsl_diu_match,
 	},
@@ -1783,43 +1664,48 @@ static int __init fsl_diu_init(void)
 #else
 	monitor_port = fsl_diu_name_to_port(monitor_string);
 #endif
-	printk(KERN_INFO "Freescale DIU driver\n");
+	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	np = of_find_node_by_type(NULL, "cpu");
 	if (!np) {
-		printk(KERN_ERR "Err: can't find device node 'cpu'\n");
+		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
 		return -ENODEV;
 	}
 
 	prop = of_get_property(np, "d-cache-size", NULL);
 	if (prop = NULL) {
+		pr_err("fsl-diu-fb: missing 'd-cache-size' property' "
+		       "in 'cpu' node\n");
 		of_node_put(np);
 		return -ENODEV;
 	}
 
-	/* Freescale PLRU requires 13/8 times the cache size to do a proper
-	   displacement flush
+	/*
+	 * Freescale PLRU requires 13/8 times the cache size to do a proper
+	 * displacement flush
 	 */
-	coherence_data_size = *prop * 13;
+	coherence_data_size = be32_to_cpup(prop) * 13;
 	coherence_data_size /= 8;
 
 	prop = of_get_property(np, "d-cache-line-size", NULL);
 	if (prop = NULL) {
+		pr_err("fsl-diu-fb: missing 'd-cache-line-size' property' "
+		       "in 'cpu' node\n");
 		of_node_put(np);
 		return -ENODEV;
 	}
-	d_cache_line_size = *prop;
+	d_cache_line_size = be32_to_cpup(prop);
 
 	of_node_put(np);
 	coherence_data = vmalloc(coherence_data_size);
 	if (!coherence_data)
 		return -ENOMEM;
 #endif
+
 	ret = platform_driver_register(&fsl_diu_driver);
 	if (ret) {
-		printk(KERN_ERR
-			"fsl-diu: failed to register platform driver\n");
+		pr_err("fsl-diu-fb: failed to register platform driver\n");
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 		vfree(coherence_data);
 #endif
@@ -1847,7 +1733,7 @@ module_param_named(mode, fb_mode, charp, 0);
 MODULE_PARM_DESC(mode,
 	"Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 module_param_named(bpp, default_bpp, ulong, 0);
-MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified mode");
+MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified in \"mode\"");
 module_param_named(monitor, monitor_string, charp, 0);
 MODULE_PARM_DESC(monitor, "Specify the monitor port "
 	"(\"dvi\", \"lvds\", or \"dlvds\") if supported by the platform");
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index daa9952..df23f59 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -20,18 +20,8 @@
 #ifndef __FSL_DIU_FB_H__
 #define __FSL_DIU_FB_H__
 
-/* Arbitrary threshold to determine the allocation method
- * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
- */
-#define MEM_ALLOC_THRESHOLD (1024*768*4+32)
-
 #include <linux/types.h>
 
-struct mfb_alpha {
-	int enable;
-	int alpha;
-};
-
 struct mfb_chroma_key {
 	int enable;
 	__u8  red_max;
@@ -167,7 +157,7 @@ struct diu_hw {
 };
 
 struct diu_addr {
-	__u8 __iomem *vaddr;	/* Virtual address */
+	void *vaddr;		/* Virtual address */
 	dma_addr_t paddr;	/* Physical address */
 	__u32 	   offset;
 };
-- 
1.7.3.4


