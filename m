From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:43:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915194329.GI16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzHA-0004AO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:44:44 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzH8-0005nu-6U
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:44:42 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rmk@arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/cyber200fb.c to framebuffer_alloc:

======== drivers/video/cyber2000fb.c 1.33 ========
D 1.33 03/09/13 23:21:10+02:00 kronos@kronoz.cjb.net 35 34 108/99/1650
P drivers/video/cyber2000fb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/cyber2000fb.c 1.32 vs 1.33 =====
--- 1.32/drivers/video/cyber2000fb.c	Fri Aug 22 08:27:08 2003
+++ 1.33/drivers/video/cyber2000fb.c	Sat Sep 13 23:21:10 2003
@@ -62,7 +62,7 @@
 #include "cyber2000fb.h"
 
 struct cfb_info {
-	struct fb_info		fb;
+	struct fb_info		*fb;
 	struct display_switch	*dispsw;
 	struct display		*display;
 	struct pci_dev		*dev;
@@ -97,6 +97,8 @@
 MODULE_PARM(default_font, "s");
 MODULE_PARM_DESC(default_font, "Default font name");
 
+static void release_cfb_info(struct fb_info *);
+
 /*
  * Our access methods.
  */
@@ -148,10 +150,10 @@
 static void
 cyber2000fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 	unsigned long dst, col;
 
-	if (!(cfb->fb.var.accel_flags & FB_ACCELF_TEXT)) {
+	if (!(info->var.accel_flags & FB_ACCELF_TEXT)) {
 		cfb_fillrect(info, rect);
 		return;
 	}
@@ -161,12 +163,12 @@
 	cyber2000fb_writew(rect->height - 1, CO_REG_PIXHEIGHT, cfb);
 
 	col = rect->color;
-	if (cfb->fb.var.bits_per_pixel > 8)
-		col = ((u32 *)cfb->fb.pseudo_palette)[col];
+	if (info->var.bits_per_pixel > 8)
+		col = ((u32 *)info->pseudo_palette)[col];
 	cyber2000fb_writel(col, CO_REG_FGCOLOUR, cfb);
 
-	dst = rect->dx + rect->dy * cfb->fb.var.xres_virtual;
-	if (cfb->fb.var.bits_per_pixel == 24) {
+	dst = rect->dx + rect->dy * info->var.xres_virtual;
+	if (info->var.bits_per_pixel == 24) {
 		cyber2000fb_writeb(dst, CO_REG_X_PHASE, cfb);
 		dst *= 3;
 	}
@@ -180,11 +182,11 @@
 static void
 cyber2000fb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 	unsigned int cmd = CO_CMD_L_PATTERN_FGCOL;
 	unsigned long src, dst;
 
-	if (!(cfb->fb.var.accel_flags & FB_ACCELF_TEXT)) {
+	if (!(info->var.accel_flags & FB_ACCELF_TEXT)) {
 		cfb_copyarea(info, region);
 		return;
 	}
@@ -193,8 +195,8 @@
 	cyber2000fb_writew(region->width - 1, CO_REG_PIXWIDTH, cfb);
 	cyber2000fb_writew(region->height - 1, CO_REG_PIXHEIGHT, cfb);
 
-	src = region->sx + region->sy * cfb->fb.var.xres_virtual;
-	dst = region->dx + region->dy * cfb->fb.var.xres_virtual;
+	src = region->sx + region->sy * info->var.xres_virtual;
+	dst = region->dx + region->dy * info->var.xres_virtual;
 
 	if (region->sx < region->dx) {
 		src += region->width - 1;
@@ -203,12 +205,12 @@
 	}
 
 	if (region->sy < region->dy) {
-		src += (region->height - 1) * cfb->fb.var.xres_virtual;
-		dst += (region->height - 1) * cfb->fb.var.xres_virtual;
+		src += (region->height - 1) * info->var.xres_virtual;
+		dst += (region->height - 1) * info->var.xres_virtual;
 		cmd |= CO_CMD_L_INC_UP;
 	}
 
-	if (cfb->fb.var.bits_per_pixel == 24) {
+	if (info->var.bits_per_pixel == 24) {
 		cyber2000fb_writeb(dst, CO_REG_X_PHASE, cfb);
 		src *= 3;
 		dst *= 3;
@@ -234,10 +236,10 @@
 
 static int cyber2000fb_sync(struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 	int count = 100000;
 
-	if (!(cfb->fb.var.accel_flags & FB_ACCELF_TEXT))
+	if (!(info->var.accel_flags & FB_ACCELF_TEXT))
 		return 0;
 
 	while (cyber2000fb_readb(CO_REG_CONTROL, cfb) & CO_CTRL_BUSY) {
@@ -269,12 +271,12 @@
 cyber2000fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		      u_int transp, struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
-	struct fb_var_screeninfo *var = &cfb->fb.var;
+	struct cfb_info *cfb = info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	u32 pseudo_val;
 	int ret = 1;
 
-	switch (cfb->fb.fix.visual) {
+	switch (info->fix.visual) {
 	default:
 		return 1;
 
@@ -400,7 +402,7 @@
 	 * Now set our pseudo palette for the CFB16/24/32 drivers.
 	 */
 	if (regno < 16)
-		((u32 *)cfb->fb.pseudo_palette)[regno] = pseudo_val;
+		((u32 *)info->pseudo_palette)[regno] = pseudo_val;
 
 	return ret;
 }
@@ -744,7 +746,7 @@
 static int
 cyber2000fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 	struct par_info hw;
 	unsigned int mem;
 	int err;
@@ -831,8 +833,8 @@
 	}
 
 	mem = var->xres_virtual * var->yres_virtual * (var->bits_per_pixel / 8);
-	if (mem > cfb->fb.fix.smem_len)
-		var->yres_virtual = cfb->fb.fix.smem_len * 8 /
+	if (mem > info->fix.smem_len)
+		var->yres_virtual = info->fix.smem_len * 8 /
 			(var->bits_per_pixel * var->xres_virtual);
 
 	if (var->yres > var->yres_virtual)
@@ -853,8 +855,8 @@
 
 static int cyber2000fb_set_par(struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
-	struct fb_var_screeninfo *var = &cfb->fb.var;
+	struct cfb_info *cfb = info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	struct par_info hw;
 	unsigned int mem;
 
@@ -924,7 +926,7 @@
 		hw.fetch <<= 1;
 	hw.fetch += 1;
 
-	cfb->fb.fix.line_length	= var->xres_virtual * var->bits_per_pixel / 8;
+	info->fix.line_length	= var->xres_virtual * var->bits_per_pixel / 8;
 
 	/*
 	 * Same here - if the size of the video mode exceeds the
@@ -933,8 +935,8 @@
 	 * In theory, since NetWinders contain just one VGA card,
 	 * we should never end up hitting this problem.
 	 */
-	mem = cfb->fb.fix.line_length * var->yres_virtual;
-	BUG_ON(mem > cfb->fb.fix.smem_len);
+	mem = info->fix.line_length * var->yres_virtual;
+	BUG_ON(mem > info->fix.smem_len);
 
 	/*
 	 * 8bpp displays are always pseudo colour.  16bpp and above
@@ -943,11 +945,11 @@
 	 * palettes, true colour does not.)
 	 */
 	if (var->bits_per_pixel == 8)
-		cfb->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 	else if (hw.ramdac & RAMDAC_BYPASS)
-		cfb->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 	else
-		cfb->fb.fix.visual = FB_VISUAL_DIRECTCOLOR;
+		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
 
 	cyber2000fb_set_timing(cfb, &hw);
 	cyber2000fb_update_start(cfb, var);
@@ -962,18 +964,18 @@
 static int
 cyber2000fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 
 	if (cyber2000fb_update_start(cfb, var))
 		return -EINVAL;
 
-	cfb->fb.var.xoffset = var->xoffset;
-	cfb->fb.var.yoffset = var->yoffset;
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
 
 	if (var->vmode & FB_VMODE_YWRAP) {
-		cfb->fb.var.vmode |= FB_VMODE_YWRAP;
+		info->var.vmode |= FB_VMODE_YWRAP;
 	} else {
-		cfb->fb.var.vmode &= ~FB_VMODE_YWRAP;
+		info->var.vmode &= ~FB_VMODE_YWRAP;
 	}
 
 	return 0;
@@ -998,7 +1000,7 @@
  */
 static int cyber2000fb_blank(int blank, struct fb_info *info)
 {
-	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct cfb_info *cfb = info->par;
 	unsigned int sync = 0;
 	int i;
 
@@ -1111,7 +1113,7 @@
 
 void cyber2000fb_get_fb_var(struct cfb_info *cfb, struct fb_var_screeninfo *var)
 {
-	memcpy(var, &cfb->fb.var, sizeof(struct fb_var_screeninfo));
+	memcpy(var, &cfb->fb->var, sizeof(struct fb_var_screeninfo));
 }
 
 /*
@@ -1122,13 +1124,13 @@
 	if (int_cfb_info != NULL) {
 		info->dev	      = int_cfb_info->dev;
 		info->regs	      = int_cfb_info->regs;
-		info->fb	      = int_cfb_info->fb.screen_base;
-		info->fb_size	      = int_cfb_info->fb.fix.smem_len;
+		info->fb	      = int_cfb_info->fb->screen_base;
+		info->fb_size	      = int_cfb_info->fb->fix.smem_len;
 		info->enable_extregs  = cyber2000fb_enable_extregs;
 		info->disable_extregs = cyber2000fb_disable_extregs;
 		info->info            = int_cfb_info;
 
-		strlcpy(info->dev_name, int_cfb_info->fb.fix.id, sizeof(info->dev_name));
+		strlcpy(info->dev_name, int_cfb_info->fb->fix.id, sizeof(info->dev_name));
 	}
 
 	return int_cfb_info != NULL;
@@ -1220,17 +1222,19 @@
 }
 
 static struct cfb_info * __devinit
-cyberpro_alloc_fb_info(unsigned int id, char *name)
+cyberpro_alloc_fb_info(unsigned int id, char *name, struct device *dev)
 {
 	struct cfb_info *cfb;
+	struct fb_info *fb_info;
 
-	cfb = kmalloc(sizeof(struct cfb_info) +
-		       sizeof(u32) * 16, GFP_KERNEL);
+	fb_info = framebuffer_alloc(sizeof(struct cfb_info) + 32 * 16, dev);
 
-	if (!cfb)
+	if (!fb_info)
 		return NULL;
 
-	memset(cfb, 0, sizeof(struct cfb_info));
+	fb_info->release = release_cfb_info;
+	cfb = fb_info->par;
+	cfb->fb = fb_info;
 
 	cfb->id			= id;
 
@@ -1248,43 +1252,43 @@
 	else
 		cfb->divisors[3] = 6;
 
-	strcpy(cfb->fb.fix.id, name);
+	strcpy(fb_info->fix.id, name);
 
-	cfb->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
-	cfb->fb.fix.type_aux	= 0;
-	cfb->fb.fix.xpanstep	= 0;
-	cfb->fb.fix.ypanstep	= 1;
-	cfb->fb.fix.ywrapstep	= 0;
+	fb_info->fix.type	= FB_TYPE_PACKED_PIXELS;
+	fb_info->fix.type_aux	= 0;
+	fb_info->fix.xpanstep	= 0;
+	fb_info->fix.ypanstep	= 1;
+	fb_info->fix.ywrapstep	= 0;
 
 	switch (id) {
 	case ID_IGA_1682:
-		cfb->fb.fix.accel = 0;
+		fb_info->fix.accel = 0;
 		break;
 
 	case ID_CYBERPRO_2000:
-		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER2000;
+		fb_info->fix.accel = FB_ACCEL_IGS_CYBER2000;
 		break;
 
 	case ID_CYBERPRO_2010:
-		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER2010;
+		fb_info->fix.accel = FB_ACCEL_IGS_CYBER2010;
 		break;
 
 	case ID_CYBERPRO_5000:
-		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER5000;
+		fb_info->fix.accel = FB_ACCEL_IGS_CYBER5000;
 		break;
 	}
 
-	cfb->fb.var.nonstd	= 0;
-	cfb->fb.var.activate	= FB_ACTIVATE_NOW;
-	cfb->fb.var.height	= -1;
-	cfb->fb.var.width	= -1;
-	cfb->fb.var.accel_flags	= FB_ACCELF_TEXT;
-
-	cfb->fb.fbops		= &cyber2000fb_ops;
-	cfb->fb.flags		= FBINFO_FLAG_DEFAULT;
-	cfb->fb.pseudo_palette	= (void *)(cfb + 1);
+	fb_info->var.nonstd	= 0;
+	fb_info->var.activate	= FB_ACTIVATE_NOW;
+	fb_info->var.height	= -1;
+	fb_info->var.width	= -1;
+	fb_info->var.accel_flags	= FB_ACCELF_TEXT;
+
+	fb_info->fbops		= &cyber2000fb_ops;
+	fb_info->flags		= FBINFO_FLAG_DEFAULT;
+	fb_info->pseudo_palette	= (void *)(cfb + 1);
 
-	fb_alloc_cmap(&cfb->fb.cmap, NR_PALETTE, 0);
+	fb_alloc_cmap(&fb_info->cmap, NR_PALETTE, 0);
 
 	return cfb;
 }
@@ -1296,9 +1300,9 @@
 		/*
 		 * Free the colourmap
 		 */
-		fb_alloc_cmap(&cfb->fb.cmap, 0, 0);
+		fb_alloc_cmap(&cfb->fb->cmap, 0, 0);
 
-		kfree(cfb);
+		kfree(cfb->fb);
 	}
 }
 
@@ -1363,23 +1367,22 @@
 	default:		smem_size = 0x00100000; break;
 	}
 
-	cfb->fb.fix.smem_len   = smem_size;
-	cfb->fb.fix.mmio_len   = MMIO_SIZE;
-	cfb->fb.screen_base    = cfb->region;
-	cfb->fb.dev            = &cfb->dev->dev;
+	cfb->fb->fix.smem_len   = smem_size;
+	cfb->fb->fix.mmio_len   = MMIO_SIZE;
+	cfb->fb->screen_base    = cfb->region;
 
 	err = -EINVAL;
-	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
+	if (!fb_find_mode(&cfb->fb->var, cfb->fb, NULL, NULL, 0,
 	    		  &cyber2000fb_default_mode, 8)) {
-		printk("%s: no valid mode found\n", cfb->fb.fix.id);
+		printk("%s: no valid mode found\n", cfb->fb->fix.id);
 		goto failed;
 	}
 
-	cfb->fb.var.yres_virtual = cfb->fb.fix.smem_len * 8 /
-			(cfb->fb.var.bits_per_pixel * cfb->fb.var.xres_virtual);
+	cfb->fb->var.yres_virtual = cfb->fb->fix.smem_len * 8 /
+			(cfb->fb->var.bits_per_pixel * cfb->fb->var.xres_virtual);
 
-	if (cfb->fb.var.yres_virtual < cfb->fb.var.yres)
-		cfb->fb.var.yres_virtual = cfb->fb.var.yres;
+	if (cfb->fb->var.yres_virtual < cfb->fb->var.yres)
+		cfb->fb->var.yres_virtual = cfb->fb->var.yres;
 
 //	fb_set_var(&cfb->fb.var, -1, &cfb->fb);
 
@@ -1389,18 +1392,18 @@
 	 * the precision and fit the results into 32-bit registers.
 	 *  (1953125000 * 512 = 1e12)
 	 */
-	h_sync = 1953125000 / cfb->fb.var.pixclock;
-	h_sync = h_sync * 512 / (cfb->fb.var.xres + cfb->fb.var.left_margin +
-		 cfb->fb.var.right_margin + cfb->fb.var.hsync_len);
-	v_sync = h_sync / (cfb->fb.var.yres + cfb->fb.var.upper_margin +
-		 cfb->fb.var.lower_margin + cfb->fb.var.vsync_len);
+	h_sync = 1953125000 / cfb->fb->var.pixclock;
+	h_sync = h_sync * 512 / (cfb->fb->var.xres + cfb->fb->var.left_margin +
+		 cfb->fb->var.right_margin + cfb->fb->var.hsync_len);
+	v_sync = h_sync / (cfb->fb->var.yres + cfb->fb->var.upper_margin +
+		 cfb->fb->var.lower_margin + cfb->fb->var.vsync_len);
 
 	printk(KERN_INFO "%s: %dKiB VRAM, using %dx%d, %d.%03dkHz, %dHz\n",
-		cfb->fb.fix.id, cfb->fb.fix.smem_len >> 10,
-		cfb->fb.var.xres, cfb->fb.var.yres,
+		cfb->fb->fix.id, cfb->fb->fix.smem_len >> 10,
+		cfb->fb->var.xres, cfb->fb->var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
-	err = register_framebuffer(&cfb->fb);
+	err = register_framebuffer(cfb->fb);
 
 failed:
 	return err;
@@ -1420,7 +1423,7 @@
 	 * Restore the old video mode and the palette.
 	 * We also need to tell fbcon to redraw the console.
 	 */
-	cyber2000fb_set_par(&cfb->fb);
+	cyber2000fb_set_par(cfb->fb);
 }
 
 #ifdef CONFIG_ARCH_SHARK
@@ -1445,8 +1448,8 @@
 		goto failed_ioremap;
 
 	cfb->regs = cfb->region + MMIO_OFFSET;
-	cfb->fb.fix.mmio_start = FB_START + MMIO_OFFSET;
-	cfb->fb.fix.smem_start = FB_START;
+	cfb->fb->fix.mmio_start = FB_START + MMIO_OFFSET;
+	cfb->fb->fix.smem_start = FB_START;
 
 	/*
 	 * Bring up the hardware.  This is expected to enable access
@@ -1541,7 +1544,7 @@
 	 */
 	val = cyber2000_grphr(EXT_BUS_CTL, cfb);
 	if (!(val & EXT_BUS_CTL_PCIBURST_WRITE)) {
-		printk(KERN_INFO "%s: enabling PCI bursts\n", cfb->fb.fix.id);
+		printk(KERN_INFO "%s: enabling PCI bursts\n", cfb->fb->fix.id);
 
 		val |= EXT_BUS_CTL_PCIBURST_WRITE;
 
@@ -1572,7 +1575,7 @@
 		return err;
 
 	err = -ENOMEM;
-	cfb = cyberpro_alloc_fb_info(id->driver_data, name);
+	cfb = cyberpro_alloc_fb_info(id->driver_data, name, &dev->dev);
 	if (!cfb)
 		goto failed_release;
 
@@ -1583,8 +1586,8 @@
 		goto failed_ioremap;
 
 	cfb->regs = cfb->region + MMIO_OFFSET;
-	cfb->fb.fix.mmio_start = pci_resource_start(dev, 0) + MMIO_OFFSET;
-	cfb->fb.fix.smem_start = pci_resource_start(dev, 0);
+	cfb->fb->fix.mmio_start = pci_resource_start(dev, 0) + MMIO_OFFSET;
+	cfb->fb->fix.smem_start = pci_resource_start(dev, 0);
 
 	/*
 	 * Bring up the hardware.  This is expected to enable access
@@ -1635,6 +1638,16 @@
 	return err;
 }
 
+static void release_cfb_info(struct fb_info *info) {
+	struct cfb_info *cfb = info->par;
+
+	iounmap(cfb->region);
+	fb_alloc_cmap(&info->cmap, 0, 0);
+
+	if (cfb->dev)
+		pci_release_regions(cfb->dev);
+}
+
 static void __devexit cyberpro_pci_remove(struct pci_dev *dev)
 {
 	struct cfb_info *cfb = pci_get_drvdata(dev);
@@ -1645,12 +1658,10 @@
 		 * we will be leaving hooks that could cause
 		 * oopsen laying around.
 		 */
-		if (unregister_framebuffer(&cfb->fb))
+		if (unregister_framebuffer(cfb->fb))
 			printk(KERN_WARNING "%s: danger Will Robinson, "
 				"danger danger!  Oopsen imminent!\n",
-				cfb->fb.fix.id);
-		iounmap(cfb->region);
-		cyberpro_free_fb_info(cfb);
+				cfb->fb->fix.id);
 
 		/*
 		 * Ensure that the driver data is no longer
@@ -1659,8 +1670,6 @@
 		pci_set_drvdata(dev, NULL);
 		if (cfb == int_cfb_info)
 			int_cfb_info = NULL;
-
-		pci_release_regions(dev);
 	}
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La Via prosegue senza fine."
	Bilbo Baggins - Il Signore degli Anelli - J.R.R. Tolkien


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
