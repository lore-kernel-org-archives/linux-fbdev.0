From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] ffb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:53:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915195316.GK16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzQC-0004nv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:54:04 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzQB-00059X-9m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:54:04 -0700
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
this patch converts driver/video/ffb.c to framebuffer_alloc:

======== drivers/video/ffb.c 1.9 ========
D 1.9 03/09/13 23:29:53+02:00 kronos@kronoz.cjb.net 13 12 56/56/976
P drivers/video/ffb.c
C convert driver to framebuffer_alloc
------------------------------------------------

===== drivers/video/ffb.c 1.8 vs 1.9 =====
--- 1.8/drivers/video/ffb.c	Fri Aug 22 08:34:52 2003
+++ 1.9/drivers/video/ffb.c	Sat Sep 13 23:29:53 2003
@@ -41,6 +41,7 @@
 static int ffb_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long, struct fb_info *);
 static int ffb_pan_display(struct fb_var_screeninfo *, struct fb_info *);
+static void release_ffb(struct fb_info *info);
 
 /*
  *  Frame buffer operations
@@ -359,6 +360,7 @@
 	int			prom_parent_node;
 	int			dac_rev;
 	int			board_type;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -868,12 +870,6 @@
 	return 1;
 }
 
-struct all_info {
-	struct fb_info info;
-	struct ffb_par par;
-	u32 pseudo_palette[256];
-	struct list_head list;
-};
 static LIST_HEAD(ffb_list);
 
 static void ffb_init_one(int node, int parent)
@@ -881,7 +877,8 @@
 	struct linux_prom64_registers regs[2*PROMREG_MAX];
 	struct ffb_fbc *fbc;
 	struct ffb_dac *dac;
-	struct all_info *all;
+	struct fb_info *info;
+	struct ffb_par *par;
 
 	if (prom_getproperty(node, "reg", (void *) regs, sizeof(regs)) <= 0) {
 		printk("ffb: Cannot get reg device node property.\n");
@@ -893,86 +890,87 @@
 		return;
 	}
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct ffb_par) + 32 * 256, NULL);
+	if (!info) {
 		printk(KERN_ERR "ffb: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
-
-	INIT_LIST_HEAD(&all->list);	
-
-	spin_lock_init(&all->par.lock);
-	all->par.fbc = (struct ffb_fbc *)(regs[0].phys_addr + FFB_FBC_REGS_POFF);
-	all->par.dac = (struct ffb_dac *)(regs[0].phys_addr + FFB_DAC_POFF);
-	all->par.rop_cache = FFB_ROP_NEW;
-	all->par.physbase = regs[0].phys_addr;
-	all->par.prom_node = node;
-	all->par.prom_parent_node = parent;
-
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &ffb_ops;
-	all->info.screen_base = (char *) all->par.physbase + FFB_DFB24_POFF;
-	all->info.par = &all->par;
-	all->info.pseudo_palette = all->pseudo_palette;
-
-	sbusfb_fill_var(&all->info.var, all->par.prom_node, 32);
-	all->par.fbsize = PAGE_ALIGN(all->info.var.xres *
-				     all->info.var.yres *
+	par = info->par;
+	par->info = info;
+	info->release = &release_ffb;
+	
+	INIT_LIST_HEAD(&par->list);	
+
+	spin_lock_init(&par->lock);
+	par->fbc = (struct ffb_fbc *)(regs[0].phys_addr + FFB_FBC_REGS_POFF);
+	par->dac = (struct ffb_dac *)(regs[0].phys_addr + FFB_DAC_POFF);
+	par->rop_cache = FFB_ROP_NEW;
+	par->physbase = regs[0].phys_addr;
+	par->prom_node = node;
+	par->prom_parent_node = parent;
+
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &ffb_ops;
+	info->screen_base = (char *) par->physbase + FFB_DFB24_POFF;
+	info->pseudo_palette = (void *)(par + 1);
+
+	sbusfb_fill_var(&info->var, par->prom_node, 32);
+	par->fbsize = PAGE_ALIGN(info->var.xres *
+				     info->var.yres *
 				     4);
-	ffb_fixup_var_rgb(&all->info.var);
+	ffb_fixup_var_rgb(&info->var);
 
-	all->info.var.accel_flags = FB_ACCELF_TEXT;
+	info->var.accel_flags = FB_ACCELF_TEXT;
 
-	prom_getstring(node, "name", all->par.name, sizeof(all->par.name));
-	if (!strcmp(all->par.name, "SUNW,afb"))
-		all->par.flags |= FFB_FLAG_AFB;
+	prom_getstring(node, "name", par->name, sizeof(par->name));
+	if (!strcmp(par->name, "SUNW,afb"))
+		par->flags |= FFB_FLAG_AFB;
 
-	all->par.board_type = prom_getintdefault(node, "board_type", 0);
+	par->board_type = prom_getintdefault(node, "board_type", 0);
 
-	fbc = all->par.fbc;
+	fbc = par->fbc;
 	if((upa_readl(&fbc->ucsr) & FFB_UCSR_ALL_ERRORS) != 0)
 		upa_writel(FFB_UCSR_ALL_ERRORS, &fbc->ucsr);
 
-	ffb_switch_from_graph(&all->par);
+	ffb_switch_from_graph(par);
 
-	dac = all->par.dac;
+	dac = par->dac;
 	upa_writel(0x8000, &dac->type);
-	all->par.dac_rev = upa_readl(&dac->value) >> 0x1c;
+	par->dac_rev = upa_readl(&dac->value) >> 0x1c;
 
 	/* Elite3D has different DAC revision numbering, and no DAC revisions
 	 * have the reversed meaning of cursor enable.
 	 */
-	if (all->par.flags & FFB_FLAG_AFB)
-		all->par.dac_rev = 10;
+	if (par->flags & FFB_FLAG_AFB)
+		par->dac_rev = 10;
 
 	/* Unblank it just to be sure.  When there are multiple
 	 * FFB/AFB cards in the system, or it is not the OBP
 	 * chosen console, it will have video outputs off in
 	 * the DAC.
 	 */
-	ffb_blank(0, &all->info);
+	ffb_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "ffb: Could not allocate color map.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	ffb_init_fix(&all->info);
+	ffb_init_fix(info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "ffb: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &ffb_list);
+	list_add(&par->list, &ffb_list);
 
 	printk("ffb: %s at %016lx type %d DAC %d\n",
-	       ((all->par.flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
-	       regs[0].phys_addr, all->par.board_type, all->par.dac_rev);
+	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
+	       regs[0].phys_addr, par->board_type, par->dac_rev);
 }
 
 static void ffb_scan_siblings(int root)
@@ -1002,16 +1000,18 @@
 	return 0;
 }
 
+static void release_ffb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit ffb_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &ffb_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct ffb_par *par = list_entry(pos, typeof(*par), list);
 
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
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
