From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 11 Mar 2011 09:20:47 +0000
Subject: [PATCH 1/4] ARM: PXA: PXAFB: rework pxafb overlay memory management
Message-Id: <1299835250-11095-1-git-send-email-anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
In-Reply-To: <201103060030.59584.anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

PXAFB overlay memory management is something messy:
- it allocates memory dynamically on open/release, and it results
  in memory allocation failure after ~1h of uptime (system does not have
  115k of physically contiguous memory)
- in release callback it tries to free memory even if it was not
  allocated.

Also driver touches FDADR1 on main plane reconfiguration, and it can cause
problems if overlay1 is enabled.

This patch attempts to fix those issues.

Patch is based on Russell King's work.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/pxafb.c |  121 ++++++++++++++++++++++++++++++++-----------------
 drivers/video/pxafb.h |    3 +-
 2 files changed, 81 insertions(+), 43 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 825b665..0764759 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -627,7 +627,12 @@ static void overlay1fb_enable(struct pxafb_layer *ofb)
 
 static void overlay1fb_disable(struct pxafb_layer *ofb)
 {
-	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
+	uint32_t lccr5;
+
+	if (!(lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN))
+		return;
+
+	lccr5 = lcd_readl(ofb->fbi, LCCR5);
 
 	lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
 
@@ -685,7 +690,12 @@ static void overlay2fb_enable(struct pxafb_layer *ofb)
 
 static void overlay2fb_disable(struct pxafb_layer *ofb)
 {
-	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
+	uint32_t lccr5;
+
+	if (!(lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN))
+		return;
+
+	lccr5 = lcd_readl(ofb->fbi, LCCR5);
 
 	lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] & ~OVLxC1_OEN);
 
@@ -720,12 +730,10 @@ static int overlayfb_open(struct fb_info *info, int user)
 	if (user = 0)
 		return -ENODEV;
 
-	/* allow only one user at a time */
-	if (atomic_inc_and_test(&ofb->usage))
-		return -EBUSY;
+	if (ofb->usage++ = 0)
+		/* unblank the base framebuffer */
+		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
 
-	/* unblank the base framebuffer */
-	fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
 	return 0;
 }
 
@@ -733,12 +741,15 @@ static int overlayfb_release(struct fb_info *info, int user)
 {
 	struct pxafb_layer *ofb = (struct pxafb_layer*) info;
 
-	atomic_dec(&ofb->usage);
-	ofb->ops->disable(ofb);
+	if (ofb->usage = 1) {
+		ofb->ops->disable(ofb);
+		ofb->fb.var.height	= -1;
+		ofb->fb.var.width	= -1;
+		ofb->fb.var.xres = ofb->fb.var.xres_virtual = 0;
+		ofb->fb.var.yres = ofb->fb.var.yres_virtual = 0;
 
-	free_pages_exact(ofb->video_mem, ofb->video_mem_size);
-	ofb->video_mem = NULL;
-	ofb->video_mem_size = 0;
+		ofb->usage--;
+	}
 	return 0;
 }
 
@@ -794,7 +805,7 @@ static int overlayfb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
+static int overlayfb_check_video_memory(struct pxafb_layer *ofb)
 {
 	struct fb_var_screeninfo *var = &ofb->fb.var;
 	int pfor = NONSTD_TO_PFOR(var->nonstd);
@@ -812,27 +823,11 @@ static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
 
 	size = PAGE_ALIGN(ofb->fb.fix.line_length * var->yres_virtual);
 
-	/* don't re-allocate if the original video memory is enough */
 	if (ofb->video_mem) {
 		if (ofb->video_mem_size >= size)
 			return 0;
-
-		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
 	}
-
-	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
-	if (ofb->video_mem = NULL)
-		return -ENOMEM;
-
-	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
-	ofb->video_mem_size = size;
-
-	mutex_lock(&ofb->fb.mm_lock);
-	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
-	ofb->fb.fix.smem_len	= ofb->fb.fix.line_length * var->yres_virtual;
-	mutex_unlock(&ofb->fb.mm_lock);
-	ofb->fb.screen_base	= ofb->video_mem;
-	return 0;
+	return -EINVAL;
 }
 
 static int overlayfb_set_par(struct fb_info *info)
@@ -841,7 +836,7 @@ static int overlayfb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	int xpos, ypos, pfor, bpp, ret;
 
-	ret = overlayfb_map_video_memory(ofb);
+	ret = overlayfb_check_video_memory(ofb);
 	if (ret)
 		return ret;
 
