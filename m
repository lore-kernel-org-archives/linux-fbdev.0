From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] leofb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:15:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201552.GT16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzm1-0006pz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:37 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzm0-0005CA-Ub
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:37 -0700
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
this patch converts driver/video/leo.c to framebuffer_alloc:

======== drivers/video/leo.c 1.7 ========
D 1.7 03/09/13 23:46:09+02:00 kronos@kronoz.cjb.net 8 7 43/37/574
P drivers/video/leo.c
C port driver to framebuffer_alloc
------------------------------------------------

===== drivers/video/leo.c 1.6 vs 1.7 =====
--- 1.6/drivers/video/leo.c	Fri Aug 22 08:34:52 2003
+++ 1.7/drivers/video/leo.c	Sat Sep 13 23:46:09 2003
@@ -36,6 +36,7 @@
 static int leo_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long, struct fb_info *);
 static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
+static void release_leofb(struct fb_info *);
 
 /*
  *  Frame buffer operations
@@ -195,6 +196,7 @@
 	unsigned long		fbsize;
 
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -487,80 +489,82 @@
 
 static void leo_init_one(struct sbus_dev *sdev)
 {
-	struct all_info *all;
+	struct fb_info *info;
+	struct leo_par *par;
 	int linebytes;
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct leo_par), NULL);
+	if (!info) {
 		printk(KERN_ERR "leo: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	info->release = &release_leofb;
+	par = info->par;
+	par->info = info;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
-	all->par.sdev = sdev;
+	spin_lock_init(&par->lock);
+	par->sdev = sdev;
 
-	all->par.physbase = sdev->reg_addrs[0].phys_addr;
+	par->physbase = sdev->reg_addrs[0].phys_addr;
 
-	sbusfb_fill_var(&all->info.var, sdev->prom_node, 32);
-	leo_fixup_var_rgb(&all->info.var);
+	sbusfb_fill_var(&info->var, sdev->prom_node, 32);
+	leo_fixup_var_rgb(&info->var);
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-				       all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+				       info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
 #ifdef CONFIG_SPARC32
-	all->info.screen_base = (char *)
+	info->screen_base = (char *)
 		prom_getintdefault(sdev->prom_node, "address", 0);
 #endif
-	if (!all->info.screen_base)
-		all->info.screen_base = (char *)
+	if (!info->screen_base)
+		info->screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], LEO_OFF_SS0,
 				     0x800000, "leo ram");
 
-	all->par.lc_ss0_usr = (struct leo_lc_ss0_usr *)
+	par->lc_ss0_usr = (struct leo_lc_ss0_usr *)
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LC_SS0_USR,
 			     0x1000, "leolc ss0usr");
-	all->par.ld_ss0 = (struct leo_ld_ss0 *)
+	par->ld_ss0 = (struct leo_ld_ss0 *)
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LD_SS0,
 			     0x1000, "leold ss0");
-	all->par.ld_ss1 = (struct leo_ld_ss1 *)
+	par->ld_ss1 = (struct leo_ld_ss1 *)
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LD_SS1,
 			     0x1000, "leold ss1");
-	all->par.lx_krn = (struct leo_lx_krn *)
+	par->lx_krn = (struct leo_lx_krn *)
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LX_KRN,
 			     0x1000, "leolx krn");
-	all->par.cursor = (struct leo_cursor *)
+	par->cursor = (struct leo_cursor *)
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LX_CURSOR,
 			     sizeof(struct leo_cursor), "leolx cursor");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &leo_ops;
-	all->info.par = &all->par;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &leo_ops;
 
-	leo_init_wids(&all->info);
-	leo_init_hw(&all->info);
+	leo_init_wids(info);
+	leo_init_hw(info);
 
-	leo_blank(0, &all->info);
+	leo_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "leo: Could not allocate color map.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	leo_init_fix(&all->info);
+	leo_init_fix(info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "leo: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &leo_list);
+	list_add(&par->list, &leo_list);
 
 	printk("leo: %s at %lx:%lx\n",
 	       sdev->prom_name,
@@ -581,16 +585,18 @@
 	return 0;
 }
 
+static void release_leofb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit leo_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &leo_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct leo_par *par = list_entry(pos, typeof(*par), list);
 
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
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
