From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Re: Devices don't get linked to their class.
Date: Wed, 8 Sep 2004 08:55:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409080855.34209.adaplas@hotpop.com>
References: <1094187751.2979.41.camel@laptop.cunninghams> <1094441896.19674.24.camel@laptop.cunninghams> <20040907195055.GB6021@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4qks-0007GY-GO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 17:56:10 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4qkr-0006qk-2o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 17:56:10 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9856D7F1063
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  8 Sep 2004 00:56:01 +0000 (UTC)
In-Reply-To: <20040907195055.GB6021@dreamland.darkstar.lan>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Kronos <kronos@people.it>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>

On Wednesday 08 September 2004 03:50, Kronos wrote:
> Il Mon, Sep 06, 2004 at 01:38:16PM +1000, Nigel Cunningham ha scritto:
> > On Sun, 2004-09-05 at 20:40, Antonino A. Daplas wrote:
> > > Frankly, I don't know a thing about this stuff.  Just let me know what
> > > you need and where you need them, and I'll see what I can do.
> >
> > It did turn out to just need the dev parameter to be non null. I've gone
> > through all the frame buffer drivers and done what I believe to be the
> > right thing; if they're PCI based, they get the struct device pointer
> > passed through, otherwise NULL is sent.
> >
> > The attached patch is against 2.6.9-rc1, and (combined with other code)
> > allows the driver to remain active while we're suspending to disk.
>
> There's framebuffer_alloc for that. I forgot to re-add a struct device *
> to fb_info after I added the class_simple stuff:
>

Hey, nice!

Nigel, here's an updated patch.  For drivers already using
framebuffer_alloc(), we let them be.  For the rest, some I updated to use
framebuffer_alloc(), rivafb and i810fb, and the remainder, set info->device
during the initialization stage.

I'll push this to Andrew at the end of the week, I'll just let the previous
patches I submitted simmer in his tree first.

You need to reverse the patch I sent you.  You'll probably get offsets.

Tony

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c	2004-09-08 08:09:41.726436928 +0800
@@ -1976,7 +1976,7 @@ int __init atyfb_init(void)
 
 			info->fix = atyfb_fix;
 			info->par = default_par;
