From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] acornfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:34:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915193450.GC16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yz8B-00036U-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:35:27 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yz89-0001GN-K5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:35:25 -0700
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
this patch convert driver/video/acorn.c to framebuffer_alloc:

======== drivers/video/acornfb.c 1.25 ========
D 1.25 03/09/13 00:30:16+02:00 kronos@kronoz.cjb.net 29 28 136/125/1302
P drivers/video/acornfb.c
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/acornfb.c 1.24 vs 1.25 =====
--- 1.24/drivers/video/acornfb.c	Fri Aug 22 08:34:52 2003
+++ 1.25/drivers/video/acornfb.c	Sat Sep 13 00:30:16 2003
@@ -76,8 +76,8 @@
 	{ 30000, 70000, 60, 60, 0 }
 };
 
-static struct fb_info fb_info;
-static struct acornfb_par current_par;
+static struct fb_info *fb_info;
+static struct acornfb_par *current_par;
 static struct vidc_timing current_vidc;
 
 extern unsigned int vram_size;	/* set by setup.c */
@@ -313,7 +313,7 @@
 {
 	union palette pal;
 
-	if (regno >= current_par.palette_size)
+	if (regno >= current_par->palette_size)
 		return 1;
 
 	pal.p = 0;
@@ -322,7 +322,7 @@
 	pal.vidc.green = green >> 12;
 	pal.vidc.blue  = blue >> 12;
 
-	current_par.palette[regno] = pal;
+	current_par->palette[regno] = pal;
 
 	vidc_writel(pal.p);
 
@@ -436,7 +436,7 @@
 
 	words_per_line = var->xres * var->bits_per_pixel / 32;
 
-	if (current_par.using_vram && info->fix.smem_len == 2048*1024)
+	if (current_par->using_vram && info->fix.smem_len == 2048*1024)
 		words_per_line /= 2;
 
 	/* RiscPC doesn't use the VIDC's VRAM control. */
@@ -448,7 +448,7 @@
 	 * 1MB VRAM	32bit
 	 * 2MB VRAM	64bit
 	 */
-	if (current_par.using_vram && current_par.vram_half_sam == 2048) {
+	if (current_par->using_vram && current_par.vram_half_sam == 2048) {
 		dat_ctl |= VIDC20_DCTL_BUS_D63_0;
 	} else 
 		dat_ctl |= VIDC20_DCTL_BUS_D31_0;
@@ -504,7 +504,7 @@
 	union palette pal;
 	int bpp = info->var.bits_per_pixel;
 
-	if (regno >= current_par.palette_size)
+	if (regno >= current_par->palette_size)
 		return 1;
 
 	pal.p = 0;
@@ -512,16 +512,16 @@
 	pal.vidc20.green = green >> 8;
 	pal.vidc20.blue  = blue >> 8;
 
-	current_par.palette[regno] = pal;
+	current_par->palette[regno] = pal;
 
 	if (bpp == 32 && regno < 16) {
-		current_par.cmap.cfb32[regno] =
+		current_par->cmap.cfb32[regno] =
 				regno | regno << 8 | regno << 16;
 	}
 	if (bpp == 16 && regno < 16) {
 		int i;
 
-		current_par.cmap.cfb16[regno] =
+		current_par->cmap.cfb16[regno] =
 				regno | regno << 5 | regno << 10;
 
 		pal.p = 0;
@@ -560,8 +560,8 @@
 	var->xres_virtual = var->xres;
 	var->xoffset = 0;
 
-	if (current_par.using_vram)
-		sam_size = current_par.vram_half_sam * 2;
+	if (current_par->using_vram)
+		sam_size = current_par->vram_half_sam * 2;
 	else
 		sam_size = 16;
 
@@ -605,7 +605,7 @@
 	} else if (var->yres_virtual > nr_y)
 		var->yres_virtual = nr_y;
 
-	current_par.screen_end = info->fix.smem_start + size;
+	current_par->screen_end = info->fix.smem_start + size;
 
 	/*
 	 * Fix yres & yoffset if needed.
@@ -760,19 +760,19 @@
 {
 	switch (info->var.bits_per_pixel) {
 	case 1:
-		current_par.palette_size = 2;
+		current_par->palette_size = 2;
 		info->fix.visual = FB_VISUAL_MONO10;
 		break;
 	case 2:
-		current_par.palette_size = 4;
+		current_par->palette_size = 4;
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 4:
-		current_par.palette_size = 16;
+		current_par->palette_size = 16;
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 8:
-		current_par.palette_size = VIDC_PALETTE_SIZE;
+		current_par->palette_size = VIDC_PALETTE_SIZE;
 #ifdef HAS_VIDC
 		info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
 #else
@@ -781,13 +781,13 @@
 		break;
 #ifdef HAS_VIDC20
 	case 16:
-		current_par.palette_size = 32;
-		info->pseudo_palette = current_par.cmap.cfb16;
+		current_par->palette_size = 32;
+		info->pseudo_palette = current_par->cmap.cfb16;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
 		break;
 	case 32:
-		current_par.palette_size = VIDC_PALETTE_SIZE;
-		info->pseudo_palette = current_par.cmap.cfb32;
+		current_par->palette_size = VIDC_PALETTE_SIZE;
+		info->pseudo_palette = current_par->cmap.cfb32;
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 #endif
@@ -810,11 +810,11 @@
 		u_int control;
 
 		start = info->fix.smem_start;
-		size  = current_par.screen_end;
+		size  = current_par->screen_end;
 
 		if (current_par.using_vram) {
-			size -= current_par.vram_half_sam;
-			control = DMA_CR_E | (current_par.vram_half_sam / 256);
+			size -= current_par->vram_half_sam;
+			control = DMA_CR_E | (current_par->vram_half_sam / 256);
 		} else {
 			size -= 16;
 			control = DMA_CR_E | DMA_CR_D | 16;
@@ -971,50 +971,55 @@
 	.vmode =	FB_VMODE_NONINTERLACED
 };
 
-static void __init acornfb_init_fbinfo(void)
+static int __init acornfb_init_fbinfo(void)
 {
 	static int first = 1;
 
 	if (!first)
-		return;
+		return 0;
 	first = 0;
 
-	fb_info.fbops		= &acornfb_ops;
-	fb_info.flags		= FBINFO_FLAG_DEFAULT;
-
-	strcpy(fb_info.fix.id, "Acorn");
-	fb_info.fix.type	= FB_TYPE_PACKED_PIXELS;
-	fb_info.fix.type_aux	= 0;
-	fb_info.fix.xpanstep	= 0;
-	fb_info.fix.ypanstep	= 1;
-	fb_info.fix.ywrapstep	= 1;
-	fb_info.fix.line_length	= 0;
-	fb_info.fix.accel	= FB_ACCEL_NONE;
+	fb_info = framebuffer_alloc(sizeof(struct acornfb_par), NULL);
+	if (!fb_info)
+		return -ENOMEM;
+	current_par		= fb_info->par;
+
+	fb_info->fbops		= &acornfb_ops;
+	fb_info->flags		= FBINFO_FLAG_DEFAULT;
+
+	strcpy(fb_info->fix.id, "Acorn");
+	fb_info->fix.type	= FB_TYPE_PACKED_PIXELS;
+	fb_info->fix.type_aux	= 0;
+	fb_info->fix.xpanstep	= 0;
+	fb_info->fix.ypanstep	= 1;
+	fb_info->fix.ywrapstep	= 1;
+	fb_info->fix.line_length	= 0;
+	fb_info->fix.accel	= FB_ACCEL_NONE;
 
 	/*
 	 * setup initial parameters
 	 */
-	memset(&fb_info.var, 0, sizeof(fb_info.var));
-
 #if defined(HAS_VIDC20)
-	fb_info.var.red.length	   = 8;
-	fb_info.var.transp.length  = 4;
+	fb_info->var.red.length	   = 8;
+	fb_info->var.transp.length  = 4;
 #elif defined(HAS_VIDC)
-	fb_info.var.red.length	   = 4;
-	fb_info.var.transp.length  = 1;
+	fb_info->var.red.length	   = 4;
+	fb_info->var.transp.length  = 1;
 #endif
-	fb_info.var.green	   = fb_info.var.red;
-	fb_info.var.blue	   = fb_info.var.red;
-	fb_info.var.nonstd	   = 0;
-	fb_info.var.activate	   = FB_ACTIVATE_NOW;
-	fb_info.var.height	   = -1;
-	fb_info.var.width	   = -1;
-	fb_info.var.vmode	   = FB_VMODE_NONINTERLACED;
-	fb_info.var.accel_flags	   = FB_ACCELF_TEXT;
-
-	current_par.dram_size	   = 0;
-	current_par.montype	   = -1;
-	current_par.dpms	   = 0;
+	fb_info->var.green	   = fb_info->var.red;
+	fb_info->var.blue	   = fb_info->var.red;
+	fb_info->var.nonstd	   = 0;
+	fb_info->var.activate	   = FB_ACTIVATE_NOW;
+	fb_info->var.height	   = -1;
+	fb_info->var.width	   = -1;
+	fb_info->var.vmode	   = FB_VMODE_NONINTERLACED;
+	fb_info->var.accel_flags   = FB_ACCELF_TEXT;
+
+	current_par->dram_size	   = 0;
+	current_par->montype	   = -1;
+	current_par->dpms	   = 0;
+
+	return 0;
 }
 
 /*
@@ -1051,84 +1056,84 @@
 {
 	char *p = opt;
 
-	current_par.montype = -2;
+	current_par->montype = -2;
 
-	fb_info.monspecs.hfmin = simple_strtoul(p, &p, 0);
+	fb_info->monspecs.hfmin = simple_strtoul(p, &p, 0);
 	if (*p == '-')
-		fb_info.monspecs.hfmax = simple_strtoul(p + 1, &p, 0);
+		fb_info->monspecs.hfmax = simple_strtoul(p + 1, &p, 0);
 	else
-		fb_info.monspecs.hfmax = fb_info.monspecs.hfmin;
+		fb_info->monspecs.hfmax = fb_info->monspecs.hfmin;
 
 	if (*p != ':')
 		goto bad;
 
-	fb_info.monspecs.vfmin = simple_strtoul(p + 1, &p, 0);
+	fb_info->monspecs.vfmin = simple_strtoul(p + 1, &p, 0);
 	if (*p == '-')
-		fb_info.monspecs.vfmax = simple_strtoul(p + 1, &p, 0);
+		fb_info->monspecs.vfmax = simple_strtoul(p + 1, &p, 0);
 	else
-		fb_info.monspecs.vfmax = fb_info.monspecs.vfmin;
+		fb_info->monspecs.vfmax = fb_info->monspecs.vfmin;
 
 	if (*p != ':')
 		goto check_values;
 
-	fb_info.monspecs.dpms = simple_strtoul(p + 1, &p, 0);
+	fb_info->monspecs.dpms = simple_strtoul(p + 1, &p, 0);
 
 	if (*p != ':')
 		goto check_values;
 
-	fb_info.var.width = simple_strtoul(p + 1, &p, 0);
+	fb_info->var.width = simple_strtoul(p + 1, &p, 0);
 
 	if (*p != ':')
 		goto check_values;
 
-	fb_info.var.height = simple_strtoul(p + 1, NULL, 0);
+	fb_info->var.height = simple_strtoul(p + 1, NULL, 0);
 
 check_values:
-	if (fb_info.monspecs.hfmax < fb_info.monspecs.hfmin ||
-	    fb_info.monspecs.vfmax < fb_info.monspecs.vfmin)
+	if (fb_info->monspecs.hfmax < fb_info->monspecs.hfmin ||
+	    fb_info->monspecs.vfmax < fb_info->monspecs.vfmin)
 		goto bad;
 	return;
 
 bad:
 	printk(KERN_ERR "Acornfb: bad monitor settings: %s\n", opt);
-	current_par.montype = -1;
+	current_par->montype = -1;
 }
 
 static void __init
 acornfb_parse_montype(char *opt)
 {
-	current_par.montype = -2;
+	current_par->montype = -2;
 
 	if (strncmp(opt, "tv", 2) == 0) {
 		opt += 2;
-		current_par.montype = 0;
+		current_par->montype = 0;
 	} else if (strncmp(opt, "multi", 5) == 0) {
 		opt += 5;
-		current_par.montype = 1;
+		current_par->montype = 1;
 	} else if (strncmp(opt, "hires", 5) == 0) {
 		opt += 5;
-		current_par.montype = 2;
+		current_par->montype = 2;
 	} else if (strncmp(opt, "vga", 3) == 0) {
 		opt += 3;
-		current_par.montype = 3;
+		current_par->montype = 3;
 	} else if (strncmp(opt, "svga", 4) == 0) {
 		opt += 4;
-		current_par.montype = 4;
+		current_par->montype = 4;
 	} else if (strncmp(opt, "auto", 4) == 0) {
 		opt += 4;
-		current_par.montype = -1;
+		current_par->montype = -1;
 	} else if (isdigit(*opt))
-		current_par.montype = simple_strtoul(opt, &opt, 0);
+		current_par->montype = simple_strtoul(opt, &opt, 0);
 
-	if (current_par.montype == -2 ||
-	    current_par.montype > NR_MONTYPES) {
+	if (current_par->montype == -2 ||
+	    current_par->montype > NR_MONTYPES) {
 		printk(KERN_ERR "acornfb: unknown monitor type: %s\n",
 			opt);
-		current_par.montype = -1;
+		current_par->montype = -1;
 	} else
 	if (opt && *opt) {
 		if (strcmp(opt, ",dpms") == 0)
-			current_par.dpms = 1;
+			current_par->dpms = 1;
 		else
 			printk(KERN_ERR
 			       "acornfb: unknown monitor option: %s\n",
@@ -1156,7 +1161,7 @@
 		}
 	}
 
-	current_par.dram_size = size;
+	current_par->dram_size = size;
 }
 
 static struct options {
@@ -1178,7 +1183,8 @@
 	if (!options || !*options)
 		return 0;
 
-	acornfb_init_fbinfo();
+	if (acornfb_init_fbinfo())
+		return 0;
 
 	while ((opt = strsep(&options, ",")) != NULL) {
 		if (!*opt)
@@ -1254,17 +1260,18 @@
 	u_int h_sync, v_sync;
 	int rc, i;
 
-	acornfb_init_fbinfo();
+	if (acornfb_init_fbinfo())
+		return -ENOMEM;
 
-	if (current_par.montype == -1)
-		current_par.montype = acornfb_detect_monitortype();
+	if (current_par->montype == -1)
+		current_par->montype = acornfb_detect_monitortype();
 
-	if (current_par.montype == -1 || current_par.montype > NR_MONTYPES)
-		current_par.montype = 4;
+	if (current_par->montype == -1 || current_par->montype > NR_MONTYPES)
+		current_par->montype = 4;
 
-	if (current_par.montype >= 0) {
-		fb_info.monspecs = monspecs[current_par.montype];
-		fb_info.monspecs.dpms = current_par.dpms;
+	if (current_par->montype >= 0) {
+		fb_info->monspecs = monspecs[current_par->montype];
+		fb_info->monspecs.dpms = current_par->dpms;
 	}
 
 	/*
@@ -1278,30 +1285,30 @@
 		      modedb[i].lower_margin + modedb[i].vsync_len);
 		if (modedb[i].xres == DEFAULT_XRES &&
 		    modedb[i].yres == DEFAULT_YRES &&
-		    modedb[i].refresh >= fb_info.monspecs.vfmin &&
-		    modedb[i].refresh <= fb_info.monspecs.vfmax &&
-		    hs                >= fb_info.monspecs.hfmin &&
-		    hs                <= fb_info.monspecs.hfmax) {
+		    modedb[i].refresh >= fb_info->monspecs.vfmin &&
+		    modedb[i].refresh <= fb_info->monspecs.vfmax &&
+		    hs                >= fb_info->monspecs.hfmin &&
+		    hs                <= fb_info->monspecs.hfmax) {
 			acornfb_default_mode = modedb[i];
 			break;
 		}
 	}
 
-	fb_info.screen_base    = (char *)SCREEN_BASE;
-	fb_info.fix.smem_start = SCREEN_START;
-	current_par.using_vram = 0;
+	fb_info->screen_base    = (char *)SCREEN_BASE;
+	fb_info->fix.smem_start = SCREEN_START;
+	current_par->using_vram = 0;
 
 	/*
 	 * If vram_size is set, we are using VRAM in
 	 * a Risc PC.  However, if the user has specified
 	 * an amount of DRAM then use that instead.
 	 */
-	if (vram_size && !current_par.dram_size) {
+	if (vram_size && !current_par->dram_size) {
 		size = vram_size;
-		current_par.vram_half_sam = vram_size / 1024;
-		current_par.using_vram = 1;
-	} else if (current_par.dram_size)
-		size = current_par.dram_size;
+		current_par->vram_half_sam = vram_size / 1024;
+		current_par->using_vram = 1;
+	} else if (current_par->dram_size)
+		size = current_par->dram_size;
 	else
 		size = MAX_SIZE;
 
@@ -1314,7 +1321,7 @@
 	size = PAGE_ALIGN(size);
 
 #if defined(HAS_VIDC20)
-	if (!current_par.using_vram) {
+	if (!current_par->using_vram) {
 		/*
 		 * RiscPC needs to allocate the DRAM memory
 		 * for the framebuffer if we are not using
@@ -1328,6 +1335,7 @@
 		if (base == 0) {
 			printk(KERN_ERR "acornfb: unable to allocate screen "
 			       "memory\n");
+			kfree(fb_info);
 			return -ENOMEM;
 		}
 		top = base + (PAGE_SIZE << order);
@@ -1339,8 +1347,8 @@
 		for (page = base + size; page < top; page += PAGE_SIZE)
 			free_page(page);
 
-		fb_info.screen_base = (char *)base;
-		fb_info.fix.smem_start = virt_to_phys(fb_info.screen_base);
+		fb_info->screen_base = (char *)base;
+		fb_info->fix.smem_start = virt_to_phys(fb_info->screen_base);
 	}
 #endif
 #if defined(HAS_VIDC)
@@ -1350,8 +1358,8 @@
 	free_unused_pages(PAGE_OFFSET + size, PAGE_OFFSET + MAX_SIZE);
 #endif
 	
-	fb_info.fix.smem_len = size;
-	current_par.palette_size   = VIDC_PALETTE_SIZE;
+	fb_info->fix.smem_len = size;
+	current_par->palette_size   = VIDC_PALETTE_SIZE;
 
 	/*
 	 * Lookup the timing for this resolution.  If we can't
@@ -1359,7 +1367,7 @@
 	 * the resolution, so we disable this feature.
 	 */
 	do {
-		rc = fb_find_mode(&fb_info.var, &fb_info, NULL, modedb,
+		rc = fb_find_mode(&fb_info->var, fb_info, NULL, modedb,
 				 sizeof(modedb) / sizeof(*modedb),
 				 &acornfb_default_mode, DEFAULT_BPP);
 		/*
@@ -1368,7 +1376,7 @@
 		if (rc == 1)
 			break;
 
-		rc = fb_find_mode(&fb_info.var, &fb_info, NULL, NULL, 0,
+		rc = fb_find_mode(&fb_info->var, fb_info, NULL, NULL, 0,
 				  &acornfb_default_mode, DEFAULT_BPP);
 		/*
 		 * If we found an exact match, all ok.
@@ -1376,13 +1384,13 @@
 		if (rc == 1)
 			break;
 
-		rc = fb_find_mode(&fb_info.var, &fb_info, NULL, modedb,
+		rc = fb_find_mode(&fb_info->var, fb_info, NULL, modedb,
 				 sizeof(modedb) / sizeof(*modedb),
 				 &acornfb_default_mode, DEFAULT_BPP);
 		if (rc)
 			break;
 
-		rc = fb_find_mode(&fb_info.var, &fb_info, NULL, NULL, 0,
+		rc = fb_find_mode(&fb_info->var, fb_info, NULL, NULL, 0,
 				  &acornfb_default_mode, DEFAULT_BPP);
 	} while (0);
 
@@ -1392,33 +1400,36 @@
 	 */
 	if (rc == 0) {
 		printk("Acornfb: no valid mode found\n");
+		kfree(fb_info);
 		return -EINVAL;
 	}
 
-	h_sync = 1953125000 / fb_info.var.pixclock;
-	h_sync = h_sync * 512 / (fb_info.var.xres + fb_info.var.left_margin +
-		 fb_info.var.right_margin + fb_info.var.hsync_len);
-	v_sync = h_sync / (fb_info.var.yres + fb_info.var.upper_margin +
-		 fb_info.var.lower_margin + fb_info.var.vsync_len);
+	h_sync = 1953125000 / fb_info->var.pixclock;
+	h_sync = h_sync * 512 / (fb_info->var.xres + fb_info->var.left_margin +
+		 fb_info->var.right_margin + fb_info->var.hsync_len);
+	v_sync = h_sync / (fb_info->var.yres + fb_info->var.upper_margin +
+		 fb_info->var.lower_margin + fb_info->var.vsync_len);
 
 	printk(KERN_INFO "Acornfb: %dkB %cRAM, %s, using %dx%d, "
 		"%d.%03dkHz, %dHz\n",
-		fb_info.fix.smem_len / 1024,
-		current_par.using_vram ? 'V' : 'D',
-		VIDC_NAME, fb_info.var.xres, fb_info.var.yres,
+		fb_info->fix.smem_len / 1024,
+		current_par->using_vram ? 'V' : 'D',
+		VIDC_NAME, fb_info->var.xres, fb_info->var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
 	printk(KERN_INFO "Acornfb: Monitor: %d.%03d-%d.%03dkHz, %d-%dHz%s\n",
-		fb_info.monspecs.hfmin / 1000, fb_info.monspecs.hfmin % 1000,
-		fb_info.monspecs.hfmax / 1000, fb_info.monspecs.hfmax % 1000,
-		fb_info.monspecs.vfmin, fb_info.monspecs.vfmax,
-		fb_info.monspecs.dpms ? ", DPMS" : "");
+		fb_info->monspecs.hfmin / 1000, fb_info->monspecs.hfmin % 1000,
+		fb_info->monspecs.hfmax / 1000, fb_info->monspecs.hfmax % 1000,
+		fb_info->monspecs.vfmin, fb_info->monspecs.vfmax,
+		fb_info->monspecs.dpms ? ", DPMS" : "");
 
-	if (fb_set_var(&fb_info.var, &fb_info))
+	if (fb_set_var(fb_info, &fb_info->var))
 		printk(KERN_ERR "Acornfb: unable to set display parameters\n");
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return -EINVAL;
+	}
 	return 0;
 }


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
This message will self distruct in 5 seconds.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
