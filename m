From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] aty: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:36:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915193649.GE16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzAL-0003Ra-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:37:41 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzAK-0001jm-E0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:37:40 -0700
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
To: brad@neruo.com, geert@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/aty to framebuffer_alloc:

======== drivers/video/aty/aty128fb.c 1.41 ========
D 1.41 03/09/13 00:35:43+02:00 kronos@kronoz.cjb.net 52 51 23/19/2333
P drivers/video/aty/aty128fb.c
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/aty/aty128fb.c 1.40 vs 1.41 =====
--- 1.40/drivers/video/aty/aty128fb.c	Fri Aug 22 08:27:08 2003
+++ 1.41/drivers/video/aty/aty128fb.c	Sat Sep 13 00:35:43 2003
@@ -362,6 +362,7 @@
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, struct fb_info *info);
 static int aty128fb_sync(struct fb_info *info);
+static void release_aty128fb(struct fb_info *info);
 
     /*
      *  Internal routines
@@ -1536,7 +1537,6 @@
 	/* fill in info */
 	info->fbops = &aty128fb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
-	info->dev = &pdev->dev;
 
 #ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
@@ -1677,16 +1677,14 @@
 
 	/* We have the resources. Now virtualize them */
 	size = sizeof(struct fb_info) + sizeof(struct aty128fb_par);
-	if (!(info = kmalloc(size, GFP_ATOMIC))) {
+	if (!(info = framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->dev))) {
 		printk(KERN_ERR "aty128fb: can't alloc fb_info_aty128\n");
 		goto err_free_mmio;
 	}
-	memset(info, 0, size);
-
-	par = (struct aty128fb_par *)(info + 1);
+	info->release = &release_aty128fb;
+	par = info->par;
 	info->pseudo_palette = par->pseudo_palette;
 
-	info->par = par;
 	info->fix = aty128fb_fix;
 
 	/* Virtualize mmio region */
@@ -1758,15 +1756,9 @@
 	return -ENODEV;
 }
 
-static void __devexit aty128_remove(struct pci_dev *pdev)
-{
-	struct fb_info *info = pci_get_drvdata(pdev);
+static void release_aty128fb(struct fb_info *info) {
 	struct aty128fb_par *par = info->par;
-
-	if (!info)
-		return;
-
-	unregister_framebuffer(info);
+	
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)
 		mtrr_del(par->mtrr.vram, info->fix.smem_start,
@@ -1775,17 +1767,29 @@
 	iounmap(par->regbase);
 	iounmap(info->screen_base);
 
+#ifdef CONFIG_PMAC_PBOOK
+	if (info == aty128_fb)
+		aty128_fb = NULL;
+#endif
+}
+
+static void __devexit aty128_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+
+	if (!info)
+		return;
+
+	unregister_framebuffer(info);
+	
 	release_mem_region(pci_resource_start(pdev, 0),
 			   pci_resource_len(pdev, 0));
 	release_mem_region(pci_resource_start(pdev, 1),
 			   pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 2),
 			   pci_resource_len(pdev, 2));
-#ifdef CONFIG_PMAC_PBOOK
-	if (info == aty128_fb)
-		aty128_fb = NULL;
-#endif
-	kfree(info);
+
+	pci_set_drvdata(pdev, NULL);
 }
 #endif /* CONFIG_PCI */


======== drivers/video/aty/atyfb_base.c 1.59 ========
D 1.59 03/09/13 00:37:36+02:00 kronos@kronoz.cjb.net 70 69 22/38/2575
P drivers/video/aty/atyfb_base.c
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/aty/atyfb_base.c 1.58 vs 1.59 =====
--- 1.58/drivers/video/aty/atyfb_base.c	Mon May 26 02:00:00 2003
+++ 1.59/drivers/video/aty/atyfb_base.c	Sat Sep 13 00:37:36 2003
@@ -162,6 +162,7 @@
      */
 
 static int aty_init(struct fb_info *info, const char *name);
+static void release_atyfb(struct fb_info *info);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -1941,27 +1942,17 @@
 			if (i < 0)
 				continue;
 
-			info =
-			    kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
+			info = framebuffer_alloc(sizeof(struct atyfb_par), &pdev->dev);
 			if (!info) {
 				printk
 				    ("atyfb_init: can't alloc fb_info\n");
 				return -ENXIO;
 			}
-			memset(info, 0, sizeof(struct fb_info));
+			info->release = &release_atyfb;
 
-			default_par =
-			    kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
-			if (!default_par) {
-				printk
-				    ("atyfb_init: can't alloc atyfb_par\n");
-				kfree(info);
-				return -ENXIO;
-			}
-			memset(default_par, 0, sizeof(struct atyfb_par));
+			default_par = info->par;
 
 			info->fix = atyfb_fix;
-			info->par = default_par;
 
 			rp = &pdev->resource[0];
 			if (rp->flags & IORESOURCE_IO)
@@ -2220,7 +2211,6 @@
 			    ioremap(info->fix.mmio_start, 0x1000);
 
 			if (!default_par->ati_regbase) {
-				kfree(default_par);
 				kfree(info);
 				release_mem_region(res_start, res_size);
 				return -ENOMEM;
@@ -2312,21 +2302,13 @@
 			continue;
 		}
 
-		info = kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
+		info = framebuffer_alloc(sizeof(struct atyfb_par), NULL);
 		if (!info) {
 			printk("atyfb_init: can't alloc fb_info\n");
 			return -ENOMEM;
 		}
-		memset(info, 0, sizeof(struct fb_info));
-
-		default_par = kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
-		if (!default_par) {
-			printk
-			    ("atyfb_init: can't alloc atyfb_par\n");
-			kfree(info);
-			return -ENXIO;
-		}
-		memset(default_par, 0, sizeof(struct atyfb_par));
+		info->release = &release_atyfb;
+		default_par = info->par;
 
 		info->fix = atyfb_fix;
 
@@ -2577,18 +2559,8 @@
 	return 0;
 }
 
-#ifdef MODULE
-int __init init_module(void)
-{
-	atyfb_init();
-	return fb_list ? 0 : -ENXIO;
-}
-
-void cleanup_module(void)
-{
-	struct fb_info *info = fb_list;
-	struct atyfb_par *par = (struct atyfb_par *) info->par;		
-	unregister_framebuffer(info);
+static void release_atyfb(struct fb_info *info) {
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
 #ifndef __sparc__
 	if (par->ati_regbase)
@@ -2606,7 +2578,19 @@
 	if (par->mmap_map)
 		kfree(par->mmap_map);
 #endif
-	kfree(info);
+}
+
+#ifdef MODULE
+int __init init_module(void)
+{
+	atyfb_init();
+	return fb_list ? 0 : -ENXIO;
+}
+
+void cleanup_module(void)
+{
+	struct fb_info *info = fb_list;
+	unregister_framebuffer(info);
 }
 
 #endif

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
