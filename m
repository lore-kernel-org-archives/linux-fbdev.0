From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] sgivwfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:46:55 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204655.GA23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0GG-0000nx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:47:52 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0GF-0000ij-La
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:47:51 -0700
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
To: newquist@engr.sgi.som
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/sgivwfb.c to framebuffer_alloc:

======== drivers/video/sgivwfb.c 1.30 ========
D 1.30 03/09/14 00:15:56+02:00 kronos@kronoz.cjb.net 34 33 38/24/814
P drivers/video/sgivwfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/sgivwfb.c 1.29 vs 1.30 =====
--- 1.29/drivers/video/sgivwfb.c	Thu Apr 24 12:30:41 2003
+++ 1.30/drivers/video/sgivwfb.c	Sun Sep 14 00:15:56 2003
@@ -22,7 +22,7 @@
 #include <asm/mtrr.h>
 
 #define INCLUDE_TIMING_TABLE_DATA
-#define DBE_REG_BASE default_par.regs
+#define DBE_REG_BASE default_par->regs
 #include <video/sgivw.h>
 
 struct sgivw_par {
@@ -44,9 +44,9 @@
 extern unsigned long sgivwfb_mem_phys;
 extern unsigned long sgivwfb_mem_size;
 
-static struct sgivw_par default_par;
+static struct sgivw_par *default_par;
 static u32 pseudo_palette[17];
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 static int ypan = 0;
 static int ywrap = 0;
 
@@ -118,6 +118,7 @@
 			     struct fb_info *info);
 static int sgivwfb_mmap(struct fb_info *info, struct file *file,
 			struct vm_area_struct *vma);
+static void release_sgivwfb(struct fb_info *info);
 
 static struct fb_ops sgivwfb_ops = {
 	.owner		= THIS_MODULE,
@@ -756,12 +757,21 @@
 {
 	char *monitor;
 
+	fb_info = framebuffer_alloc(sizeof(*default_par), NULL);
+	if (!fb_info) {
+		printk(KERN_ERR "sgivwfb: cannot allocate memory\n");
+		return -ENOMEM;
+	}
+	fb_info->release = &release_sgivwfb;
+	default_par = fb_info->par;
+
 	if (!request_mem_region(DBE_REG_PHYS, DBE_REG_SIZE, "sgivwfb")) {
 		printk(KERN_ERR "sgivwfb: couldn't reserve mmio region\n");
+		goto fail_framebuffer_alloc;
 		return -EBUSY;
 	}
-	default_par.regs = (struct asregs *) ioremap_nocache(DBE_REG_PHYS, DBE_REG_SIZE);
-	if (!default_par.regs) {
+	default_par->regs = (struct asregs *) ioremap_nocache(DBE_REG_PHYS, DBE_REG_SIZE);
+	if (!default_par->regs) {
 		printk(KERN_ERR "sgivwfb: couldn't ioremap registers\n");
 		goto fail_ioremap_regs;
 	}
@@ -773,51 +783,59 @@
 	sgivwfb_fix.ywrapstep = ywrap;
 	sgivwfb_fix.ypanstep = ypan;
 
-	fb_info.fix = sgivwfb_fix;
+	fb_info->fix = sgivwfb_fix;
 
 	switch (flatpanel_id) {
 		case FLATPANEL_SGI_1600SW:
-			fb_info.var = sgivwfb_var1600sw;
+			fb_info->var = sgivwfb_var1600sw;
 			monitor = "SGI 1600SW flatpanel";
 			break;
 		default:
-			fb_info.var = sgivwfb_var;
+			fb_info->var = sgivwfb_var;
 			monitor = "CRT";
 	}
 
 	printk(KERN_INFO "sgivwfb: %s monitor selected\n", monitor);
 
-	fb_info.fbops = &sgivwfb_ops;
-	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.par = &default_par;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->fbops = &sgivwfb_ops;
+	fb_info->pseudo_palette = pseudo_palette;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_info.screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
-	if (!fb_info.screen_base) {
+	fb_info->screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
+	if (!fb_info->screen_base) {
 		printk(KERN_ERR "sgivwfb: couldn't ioremap screen_base\n");
 		goto fail_ioremap_fbmem;
 	}
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(fb_info) < 0) {
 		printk(KERN_ERR "sgivwfb: couldn't register framebuffer\n");
 		goto fail_register_framebuffer;
 	}
 
 	printk(KERN_INFO "fb%d: SGI DBE frame buffer device, using %ldK of video memory at %#lx\n",      
-		fb_info.node, sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
+		fb_info->node, sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
 	return 0;
 
 fail_register_framebuffer:
-	iounmap((char *) fb_info.screen_base);
+	iounmap((char *) fb_info->screen_base);
 fail_ioremap_fbmem:
-	iounmap(default_par.regs);
+	iounmap(default_par->regs);
 fail_ioremap_regs:
 	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+fail_framebuffer_alloc:
+	kfree(fb_info);
 	return -ENXIO;
 }
 
+static void release_sgivwfb(struct fb_info *info) {
+	dbe_TurnOffDma();
+	iounmap(default_par->regs);
+	iounmap(info->screen_base);
+	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+}
+
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
@@ -828,11 +846,7 @@
 
 void cleanup_module(void)
 {
-	unregister_framebuffer(&fb_info);
-	dbe_TurnOffDma();
-	iounmap(regs);
-	iounmap(&fb_info.screen_base);
-	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+	unregister_framebuffer(fb_info);
 }
 
 #endif				/* MODULE */


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
