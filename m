From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:47 +0000
Subject: [PATCH 02/13] drivers/video: fsl-diu-fb: clean up printk usage
Message-Id: <1316123098-30967-3-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove debug printk messages (they don't help in debugging), replace
printk(KERN_xxx with its pr_xxx or dev_xxx equivalent, and add a couple
missing error messages.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  105 +++++++------------------------------------
 1 files changed, 17 insertions(+), 88 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index dbb4cb7..10ee411 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -322,14 +322,9 @@ static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
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
@@ -343,8 +338,6 @@ static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
  */
 static void fsl_diu_free(void *virt, size_t size)
 {
-	pr_debug("virt=%p size=%zu\n", virt, size);
-
 	if (virt && size)
 		free_pages_exact(virt, size);
 }
@@ -368,7 +361,6 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	struct fsl_diu_data *machine_data = mfbi->parent;
 	int res = 0;

-	pr_debug("enable_panel index %d\n", mfbi->index);
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
@@ -585,9 +577,6 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 static int fsl_diu_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
-	pr_debug("check_var xres: %d\n", var->xres);
-	pr_debug("check_var yres: %d\n", var->yres);
-
 	if (var->xres_virtual < var->xres)
 		var->xres_virtual = var->xres;
 	if (var->yres_virtual < var->yres)
@@ -720,7 +709,6 @@ static void update_lcdc(struct fb_info *info)

 	diu_ops.set_gamma_table(machine_data->monitor_port, pool.gamma.vaddr);

-	pr_debug("update-lcdc: HW - %p\n Disabling DIU\n", hw);
 	disable_lcdc(info);

 	/* Program DIU registers */
@@ -732,9 +720,6 @@ static void update_lcdc(struct fb_info *info)
 	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
 	out_be32(&hw->disp_size, (var->yres << 16 | var->xres));
 						/* DISP SIZE */
-	pr_debug("DIU xres: %d\n", var->xres);
-	pr_debug("DIU yres: %d\n", var->yres);
-
 	out_be32(&hw->wb_size, 0); /* WB SIZE */
 	out_be32(&hw->wb_mem_addr, 0); /* WB MEM ADDR */

@@ -751,15 +736,6 @@ static void update_lcdc(struct fb_info *info)

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
@@ -776,14 +752,9 @@ static int map_video_memory(struct fb_info *info)
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
@@ -792,10 +763,6 @@ static int map_video_memory(struct fb_info *info)
 	mutex_unlock(&info->mm_lock);
 	info->screen_size = info->fix.smem_len;

-	pr_debug("Allocated fb @ paddr=0x%08lx, size=%d.\n",
-		 info->fix.smem_start, info->fix.smem_len);
-	pr_debug("screen base %p\n", info->screen_base);
-
 	return 0;
 }

@@ -852,11 +819,10 @@ static int fsl_diu_set_par(struct fb_info *info)
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
@@ -1023,21 +989,17 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
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
@@ -1046,14 +1008,11 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
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
@@ -1062,7 +1021,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		ad->src_size_g_alpha = (ad->src_size_g_alpha & (~0xff)) |
 							(global_alpha & 0xff);
 		mfbi->g_alpha = global_alpha;
-		pr_debug("set global alpha for index %d\n", mfbi->index);
 		break;
 	case MFB_SET_CHROMA_KEY:
 		/* set panel winformation */
@@ -1090,7 +1048,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 			ad->ckmin_g = ck.green_min;
 			ad->ckmin_b = ck.blue_min;
 		}
-		pr_debug("set chroma key\n");
 		break;
 	case FBIOGET_GWINFO:
 		if (mfbi->type = MFB_TYPE_OFF)
@@ -1110,7 +1067,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		break;

 	default:
-		printk(KERN_ERR "Unknown ioctl command (0x%08X)\n", cmd);
+		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
 		return -ENOIOCTLCMD;
 	}

