From: Guido Guenther <agx@sigxcpu.org>
Subject: [PATCH]: rivafb, use framebuffer_alloc
Date: Sun, 26 Sep 2004 11:27:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040926092750.GA3936@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBet5-0005xS-J1
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 12:40:47 -0700
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CBet3-0005Sp-4g
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 12:40:47 -0700
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sf.net


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
attached patch against 2.6.9-rc2 converts rivafb to use
framebuffer_alloc and tries to be more specific about the errors that
occure during init. Please apply.
Cheers,
 -- Guido

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rivafb-2.6.9-rc2-framebuffer_alloc.diff"

--- linux-2.6.9-rc2.orig/drivers/video/riva/fbdev.c	2004-09-15 09:23:42.000000000 +0200
+++ linux-2.6.9-rc2/drivers/video/riva/fbdev.c	2004-09-26 10:57:41.000000000 +0200
@@ -1854,35 +1865,36 @@
 {
 	struct riva_par *default_par;
 	struct fb_info *info;
+	int ret;
 
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	info = kmalloc(sizeof(struct fb_info), GFP_KERNEL);
-	if (!info)
+	ret=pci_enable_device(pd);
+	if (ret < 0) {
+		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		goto err_out;
-
-	default_par = kmalloc(sizeof(struct riva_par), GFP_KERNEL);
-	if (!default_par)
-		goto err_out_kfree;
-
-	memset(info, 0, sizeof(struct fb_info));
-	memset(default_par, 0, sizeof(struct riva_par));
+	}
+	info = framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
+	if (!info) {
+		printk (KERN_ERR PFX "could not allocate memory\n");
+		ret = -ENOMEM;
+		goto err_pci_disable;
+	}
+	default_par = info->par;
 	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
-	if (info->pixmap.addr == NULL)
-		goto err_out_kfree1;
-	memset(info->pixmap.addr, 0, 64 * 1024);
-
-	if (pci_enable_device(pd)) {
-		printk(KERN_ERR PFX "cannot enable PCI device\n");
-		goto err_out_enable;
+	if (info->pixmap.addr == NULL) {
+	    	ret = -ENOMEM;
+		goto err_release_fb;
 	}
+	memset(info->pixmap.addr, 0, 64 * 1024);
 
-	if (pci_request_regions(pd, "rivafb")) {
+	ret=pci_request_regions(pd, "rivafb");
+	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
-		goto err_out_request;
+		goto err_free_pixmap;
 	}
 
 	default_par->riva.Architecture = riva_get_arch(pd);
@@ -1896,7 +1908,8 @@
 
 	if(default_par->riva.Architecture == 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_kfree1;
+		ret=-ENODEV;
+		goto err_release_pci;
 	}
 	if(default_par->riva.Architecture == NV_ARCH_10 ||
 	   default_par->riva.Architecture == NV_ARCH_20 ||
@@ -1930,11 +1943,10 @@
 					 rivafb_fix.mmio_len);
 	if (!default_par->ctrl_base) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
-		goto err_out_free_base0;
+		ret = -EIO;
+		goto err_release_pci;
 	}
 
-	info->par = default_par;
-
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
 		/* Riva128's PRAMIN is in the "framebuffer" space
@@ -1944,7 +1956,8 @@
 		default_par->riva.PRAMIN = ioremap(rivafb_fix.smem_start + 0x00C00000, 0x00008000);
 		if (!default_par->riva.PRAMIN) {
 			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
-			goto err_out_free_nv3_pramin;
+			ret = -EIO;
+			goto err_iounmap_ctrl_base;
 		}
 		rivafb_fix.accel = FB_ACCEL_NV3;
 		break;
@@ -1970,7 +1983,8 @@
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "cannot ioremap FB base\n");
-		goto err_out_free_base1;
+		ret = -EIO;
+		goto err_iounmap_pramin;
 	}
 
 #ifdef CONFIG_MTRR
@@ -1993,19 +2007,21 @@
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
 	info->monspecs.modedb_len = 0;
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
@@ -2024,28 +2040,26 @@
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
 		iounmap((caddr_t)default_par->riva.PRAMIN);
-err_out_free_nv3_pramin:
+err_iounmap_ctrl_base:
 	iounmap(default_par->ctrl_base);
-err_out_free_base0:
+err_release_pci:
 	pci_release_regions(pd);
-err_out_request:
-	pci_disable_device(pd);
-err_out_enable:
+err_free_pixmap:
 	kfree(info->pixmap.addr);
-err_out_kfree1:
-	kfree(default_par);
-err_out_kfree:
-	kfree(info);
+err_release_fb:
+	framebuffer_release(info);
+err_pci_disable:
+	pci_disable_device(pd);
 err_out:
-	return -ENODEV;
+	return ret;
 }
 
 static void __exit rivafb_remove(struct pci_dev *pd)

--nFreZHaLTZJo0R7j--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
