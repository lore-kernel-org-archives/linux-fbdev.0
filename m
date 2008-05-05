From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/8] tridentfb: convert fb_info into
	allocated one
Date: Mon, 5 May 2008 18:52:53 +0200
Message-ID: <20080505185253.a7d89a64.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt3w0-00078X-Ux for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:53:05 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt3vx-0004lp-Ha
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:53:04 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch converts fb_info structure from global
variable to allocatable one.
The global default_par is moved into function variable.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-03 03:58:41.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-03 03:59:30.000000000 +0200
@@ -33,10 +33,7 @@ struct tridentfb_par {
 static unsigned char eng_oper;	/* engine operation... */
 static struct fb_ops tridentfb_ops;
 
-static struct tridentfb_par default_par;
-
 /* FIXME:kmalloc these 3 instead */
-static struct fb_info fb_info;
 static u32 pseudo_pal[16];
 
 static struct fb_var_screeninfo default_var;
@@ -1217,16 +1214,23 @@ static struct fb_ops tridentfb_ops = {
 	.fb_imageblit = cfb_imageblit,
 };
 
-static int __devinit trident_pci_probe(struct pci_dev * dev,
-				       const struct pci_device_id * id)
+static int __devinit trident_pci_probe(struct pci_dev *dev,
+				       const struct pci_device_id *id)
 {
 	int err;
 	unsigned char revision;
+	struct fb_info *info;
+	struct tridentfb_par *default_par;
 
 	err = pci_enable_device(dev);
 	if (err)
 		return err;
 
+	info = framebuffer_alloc(sizeof(struct tridentfb_par), &dev->dev);
+	if (!info)
+		return -ENOMEM;
+	default_par = info->par;
+
 	chip_id = id->device;
 
 	if (chip_id == CYBERBLADEi1)
@@ -1282,8 +1286,6 @@ static int __devinit trident_pci_probe(s
 	/* acceleration is on by default for 3D chips */
 	defaultaccel = chip3D && !noaccel;
 
-	fb_info.par = &default_par;
-
 	/* setup MMIO region */
 	tridentfb_fix.mmio_start = pci_resource_start(dev, 1);
 	tridentfb_fix.mmio_len = chip3D ? 0x20000 : 0x10000;
@@ -1293,9 +1295,10 @@ static int __devinit trident_pci_probe(s
 		return -1;
 	}
 
-	default_par.io_virt = ioremap_nocache(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	default_par->io_virt = ioremap_nocache(tridentfb_fix.mmio_start,
+					       tridentfb_fix.mmio_len);
 
-	if (!default_par.io_virt) {
+	if (!default_par->io_virt) {
 		debug("ioremap failed\n");
 		err = -1;
 		goto out_unmap1;
@@ -1305,46 +1308,46 @@ static int __devinit trident_pci_probe(s
 
 	/* setup framebuffer memory */
 	tridentfb_fix.smem_start = pci_resource_start(dev, 0);
-	tridentfb_fix.smem_len = get_memsize(&default_par);
+	tridentfb_fix.smem_len = get_memsize(default_par);
 
 	if (!request_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
-		disable_mmio(fb_info.par);
+		disable_mmio(info->par);
 		err = -1;
 		goto out_unmap1;
 	}
 
-	fb_info.screen_base = ioremap_nocache(tridentfb_fix.smem_start,
-					      tridentfb_fix.smem_len);
+	info->screen_base = ioremap_nocache(tridentfb_fix.smem_start,
+					    tridentfb_fix.smem_len);
 
-	if (!fb_info.screen_base) {
+	if (!info->screen_base) {
 		debug("ioremap failed\n");
 		err = -1;
 		goto out_unmap2;
 	}
 
 	output("%s board found\n", pci_name(dev));
-	displaytype = get_displaytype(&default_par);
+	displaytype = get_displaytype(default_par);
 
 	if (flatpanel)
-		nativex = get_nativex(&default_par);
+		nativex = get_nativex(default_par);
 
-	fb_info.fix = tridentfb_fix;
-	fb_info.fbops = &tridentfb_ops;
+	info->fix = tridentfb_fix;
+	info->fbops = &tridentfb_ops;
 
 
-	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_TRIDENT_ACCEL
-	fb_info.flags |= FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
+	info->flags |= FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
 #endif
-	fb_info.pseudo_palette = pseudo_pal;
+	info->pseudo_palette = pseudo_pal;
 
-	if (!fb_find_mode(&default_var, &fb_info,
+	if (!fb_find_mode(&default_var, info,
 			  mode_option, NULL, 0, NULL, bpp)) {
 		err = -EINVAL;
 		goto out_unmap2;
 	}
-	err = fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0)
 		goto out_unmap2;
 
@@ -1353,39 +1356,46 @@ static int __devinit trident_pci_probe(s
 	else
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
-	fb_info.var = default_var;
-	fb_info.device = &dev->dev;
-	if (register_framebuffer(&fb_info) < 0) {
+	info->var = default_var;
+	info->device = &dev->dev;
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
-		fb_dealloc_cmap(&fb_info.cmap);
+		fb_dealloc_cmap(&info->cmap);
 		err = -EINVAL;
 		goto out_unmap2;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
-	   fb_info.node, fb_info.fix.id, default_var.xres,
+	   info->node, info->fix.id, default_var.xres,
 	   default_var.yres, default_var.bits_per_pixel);
+
+	pci_set_drvdata(dev, info);
 	return 0;
 
 out_unmap2:
-	if (fb_info.screen_base)
-		iounmap(fb_info.screen_base);
+	if (info->screen_base)
+		iounmap(info->screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-	disable_mmio(fb_info.par);
+	disable_mmio(info->par);
 out_unmap1:
-	if (default_par.io_virt)
-		iounmap(default_par.io_virt);
+	if (default_par->io_virt)
+		iounmap(default_par->io_virt);
 	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	framebuffer_release(info);
 	return err;
 }
 
 static void __devexit trident_pci_remove(struct pci_dev *dev)
 {
-	struct tridentfb_par *par = (struct tridentfb_par*)fb_info.par;
-	unregister_framebuffer(&fb_info);
+	struct fb_info *info = pci_get_drvdata(dev);
+	struct tridentfb_par *par = info->par;
+
+	unregister_framebuffer(info);
 	iounmap(par->io_virt);
-	iounmap(fb_info.screen_base);
+	iounmap(info->screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	pci_set_drvdata(dev, NULL);
+	framebuffer_release(info);
 }
 
 /* List of boards that we are trying to support */

----------------------------------------------------------------------
Poprowadz swoj klub do zwyciestwa!
Sprawdz >>> http://link.interia.pl/f1d76


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