@@ -1131,7 +1088,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
 	spin_lock(&diu_lock);
 	mfbi->count++;
 	if (mfbi->count = 1) {
-		pr_debug("open plane index %d\n", mfbi->index);
 		fsl_diu_check_var(&info->var, info);
 		res = fsl_diu_set_par(info);
 		if (res < 0)
@@ -1157,7 +1113,6 @@ static int fsl_diu_release(struct fb_info *info, int user)
 	spin_lock(&diu_lock);
 	mfbi->count--;
 	if (mfbi->count = 0) {
-		pr_debug("release plane index %d\n", mfbi->index);
 		res = fsl_diu_disable_panel(info);
 		if (res < 0)
 			mfbi->count++;
@@ -1222,26 +1177,9 @@ static int __devinit install_fb(struct fb_info *info)
 	} else {
 		aoi_mode = init_aoi_mode;
 	}
-	pr_debug("mode used = %s\n", aoi_mode);
 	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize,
 			  &fsl_diu_default_mode, default_bpp);
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
+	if (!rc) {
 		/*
 		 * For plane 0 we continue and look into
 		 * driver's internal modedb.
@@ -1250,7 +1188,6 @@ static int __devinit install_fb(struct fb_info *info)
 			has_default_mode = 0;
 		else
 			return -EINVAL;
-		break;
 	}

 	if (!has_default_mode) {
@@ -1286,33 +1223,26 @@ static int __devinit install_fb(struct fb_info *info)
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
@@ -1344,7 +1274,6 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 		/* This is the workaround for underrun */
 		if (status & INT_UNDRUN) {
 			out_be32(&hw->diu_mode, 0);
-			pr_debug("Err: DIU occurs underrun!\n");
 			udelay(1);
 			out_be32(&hw->diu_mode, 1);
 		}
@@ -1376,9 +1305,7 @@ static int request_irq_local(int irq)
 	status = in_be32(&hw->int_status);

 	ret = request_irq(irq, fsl_diu_isr, 0, "diu", NULL);
-	if (ret)
-		pr_info("Request diu IRQ failed.\n");
-	else {
+	if (!ret) {
 		ints = INT_PARERR | INT_LS_BF_VS;
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
 		ints |=	INT_VSYNC;
@@ -1557,7 +1484,6 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 		dev_err(&ofdev->dev, "invalid DIU address\n");
 		goto error;
 	}
-	dev_dbg(&ofdev->dev, "%s, res.start: 0x%08x\n", __func__, res.start);

 	dr.diu_reg = ioremap(res.start, sizeof(struct diu));
 	if (!dr.diu_reg) {
@@ -1787,17 +1713,19 @@ static int __init fsl_diu_init(void)
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
@@ -1811,6 +1739,8 @@ static int __init fsl_diu_init(void)

 	prop = of_get_property(np, "d-cache-line-size", NULL);
 	if (prop = NULL) {
+		pr_err("fsl-diu-fb: missing 'd-cache-line-size' property' "
+		       "in 'cpu' node\n");
 		of_node_put(np);
 		return -ENODEV;
 	}
@@ -1824,8 +1754,7 @@ static int __init fsl_diu_init(void)

 	ret = platform_driver_register(&fsl_diu_driver);
 	if (ret) {
-		printk(KERN_ERR
-			"fsl-diu: failed to register platform driver\n");
+		pr_err("fsl-diu-fb: failed to register platform driver\n");
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 		vfree(coherence_data);
 #endif
@@ -1853,7 +1782,7 @@ module_param_named(mode, fb_mode, charp, 0);
 MODULE_PARM_DESC(mode,
 	"Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 module_param_named(bpp, default_bpp, ulong, 0);
-MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified mode");
+MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified in 'mode'");
 module_param_named(monitor, monitor_string, charp, 0);
 MODULE_PARM_DESC(monitor, "Specify the monitor port "
 	"(\"dvi\", \"lvds\", or \"dlvds\") if supported by the platform");
--
1.7.3.4


