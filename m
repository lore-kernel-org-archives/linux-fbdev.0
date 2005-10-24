From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] Make mach64 driver a platform device on m68k
Date: Mon, 24 Oct 2005 21:48:39 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0510242146230.13921@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EU9FQ-00080S-KN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 13:48:48 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EU9FP-0007Lx-HA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 13:48:48 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch makes the mach64 chip on atari machines a platform device so it 
can be used via sysfs. Please apply.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/atyfb_base.c fbdev-2.6/drivers/video/aty/atyfb_base.c
--- linus-2.6/drivers/video/aty/atyfb_base.c	2005-09-13 14:01:40.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/atyfb_base.c	2005-10-24 13:41:35.000000000 -0700
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
+static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num);
+static LIST_HEAD(mach64_list);
 #endif
 
 /* top -> down is an evolution of mach64 chipset, any corrections? */
@@ -2155,15 +2150,12 @@
      *  Initialisation
      */
 
-static struct fb_info *fb_list = NULL;
-
 static int __init aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *ramname = NULL, *xtal;
-	int gtb_memsize;
 	struct fb_var_screeninfo var;
-	u8 pll_ref_div;
+	int gtb_memsize;
 	u32 i;
 #if defined(CONFIG_PPC)
 	int sense;
@@ -2276,18 +2268,20 @@
 			par->pll_limits.mclk = 63;
 	}
 
-	if (M64_HAS(GTB_DSP)
-	    && (pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par))) {
-		int diff1, diff2;
-		diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
-		diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
-		if (diff1 < 0)
-			diff1 = -diff1;
-		if (diff2 < 0)
-			diff2 = -diff2;
-		if (diff2 < diff1) {
-			par->ref_clk_per = 1000000000000ULL / 29498928;
-			xtal = "29.498928";
+	if (M64_HAS(GTB_DSP)) {
+		u8 pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par);
+		if (pll_ref_dev) {
+			int diff1, diff2;
+			diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
+			diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
+			if (diff1 < 0)
+				diff1 = -diff1;
+			if (diff2 < 0)
+				diff2 = -diff2;
+			if (diff2 < diff1) {
+				par->ref_clk_per = 1000000000000ULL / 29498928;
+				xtal = "29.498928";
+			}
 		}
 	}
 #endif /* CONFIG_FB_ATY_CT */
@@ -2547,8 +2541,6 @@
 	if (register_framebuffer(info) < 0)
 		goto aty_init_exit;
 
-	fb_list = info;
-
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
 	return 0;
@@ -2571,37 +2563,6 @@
 	return -1;
 }
 
-#ifdef CONFIG_ATARI
-static int __init store_video_par(char *video_str, unsigned char m64_num)
-{
-	char *p;
-	unsigned long vmembase, size, guiregbase;
-
-	PRINTKI("store_video_par() '%s' \n", video_str);
-
-	if (!(p = strsep(&video_str, ";")) || !*p)
-		goto mach64_invalid;
-	vmembase = simple_strtoul(p, NULL, 0);
-	if (!(p = strsep(&video_str, ";")) || !*p)
-		goto mach64_invalid;
-	size = simple_strtoul(p, NULL, 0);
-	if (!(p = strsep(&video_str, ";")) || !*p)
-		goto mach64_invalid;
-	guiregbase = simple_strtoul(p, NULL, 0);
-
-	phys_vmembase[m64_num] = vmembase;
-	phys_size[m64_num] = size;
-	phys_guiregbase[m64_num] = guiregbase;
-	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
-	       guiregbase);
-	return 0;
-
-      mach64_invalid:
-	phys_vmembase[m64_num] = 0;
-	return -1;
-}
-#endif /* CONFIG_ATARI */
-
     /*
      *  Blank the display.
      */
@@ -2756,6 +2717,48 @@
 	return 0;
 }
 
