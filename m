From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.20-rc1 08/10] pmag-ba-fb: Convert to
	the driver model
Date: Wed, 20 Dec 2006 12:02:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612201120121.11005@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gx09R-0004Em-Gb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 04:02:25 -0800
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gx09P-0002eL-B3
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 04:02:25 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 This is a set of changes to convert the driver to the driver model.  As a 
side-effect the driver now supports building as a module.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-pmag-ba-2
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig linux-mips-2.6.18-20060920/drivers/video/Kconfig
--- linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig	2006-08-21 04:55:25.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/Kconfig	2006-12-14 04:19:47.000000000 +0000
@@ -1442,8 +1442,8 @@ config FB_PMAG_AA
 	  used mainly in the MIPS-based DECstation series.
 
 config FB_PMAG_BA
-	bool "PMAG-BA TURBOchannel framebuffer support"
-	depends on (FB = y) && TC
+	tristate "PMAG-BA TURBOchannel framebuffer support"
+	depends on FB && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.18-20060920/drivers/video/pmag-ba-fb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/pmag-ba-fb.c	2006-05-30 17:03:12.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/pmag-ba-fb.c	2006-12-19 23:43:10.000000000 +0000
@@ -15,7 +15,8 @@
  *	Michael Engel <engel@unix-ag.org>,
  *	Karsten Merker <merker@linuxtag.org> and
  *	Harald Koerfgen.
- *	Copyright (c) 2005  Maciej W. Rozycki
+ *	Copyright (c) 2005, 2006  Maciej W. Rozycki
+ *	Copyright (c) 2005  James Simmons 
  *
  *	This file is subject to the terms and conditions of the GNU General
  *	Public License.  See the file COPYING in the main directory of this
@@ -28,26 +29,21 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/tc.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
 
-#include <asm/dec/tc.h>
-
 #include <video/pmag-ba-fb.h>
 
 
 struct pmagbafb_par {
-	struct fb_info *next;
 	volatile void __iomem *mmio;
 	volatile u32 __iomem *dac;
-	int slot;
 };
 
 
-static struct fb_info *root_pmagbafb_dev;
-
 static struct fb_var_screeninfo pmagbafb_defined __initdata = {
 	.xres		= 1024,
 	.yres		= 864,
@@ -145,24 +141,19 @@ static void __init pmagbafb_erase_cursor
 }
 
 
-static int __init pmagbafb_init_one(int slot)
+static int __init pmagbafb_probe(struct device *dev)
 {
+	struct tc_dev *tdev = to_tc_dev(dev);
+	resource_size_t start, len;
 	struct fb_info *info;
 	struct pmagbafb_par *par;
-	unsigned long base_addr;
 
-	info = framebuffer_alloc(sizeof(struct pmagbafb_par), NULL);
+	info = framebuffer_alloc(sizeof(struct pmagbafb_par), dev);
 	if (!info)
 		return -ENOMEM;
 
 	par = info->par;
-	par->slot = slot;
-	claim_tc_card(par->slot);
-
-	base_addr = get_tc_base_addr(par->slot);
-
-	par->next = root_pmagbafb_dev;
-	root_pmagbafb_dev = info;
+	dev_set_drvdata(dev, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 		goto err_alloc;
@@ -172,15 +163,21 @@ static int __init pmagbafb_init_one(int 
 	info->var = pmagbafb_defined;
 	info->flags = FBINFO_DEFAULT;
 
+	/* Request the I/O MEM resource.  */
+	start = tdev->resource.start;
+	len = tdev->resource.end - start + 1;
+	if (!request_mem_region(start, len, dev->bus_id))
+		goto err_cmap;
+
 	/* MMIO mapping setup.  */
-	info->fix.mmio_start = base_addr;
+	info->fix.mmio_start = start;
 	par->mmio = ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
 	if (!par->mmio)
-		goto err_cmap;
+		goto err_resource;
 	par->dac = par->mmio + PMAG_BA_BT459;
 
 	/* Frame buffer mapping setup.  */
-	info->fix.smem_start = base_addr + PMAG_BA_FBMEM;
+	info->fix.smem_start = start + PMAG_BA_FBMEM;
 	info->screen_base = ioremap_nocache(info->fix.smem_start,
 					    info->fix.smem_len);
 	if (!info->screen_base)
@@ -192,8 +189,10 @@ static int __init pmagbafb_init_one(int 
 	if (register_framebuffer(info) < 0)
 		goto err_smem_map;
 
-	pr_info("fb%d: %s frame buffer device in slot %d\n",
-		info->node, info->fix.id, par->slot);
+	get_device(dev);
+
+	pr_info("fb%d: %s frame buffer device at %s\n",
+		info->node, info->fix.id, dev->bus_id);
 
 	return 0;
 
@@ -204,54 +203,68 @@ err_smem_map:
 err_mmio_map:
 	iounmap(par->mmio);
 
+err_resource:
+	release_mem_region(start, len);
+
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
 
 err_alloc:
-	root_pmagbafb_dev = par->next;
-	release_tc_card(par->slot);
 	framebuffer_release(info);
 	return -ENXIO;
 }
 
-static void __exit pmagbafb_exit_one(void)
+static int __exit pmagbafb_remove(struct device *dev)
 {
-	struct fb_info *info = root_pmagbafb_dev;
+	struct tc_dev *tdev = to_tc_dev(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct pmagbafb_par *par = info->par;
+	resource_size_t start, len;
 
+	put_device(dev);
 	unregister_framebuffer(info);
 	iounmap(info->screen_base);
 	iounmap(par->mmio);
+	start = tdev->resource.start;
+	len = tdev->resource.end - start + 1;
+	release_mem_region(start, len);
 	fb_dealloc_cmap(&info->cmap);
-	root_pmagbafb_dev = par->next;
-	release_tc_card(par->slot);
 	framebuffer_release(info);
+	return 0;
 }
 
 
 /*
- * Initialise the framebuffer.
+ * Initialize the framebuffer.
  */
+static const struct tc_device_id pmagbafb_tc_table[] = {
+	{ "DEC     ", "PMAG-BA " },
+	{ }
+};
+MODULE_DEVICE_TABLE(tc, pmagbafb_tc_table);
+
+static struct tc_driver pmagbafb_driver = {
+	.id_table	= pmagbafb_tc_table,
+	.driver		= {
+		.name	= "pmagbafb",
+		.bus	= &tc_bus_type,
+		.probe	= pmagbafb_probe,
+		.remove	= __exit_p(pmagbafb_remove),
+	},
+};
+
 static int __init pmagbafb_init(void)
 {
-	int count = 0;
-	int slot;
-
+#ifndef MODULE
 	if (fb_get_options("pmagbafb", NULL))
 		return -ENXIO;
-
-	while ((slot = search_tc_card("PMAG-BA")) >= 0) {
-		if (pmagbafb_init_one(slot) < 0)
-			break;
-		count++;
-	}
-	return (count > 0) ? 0 : -ENXIO;
+#endif
+	return tc_register_driver(&pmagbafb_driver);
 }
 
 static void __exit pmagbafb_exit(void)
 {
-	while (root_pmagbafb_dev)
-		pmagbafb_exit_one();
+	tc_unregister_driver(&pmagbafb_driver);
 }
 
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