-
+			info->device = &pdev->dev;
 #ifdef __sparc__
 			/*
 			 * Map memory-mapped registers.
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c	2004-09-08 08:09:41.730436320 +0800
@@ -416,7 +416,7 @@ chipsfb_pci_init(struct pci_dev *dp, con
 		release_mem_region(addr, size);
 		return -ENOMEM;
 	}
-
+	p->device = &dp->dev;
 	init_chips(p, addr);
 
 #ifdef CONFIG_PMAC_PBOOK
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c	2004-09-08 08:09:41.734435712 +0800
@@ -1399,6 +1399,8 @@ static int __devinit cyberpro_common_pro
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
+	if (cfb->dev)
+		cfb->fb.device = &cfb->dev->dev;
 	err = register_framebuffer(&cfb->fb);
 
 failed:
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-08 08:07:14.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-08 08:09:41.737435256 +0800
@@ -1131,7 +1131,8 @@ register_framebuffer(struct fb_info *fb_
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+				    fb_info->device, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbsysfs.c linux-2.6.9-rc1-mm4/drivers/video/fbsysfs.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbsysfs.c	2004-05-10 10:33:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbsysfs.c	2004-09-08 07:55:49.000000000 +0800
@@ -51,6 +51,8 @@ struct fb_info *framebuffer_alloc(size_t
 	if (size)
 		info->par = p + fb_info_size;
 
+	info->device = dev;
+
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c	2004-09-08 08:06:47.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c	2004-09-08 08:14:48.112859112 +0800
@@ -1855,20 +1855,13 @@ static int __devinit i810fb_init_pci (st
 	int i, err = -1, vfreq, hfreq, pixclock;
 
 	i = 0;
-	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
-		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(struct fb_info));
-
-	if(!(par = kmalloc(sizeof(struct i810fb_par), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
+
+	info = framebuffer_alloc(sizeof(struct i810fb_par), &dev->dev);
+	if (!info)
 		return -ENOMEM;
-	}
-	memset(par, 0, sizeof(struct i810fb_par));
 
+	par = (struct i810fb_par *) info->par;
 	par->dev = dev;
-	info->par = par;
 
 	if (!(info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
@@ -1941,38 +1934,36 @@ static int __devinit i810fb_init_pci (st
 static void i810fb_release_resource(struct fb_info *info, 
 				    struct i810fb_par *par)
 {
-	if (par) {
-		unset_mtrr(par);
-		if (par->drm_agp) {
-			drm_agp_t *agp = par->drm_agp;
-			struct gtt_data *gtt = &par->i810_gtt;
-
-			if (par->i810_gtt.i810_cursor_memory) 
-				agp->free_memory(gtt->i810_cursor_memory);
-			if (par->i810_gtt.i810_fb_memory) 
-				agp->free_memory(gtt->i810_fb_memory);
-
-			inter_module_put("drm_agp");
-			par->drm_agp = NULL;
-		}
-
-		if (par->mmio_start_virtual) 
-			iounmap(par->mmio_start_virtual);
-		if (par->aperture.virtual) 
-			iounmap(par->aperture.virtual);
-
-		if (par->res_flags & FRAMEBUFFER_REQ)
-			release_mem_region(par->aperture.physical, 
-					   par->aperture.size);
-		if (par->res_flags & MMIO_REQ)
-			release_mem_region(par->mmio_start_phys, MMIO_SIZE);
+	unset_mtrr(par);
+	if (par->drm_agp) {
+		drm_agp_t *agp = par->drm_agp;
+		struct gtt_data *gtt = &par->i810_gtt;
+
+		if (par->i810_gtt.i810_cursor_memory)
+			agp->free_memory(gtt->i810_cursor_memory);
+		if (par->i810_gtt.i810_fb_memory)
+			agp->free_memory(gtt->i810_fb_memory);
+
+		inter_module_put("drm_agp");
+		par->drm_agp = NULL;
+	}
+
+	if (par->mmio_start_virtual)
+		iounmap(par->mmio_start_virtual);
+	if (par->aperture.virtual)
+		iounmap(par->aperture.virtual);
+
+	if (par->res_flags & FRAMEBUFFER_REQ)
+		release_mem_region(par->aperture.physical,
+				   par->aperture.size);
+	if (par->res_flags & MMIO_REQ)
+		release_mem_region(par->mmio_start_phys, MMIO_SIZE);
+
+	if (par->res_flags & PCI_DEVICE_ENABLED)
+		pci_disable_device(par->dev);
+
+	framebuffer_release(info);
 
-		if (par->res_flags & PCI_DEVICE_ENABLED)
-			pci_disable_device(par->dev); 
-
-		kfree(par);
-	}
-	kfree(info);
 }
 
 static void __exit i810fb_remove_pci(struct pci_dev *dev)
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c linux-2.6.9-rc1-mm4/drivers/video/igafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/igafb.c	2004-09-08 08:09:41.740434800 +0800
@@ -528,6 +528,7 @@ int __init igafb_init(void)
 	info->var = default_var;
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
+	info->device = &pdev->dev;
 
 	if (!iga_init(info, par)) {
 		iounmap((void *)par->io_base);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c	2004-09-08 08:09:41.741434648 +0800
@@ -1524,6 +1524,7 @@ imsttfb_probe(struct pci_dev *pdev, cons
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
+	info->device = &pdev->dev;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c	2004-09-08 08:09:41.742434496 +0800
@@ -735,6 +735,7 @@ static int __devinit kyrofb_probe(struct
 
 	fb_memset(info->screen_base, 0, size);
 
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c	2004-09-08 08:09:41.744434192 +0800
@@ -1864,6 +1864,7 @@ static int initMatrox2(WPMINFO struct bo
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
+	ACCESS_FBINFO(fbcon).device = &ACCESS_FBINFO(pcidev)->dev;
 	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
 		goto failVideoIO;
 	}
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c	2004-09-08 08:09:41.750433280 +0800
@@ -939,6 +939,7 @@ static int __devinit pvr2fb_pci_probe(st
 
 	pvr2_fix.mmio_start	= pci_resource_start(pdev, 1);
 	pvr2_fix.mmio_len	= pci_resource_len(pdev, 1);
+	fbinfo->device = &pdev->dev;
 
 	return pvr2fb_common_init();
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c	2004-09-08 08:09:41.753432824 +0800
@@ -3040,7 +3040,7 @@ static int radeonfb_pci_register (struct
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
-
+	((struct fb_info *) rinfo)->device = &pdev->dev;
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c	2004-09-08 08:07:00.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c	2004-09-08 08:14:37.618454504 +0800
@@ -1858,21 +1858,17 @@ static int __devinit rivafb_probe(struct
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	info = kmalloc(sizeof(struct fb_info), GFP_KERNEL);
+	info = framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
+
 	if (!info)
 		goto err_out;
 
-	default_par = kmalloc(sizeof(struct riva_par), GFP_KERNEL);
-	if (!default_par)
-		goto err_out_kfree;
-
-	memset(info, 0, sizeof(struct fb_info));
-	memset(default_par, 0, sizeof(struct riva_par));
+	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL)
-		goto err_out_kfree1;
+		goto err_out_kfree;
 	memset(info->pixmap.addr, 0, 64 * 1024);
 
 	if (pci_enable_device(pd)) {
@@ -1896,7 +1892,7 @@ static int __devinit rivafb_probe(struct
 
 	if(default_par->riva.Architecture == 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_kfree1;
+		goto err_out_free_base0;
 	}
 	if(default_par->riva.Architecture == NV_ARCH_10 ||
 	   default_par->riva.Architecture == NV_ARCH_20 ||
@@ -2001,7 +1997,6 @@ static int __devinit rivafb_probe(struct
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb_len = 0;
 	info->monspecs.modedb = NULL;
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
@@ -2040,10 +2035,8 @@ err_out_request:
 	pci_disable_device(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
-err_out_kfree1:
-	kfree(default_par);
 err_out_kfree:
-	kfree(info);
+	framebuffer_release(info);
 err_out:
 	return -ENODEV;
 }
@@ -2077,8 +2070,7 @@ static void __exit rivafb_remove(struct 
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
-	kfree(par);
-	kfree(info);
+	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c linux-2.6.9-rc1-mm4/drivers/video/sstfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sstfb.c	2004-09-08 08:09:41.764431152 +0800
@@ -1507,6 +1507,7 @@ static int __devinit sstfb_probe(struct 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* register fb */
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0) {
 		eprintk("can't register framebuffer.\n");
 		goto fail;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c linux-2.6.9-rc1-mm4/drivers/video/tgafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tgafb.c	2004-09-08 08:09:41.767430696 +0800
@@ -1454,6 +1454,7 @@ tgafb_pci_register(struct pci_dev *pdev,
 	tgafb_set_par(&all->info);
 	tgafb_init_fix(&all->info);
 
+	all->info.device = &pdev->dev;
 	if (register_framebuffer(&all->info) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c	2004-09-08 06:01:03.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c	2004-09-08 08:09:41.769430392 +0800
@@ -1164,6 +1164,7 @@ static int __devinit trident_pci_probe(s
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
+	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/include/linux/fb.h
--- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-08 08:07:00.000000000 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-08 08:09:41.772429936 +0800
@@ -602,6 +602,7 @@ struct fb_info {
 	struct fb_cmap cmap;		/* Current cmap */
 	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
+	struct device *device;
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
