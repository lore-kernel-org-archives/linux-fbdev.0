From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] sstfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:47:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204709.GC23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0GS-0000ov-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:48:04 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0GR-00014R-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:48:04 -0700
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
To: gtoumi@laposte.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/sstfb.c to framebuffer_alloc:

======== drivers/video/sstfb.c 1.30 ========
D 1.30 03/09/14 18:08:47+02:00 kronos@kronoz.cjb.net 34 33 20/22/1695
P drivers/video/sstfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/sstfb.c 1.29 vs 1.30 =====
--- 1.29/drivers/video/sstfb.c	Fri Sep  5 00:20:13 2003
+++ 1.30/drivers/video/sstfb.c	Sun Sep 14 18:08:47 2003
@@ -117,6 +117,8 @@
 	ID_VOODOO2 = 1,
 };
 
+static void release_sstfb(struct fb_info *info);
+
 #define IS_VOODOO2(par) ((par)->type == ID_VOODOO2)
 
 static struct sst_spec voodoo_spec[] __devinitdata = {
@@ -1399,12 +1401,6 @@
 	struct sst_spec *spec;
 	int err;
 
-	struct all_info {
-		struct fb_info info;
-		struct sstfb_par par;
-		u32 pseudo_palette[16];
-	} *all;
-	
 	/* Enable device in PCI config. */
 	if ((err=pci_enable_device(pdev))) {
 		eprintk("cannot enable device\n");
@@ -1412,14 +1408,14 @@
 	}
 
 	/* Allocate the fb and par structures.  */
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
+	info = framebuffer_alloc(sizeof(struct sstfb_par) + 32 * 16,
+			&pdev->dev);
+	if (!info)
 		return -ENOMEM;
-	memset(all, 0, sizeof(*all));
-	pci_set_drvdata(pdev, all);
-	
-	info = &all->info;
-	par  = info->par = &all->par;
+	pci_set_drvdata(pdev, info);
+
+	info->release = &release_sstfb;
+	par  = info->par;
 	fix  = &info->fix;
 	
 	par->type = id->driver_data;
@@ -1476,8 +1472,7 @@
 
 	info->flags	= FBINFO_FLAG_DEFAULT;
 	info->fbops	= &sstfb_ops;
-	info->pseudo_palette = &all->pseudo_palette;
-	info->dev	= &pdev->dev;
+	info->pseudo_palette = (par + 1);
 
 	fix->type	= FB_TYPE_PACKED_PIXELS;
 	fix->visual	= FB_VISUAL_TRUECOLOR;
@@ -1536,21 +1531,24 @@
 	return -ENXIO; 	/* no voodoo detected */
 }
 
+static void release_sstfb(struct fb_info *info) {
+	struct sstfb_par *par = info->par;
+	
+	iounmap(info->screen_base);
+	iounmap((void*)par->mmio_vbase);
+	release_mem_region(info->fix.smem_start, 0x400000);
+	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
+}
+
 static void __devexit sstfb_remove(struct pci_dev *pdev)
 {
-	struct sstfb_par *par;
 	struct fb_info *info;
 
 	info = pci_get_drvdata(pdev);
-	par = (struct sstfb_par *) info->par;
 	
 	sst_shutdown(info);
 	unregister_framebuffer(info);
-	iounmap(info->screen_base);
-	iounmap((void*)par->mmio_vbase);
-	release_mem_region(info->fix.smem_start, 0x400000);
-	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
-	kfree(info);
+	pci_set_drvdata(pdev, NULL);
 }
 
 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
