From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/9][SGIVWFB]: Salvage sgivwfb from James' tree
Date: Sat, 21 Aug 2004 21:25:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212121.20889.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW0S-0008A7-Kn
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:04 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW0S-0008Gz-0c
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:04 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AE4B07421F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:33:53 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Took code from James'  tree to be hopefully included in the mm tree so it can
receive more testing.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 sgivwfb.c |  129 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 92 insertions(+), 37 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/sgivwfb.c linux-2.6.8.1-mm3/drivers/video/sgivwfb.c
--- linux-2.6.8.1-mm3-orig/drivers/video/sgivwfb.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/sgivwfb.c	2004-08-21 18:59:59.711266408 +0800
@@ -22,7 +22,7 @@
 #include <asm/mtrr.h>
 
 #define INCLUDE_TIMING_TABLE_DATA
-#define DBE_REG_BASE default_par.regs
+#define DBE_REG_BASE par->regs
 #include <video/sgivw.h>
 
 struct sgivw_par {
@@ -44,9 +44,6 @@ struct sgivw_par {
 extern unsigned long sgivwfb_mem_phys;
 extern unsigned long sgivwfb_mem_size;
 
-static struct sgivw_par default_par;
-static u32 pseudo_palette[17];
-static struct fb_info fb_info;
 static int ypan = 0;
 static int ywrap = 0;
 
@@ -162,7 +159,7 @@ static unsigned long get_line_length(int
  *              console.
  */
 
-static void dbe_TurnOffDma(void)
+static void dbe_TurnOffDma(struct sgivw_par *par)
 {
 	unsigned int readVal;
 	int i;
@@ -367,7 +364,7 @@ static int sgivwfb_check_var(struct fb_v
 /*
  *  Setup flatpanel related registers.
  */
-static void sgivwfb_setup_flatpanel(struct dbe_timing_info *currentTiming)
+static void sgivwfb_setup_flatpanel(struct sgivw_par *par, struct dbe_timing_info *currentTiming)
 {
 	int fp_wid, fp_hgt, fp_vbs, fp_vbe;
 	u32 outputVal = 0;
@@ -429,7 +426,7 @@ static int sgivwfb_set_par(struct fb_inf
 	/* Turn on dotclock PLL */
 	DBE_SETREG(ctrlstat, 0x20000000);
 
-	dbe_TurnOffDma();
+	dbe_TurnOffDma(par);
 
 	/* dbe_CalculateScreenParams(); */
 	maxPixelsPerTileX = 512 / bytesPerPixel;
@@ -453,7 +450,7 @@ static int sgivwfb_set_par(struct fb_inf
 		DBE_SETREG(vt_xy, 0x00000000);
 		udelay(1);
 	} else
-		dbe_TurnOffDma();
+		dbe_TurnOffDma(par);
 
 	/* dbe_Initdbe(); */
 	for (i = 0; i < 256; i++) {
@@ -567,7 +564,7 @@ static int sgivwfb_set_par(struct fb_inf
 	DBE_SETREG(vt_hcmap, outputVal);
 
 	if (flatpanel_id != -1)
-		sgivwfb_setup_flatpanel(currentTiming);
+		sgivwfb_setup_flatpanel(par, currentTiming);
 
 	outputVal = 0;
 	temp = currentTiming->vblank_start - currentTiming->vblank_end - 1;
@@ -752,16 +749,30 @@ int __init sgivwfb_setup(char *options)
 /*
  *  Initialisation
  */
-int __init sgivwfb_init(void)
+static void sgivwfb_release(struct device *device)
+{
+}	
+
+static int __init sgivwfb_probe(struct device *device)
 {
+	struct platform_device *dev = to_platform_device(device);
+	struct sgivw_par *par;	
+	struct fb_info *info;
 	char *monitor;
 
+	info = framebuffer_alloc(sizeof(struct sgivw_par) + sizeof(u32) * 256, &dev->dev); 
+	if (!info)
+		return -ENOMEM;
+	par = info->par;
+	
 	if (!request_mem_region(DBE_REG_PHYS, DBE_REG_SIZE, "sgivwfb")) {
 		printk(KERN_ERR "sgivwfb: couldn't reserve mmio region\n");
+		framebuffer_release(info);
 		return -EBUSY;
 	}
-	default_par.regs = (struct asregs *) ioremap_nocache(DBE_REG_PHYS, DBE_REG_SIZE);
-	if (!default_par.regs) {
+
+	par->regs = (struct asregs *) ioremap_nocache(DBE_REG_PHYS, DBE_REG_SIZE);
+	if (!par->regs) {
 		printk(KERN_ERR "sgivwfb: couldn't ioremap registers\n");
 		goto fail_ioremap_regs;
 	}
@@ -773,66 +784,110 @@ int __init sgivwfb_init(void)
 	sgivwfb_fix.ywrapstep = ywrap;
 	sgivwfb_fix.ypanstep = ypan;
 
-	fb_info.fix = sgivwfb_fix;
+	info->fix = sgivwfb_fix;
 
 	switch (flatpanel_id) {
 		case FLATPANEL_SGI_1600SW:
-			fb_info.var = sgivwfb_var1600sw;
+			info->var = sgivwfb_var1600sw;
 			monitor = "SGI 1600SW flatpanel";
 			break;
 		default:
-			fb_info.var = sgivwfb_var;
+			info->var = sgivwfb_var;
 			monitor = "CRT";
 	}
 
 	printk(KERN_INFO "sgivwfb: %s monitor selected\n", monitor);
 
-	fb_info.fbops = &sgivwfb_ops;
-	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.par = &default_par;
-	fb_info.flags = FBINFO_DEFAULT;
+	info->fbops = &sgivwfb_ops;
+	info->pseudo_palette = (void *) (par + 1);
+	info->flags = FBINFO_DEFAULT;
 
-	fb_info.screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
-	if (!fb_info.screen_base) {
+	info->screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
+	if (!info->screen_base) {
 		printk(KERN_ERR "sgivwfb: couldn't ioremap screen_base\n");
 		goto fail_ioremap_fbmem;
 	}
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+		goto fail_color_map;
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "sgivwfb: couldn't register framebuffer\n");
 		goto fail_register_framebuffer;
 	}
 
+	dev_set_drvdata(&dev->dev, info);
+	
 	printk(KERN_INFO "fb%d: SGI DBE frame buffer device, using %ldK of video memory at %#lx\n",      
-		fb_info.node, sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
+		info->node, sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
 	return 0;
-
+	
 fail_register_framebuffer:
-	iounmap((char *) fb_info.screen_base);
+	fb_dealloc_cmap(&info->cmap);
+fail_color_map:
+	iounmap((char *) info->screen_base);
 fail_ioremap_fbmem:
-	iounmap(default_par.regs);
+	iounmap(par->regs);
 fail_ioremap_regs:
 	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+	framebuffer_release(info);
 	return -ENXIO;
 }
 
-#ifdef MODULE
-MODULE_LICENSE("GPL");
+static int sgivwfb_remove(struct device *device)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+
+	if (info) {
+		struct sgivw_par *par = info->par;
+		
+		unregister_framebuffer(info);
+		dbe_TurnOffDma(par);
+		iounmap(par->regs);
+		iounmap(info->screen_base);
+		release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+	}
+	return 0;
+}	
+
+static struct device_driver sgivwfb_driver = {
+	.name	= "sgivwfb",
+	.bus	= &platform_bus_type,
+	.probe	= sgivwfb_probe,
+	.remove	= sgivwfb_remove,
+};
+
+static struct platform_device sgivwfb_device = {
+	.name	= "sgivwfb",
+	.id	= 0,
+	.dev	= {
+		.release = sgivwfb_release,
+	}
+};
 
-int init_module(void)
+int __init sgivwfb_init(void)
 {
-	return sgivwfb_init();
+	int ret;
+
+	ret = driver_register(&sgivwfb_driver);
+	if (!ret) {
+		ret = platform_device_register(&sgivwfb_device);
+		if (ret)
+			driver_unregister(&sgivwfb_driver);
+	}
+	return ret;
 }
 
-void cleanup_module(void)
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+static void __exit sgivwfb_exit(void)
 {
-	unregister_framebuffer(&fb_info);
-	dbe_TurnOffDma();
-	iounmap(regs);
-	iounmap(&fb_info.screen_base);
-	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+	platform_device_unregister(&sgivwfb_device);
+	driver_unregister(&sgivwfb_driver);
 }
 
+module_init(sgivwfb_init);
+module_exit(sgivwfb_exit);
+
 #endif				/* MODULE */




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
