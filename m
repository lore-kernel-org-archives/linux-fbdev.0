From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: [PATCH] Re: Devices don't get linked to their
	class.
Date: Mon, 06 Sep 2004 13:38:16 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094441896.19674.24.camel@laptop.cunninghams>
References: <1094187751.2979.41.camel@laptop.cunninghams>
	 <200409042041.55199.adaplas@hotpop.com>
	 <1094365292.6252.3.camel@laptop.cunninghams>
	 <200409051840.27452.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Is0i3yDGagrCBmFpkgMT"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4ANb-00071N-Dr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 20:41:19 -0700
Received: from relay01.kbs.net.au ([203.220.32.149] ident=8)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4ANY-0006WV-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 20:41:19 -0700
In-Reply-To: <200409051840.27452.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net


--=-Is0i3yDGagrCBmFpkgMT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sun, 2004-09-05 at 20:40, Antonino A. Daplas wrote:
> Frankly, I don't know a thing about this stuff.  Just let me know what you
> need and where you need them, and I'll see what I can do.

It did turn out to just need the dev parameter to be non null. I've gone
through all the frame buffer drivers and done what I believe to be the
right thing; if they're PCI based, they get the struct device pointer
passed through, otherwise NULL is sent.

The attached patch is against 2.6.9-rc1, and (combined with other code)
allows the driver to remain active while we're suspending to disk.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

--=-Is0i3yDGagrCBmFpkgMT
Content-Disposition: attachment; filename=drivers-video-device-class-support.patch
Content-Type: text/x-patch; name=drivers-video-device-class-support.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.6.9-rc1/drivers/video/68328fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/68328fb.c
--- linux-2.6.9-rc1/drivers/video/68328fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/68328fb.c	2004-09-06 13:11:51.266503032 +1000
@@ -470,7 +470,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		return -EINVAL;
 	}
 
diff -ruN linux-2.6.9-rc1/drivers/video/acornfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/acornfb.c
--- linux-2.6.9-rc1/drivers/video/acornfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/acornfb.c	2004-09-06 13:11:51.267502880 +1000
@@ -1451,7 +1451,7 @@
 	if (fb_set_var(&fb_info, &fb_info.var))
 		printk(KERN_ERR "Acornfb: unable to set display parameters\n");
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -EINVAL;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/amba-clcd.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/amba-clcd.c
--- linux-2.6.9-rc1/drivers/video/amba-clcd.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/amba-clcd.c	2004-09-06 13:11:51.267502880 +1000
@@ -396,7 +396,7 @@
         printk(KERN_INFO "CLCD: %s hardware, %s display\n",
                fb->board->name, fb->panel->mode.name);
 
-	ret = register_framebuffer(&fb->fb);
+	ret = register_framebuffer(&fb->fb, NULL);
 	if (ret == 0)
 		goto out;
 
diff -ruN linux-2.6.9-rc1/drivers/video/amifb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/amifb.c
--- linux-2.6.9-rc1/drivers/video/amifb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/amifb.c	2004-09-06 13:11:51.270502424 +1000
@@ -2444,7 +2444,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		err = -EINVAL;
 		goto amifb_error;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/asiliantfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/asiliantfb.c
--- linux-2.6.9-rc1/drivers/video/asiliantfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/asiliantfb.c	2004-09-06 13:11:51.271502272 +1000
@@ -518,7 +518,8 @@
 	.vsync_len 	= 2,
 };
 
-static void __init init_asiliant(struct fb_info *p, unsigned long addr)
+static void __init init_asiliant(struct fb_info *p, unsigned long addr,
+		struct device * dev)
 {
 	p->fix			= asiliantfb_fix;
 	p->fix.smem_start	= addr;
@@ -528,7 +529,7 @@
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
-	if (register_framebuffer(p) < 0) {
+	if (register_framebuffer(p, dev) < 0) {
 		printk(KERN_ERR "C&T 69000 framebuffer failed to register\n");
 		return;
 	}
@@ -573,7 +574,7 @@
 	pci_write_config_dword(dp, 4, 0x02800083);
 	writeb(3, p->screen_base + 0x400784);
 
-	init_asiliant(p, addr);
+	init_asiliant(p, addr, &dp->dev);
 
 	/* Clear the entire framebuffer */
 	memset(p->screen_base, 0, 0x200000);
diff -ruN linux-2.6.9-rc1/drivers/video/atafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/atafb.c
--- linux-2.6.9-rc1/drivers/video/atafb.c	2004-06-18 12:44:12.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/atafb.c	2004-09-06 13:11:51.273501968 +1000
@@ -2806,7 +2806,7 @@
 	atafb_set_disp(-1, &fb_info);
 	do_install_cmap(0, &fb_info);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -EINVAL;
 
 	printk("Determined %dx%d, depth %d\n",
diff -ruN linux-2.6.9-rc1/drivers/video/aty/aty128fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/aty128fb.c
--- linux-2.6.9-rc1/drivers/video/aty/aty128fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/aty128fb.c	2004-09-06 13:11:51.274501816 +1000
@@ -1856,7 +1856,7 @@
 
 	aty128_init_engine(par);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, &pdev->dev) < 0)
 		return 0;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
diff -ruN linux-2.6.9-rc1/drivers/video/aty/atyfb_base.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1/drivers/video/aty/atyfb_base.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/atyfb_base.c	2004-09-06 13:11:51.276501512 +1000
@@ -161,7 +161,8 @@
      *  Internal routines
      */
 
-static int aty_init(struct fb_info *info, const char *name);
+static int aty_init(struct fb_info *info, const char *name,
+		struct device * dev);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -1499,7 +1500,8 @@
 
 static struct fb_info *fb_list = NULL;
 
-static int __init aty_init(struct fb_info *info, const char *name)
+static int __init aty_init(struct fb_info *info, const char *name,
+		struct device * dev)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *chipname = NULL, *ramname = NULL, *xtal;
@@ -1892,7 +1894,7 @@
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, dev) < 0)
 		return 0;
 
 	fb_list = info;
