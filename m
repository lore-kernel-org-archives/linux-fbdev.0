From: Guido Guenther <agx@sigxcpu.org>
Subject: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Thu, 18 Nov 2004 17:49:46 +0100
Message-ID: <20041118164946.GA3763@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUphO-0004DV-QR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 09:03:58 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CUphM-0000hp-Th
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 09:03:58 -0800
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

Hi Antonio,
this patch against 2.6.10-rc2 finally detects rivafb on NV30 based power
books by adding the pciid. Wolfram Quester tested it and reported it
working. It also cleans up the error code reported from the probe
function.

Singed-Off-By: Guido Guenther <agx@sigxcpu.org>
Cheers,
 -- Guido

--- linux-2.6.10-rc2.orig/drivers/video/riva/fbdev.c	2004-11-17 17:33:53.000000000 +0100
+++ linux-2.6.10-rc2/drivers/video/riva/fbdev.c	2004-11-18 15:50:56.000000000 +0100
@@ -192,6 +192,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
@@ -1880,31 +1882,37 @@
 {
 	struct riva_par *default_par;
 	struct fb_info *info;
+	int ret;
 
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
 	info = framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
-
-	if (!info)
-		goto err_out;
-
+	if (!info) {
+		printk (KERN_ERR PFX "could not allocate memory\n");
+		ret = -ENOMEM;
+		goto err_ret;
+	}
 	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
-	if (info->pixmap.addr == NULL)
-		goto err_out_kfree;
+	if (info->pixmap.addr == NULL) {
+	    	ret = -ENOMEM;
+		goto err_framebuffer_release;
+	}
 	memset(info->pixmap.addr, 0, 8 * 1024);
 
-	if (pci_enable_device(pd)) {
+	ret = pci_enable_device(pd);
+	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
-		goto err_out_enable;
+		goto err_free_pixmap;
 	}
 
-	if (pci_request_regions(pd, "rivafb")) {
+	ret = pci_request_regions(pd, "rivafb");
+	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
-		goto err_out_request;
+		goto err_disable_device;
 	}
 
 	default_par->riva.Architecture = riva_get_arch(pd);
@@ -1918,7 +1926,8 @@
 
 	if(default_par->riva.Architecture == 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_free_base0;
+		ret=-ENODEV;
+		goto err_release_region;
 	}
 	if(default_par->riva.Architecture == NV_ARCH_10 ||
 	   default_par->riva.Architecture == NV_ARCH_20 ||
@@ -1952,11 +1961,10 @@
 					 rivafb_fix.mmio_len);
 	if (!default_par->ctrl_base) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
-		goto err_out_free_base0;
+		ret = -EIO;
+		goto err_release_region;
 	}
 
-	info->par = default_par;
-
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
 		/* Riva128's PRAMIN is in the "framebuffer" space
@@ -1966,7 +1974,8 @@
 		default_par->riva.PRAMIN = ioremap(rivafb_fix.smem_start + 0x00C00000, 0x00008000);
 		if (!default_par->riva.PRAMIN) {
 			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
-			goto err_out_free_nv3_pramin;
+			ret = -EIO;
+			goto err_iounmap_ctrl_base;
 		}
 		break;
 	case NV_ARCH_04:
@@ -1992,7 +2001,8 @@
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "cannot ioremap FB base\n");
-		goto err_out_free_base1;
+		ret = -EIO;
+		goto err_iounmap_pramin;
 	}
 
 #ifdef CONFIG_MTRR
@@ -2015,17 +2025,19 @@
 	riva_get_EDID(info, pd);
 	riva_get_edidinfo(info);
 
-	if (riva_set_fbinfo(info) < 0) {
+	ret=riva_set_fbinfo(info);
+	if (ret < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
-		goto err_out_iounmap_fb;
+		goto err_iounmap_screen_base;
 	}
 
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb = NULL;
-	if (register_framebuffer(info) < 0) {
+	ret = register_framebuffer(info);
+	if (ret < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
-		goto err_out_iounmap_fb;
+		goto err_iounmap_screen_base;
 	}
 
 	pci_set_drvdata(pd, info);
@@ -2044,26 +2056,26 @@
 	NVTRACE_LEAVE();
 	return 0;
 
-err_out_iounmap_fb:
+err_iounmap_screen_base:
 #ifdef CONFIG_FB_RIVA_I2C
 	riva_delete_i2c_busses((struct riva_par *) info->par);
 #endif
 	iounmap(info->screen_base);
-err_out_free_base1:
+err_iounmap_pramin:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
 		iounmap(default_par->riva.PRAMIN);
-err_out_free_nv3_pramin:
+err_iounmap_ctrl_base:
 	iounmap(default_par->ctrl_base);
-err_out_free_base0:
+err_release_region:
 	pci_release_regions(pd);
-err_out_request:
+err_disable_device:
 	pci_disable_device(pd);
-err_out_enable:
+err_free_pixmap:
 	kfree(info->pixmap.addr);
-err_out_kfree:
+err_framebuffer_release:
 	framebuffer_release(info);
-err_out:
-	return -ENODEV;
+err_ret:
+	return ret;
 }
 
 static void __exit rivafb_remove(struct pci_dev *pd)
--- linux-2.6.10-rc2.orig/include/linux/pci_ids.h	2004-11-17 17:34:04.000000000 +0100
+++ linux-2.6.10-rc2/include/linux/pci_ids.h	2004-11-18 15:50:56.000000000 +0100
@@ -1140,6 +1140,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
