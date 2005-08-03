From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] Make mach64 a platform device on atari
Date: Wed, 3 Aug 2005 19:04:24 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508031902290.2330@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0NbZ-0007xq-JN
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 11:04:37 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0NbY-0008DM-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 11:04:37 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: linux-m68k@lists.linux-m68k.org


This makes the mach64 a platform device on atari m68 devices. Please test 
and it if is okay I will send it to Andrew Morton.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/atyfb_base.c fbdev-2.6/drivers/video/aty/atyfb_base.c
--- linus-2.6/drivers/video/aty/atyfb_base.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/atyfb_base.c	2005-07-27 08:41:24.000000000 -0700
@@ -244,9 +244,6 @@
      */
 
 static int aty_init(struct fb_info *info, const char *name);
-#ifdef CONFIG_ATARI
-static int store_video_par(char *videopar, unsigned char m64_num);
-#endif
 
 static struct crtc saved_crtc;
 static union aty_pll saved_pll;
@@ -321,10 +318,8 @@
 #endif
 
 #ifdef CONFIG_ATARI
-static unsigned int mach64_count __initdata = 0;
-static unsigned long phys_vmembase[FB_MAX] __initdata = { 0, };
-static unsigned long phys_size[FB_MAX] __initdata = { 0, };
-static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
+static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)
+static LIST_HEAD(mach64_list);
 #endif
 
 /* top -> down is an evolution of mach64 chipset, any corrections? */
@@ -2170,8 +2165,6 @@
      *  Initialisation
      */
 
-static struct fb_info *fb_list = NULL;
-
 static int __init aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -2562,8 +2555,6 @@
 	if (register_framebuffer(info) < 0)
 		goto aty_init_exit;
 
-	fb_list = info;
-
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
 	return 0;
@@ -2587,10 +2578,13 @@
 }
 
 #ifdef CONFIG_ATARI
-static int __init store_video_par(char *video_str, unsigned char m64_num)
+static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)
 {
-	char *p;
 	unsigned long vmembase, size, guiregbase;
+	struct platform_device *atyfb_device;
+	struct mach64_device *device;
+	struct resource io[2];
+	char *p;
 
 	PRINTKI("store_video_par() '%s' \n", video_str);
 
@@ -2604,16 +2598,18 @@
 		goto mach64_invalid;
 	guiregbase = simple_strtoul(p, NULL, 0);
 
-	phys_vmembase[m64_num] = vmembase;
-	phys_size[m64_num] = size;
-	phys_guiregbase[m64_num] = guiregbase;
-	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
-	       guiregbase);
-	return 0;
+	io[0] = request_mem_region(vmembase, size, "atyfb");
+	io[1] = request_mem_region(guiregbase, 0x10000, "atyfb");
 
-      mach64_invalid:
-	phys_vmembase[m64_num] = 0;
-	return -1;
+	atyfb_device = platform_device_register_simple("atyfb", m64_num, io, 2);
+	if (IS_ERR(atyfb_device))
+		return PTR_ERR(atyfb_device);
+
+	device = kmalloc(sizeof(struct mach64_device), GFP_KERNEL);
+	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size, guiregbase);
+	return device;
+mach64_invalid:
+	return NULL;
 }
 #endif /* CONFIG_ATARI */
 
@@ -2679,17 +2675,10 @@
 static void aty_st_pal(u_int regno, u_int red, u_int green, u_int blue,
 		       const struct atyfb_par *par)
 {
-#ifdef CONFIG_ATARI
-	out_8(&par->aty_cmap_regs->windex, regno);
-	out_8(&par->aty_cmap_regs->lut, red);
-	out_8(&par->aty_cmap_regs->lut, green);
-	out_8(&par->aty_cmap_regs->lut, blue);
-#else
 	writeb(regno, &par->aty_cmap_regs->windex);
 	writeb(red, &par->aty_cmap_regs->lut);
 	writeb(green, &par->aty_cmap_regs->lut);
 	writeb(blue, &par->aty_cmap_regs->lut);
-#endif
 }
 
     /*
@@ -3456,47 +3445,43 @@
 
 #ifdef CONFIG_ATARI
 
-static int __devinit atyfb_atari_probe(void)
+static int __devinit atyfb_atari_probe(struct device *device)
 {
-	struct aty_par *par;
+	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
-	int m64_num;
+	struct aty_par *par;
+	int size = 0;
 	u32 clock_r;
 
-	for (m64_num = 0; m64_num < mach64_count; m64_num++) {
-		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
-		    !phys_guiregbase[m64_num]) {
-		    PRINTKI("phys_*[%d] parameters not set => returning early. \n", m64_num);
-			continue;
-		}
-
-		info = framebuffer_alloc(sizeof(struct atyfb_par), NULL);
-		if (!info) {
-			PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
-			return -ENOMEM;
-		}
-		par = info->par;
+	info = framebuffer_alloc(sizeof(struct atyfb_par), &dev->dev);
+	if (!info) {
+		PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
+		return -ENOMEM;
+	}
+	par = info->par;
 
-		info->fix = atyfb_fix;
+	info->fix = atyfb_fix;
 
-		par->irq = (unsigned int) -1; /* something invalid */
+	par->irq = (unsigned int) -1; /* something invalid */
 