@@ -2261,7 +2263,7 @@
 			}
 #endif				/* __sparc__ */
 
-			if (!aty_init(info, "PCI")) {
+			if (!aty_init(info, "PCI", &pdev->dev)) {
 #ifdef __sparc__	
 				if (default_par->mmap_map)
 					kfree(default_par->mmap_map);
@@ -2366,7 +2368,7 @@
 			break;
 		}
 
-		if (!aty_init(info, "ISA bus")) {
+		if (!aty_init(info, "ISA bus", NULL)) {
 			kfree(default_par);
 			kfree(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
diff -ruN linux-2.6.9-rc1/drivers/video/aty/radeon_base.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/radeon_base.c
--- linux-2.6.9-rc1/drivers/video/aty/radeon_base.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/radeon_base.c	2004-09-06 13:11:51.279501056 +1000
@@ -2326,7 +2326,7 @@
 		printk("radeonfb: Power Management enabled for Mobility chipsets\n");
 	}
 
-	ret = register_framebuffer(info);
+	ret = register_framebuffer(info, &pdev->dev);
 	if (ret < 0) {
 		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
 		goto err_unmap_fb;
diff -ruN linux-2.6.9-rc1/drivers/video/bw2.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/bw2.c
--- linux-2.6.9-rc1/drivers/video/bw2.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/bw2.c	2004-09-06 13:11:51.280500904 +1000
@@ -368,7 +368,7 @@
 
 	bw2_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "bw2: Could not register framebuffer.\n");
 		kfree(all);
 		return;
diff -ruN linux-2.6.9-rc1/drivers/video/cg14.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg14.c
--- linux-2.6.9-rc1/drivers/video/cg14.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg14.c	2004-09-06 13:11:51.282500600 +1000
@@ -565,7 +565,7 @@
 
 	cg14_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "cg14: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/cg3.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg3.c
--- linux-2.6.9-rc1/drivers/video/cg3.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg3.c	2004-09-06 13:11:51.283500448 +1000
@@ -424,7 +424,7 @@
 
 	cg3_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "cg3: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/cg6.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg6.c
--- linux-2.6.9-rc1/drivers/video/cg6.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cg6.c	2004-09-06 13:11:51.284500296 +1000
@@ -740,7 +740,7 @@
 
 	cg6_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "cg6: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/chipsfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/chipsfb.c
--- linux-2.6.9-rc1/drivers/video/chipsfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/chipsfb.c	2004-09-06 13:11:51.285500144 +1000
@@ -354,7 +354,7 @@
 	.vsync_len = 8,
 };
 
-static void __init init_chips(struct fb_info *p, unsigned long addr)
+static void __init init_chips(struct fb_info *p, unsigned long addr, struct device * dev)
 {
 	p->fix = chipsfb_fix;
 	p->fix.smem_start = addr;
@@ -366,7 +366,7 @@
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
-	if (register_framebuffer(p) < 0) {
+	if (register_framebuffer(p, dev) < 0) {
 		printk(KERN_ERR "C&T 65550 framebuffer failed to register\n");
 		return;
 	}
@@ -417,7 +417,7 @@
 		return -ENOMEM;
 	}
 
-	init_chips(p, addr);
+	init_chips(p, addr, &dp->dev);
 
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&chips_sleep_notifier);
diff -ruN linux-2.6.9-rc1/drivers/video/cirrusfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cirrusfb.c
--- linux-2.6.9-rc1/drivers/video/cirrusfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cirrusfb.c	2004-09-06 13:11:51.287499840 +1000
@@ -2296,6 +2296,7 @@
 	struct fb_info *info;
 	int err;
 	cirrusfb_board_t btype;
+	struct device * dev = NULL;
 
 	DPRINTK ("ENTER\n");
 
@@ -2324,7 +2325,10 @@
 	/* set all the vital stuff */
 	cirrusfb_set_fbinfo(cinfo);
 
-	err = register_framebuffer(info);
+	if (cinfo->pdev)
+		dev = &cinfo->pdev->dev;
+	
+	err = register_framebuffer(info, dev);
 	if (err < 0) {
 		printk (KERN_ERR "cirrusfb: could not register fb device; err = %d!\n", err);
 		goto err_dealloc_cmap;
diff -ruN linux-2.6.9-rc1/drivers/video/clps711xfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/clps711xfb.c
--- linux-2.6.9-rc1/drivers/video/clps711xfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/clps711xfb.c	2004-09-06 13:11:51.287499840 +1000
@@ -413,7 +413,7 @@
 		clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
 	}
 
-	err = register_framebuffer(cfb);
+	err = register_framebuffer(cfb, NULL);
 
 out:	return err;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/controlfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/controlfb.c
--- linux-2.6.9-rc1/drivers/video/controlfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/controlfb.c	2004-09-06 13:11:51.288499688 +1000
@@ -480,7 +480,7 @@
 		goto try_again;
 
 	/* Register with fbdev layer */
-	if (register_framebuffer(&p->info) < 0)
+	if (register_framebuffer(&p->info, NULL) < 0)
 		return -ENXIO;
 	
 	printk(KERN_INFO "fb%d: control display adapter\n", p->info.node);	
diff -ruN linux-2.6.9-rc1/drivers/video/cyber2000fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1/drivers/video/cyber2000fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyber2000fb.c	2004-09-06 13:11:51.290499384 +1000
@@ -1342,6 +1342,7 @@
 	u_long smem_size;
 	u_int h_sync, v_sync;
 	int err;
+	struct device * dev = NULL;
 
 	cyberpro_init_hw(cfb);
 
@@ -1399,7 +1400,9 @@
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
-	err = register_framebuffer(&cfb->fb);
+	if (cfb->dev)
+		dev = &cfb->dev->dev;
+	err = register_framebuffer(&cfb->fb, dev);
 
 failed:
 	return err;
diff -ruN linux-2.6.9-rc1/drivers/video/cyberfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyberfb.c
--- linux-2.6.9-rc1/drivers/video/cyberfb.c	2004-06-18 12:44:12.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyberfb.c	2004-09-06 13:11:51.291499232 +1000
@@ -1054,7 +1054,7 @@
 	    cyberfb_set_disp(-1, &fb_info);
 	    do_install_cmap(0, &fb_info);
 
-	    if (register_framebuffer(&fb_info) < 0) {
+	    if (register_framebuffer(&fb_info, NULL) < 0) {
 		    DPRINTK("EXIT - register_framebuffer failed\n");
 		    release_mem_region(CyberMem_phys, 0x400000);
 		    release_mem_region(CyberRegs_phys, 0x10000);
diff -ruN linux-2.6.9-rc1/drivers/video/dnfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/dnfb.c
--- linux-2.6.9-rc1/drivers/video/dnfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/dnfb.c	2004-09-06 13:11:51.292499080 +1000
@@ -250,7 +250,7 @@
 		return err;
 	}
 
-	err = register_framebuffer(info);
+	err = register_framebuffer(info, device);
 	if (err < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
diff -ruN linux-2.6.9-rc1/drivers/video/epson1355fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/epson1355fb.c
--- linux-2.6.9-rc1/drivers/video/epson1355fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/epson1355fb.c	2004-09-06 13:11:51.293498928 +1000
@@ -702,7 +702,7 @@
 	backlight_enable(1);
 	lcd_enable(default_par, 1);
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, NULL) < 0) {
 		rc = -EINVAL;
 		goto bail;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/fbmem.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbmem.c
--- linux-2.6.9-rc1/drivers/video/fbmem.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbmem.c	2004-09-06 13:11:51.294498776 +1000
@@ -1431,7 +1431,7 @@
  */
 
 int
-register_framebuffer(struct fb_info *fb_info)
+register_framebuffer(struct fb_info *fb_info, struct device * dev)
 {
 	int i;
 	struct class_device *c;
@@ -1444,7 +1444,7 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), dev, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
diff -ruN linux-2.6.9-rc1/drivers/video/ffb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/ffb.c
--- linux-2.6.9-rc1/drivers/video/ffb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/ffb.c	2004-09-06 13:11:51.295498624 +1000
@@ -1079,7 +1079,7 @@
 
 	ffb_init_fix(&all->info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "ffb: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/fm2fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fm2fb.c
--- linux-2.6.9-rc1/drivers/video/fm2fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fm2fb.c	2004-09-06 13:11:51.296498472 +1000
@@ -282,7 +282,7 @@
 	info->fix = fb_fix;
 	info->flags = FBINFO_DEFAULT;
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, NULL) < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 		zorro_release_device(z);
diff -ruN linux-2.6.9-rc1/drivers/video/g364fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/g364fb.c
--- linux-2.6.9-rc1/drivers/video/g364fb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/g364fb.c	2004-09-06 13:11:51.296498472 +1000
@@ -245,7 +245,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 255, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -EINVAL;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/gbefb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/gbefb.c
--- linux-2.6.9-rc1/drivers/video/gbefb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/gbefb.c	2004-09-06 13:11:51.297498320 +1000
@@ -1151,7 +1151,7 @@
 	gbefb_encode_fix(&fb_info.fix, &fb_info.var);
 	fb_info.par = &par_current;
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		ret = -ENXIO;
 		printk(KERN_ERR "gbefb: couldn't register framebuffer\n");
 		goto out_gbe_unmap;
diff -ruN linux-2.6.9-rc1/drivers/video/hgafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hgafb.c
--- linux-2.6.9-rc1/drivers/video/hgafb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hgafb.c	2004-09-06 13:11:51.298498168 +1000
@@ -569,7 +569,7 @@
 	fb_info.fbops = &hgafb_ops;
 	fb_info.screen_base = (char *)hga_fix.smem_start;
 
-        if (register_framebuffer(&fb_info) < 0)
+        if (register_framebuffer(&fb_info, NULL) < 0)
                 return -EINVAL;
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
diff -ruN linux-2.6.9-rc1/drivers/video/hitfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hitfb.c
--- linux-2.6.9-rc1/drivers/video/hitfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hitfb.c	2004-09-06 13:11:51.299498016 +1000
@@ -328,7 +328,7 @@
 	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&fb_info.cmap, size, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
diff -ruN linux-2.6.9-rc1/drivers/video/hpfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hpfb.c
--- linux-2.6.9-rc1/drivers/video/hpfb.c	2004-08-30 16:01:10.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/hpfb.c	2004-09-06 13:11:51.299498016 +1000
@@ -158,7 +158,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/i810/i810_main.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1/drivers/video/i810/i810_main.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/i810/i810_main.c	2004-09-06 13:11:51.301497712 +1000
@@ -1905,7 +1905,7 @@
 	encode_fix(&info->fix, info); 
 	 	    
 	i810fb_init_ringbuffer(info);
-	err = register_framebuffer(info);
+	err = register_framebuffer(info, &dev->dev);
 	if (err < 0) {
     		i810fb_release_resource(info, par); 
 		printk("i810fb_init: cannot register framebuffer device\n");
diff -ruN linux-2.6.9-rc1/drivers/video/igafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/igafb.c
--- linux-2.6.9-rc1/drivers/video/igafb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/igafb.c	2004-09-06 13:11:51.302497560 +1000
@@ -332,7 +332,8 @@
 #endif
 };
 
-static int __init iga_init(struct fb_info *info, struct iga_par *par)
+static int __init iga_init(struct fb_info *info, struct iga_par *par,
+		struct device * dev)
 {
         char vramsz = iga_inb(par, IGA_EXT_CNTRL, IGA_IDX_EXT_BUS_CNTL) 
 		                                         & MEM_SIZE_ALIAS;
@@ -361,7 +362,7 @@
 
 	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, dev) < 0)
 		return 0;
 
 	printk("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
@@ -529,7 +530,7 @@
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
 
-	if (!iga_init(info, par)) {
+	if (!iga_init(info, par, &pdev->dev)) {
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
 		if (par->mmap_map)
diff -ruN linux-2.6.9-rc1/drivers/video/imsttfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/imsttfb.c
--- linux-2.6.9-rc1/drivers/video/imsttfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/imsttfb.c	2004-09-06 13:11:51.303497408 +1000
@@ -1349,7 +1349,7 @@
 };
 
 static void __init 
-init_imstt(struct fb_info *info)
+init_imstt(struct fb_info *info, struct device * dev)
 {
 	struct imstt_par *par = (struct imstt_par *) info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1449,7 +1449,7 @@
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, dev) < 0) {
 		kfree(info);
 		return;
 	}
@@ -1524,7 +1524,7 @@
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
-	init_imstt(info);
+	init_imstt(info, &pdev->dev);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
diff -ruN linux-2.6.9-rc1/drivers/video/kyro/fbdev.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1/drivers/video/kyro/fbdev.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/kyro/fbdev.c	2004-09-06 13:11:51.304497256 +1000
@@ -735,7 +735,7 @@
 
 	fb_memset(info->screen_base, 0, size);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, &pdev->dev) < 0)
 		goto out_unmap;
 
 	printk("fb%d: %s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
diff -ruN linux-2.6.9-rc1/drivers/video/leo.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/leo.c
--- linux-2.6.9-rc1/drivers/video/leo.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/leo.c	2004-09-06 13:11:51.304497256 +1000
@@ -606,7 +606,7 @@
 
 	leo_init_fix(&all->info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "leo: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/macfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/macfb.c
--- linux-2.6.9-rc1/drivers/video/macfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/macfb.c	2004-09-06 13:11:51.305497104 +1000
@@ -954,7 +954,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return;
 
 	printk("fb%d: %s frame buffer device\n",
diff -ruN linux-2.6.9-rc1/drivers/video/matrox/matroxfb_base.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1/drivers/video/matrox/matroxfb_base.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_base.c	2004-09-06 13:11:51.307496800 +1000
@@ -1572,7 +1572,8 @@
 	outputs[0] = 0;
 }
 
-static int initMatrox2(WPMINFO struct board* b){
+static int initMatrox2(WPMINFO struct board* b,
+		struct device * dev){
 	unsigned long ctrlptr_phys = 0;
 	unsigned long video_base_phys = 0;
 	unsigned int memsize;
@@ -1864,7 +1865,7 @@
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
-	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
+	if (register_framebuffer(&ACCESS_FBINFO(fbcon), dev) < 0) {
 		goto failVideoIO;
 	}
 	printk("fb%d: %s frame buffer device\n",
@@ -2056,7 +2057,7 @@
 	init_waitqueue_head(&ACCESS_FBINFO(crtc2.vsync.wait));
 	ACCESS_FBINFO(crtc1.panpos) = -1;
 
-	err = initMatrox2(PMINFO b);
+	err = initMatrox2(PMINFO b, &pdev->dev);
 	if (!err) {
 #ifndef CONFIG_FB_MATROX_MULTIHEAD
 		registered = 1;
diff -ruN linux-2.6.9-rc1/drivers/video/matrox/matroxfb_crtc2.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_crtc2.c
--- linux-2.6.9-rc1/drivers/video/matrox/matroxfb_crtc2.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_crtc2.c	2004-09-06 13:11:51.308496648 +1000
@@ -629,7 +629,7 @@
 	m2info->mmio.len = ACCESS_FBINFO(mmio.len);
 
 	matroxfb_dh_init_fix(m2info);
-	if (register_framebuffer(&m2info->fbcon)) {
+	if (register_framebuffer(&m2info->fbcon, NULL)) {
 		return -ENXIO;
 	}
 	if (m2info->fbcon.currcon < 0) {
diff -ruN linux-2.6.9-rc1/drivers/video/maxinefb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/maxinefb.c
--- linux-2.6.9-rc1/drivers/video/maxinefb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/maxinefb.c	2004-09-06 13:11:51.309496496 +1000
@@ -163,7 +163,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/neofb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/neofb.c
--- linux-2.6.9-rc1/drivers/video/neofb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/neofb.c	2004-09-06 13:11:51.320494824 +1000
@@ -2139,7 +2139,7 @@
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 		goto err_map_video;
 
-	err = register_framebuffer(info);
+	err = register_framebuffer(info, &dev->dev);
 	if (err < 0)
 		goto err_reg_fb;
 
diff -ruN linux-2.6.9-rc1/drivers/video/offb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/offb.c
--- linux-2.6.9-rc1/drivers/video/offb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/offb.c	2004-09-06 13:11:51.321494672 +1000
@@ -531,7 +531,7 @@
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, NULL) < 0) {
 		kfree(info);
 		release_mem_region(res_start, res_size);
 		return;
diff -ruN linux-2.6.9-rc1/drivers/video/p9100.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/p9100.c
--- linux-2.6.9-rc1/drivers/video/p9100.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/p9100.c	2004-09-06 13:11:51.321494672 +1000
@@ -320,7 +320,7 @@
 
 	p9100_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "p9100: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/platinumfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/platinumfb.c
--- linux-2.6.9-rc1/drivers/video/platinumfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/platinumfb.c	2004-09-06 13:11:51.322494520 +1000
@@ -388,7 +388,7 @@
 		goto try_again;
 
 	/* Register with fbdev layer */
-	rc = register_framebuffer(info);
+	rc = register_framebuffer(info, NULL);
 	if (rc < 0)
 		return rc;
 
diff -ruN linux-2.6.9-rc1/drivers/video/pm2fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pm2fb.c
--- linux-2.6.9-rc1/drivers/video/pm2fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pm2fb.c	2004-09-06 13:11:51.323494368 +1000
@@ -1139,7 +1139,7 @@
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 		goto err_exit_all;
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, &pdev->dev) < 0)
 		goto err_exit_both;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory = %dK.\n",
diff -ruN linux-2.6.9-rc1/drivers/video/pm3fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pm3fb.c
--- linux-2.6.9-rc1/drivers/video/pm3fb.c	2004-01-13 14:18:03.000000000 +1100
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pm3fb.c	2004-09-06 13:11:51.326493912 +1000
@@ -1631,7 +1631,7 @@
 
 	do_install_cmap(0, &l_fb_info->gen.info);
 
-	if (register_framebuffer(&l_fb_info->gen.info) < 0) {
+	if (register_framebuffer(&l_fb_info->gen.info, &l_fb_info->dev->dev) < 0) {
 		DPRINTK(1, "Couldn't register framebuffer\n");
 		return;
 	}
@@ -3494,7 +3494,7 @@
 #endif /* KERNEL_2_4 or KERNEL_2_5 */
 				if (forcesize[l_fb_info->board_num])
 					l_fb_info->fb_size = forcesize[l_fb_info->board_num];
-				
+		
 				l_fb_info->fb_size =
 				    pm3fb_size_memory(l_fb_info);
 
diff -ruN linux-2.6.9-rc1/drivers/video/pmag-ba-fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pmag-ba-fb.c
--- linux-2.6.9-rc1/drivers/video/pmag-ba-fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pmag-ba-fb.c	2004-09-06 13:11:51.326493912 +1000
@@ -146,7 +146,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 	
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/pmagb-b-fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pmagb-b-fb.c
--- linux-2.6.9-rc1/drivers/video/pmagb-b-fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pmagb-b-fb.c	2004-09-06 13:11:51.327493760 +1000
@@ -149,7 +149,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -ruN linux-2.6.9-rc1/drivers/video/pvr2fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1/drivers/video/pvr2fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pvr2fb.c	2004-09-06 13:11:51.328493608 +1000
@@ -766,7 +766,7 @@
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int __init pvr2fb_common_init(void)
+static int __init pvr2fb_common_init(struct device * dev)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -809,7 +809,7 @@
 
 	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
-	if (register_framebuffer(fb_info) < 0)
+	if (register_framebuffer(fb_info, dev) < 0)
 		goto out_err;
 
 	modememused = get_line_length(fb_info->var.xres_virtual,
@@ -901,7 +901,7 @@
 	}
 #endif
 
-	return pvr2fb_common_init();
+	return pvr2fb_common_init(NULL);
 }
 
 static void pvr2fb_dc_exit(void)
@@ -940,7 +940,7 @@
 	pvr2_fix.mmio_start	= pci_resource_start(pdev, 1);
 	pvr2_fix.mmio_len	= pci_resource_len(pdev, 1);
 
-	return pvr2fb_common_init();
+	return pvr2fb_common_init(&pdev->dev);
 }
 
 static void __devexit pvr2fb_pci_remove(struct pci_dev *pdev)
diff -ruN linux-2.6.9-rc1/drivers/video/pxafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pxafb.c
--- linux-2.6.9-rc1/drivers/video/pxafb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pxafb.c	2004-09-06 13:11:51.329493456 +1000
@@ -1318,7 +1318,7 @@
 
 	dev_set_drvdata(dev, fbi);
 
-	ret = register_framebuffer(&fbi->fb);
+	ret = register_framebuffer(&fbi->fb, dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register framebuffer device: %d\n", ret);
 		goto failed;
diff -ruN linux-2.6.9-rc1/drivers/video/q40fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/q40fb.c
--- linux-2.6.9-rc1/drivers/video/q40fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/q40fb.c	2004-09-06 13:11:51.330493304 +1000
@@ -117,7 +117,7 @@
 
 	master_outb(3, DISPLAY_CONTROL_REG);
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, device) < 0) {
 		printk(KERN_ERR "Unable to register Q40 frame buffer\n");
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
diff -ruN linux-2.6.9-rc1/drivers/video/radeonfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/radeonfb.c
--- linux-2.6.9-rc1/drivers/video/radeonfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/radeonfb.c	2004-09-06 13:11:51.332493000 +1000
@@ -3041,7 +3041,7 @@
 	rinfo->next = board_list;
 	board_list = rinfo;
 
-	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+	if (register_framebuffer ((struct fb_info *) rinfo, &pdev->dev) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
 		iounmap ((void*)rinfo->mmio_base);
diff -ruN linux-2.6.9-rc1/drivers/video/retz3fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/retz3fb.c
--- linux-2.6.9-rc1/drivers/video/retz3fb.c	2004-06-18 12:44:12.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/retz3fb.c	2004-09-06 13:11:51.333492848 +1000
@@ -1424,7 +1424,7 @@
 
 		do_install_cmap(0, fb_info);
 
-		if (register_framebuffer(fb_info) < 0)
+		if (register_framebuffer(fb_info, NULL) < 0)
 			return -EINVAL;
 
 		printk(KERN_INFO "fb%d: %s frame buffer device, using %ldK of "
diff -ruN linux-2.6.9-rc1/drivers/video/riva/fbdev.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1/drivers/video/riva/fbdev.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/riva/fbdev.c	2004-09-06 13:11:51.335492544 +1000
@@ -1995,7 +1995,7 @@
 	info->monspecs.modedb_len = 0;
 	info->monspecs.modedb = NULL;
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pd->dev) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
 		goto err_out_iounmap_fb;
diff -ruN linux-2.6.9-rc1/drivers/video/S3triofb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/S3triofb.c
--- linux-2.6.9-rc1/drivers/video/S3triofb.c	2004-01-13 14:24:00.000000000 +1100
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/S3triofb.c	2004-09-06 13:11:51.336492392 +1000
@@ -537,7 +537,7 @@
 #endif
 
     fb_info.flags = FBINFO_FLAG_DEFAULT;
-    if (register_framebuffer(&fb_info) < 0)
+    if (register_framebuffer(&fb_info, NULL) < 0)
 	return;
 
     printk("fb%d: S3 Trio frame buffer device on %s\n",
diff -ruN linux-2.6.9-rc1/drivers/video/sa1100fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sa1100fb.c
--- linux-2.6.9-rc1/drivers/video/sa1100fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sa1100fb.c	2004-09-06 13:11:51.337492240 +1000
@@ -1772,7 +1772,7 @@
 
 	dev_set_drvdata(dev, fbi);
 
-	ret = register_framebuffer(&fbi->fb);
+	ret = register_framebuffer(&fbi->fb, NULL);
 	if (ret < 0)
 		goto failed;
 
diff -ruN linux-2.6.9-rc1/drivers/video/sgivwfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sgivwfb.c
--- linux-2.6.9-rc1/drivers/video/sgivwfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sgivwfb.c	2004-09-06 13:11:51.338492088 +1000
@@ -811,7 +811,7 @@
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 		goto fail_color_map;
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, device) < 0) {
 		printk(KERN_ERR "sgivwfb: couldn't register framebuffer\n");
 		goto fail_register_framebuffer;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/sis/sis_main.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sis/sis_main.c
--- linux-2.6.9-rc1/drivers/video/sis/sis_main.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sis/sis_main.c	2004-09-06 13:11:51.342491480 +1000
@@ -5572,7 +5572,7 @@
 		vc_resize_con(1, 1, 0);
 #endif
 
-		if(register_framebuffer(sis_fb_info) < 0) {
+		if(register_framebuffer(sis_fb_info, &pdev->dev) < 0) {
 			printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuffer\n");
 			iounmap((void *)ivideo->video_vbase);
 			iounmap((void *)ivideo->mmio_vbase);
diff -ruN linux-2.6.9-rc1/drivers/video/skeletonfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/skeletonfb.c
--- linux-2.6.9-rc1/drivers/video/skeletonfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/skeletonfb.c	2004-09-06 13:11:51.343491328 +1000
@@ -569,7 +569,14 @@
      */	
     info.var = xxxfb_var;
 	
-    if (register_framebuffer(&info) < 0)
+    /*
+     * The second parameter is the struct device. If your framebuffer
+     * is a PCI device or otherwise maps to the device tree, you
+     * should send the struct device to register_framebuffer. Code such
+     * as suspend2 will then be able to keep your device enabled while
+     * suspending other devices. (Nigel Cunningham)
+     */
+    if (register_framebuffer(&info, NULL) < 0)
 	return -EINVAL;
     printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
 	   info.fix.id);
diff -ruN linux-2.6.9-rc1/drivers/video/sstfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sstfb.c
--- linux-2.6.9-rc1/drivers/video/sstfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sstfb.c	2004-09-06 13:11:51.345491024 +1000
@@ -1507,7 +1507,7 @@
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* register fb */
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pdev->dev) < 0) {
 		eprintk("can't register framebuffer.\n");
 		goto fail;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/stifb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/stifb.c
--- linux-2.6.9-rc1/drivers/video/stifb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/stifb.c	2004-09-06 13:11:51.346490872 +1000
@@ -1344,7 +1344,7 @@
 		goto out_err2;
 	}
 
-	if (register_framebuffer(&fb->info) < 0)
+	if (register_framebuffer(&fb->info, NULL) < 0)
 		goto out_err3;
 
 	sti->info = info; /* save for unregister_framebuffer() */
diff -ruN linux-2.6.9-rc1/drivers/video/sun3fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sun3fb.c
--- linux-2.6.9-rc1/drivers/video/sun3fb.c	2004-01-13 14:18:05.000000000 +1100
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sun3fb.c	2004-09-06 13:11:51.348490568 +1000
@@ -641,7 +641,7 @@
 
 	sun3fb_set_var(var, -1, &fb->info);
 
-	if (register_framebuffer(&fb->info) < 0) {
+	if (register_framebuffer(&fb->info, NULL) < 0) {
 		kfree(fb);
 		return -EINVAL;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/tcx.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tcx.c
--- linux-2.6.9-rc1/drivers/video/tcx.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tcx.c	2004-09-06 13:11:51.349490416 +1000
@@ -447,7 +447,7 @@
 
 	tcx_init_fix(&all->info, linebytes);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, NULL) < 0) {
 		printk(KERN_ERR "tcx: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);
diff -ruN linux-2.6.9-rc1/drivers/video/tdfxfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1/drivers/video/tdfxfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tdfxfb.c	2004-09-06 13:11:51.351490112 +1000
@@ -1293,7 +1293,7 @@
 		goto out_err;
 	}
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pdev->dev) < 0) {
 		printk("tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
 		goto out_err;
diff -ruN linux-2.6.9-rc1/drivers/video/tgafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tgafb.c
--- linux-2.6.9-rc1/drivers/video/tgafb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tgafb.c	2004-09-06 13:11:51.354489656 +1000
@@ -1454,7 +1454,7 @@
 	tgafb_set_par(&all->info);
 	tgafb_init_fix(&all->info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, &pdev->dev) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
 		goto err1;
diff -ruN linux-2.6.9-rc1/drivers/video/tridentfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tridentfb.c
--- linux-2.6.9-rc1/drivers/video/tridentfb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tridentfb.c	2004-09-06 13:11:51.355489504 +1000
@@ -1164,7 +1164,7 @@
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, &dev->dev) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/tx3912fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tx3912fb.c
--- linux-2.6.9-rc1/drivers/video/tx3912fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tx3912fb.c	2004-09-06 13:11:51.356489352 +1000
@@ -307,7 +307,7 @@
 
 	fb_alloc_cmap(&info->cmap, size, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -1;
 
 	printk(KERN_INFO "fb%d: TX3912 frame buffer using %uKB.\n",
diff -ruN linux-2.6.9-rc1/drivers/video/valkyriefb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/valkyriefb.c
--- linux-2.6.9-rc1/drivers/video/valkyriefb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/valkyriefb.c	2004-09-06 13:11:51.356489352 +1000
@@ -385,7 +385,7 @@
 		/* "can't happen" */
 		printk(KERN_ERR "valkyriefb: can't set default video mode\n");
 
-	if ((err = register_framebuffer(&p->info)) != 0)
+	if ((err = register_framebuffer(&p->info, NULL)) != 0)
 		goto out_free;
 
 	printk(KERN_INFO "fb%d: valkyrie frame buffer device\n", p->info.node);
diff -ruN linux-2.6.9-rc1/drivers/video/vesafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vesafb.c
--- linux-2.6.9-rc1/drivers/video/vesafb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vesafb.c	2004-09-06 13:11:51.357489200 +1000
@@ -383,7 +383,7 @@
 		err = -ENXIO;
 		goto err;
 	}
-	if (register_framebuffer(info)<0) {
+	if (register_framebuffer(info, device)<0) {
 		err = -EINVAL;
 		fb_dealloc_cmap(&info->cmap);
 		goto err;
diff -ruN linux-2.6.9-rc1/drivers/video/vfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vfb.c
--- linux-2.6.9-rc1/drivers/video/vfb.c	2004-06-18 12:44:12.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vfb.c	2004-09-06 13:11:51.362488440 +1000
@@ -447,7 +447,7 @@
 	if (retval < 0)
 		goto err1;
 
-	retval = register_framebuffer(info);
+	retval = register_framebuffer(info, device);
 	if (retval < 0)
 		goto err2;
 	dev_set_drvdata(&dev->dev, info);
diff -ruN linux-2.6.9-rc1/drivers/video/vga16fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vga16fb.c
--- linux-2.6.9-rc1/drivers/video/vga16fb.c	2004-08-30 16:01:11.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/vga16fb.c	2004-09-06 13:11:51.363488288 +1000
@@ -1389,7 +1389,7 @@
 
 	vga16fb_update_fix(&vga16fb);
 
-	if (register_framebuffer(&vga16fb) < 0) {
+	if (register_framebuffer(&vga16fb, NULL) < 0) {
 		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
 		ret = -EINVAL;
 		goto err_check_var;
diff -ruN linux-2.6.9-rc1/drivers/video/virgefb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/virgefb.c
--- linux-2.6.9-rc1/drivers/video/virgefb.c	2004-06-18 12:44:12.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/virgefb.c	2004-09-06 13:11:51.365487984 +1000
@@ -1797,7 +1797,7 @@
 	virgefb_set_disp(-1, &fb_info);
 	do_install_cmap(0, &fb_info);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		#warning release resources
 		printk(KERN_ERR "virgefb.c: register_framebuffer failed\n");
 		DPRINTK("EXIT\n");
diff -ruN linux-2.6.9-rc1/include/linux/fb.h software-suspend-linux-2.6.9-rc1-rev3/include/linux/fb.h
--- linux-2.6.9-rc1/include/linux/fb.h	2004-08-30 16:01:16.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/include/linux/fb.h	2004-09-06 13:11:51.394483576 +1000
@@ -681,7 +681,7 @@
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* drivers/video/fbmem.c */
-extern int register_framebuffer(struct fb_info *fb_info);
+extern int register_framebuffer(struct fb_info *fb_info, struct device * dev);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);

--=-Is0i3yDGagrCBmFpkgMT--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
