From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] imsttfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:15:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201541.GS16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzm1-0006pt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:37 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzm0-0005C4-F1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:36 -0700
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
To: lethal@chaoticdreams.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/imsttfb.c to framebuffer_alloc:

======== drivers/video/imsttfb.c 1.32 ========
D 1.32 03/09/13 23:44:31+02:00 kronos@kronoz.cjb.net 35 34 18/15/1588
P drivers/video/imsttfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/imsttfb.c 1.31 vs 1.32 =====
--- 1.31/drivers/video/imsttfb.c	Fri Aug 22 08:27:08 2003
+++ 1.32/drivers/video/imsttfb.c	Sat Sep 13 23:44:31 2003
@@ -402,6 +402,7 @@
  */
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void imsttfb_remove(struct pci_dev *pdev);
+static void release_imstt_par(struct fb_info *info);
 
 /*
  * Register access
@@ -1442,7 +1443,6 @@
 
 	info->fbops = &imsttfb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
-	info->dev = &pdev->dev;
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
@@ -1463,19 +1463,16 @@
 	struct imstt_par *par;
 	struct fb_info *info;
 
-	size = sizeof(struct fb_info) + sizeof(struct imstt_par) +
-		sizeof(u32) * 16;
+	size = sizeof(struct imstt_par) + sizeof(u32) * 16;
 
-	info = kmalloc(size, GFP_KERNEL);
+	info = framebuffer_alloc(size, &pdev->dev);
 
 	if (!info) {
 		printk(KERN_ERR "imsttfb: Can't allocate memory\n");
 		return -ENOMEM;
 	}
 
-	memset(info, 0, size);
-
-	par = (struct imstt_par *) (info + 1);
+	par = info->par;
 
 	addr = pci_resource_start (pdev, 0);
 	size = pci_resource_len (pdev, 0);
@@ -1507,7 +1504,7 @@
 	par->dc_regs = (__u32 *)ioremap(addr + 0x800000, 0x1000);
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
-	info->par = par;
+	info->release = &release_imstt_par;
 	info->pseudo_palette = (void *) (par + 1);
 	init_imstt(info, pdev);
 
@@ -1515,19 +1512,25 @@
 	return 0;
 }
 
+static void release_imstt_par(struct fb_info *info) {
+	struct imstt_par *par = info->par;
+	struct pci_dev *pdev = to_pci_dev(info->class_dev.dev);
+	int size = pci_resource_len(pdev, 0);
+	
+	iounmap(par->cmap_regs);
+	iounmap(par->dc_regs);
+	iounmap(info->screen_base);
+	release_mem_region(info->fix.smem_start, size);
+}
+
 static void __devexit
 imsttfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
-	struct imstt_par *par = (struct imstt_par *) info->par;
-	int size = pci_resource_len(pdev, 0);
 
 	unregister_framebuffer(info);
-	iounmap(par->cmap_regs);
-	iounmap(par->dc_regs);
-	iounmap(info->screen_base);
-	release_mem_region(info->fix.smem_start, size);
-	kfree(info);
+
+	pci_set_drvdata(pdev, NULL);
 }
 
 #ifndef MODULE


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