+static void __devexit atyfb_remove(struct fb_info *info)
+{
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+
+	/* restore video mode */
+	aty_set_crtc(par, &saved_crtc);
+	par->pll_ops->set_pll(info, &saved_pll);
+
+	unregister_framebuffer(info);
+
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >= 0) {
+	    mtrr_del(par->mtrr_reg, 0, 0);
+	    par->mtrr_reg = -1;
+	}
+	if (par->mtrr_aper >= 0) {
+	    mtrr_del(par->mtrr_aper, 0, 0);
+	    par->mtrr_aper = -1;
+	}
+#endif
+#ifndef __sparc__
+	if (par->ati_regbase)
+		iounmap(par->ati_regbase);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+#ifdef __BIG_ENDIAN
+	if (info->sprite.addr)
+		iounmap(info->sprite.addr);
+#endif
+#endif
+#ifdef __sparc__
+	kfree(par->mmap_map);
+#endif
+	if (par->aux_start)
+		release_mem_region(par->aux_start, par->aux_size);
+
+	if (par->res_start)
+		release_mem_region(par->res_start, par->res_size);
+
+	framebuffer_release(info);
+}
+
 #ifdef CONFIG_PCI
 
 #ifdef __sparc__
@@ -3437,49 +3440,115 @@
 	return rc;
 }
 
+static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+
+	atyfb_remove(info);
+}
+
+/*
+ * This driver uses its own matching table. That will be more difficult
+ * to fix, so for now, we just match against any ATI ID and let the
+ * probe() function find out what's up. That also mean we don't have
+ * a module ID table though.
+ */
+static struct pci_device_id atyfb_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0 },
+	{ 0, }
+};
+
+static struct pci_driver atyfb_driver = {
+	.name		= "atyfb",
+	.id_table	= atyfb_pci_tbl,
+	.probe		= atyfb_pci_probe,
+	.remove		= __devexit_p(atyfb_pci_remove),
+#ifdef CONFIG_PM
+	.suspend	= atyfb_pci_suspend,
+	.resume		= atyfb_pci_resume,
+#endif /* CONFIG_PM */
+};
+
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_ATARI
 
