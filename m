From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] bw2: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:42:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915194246.GF16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzGE-00046I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:43:46 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzGD-00052v-B1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:43:45 -0700
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
this patch converts driver/video/bw2.c to framebuffer_alloc:

======== drivers/video/bw2.c 1.8 ========
D 1.8 03/09/13 00:38:35+02:00 kronos@kronoz.cjb.net 9 8 34/38/381
P drivers/video/bw2.c
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/bw2.c 1.7 vs 1.8 =====
--- 1.7/drivers/video/bw2.c	Fri Aug 22 08:34:52 2003
+++ 1.8/drivers/video/bw2.c	Sat Sep 13 00:38:35 2003
@@ -119,6 +119,7 @@
 	unsigned long		fbsize;
 
 	struct sbus_dev		*sdev;
+	struct fb_info		*info;
 	struct list_head	list;
 };
 
@@ -284,94 +285,90 @@
 	}
 }
 
-struct all_info {
-	struct fb_info info;
-	struct bw2_par par;
-	struct list_head list;
-};
 static LIST_HEAD(bw2_list);
 
 static void bw2_init_one(struct sbus_dev *sdev)
 {
-	struct all_info *all;
+	struct bw2_par *par;
+	struct fb_info *info;
 	struct resource *resp;
 #ifdef CONFIG_SUN4
 	struct resource res;
 #endif
 	int linebytes;
 
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct bw2_par), NULL);
+	if (!info) {
 		printk(KERN_ERR "bw2: Cannot allocate memory.\n");
 		return;
 	}
-	memset(all, 0, sizeof(*all));
+	par = info->par;
+	par->info = info;
 
-	INIT_LIST_HEAD(&all->list);
+	INIT_LIST_HEAD(&par->list);
 
-	spin_lock_init(&all->par.lock);
-	all->par.sdev = sdev;
+	spin_lock_init(&par->lock);
+	par->sdev = sdev;
 
 #ifdef CONFIG_SUN4
 	if (!sdev) {
-		all->par.physbase = sun4_bwtwo_physaddr;
+		par->physbase = sun4_bwtwo_physaddr;
 		res.start = sun4_bwtwo_physaddr;
 		res.end = res.start + BWTWO_REGISTER_OFFSET + sizeof(struct bw2_regs) - 1;
 		res.flags = IORESOURCE_IO;
 		resp = &res;
-		all->info.var.xres = all->info.var.xres_virtual = 1152;
-		all->info.var.yres = all->info.var.yres_virtual = 900;
-		all->info.bits_per_pixel = 1;
+		info->var.xres = info->var.xres_virtual = 1152;
+		info->info.var.yres = info->var.yres_virtual = 900;
+		info->info.bits_per_pixel = 1;
 		linebytes = 1152 / 8;
 	} else
 #else
 	{
 		if (!sdev)
 			BUG();
-		all->par.physbase = sdev->reg_addrs[0].phys_addr;
+		par->physbase = sdev->reg_addrs[0].phys_addr;
 		resp = &sdev->resource[0];
-		sbusfb_fill_var(&all->info.var, (sdev ? sdev->prom_node : 0), 1);
+		sbusfb_fill_var(&info->var, (sdev ? sdev->prom_node : 0), 1);
 		linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
-					       all->info.var.xres);
+					       info->var.xres);
 	}
 #endif
 
-	all->par.regs = (struct bw2_regs *)
+	par->regs = (struct bw2_regs *)
 		sbus_ioremap(resp, BWTWO_REGISTER_OFFSET,
 			     sizeof(struct bw2_regs), "bw2 regs");
 
 	if (sdev && !prom_getbool(sdev->prom_node, "width"))
-		bw2_do_default_mode(&all->par, &all->info, &linebytes);
+		bw2_do_default_mode(par, info, &linebytes);
 
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
-	all->info.fbops = &bw2_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &bw2_ops;
 #if defined(CONFIG_SPARC32)
 	if (sdev)
-		all->info.screen_base = (char *)
+		info->screen_base = (char *)
 			prom_getintdefault(sdev->prom_node, "address", 0);
 #endif
-	if (!all->info.screen_base)
-		all->info.screen_base = (char *)
-			sbus_ioremap(resp, 0, all->par.fbsize, "bw2 ram");
-	all->info.par = &all->par;
+	if (!info->screen_base)
+		info->screen_base = (char *)
+			sbus_ioremap(resp, 0, par->fbsize, "bw2 ram");
 
-	bw2_blank(0, &all->info);
+	bw2_blank(0, info);
 
-	bw2_init_fix(&all->info, linebytes);
+	bw2_init_fix(info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "bw2: Could not register framebuffer.\n");
-		kfree(all);
+		kfree(info);
 		return;
 	}
 
-	list_add(&all->list, &bw2_list);
+	list_add(&par->list, &bw2_list);
 
 	printk("bw2: bwtwo at %lx:%lx\n",
 	       (long) (sdev ? sdev->reg_addrs[0].which_io : 0),
-	       (long) all->par.physbase);
+	       (long) par->physbase);
 }
 
 int __init bw2_init(void)
@@ -395,10 +392,9 @@
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &bw2_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
+		struct bw2_par *par = list_entry(pos, typeof(*par), list);
 
-		unregister_framebuffer(&all->info);
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