@@ -891,7 +886,7 @@ static void __devinit init_pxafb_overlay(struct pxafb_info *fbi,
 
 	ofb->id = id;
 	ofb->ops = &ofb_ops[id];
-	atomic_set(&ofb->usage, 0);
+	ofb->usage = 0;
 	ofb->fbi = fbi;
 	init_completion(&ofb->branch_done);
 }
@@ -904,20 +899,54 @@ static inline int pxafb_overlay_supported(void)
 	return 0;
 }
 
-static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
+static int __devinit pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
+	struct pxafb_layer *ofb)
+{
+	/* We assume that user will use at most video_mem_size for overlay fb,
+	 * anyway, it's useless to use 16bpp main plane and 24bpp overlay
+	 */
+	ofb->video_mem = alloc_pages_exact(PAGE_ALIGN(pxafb->video_mem_size),
+		GFP_KERNEL | __GFP_ZERO);
+	if (ofb->video_mem = NULL)
+		return -ENOMEM;
+
+	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
+	ofb->video_mem_size = PAGE_ALIGN(pxafb->video_mem_size);
+
+	mutex_lock(&ofb->fb.mm_lock);
+	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
+	ofb->fb.fix.smem_len	= pxafb->video_mem_size;
+	mutex_unlock(&ofb->fb.mm_lock);
+
+	ofb->fb.screen_base	= ofb->video_mem;
+
+	return 0;
+}
+
+static void __devinit pxafb_overlay_init(struct pxafb_info *fbi)
 {
 	int i, ret;
 
 	if (!pxafb_overlay_supported())
-		return 0;
+		return;
 
 	for (i = 0; i < 2; i++) {
-		init_pxafb_overlay(fbi, &fbi->overlay[i], i);
-		ret = register_framebuffer(&fbi->overlay[i].fb);
+		struct pxafb_layer *ofb = &fbi->overlay[i];
+		init_pxafb_overlay(fbi, ofb, i);
+		ret = register_framebuffer(&ofb->fb);
 		if (ret) {
 			dev_err(fbi->dev, "failed to register overlay %d\n", i);
-			return ret;
+			continue;
+		}
+		ret = pxafb_overlay_map_video_memory(fbi, ofb);
+		if (ret) {
+			dev_err(fbi->dev,
+				"failed to map video memory for overlay %d\n",
+				i);
+			unregister_framebuffer(&ofb->fb);
+			continue;
 		}
+		ofb->registered = 1;
 	}
 
 	/* mask all IU/BS/EOF/SOF interrupts */
@@ -926,7 +955,6 @@ static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
 	/* place overlay(s) on top of base */
 	fbi->lccr0 |= LCCR0_OUC;
 	pr_info("PXA Overlay driver loaded successfully!\n");
-	return 0;
 }
 
 static void __devexit pxafb_overlay_exit(struct pxafb_info *fbi)
@@ -936,8 +964,15 @@ static void __devexit pxafb_overlay_exit(struct pxafb_info *fbi)
 	if (!pxafb_overlay_supported())
 		return;
 
-	for (i = 0; i < 2; i++)
-		unregister_framebuffer(&fbi->overlay[i].fb);
+	for (i = 0; i < 2; i++) {
+		struct pxafb_layer *ofb = &fbi->overlay[i];
+		if (ofb->registered) {
+			if (ofb->video_mem)
+				free_pages_exact(ofb->video_mem,
+					ofb->video_mem_size);
+			unregister_framebuffer(&ofb->fb);
+		}
+	}
 }
 #else
 static inline void pxafb_overlay_init(struct pxafb_info *fbi) {}
@@ -1368,7 +1403,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	    (lcd_readl(fbi, LCCR3) != fbi->reg_lccr3) ||
 	    (lcd_readl(fbi, LCCR4) != fbi->reg_lccr4) ||
 	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
-	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
+	    ((fbi->lccr0 & LCCR0_SDS) &&
+	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1])))
 		pxafb_schedule_work(fbi, C_REENABLE);
 
 	return 0;
@@ -1420,7 +1456,8 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 & ~LCCR0_ENB);
 
 	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
-	lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
+	if (fbi->lccr0 & LCCR0_SDS)
+		lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
 }
 
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index 2353521..26ba9fa 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -92,7 +92,8 @@ struct pxafb_layer_ops {
 struct pxafb_layer {
 	struct fb_info		fb;
 	int			id;
-	atomic_t		usage;
+	int			registered;
+	uint32_t		usage;
 	uint32_t		control[2];
 
 	struct pxafb_layer_ops	*ops;
-- 
1.7.4.1

