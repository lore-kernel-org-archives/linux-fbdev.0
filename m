From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] p9100: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:47:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204742.GE23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0H1-0000r2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:48:39 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0H0-0001lo-27
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:48:38 -0700
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
this patch converts driver/video/p9100.c to framebuffer_alloc:

======== drivers/video/p9100.c 1.8 ========
D 1.8 03/09/14 00:01:06+02:00 kronos@kronoz.cjb.net 9 8 35/29/348
P drivers/video/p9100.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/p9100.c 1.7 vs 1.8 =====
--- 1.7/drivers/video/p9100.c	Fri Aug 22 08:34:52 2003
+++ 1.8/drivers/video/p9100.c	Sun Sep 14 00:01:06 2003
@@ -34,6 +34,7 @@
 static int p9100_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
 static int p9100_ioctl(struct inode *, struct file *, unsigned int,
 		       unsigned long, struct fb_info *);
+static void release_p9100fb(struct fb_info *info);
 
 /*
  *  Frame buffer operations
@@ -138,6 +139,7 @@
 	unsigned long		fbsize;
 
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -269,64 +271,66 @@
 
 static void p9100_init_one(struct sbus_dev *sdev)
 {
-	struct all_info *all;
+	struct fb_info *info;
+	struct p9100_par *par;
 	int linebytes;
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(*par), NULL);
+	if (!info) {
 		printk(KERN_ERR "p9100: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	info->release = &release_p9100fb;
+	par = info->par;
+	par->info = info;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
-	all->par.sdev = sdev;
+	spin_lock_init(&par->lock);
+	par->sdev = sdev;
 
 	/* This is the framebuffer and the only resource apps can mmap.  */
-	all->par.physbase = sdev->reg_addrs[2].phys_addr;
+	par->physbase = sdev->reg_addrs[2].phys_addr;
 
 	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-				       all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+				       info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.regs = (struct p9100_regs *)
+	par->regs = (struct p9100_regs *)
 		sbus_ioremap(&sdev->resource[0], 0,
 			     sizeof(struct p9100_regs), "p9100 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &p9100_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &p9100_ops;
 #ifdef CONFIG_SPARC32
-	all->info.screen_base = (char *)
+	info->screen_base = (char *)
 		prom_getintdefault(sdev->prom_node, "address", 0);
 #endif
-	if (!all->info.screen_base)
-		all->info.screen_base = (char *)
+	if (!info->screen_base)
+		info->screen_base = (char *)
 			sbus_ioremap(&sdev->resource[2], 0,
-				     all->par.fbsize, "p9100 ram");
-	all->info.par = &all->par;
+				     par->fbsize, "p9100 ram");
 
-	p9100_blank(0, &all->info);
+	p9100_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "p9100: Could not allocate color map.\n");
 		kfree(all);
 		return;
 	}
 
-	p9100_init_fix(&all->info, linebytes);
+	p9100_init_fix(info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "p9100: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
+		fb_dealloc_cmap(&info->cmap);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &p9100_list);
+	list_add(&par->list, &p9100_list);
 
 	printk("p9100: %s at %lx:%lx\n",
 	       sdev->prom_name,
@@ -347,16 +351,18 @@
 	return 0;
 }
 
+static void release_p9100fb(struct fb_info *info) {
+	fb_dealloc_cmap(&info->cmap);
+}
+
 void __exit p9100_exit(void)
 {
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &p9100_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct p9100_par *par = list_entry(pos, typeof(*par), list);
 
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
"I've seen things you people wouldn't believe...
 Attack Ships on fire off the shores of Orion.
 I've watched C-beams glitter in the dark off of Tanhauser Gate.
 All those moments will be lost in time...like tears, in rain.
 Time to die." -- Roy Batty (played by Rutger Hauer)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