-static int __devinit atyfb_atari_probe(void)
+static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)
 {
-	struct aty_par *par;
+	unsigned long vmembase, size, guiregbase;
+	struct platform_device *atyfb_device;
+	struct mach64_device *device;
+	struct resource io[2];
+	char *p;
+
+	PRINTKI("store_video_par() '%s' \n", video_str);
+
+	if (!(p = strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	vmembase = simple_strtoul(p, NULL, 0);
+	if (!(p = strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	size = simple_strtoul(p, NULL, 0);
+	if (!(p = strsep(&video_str, ";")) || !*p)
+		goto mach64_invalid;
+	guiregbase = simple_strtoul(p, NULL, 0);
+
+	io[0] = request_mem_region(vmembase, size, "atyfb");
+	if (!io[0])
+		return NULL;
+	io[1] = request_mem_region(guiregbase, 0x10000, "atyfb");
+	if (!io[1]) {
+		release_resource(io[0]);
+		return NULL;
+	}
+
+	atyfb_device = platform_device_register_simple("atyfb", m64_num, io, 2);
+	if (IS_ERR(atyfb_device))
+		return NULL;
+
+	device = kmalloc(sizeof(struct mach64_device), GFP_KERNEL);
+	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size, guiregbase);
+	return device;
+mach64_invalid:
+	return NULL;
+}
+
+static int __init atyfb_atari_probe(struct device *device)
+{
+	struct platform_device *dev = to_platform_device(device);
+	struct atyfb_par *par;
 	struct fb_info *info;
-	int m64_num;
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
+	/*
+	 *  Map the video memory (physical address given) to somewhere in the
+	 *  kernel address space.
+	 */
+	size = dev->resource[0].start - dev->resource[0].end + 1;
+	info->fix.smem_start = dev->resource[0].start;
+	info->screen_base = ioremap(dev->resource[0].start, size);
+
+	size = 0x10000;
+	info->fix.mmio_start = dev->resource[1].start + 0xFC00ul;
+	par->ati_regbase = ioremap(dev->resource[1].start, size) + 0xFC00ul;
 
-		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
-		clock_r = aty_ld_le32(CLOCK_CNTL, par);
+	aty_st_le32(CLOCK_CNTL, 0x12345678, par);
+	clock_r = aty_ld_le32(CLOCK_CNTL, par);
 
-		switch (clock_r & 0x003F) {
+	switch (clock_r & 0x003F) {
 		case 0x12:
 			par->clk_wr_offset = 3; /*  */
 			break;
@@ -3493,92 +3562,34 @@
 			par->clk_wr_offset = 0; /* Panther 1 ISA Adapter (Gerald) */
 			break;
 		}
-
-		if (aty_init(info, "ISA bus")) {
-			framebuffer_release(info);
-			/* This is insufficient! kernel_map has added two large chunks!! */
-			return -ENXIO;
-		}
 	}
-}
-
-#endif /* CONFIG_ATARI */
-
-static void __devexit atyfb_remove(struct fb_info *info)
-{
-	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	/* restore video mode */
-	aty_set_crtc(par, &saved_crtc);
-	par->pll_ops->set_pll(info, &saved_pll);
-
-	unregister_framebuffer(info);
+	//FIXME
+	//rc = correct_chipset(par);
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_reg >= 0) {
-	    mtrr_del(par->mtrr_reg, 0, 0);
-	    par->mtrr_reg = -1;
-	}
-	if (par->mtrr_aper >= 0) {
-	    mtrr_del(par->mtrr_aper, 0, 0);
-	    par->mtrr_aper = -1;
+	if (aty_init(info, "ISA bus")) {
+		framebuffer_release(info);
+		/* This is insufficient! kernel_map has added two large chunks!! */
+		return -ENXIO;
 	}
-#endif
-#ifndef __sparc__
-	if (par->ati_regbase)
-		iounmap(par->ati_regbase);
-	if (info->screen_base)
-		iounmap(info->screen_base);
-#ifdef __BIG_ENDIAN
-	if (info->sprite.addr)
-		iounmap(info->sprite.addr);
-#endif
-#endif
-#ifdef __sparc__
-	kfree(par->mmap_map);
-#endif
-	if (par->aux_start)
-		release_mem_region(par->aux_start, par->aux_size);
-
-	if (par->res_start)
-		release_mem_region(par->res_start, par->res_size);
-
-	framebuffer_release(info);
+	return 0;
 }
 
-#ifdef CONFIG_PCI
-
-static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
+static void __devexit atyfb_atari_remove(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 
 	atyfb_remove(info);
 }
 
-/*
- * This driver uses its own matching table. That will be more difficult
- * to fix, so for now, we just match against any ATI ID and let the
- * probe() function find out what's up. That also mean we don't have
- * a module ID table though.
- */
-static struct pci_device_id atyfb_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0 },
-	{ 0, }
-};
-
-static struct pci_driver atyfb_driver = {
+static struct device_driver atyfb_driver = {
 	.name		= "atyfb",
-	.id_table	= atyfb_pci_tbl,
-	.probe		= atyfb_pci_probe,
-	.remove		= __devexit_p(atyfb_pci_remove),
-#ifdef CONFIG_PM
-	.suspend	= atyfb_pci_suspend,
-	.resume		= atyfb_pci_resume,
-#endif /* CONFIG_PM */
+	.bus		= &platform_bus_type,
+	.probe		= atyfb_atari_probe,
+	.remove		= __devexit_p(atyfb_atari_remove),
 };
 
-#endif /* CONFIG_PCI */
+#endif /* CONFIG_ATARI */
 
 #ifndef MODULE
 static int __init atyfb_setup(char *options)
@@ -3635,15 +3646,15 @@
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
+			if (dev != NULL)
+				list_add_tail(&dev->node, &mach64_list);
 		}
 #endif
 		else
@@ -3655,6 +3666,8 @@
 
 static int __init atyfb_init(void)
 {
+    int retval = 0;
+
 #ifndef MODULE
     char *option = NULL;
 
@@ -3664,16 +3677,38 @@
 #endif
 
 #ifdef CONFIG_PCI
-    pci_register_driver(&atyfb_driver);
+    retval = pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
-    atyfb_atari_probe();
+    retval = driver_register(&atyfb_driver);
+    if (retval < 0) {
+	struct mach64_device *device;
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &mach64_list) {
+		device = list_entry(p, struct mach64_device, node);
+		platform_device_register(device->dev);
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
+	struct mach64_device *device;
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &mach64_list) {
+		device = list_entry(p, struct mach64_device, node);
+		platform_device_unregister(device->dev);
+		kfree(device);
+	}
+	driver_unregister(&atyfb_driver);
+#endif
+
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
 #endif
@@ -3703,3 +3738,4 @@
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
 #endif
+
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/atyfb.h fbdev-2.6/drivers/video/aty/atyfb.h
--- linus-2.6/drivers/video/aty/atyfb.h	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/atyfb.h	2005-10-24 13:34:07.000000000 -0700
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
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
