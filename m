From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] cg*: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:42:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915194259.GG16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzGQ-00047S-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:43:58 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzGO-0005Ds-Ub
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:43:57 -0700
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
To: davem@redhat.com
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/cg*.c to framebuffer_alloc:

======== drivers/video/cg14.c 1.10 ========
D 1.10 03/09/13 22:59:40+02:00 kronos@kronoz.cjb.net 11 10 50/49/527
P drivers/video/cg14.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/cg14.c 1.9 vs 1.10 =====
--- 1.9/drivers/video/cg14.c	Fri Aug 22 08:34:52 2003
+++ 1.10/drivers/video/cg14.c	Sat Sep 13 22:59:40 2003
@@ -35,6 +35,7 @@
 static int cg14_ioctl(struct inode *, struct file *, unsigned int,
 		      unsigned long, struct fb_info *);
 static int cg14_pan_display(struct fb_var_screeninfo *, struct fb_info *);
+static void release_cg14fb(struct fb_info *info);
 
 /*
  *  Frame buffer operations
@@ -204,6 +205,7 @@
 	int			mode;
 	int			ramsize;
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -386,16 +388,12 @@
 	{ 0,			0,			0		    }
 };
 
-struct all_info {
-	struct fb_info info;
-	struct cg14_par par;
-	struct list_head list;
-};
 static LIST_HEAD(cg14_list);
 
 static void cg14_init_one(struct sbus_dev *sdev, int node, int parent_node)
 {
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg14_par *par; 
 	unsigned long phys, rphys;
 	u32 bases[6];
 	int is_8mb, linebytes, i;
@@ -413,70 +411,72 @@
 		}
 	}
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct cg14_par), NULL);
+	if (!info) {
 		printk(KERN_ERR "cg14: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	par = info->par;
+	par->info = info;
+	info->release = &release_cg14fb;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
+	spin_lock_init(&par->lock);
 
-	sbusfb_fill_var(&all->info.var, node, 8);
+	sbusfb_fill_var(&info->var, node, 8);
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-				       all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+				       info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.sdev = sdev;
+	par->sdev = sdev;
 	if (sdev) {
 		rphys = sdev->reg_addrs[0].phys_addr;
-		all->par.physbase = phys = sdev->reg_addrs[1].phys_addr;
-		all->par.iospace = sdev->reg_addrs[0].which_io;
+		par->physbase = phys = sdev->reg_addrs[1].phys_addr;
+		par->iospace = sdev->reg_addrs[0].which_io;
 
-		all->par.regs = (struct cg14_regs *)
+		par->regs = (struct cg14_regs *)
 			sbus_ioremap(&sdev->resource[0], 0,
 				     sizeof(struct cg14_regs),
 				     "cg14 regs");
-		all->par.clut = (struct cg14_clut *)
+		par->clut = (struct cg14_clut *)
 			sbus_ioremap(&sdev->resource[0], CG14_CLUT1,
 				     sizeof(struct cg14_clut),
 				     "cg14 clut");
-		all->par.cursor = (struct cg14_cursor *)
+		par->cursor = (struct cg14_cursor *)
 			sbus_ioremap(&sdev->resource[0], CG14_CURSORREGS,
 				     sizeof(struct cg14_cursor),
 				     "cg14 cursor");
-		all->info.screen_base = (char *)
+		info->screen_base = (char *)
 			sbus_ioremap(&sdev->resource[1], 0,
-				     all->par.fbsize, "cg14 ram");
+				     par->fbsize, "cg14 ram");
 	} else {
 		rphys = __get_phys(bases[0]);
-		all->par.physbase = phys = __get_phys(bases[1]);
-		all->par.iospace = __get_iospace(bases[0]);
-		all->par.regs = (struct cg14_regs *)(unsigned long)bases[0];
-		all->par.clut = (struct cg14_clut *)((unsigned long)bases[0] +
+		par->physbase = phys = __get_phys(bases[1]);
+		par->iospace = __get_iospace(bases[0]);
+		par->regs = (struct cg14_regs *)(unsigned long)bases[0];
+		par->clut = (struct cg14_clut *)((unsigned long)bases[0] +
 						     CG14_CLUT1);
-		all->par.cursor =
+		par->cursor =
 			(struct cg14_cursor *)((unsigned long)bases[0] +
 					       CG14_CURSORREGS);
 
-		all->info.screen_base = (char *)(unsigned long)bases[1];
+		info->screen_base = (char *)(unsigned long)bases[1];
 	}
 
 	prom_getproperty(node, "reg", (char *) &bases[0], sizeof(bases));
 	is_8mb = (bases[5] == 0x800000);
 
-	if (sizeof(all->par.mmap_map) != sizeof(__cg14_mmap_map)) {
+	if (sizeof(par->mmap_map) != sizeof(__cg14_mmap_map)) {
 		extern void __cg14_mmap_sized_wrongly(void);
 
 		__cg14_mmap_sized_wrongly();
 	}
 		
-	memcpy(&all->par.mmap_map, &__cg14_mmap_map, sizeof(all->par.mmap_map));
+	memcpy(&par->mmap_map, &__cg14_mmap_map, sizeof(par->mmap_map));
 	for (i = 0; i < CG14_MMAP_ENTRIES; i++) {
-		struct sbus_mmap_map *map = &all->par.mmap_map[i];
+		struct sbus_mmap_map *map = &par->mmap_map[i];
 
 		if (!map->size)
 			break;
@@ -488,34 +488,33 @@
 			map->size *= 2;
 	}
 
-	all->par.mode = MDI_8_PIX;
-	all->par.ramsize = (is_8mb ? 0x800000 : 0x400000);
+	par->mode = MDI_8_PIX;
+	par->ramsize = (is_8mb ? 0x800000 : 0x400000);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &cg14_ops;
-	all->info.par = &all->par;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &cg14_ops;
 
-	__cg14_reset(&all->par);
+	__cg14_reset(par);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "cg14: Could not allocate color map.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	cg14_init_fix(&all->info, linebytes);
+	cg14_init_fix(info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "cg14: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &cg14_list);
+	list_add(&par->list, &cg14_list);
 
 	printk("cg14: cgfourteen at %lx:%lx\n",
-	       all->par.physbase, all->par.iospace);
+	       par->physbase, par->iospace);
 
 }
 
@@ -546,16 +545,18 @@
 	return 0;
 }
 
+static void release_cg14fb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit cg14_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &cg14_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct cg14_par *par = list_entry(pos, typeof(*par), list);
 
-		unregister_framebuffer(&all->info);
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		unregister_framebuffer(par->info);
 	}
 }


======== drivers/video/cg3.c 1.8 ========
D 1.8 03/09/13 23:03:05+02:00 kronos@kronoz.cjb.net 9 8 41/40/438
P drivers/video/cg3.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/cg3.c 1.7 vs 1.8 =====
--- 1.7/drivers/video/cg3.c	Fri Aug 22 08:34:52 2003
+++ 1.8/drivers/video/cg3.c	Sat Sep 13 23:03:05 2003
@@ -36,6 +36,7 @@
 static int cg3_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
 static int cg3_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long, struct fb_info *);
+static void release_cg3fb(struct fb_info *info);
 
 /*
  *  Frame buffer operations
@@ -122,6 +123,7 @@
 	unsigned long		fbsize;
 
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -354,79 +356,76 @@
 	}
 }
 
-struct all_info {
-	struct fb_info info;
-	struct cg3_par par;
-	struct list_head list;
-};
 static LIST_HEAD(cg3_list);
 
 static void cg3_init_one(struct sbus_dev *sdev)
 {
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg3_par *par;
 	int linebytes;
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct cg3_par), NULL);
+	if (!info) {
 		printk(KERN_ERR "cg3: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	par = info->par;
+	par->info = info;
+	info->release = &release_cg3fb;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
-	all->par.sdev = sdev;
+	spin_lock_init(&par->lock);
+	par->sdev = sdev;
 
-	all->par.physbase = sdev->reg_addrs[0].phys_addr;
+	par->physbase = sdev->reg_addrs[0].phys_addr;
 
-	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	sbusfb_fill_var(&info->var, sdev->prom_node, 8);
 	if (!strcmp(sdev->prom_name, "cgRDI"))
-		all->par.flags |= CG3_FLAG_RDI;
-	if (all->par.flags & CG3_FLAG_RDI)
-		cg3_rdi_maybe_fixup_var(&all->info.var, sdev);
+		par->flags |= CG3_FLAG_RDI;
+	if (par->flags & CG3_FLAG_RDI)
+		cg3_rdi_maybe_fixup_var(&info->var, sdev);
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-				       all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+				       info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.regs = (struct cg3_regs *)
+	par->regs = (struct cg3_regs *)
 		sbus_ioremap(&sdev->resource[0], CG3_REGS_OFFSET,
 			     sizeof(struct cg3_regs), "cg3 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &cg3_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &cg3_ops;
 #ifdef CONFIG_SPARC32
-	all->info.screen_base = (char *)
+	info->screen_base = (char *)
 		prom_getintdefault(sdev->prom_node, "address", 0);
 #endif
-	if (!all->info.screen_base)
-		all->info.screen_base = (char *)
+	if (!info->screen_base)
+		info->screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], CG3_RAM_OFFSET,
-				     all->par.fbsize, "cg3 ram");
-	all->info.par = &all->par;
+				     par->fbsize, "cg3 ram");
 
-	cg3_blank(0, &all->info);
+	cg3_blank(0, info);
 
 	if (!prom_getbool(sdev->prom_node, "width"))
-		cg3_do_default_mode(&all->par);
+		cg3_do_default_mode(par);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "cg3: Could not allocate color map.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	cg3_init_fix(&all->info, linebytes);
+	cg3_init_fix(info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "cg3: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &cg3_list);
+	list_add(&par->list, &cg3_list);
 
 	printk("cg3: %s at %lx:%lx\n",
 	       sdev->prom_name,
@@ -448,16 +447,18 @@
 	return 0;
 }
 
+static void release_cg3fb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit cg3_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &cg3_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct cg3_par *par = list_entry(pos, typeof(*par), list);
 
-		unregister_framebuffer(&all->info);
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		unregister_framebuffer(par->info);
 	}
 }


======== drivers/video/cg6.c 1.7 ========
D 1.7 03/09/13 23:01:59+02:00 kronos@kronoz.cjb.net 11 10 46/45/720
P drivers/video/cg6.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/cg6.c 1.6 vs 1.7 =====
--- 1.6/drivers/video/cg6.c	Fri Aug 22 08:34:52 2003
+++ 1.7/drivers/video/cg6.c	Sat Sep 13 23:01:59 2003
@@ -39,6 +39,7 @@
 static int cg6_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
 static int cg6_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long, struct fb_info *);
+static void release_cg6fb(struct fb_info *info);
 
 /*
  *  Frame buffer operations
@@ -263,6 +264,7 @@
 	unsigned long		fbsize;
 
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -630,93 +632,90 @@
 	sbus_writel(tmp, &par->bt->control);
 }
 
-struct all_info {
-	struct fb_info info;
-	struct cg6_par par;
-	struct list_head list;
-};
 static LIST_HEAD(cg6_list);
 
 static void cg6_init_one(struct sbus_dev *sdev)
 {
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg6_par *par;
 	int linebytes;
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct cg6_par), NULL);
+	if (!info) {
 		printk(KERN_ERR "cg6: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	par = info->par;
+	par->info = info;
+	par->release = &release_cg6fb;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
-	all->par.sdev = sdev;
+	spin_lock_init(&par->lock);
+	par->sdev = sdev;
 
-	all->par.physbase = sdev->reg_addrs[0].phys_addr;
+	par->physbase = sdev->reg_addrs[0].phys_addr;
 
-	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	sbusfb_fill_var(&info->var, sdev->prom_node, 8);
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-				       all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+				       info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 	if (prom_getbool(sdev->prom_node, "dblbuf"))
-		all->par.fbsize *= 4;
+		par->fbsize *= 4;
 
-	all->par.fbc = (struct cg6_fbc *)
+	par->fbc = (struct cg6_fbc *)
 		sbus_ioremap(&sdev->resource[0], CG6_FBC_OFFSET,
 			     4096, "cgsix fbc");
-	all->par.tec = (struct cg6_tec *)
+	par->tec = (struct cg6_tec *)
 		sbus_ioremap(&sdev->resource[0], CG6_TEC_OFFSET,
 			     sizeof(struct cg6_tec), "cgsix tec");
-	all->par.thc = (struct cg6_thc *)
+	par->thc = (struct cg6_thc *)
 		sbus_ioremap(&sdev->resource[0], CG6_THC_OFFSET,
 			     sizeof(struct cg6_thc), "cgsix thc");
-	all->par.bt = (struct bt_regs *)
+	par->bt = (struct bt_regs *)
 		sbus_ioremap(&sdev->resource[0], CG6_BROOKTREE_OFFSET,
 			     sizeof(struct bt_regs), "cgsix dac");
-	all->par.fhc = (u32 *)
+	par->fhc = (u32 *)
 		sbus_ioremap(&sdev->resource[0], CG6_FHC_OFFSET,
 			     sizeof(u32), "cgsix fhc");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &cg6_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &cg6_ops;
 #ifdef CONFIG_SPARC32
-	all->info.screen_base = (char *)
+	info->screen_base = (char *)
 		prom_getintdefault(sdev->prom_node, "address", 0);
 #endif
-	if (!all->info.screen_base)
-		all->info.screen_base = (char *)
+	if (!info->screen_base)
+		info->screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], CG6_RAM_OFFSET,
-				     all->par.fbsize, "cgsix ram");
-	all->info.par = &all->par;
+				     par->fbsize, "cgsix ram");
 
-	all->info.var.accel_flags = FB_ACCELF_TEXT;
+	info->var.accel_flags = FB_ACCELF_TEXT;
 
-	cg6_bt_init(&all->par);
-	cg6_chip_init(&all->info);
-	cg6_blank(0, &all->info);
+	cg6_bt_init(par);
+	cg6_chip_init(info);
+	cg6_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "cg6: Could not allocate color map.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	cg6_init_fix(&all->info, linebytes);
+	cg6_init_fix(info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "cg6: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &cg6_list);
+	list_add(&par->list, &cg6_list);
 
 	printk("cg6: CGsix [%s] at %lx:%lx\n",
-	       all->info.fix.id,
+	       info->fix.id,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr);
 }
@@ -735,16 +734,18 @@
 	return 0;
 }
 
+static void release_cg6fb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit cg6_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &cg6_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct cg6_par *par = list_entry(pos, typeof(*par), list);
 
-		unregister_framebuffer(&all->info);
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		unregister_framebuffer(par->info);
 	}
 }


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Di tutte le perversioni sessuali, la castita` e` la piu` strana".
Anatole France


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