-		/*
-		 *  Map the video memory (physical address given) to somewhere in the
-		 *  kernel address space.
-		 */
-		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
-		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
-		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) +
-						0xFC00ul;
-		info->fix.mmio_start = (unsigned long)par->ati_regbase; /* Fake! */
-
-		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
-		clock_r = aty_ld_le32(CLOCK_CNTL, par);
-
-		switch (clock_r & 0x003F) {
-		case 0x12:
-			par->clk_wr_offset = 3; /*  */
+	/*
+	 *  Map the video memory (physical address given) to somewhere in the
+	 *  kernel address space.
+	 */
+	size = dev->resource[0].start - dev->resource[0].end;
+	info->fix.smem_start = dev->resource[0].start;
+	info->screen_base = ioremap(dev->resource[0], size);
+
+	size = 0x10000;
+	info->fix.mmio_start = dev->resource[1].start + 0xFC00ul;
+	par->ati_regbase = ioremap(dev->resource[1], size) + 0xFC00ul;
+
+	aty_st_le32(CLOCK_CNTL, 0x12345678, par);
+	clock_r = aty_ld_le32(CLOCK_CNTL, par);
+
+	switch (clock_r & 0x003F) {
+	case 0x12:
+		par->clk_wr_offset = 3; /*  */
 			break;
 		case 0x34:
 			par->clk_wr_offset = 2; /* Medusa ST-IO ISA Adapter etc. */
@@ -3595,6 +3580,23 @@
 
 #endif /* CONFIG_PCI */
 
+#ifdef	CONFIG_ATARI
+
+static struct device_driver atyfb_driver = {
+	.name		= "atyfb",
+	.probe		= atyfb_atari_probe,
+	.remove		= __devexit_p(atyfb_atari_remove),
+}
+
+static void __devexit atyfb_atari_remove(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+
+	atyfb_remove(info);
+}
+
+#endif /* CONFIG_ATARI */
+
 #ifndef MODULE
 static int __init atyfb_setup(char *options)
 {
@@ -3650,15 +3652,15 @@
 		 * Why do we need this silly Mach64 argument?
 		 * We are already here because of mach64= so its redundant.
 		 */
-		else if (MACH_IS_ATARI
-			 && (!strncmp(this_opt, "Mach64:", 7))) {
-			static unsigned char m64_num;
-			static char mach64_str[80];
+		else if (MACH_IS_ATARI && (!strncmp(this_opt, "Mach64:", 7))) {
+			struct mach64_device *dev;
+			unsigned char m64_num = 0;
+			char mach64_str[80];
+
 			strlcpy(mach64_str, this_opt + 7, sizeof(mach64_str));
-			if (!store_video_par(mach64_str, m64_num)) {
-				m64_num++;
-				mach64_count = m64_num;
-			}
+			dev = store_video_par(mach64_str, m64_num++); 
+			if (dev != null)
+				list_add_tail(dev->node, &mach64_list);
 		}
 #endif
 		else
@@ -3670,6 +3672,8 @@
 
 static int __init atyfb_init(void)
 {
+    int retval = 0;	
+
 #ifndef MODULE
     char *option = NULL;
 
@@ -3679,16 +3683,34 @@
 #endif
 
 #ifdef CONFIG_PCI
-    pci_register_driver(&atyfb_driver);
+    retval = pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
-    atyfb_atari_probe();
+    retval = driver_register(&atyfb_driver);
+    if (retval < 0) {
+	struct platform_device *device;
+
+	list_for_each_safe(device, &mach64_list, node) {
+		platform_device_unregister(&device->dev);
+		kfree(device);
+	}
+    }
 #endif
-    return 0;
+    return retval;
 }
 
 static void __exit atyfb_exit(void)
 {
+#ifdef CONFIG_ATARI
+	struct platform_device *device;
+
+	list_for_each_safe(device, &mach64_list, node) {
+		platform_device_unregister(&device->dev);
+		kfree(device);
+	}
+	driver_unregister(&atyfb_driver);
+#endif
+
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
 #endif
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/atyfb.h fbdev-2.6/drivers/video/aty/atyfb.h
--- linus-2.6/drivers/video/aty/atyfb.h	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/atyfb.h	2005-07-22 15:36:41.000000000 -0700
@@ -187,6 +187,13 @@
 #endif
 };
 
+#ifdef CONFIG_ATARI
+struct mach64_device {
+	struct list_head node;
+	struct platform_device *dev;
+};
+#endif
+
     /*
      *  ATI Mach64 features
      */


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
