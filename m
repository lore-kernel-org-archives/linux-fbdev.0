From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: [PATCH] framebuffer_alloc() updates
Date: Wed, 13 Feb 2008 23:47:50 +0100
Message-ID: <20080213224750.GB7181@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPQOR-0007bN-N3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 14:47:55 -0800
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPQOQ-0000mI-Nf
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 14:47:55 -0800
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch corrects dev arg of framebuffer_alloc() in arkfb, s3fb
and vt8623fb.

Patch is against 2.6.24.2 with my previous patch applied
(vt8623fb: beter resume from STR).

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

---

diff -uprN -X linux-2.6.24.2.old/Documentation/dontdiff linux-2.6.24.2.old/drivers/video/arkfb.c linux-2.6.24.2.new/drivers/video/arkfb.c
--- linux-2.6.24.2.old/drivers/video/arkfb.c	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24.2.new/drivers/video/arkfb.c	2008-02-11 11:12:16.000000000 +0100
@@ -941,7 +941,7 @@ static int __devinit ark_pci_probe(struc
 	}
 
 	/* Allocate and fill driver data structure */
-	info = framebuffer_alloc(sizeof(struct arkfb_info), NULL);
+	info = framebuffer_alloc(sizeof(struct arkfb_info), &(dev->dev));
 	if (! info) {
 		dev_err(&(dev->dev), "cannot allocate memory\n");
 		return -ENOMEM;
@@ -956,20 +956,20 @@ static int __devinit ark_pci_probe(struc
 	/* Prepare PCI device */
 	rc = pci_enable_device(dev);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot enable PCI device\n");
+		dev_err(info->dev, "cannot enable PCI device\n");
 		goto err_enable_device;
 	}
 
 	rc = pci_request_regions(dev, "arkfb");
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot reserve framebuffer region\n");
+		dev_err(info->dev, "cannot reserve framebuffer region\n");
 		goto err_request_regions;
 	}
 
 	par->dac = ics5342_init(ark_dac_read_regs, ark_dac_write_regs, info);
 	if (! par->dac) {
 		rc = -ENOMEM;
-		dev_err(&(dev->dev), "RAMDAC initialization failed\n");
+		dev_err(info->dev, "RAMDAC initialization failed\n");
 		goto err_dac;
 	}
 
@@ -980,7 +980,7 @@ static int __devinit ark_pci_probe(struc
 	info->screen_base = pci_iomap(dev, 0, 0);
 	if (! info->screen_base) {
 		rc = -ENOMEM;
-		dev_err(&(dev->dev), "iomap for framebuffer failed\n");
+		dev_err(info->dev, "iomap for framebuffer failed\n");
 		goto err_iomap;
 	}
 
@@ -1002,19 +1002,19 @@ static int __devinit ark_pci_probe(struc
 	rc = fb_find_mode(&(info->var), info, mode, NULL, 0, NULL, 8);
 	if (! ((rc == 1) || (rc == 2))) {
 		rc = -EINVAL;
-		dev_err(&(dev->dev), "mode %s not found\n", mode);
+		dev_err(info->dev, "mode %s not found\n", mode);
 		goto err_find_mode;
 	}
 
 	rc = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot allocate colormap\n");
+		dev_err(info->dev, "cannot allocate colormap\n");
 		goto err_alloc_cmap;
 	}
 
 	rc = register_framebuffer(info);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot register framebugger\n");
+		dev_err(info->dev, "cannot register framebugger\n");
 		goto err_reg_fb;
 	}
 
@@ -1088,7 +1088,7 @@ static int ark_pci_suspend (struct pci_d
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
-	dev_info(&(dev->dev), "suspend\n");
+	dev_info(info->dev, "suspend\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
@@ -1119,7 +1119,7 @@ static int ark_pci_resume (struct pci_de
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
-	dev_info(&(dev->dev), "resume\n");
+	dev_info(info->dev, "resume\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
diff -uprN -X linux-2.6.24.2.old/Documentation/dontdiff linux-2.6.24.2.old/drivers/video/s3fb.c linux-2.6.24.2.new/drivers/video/s3fb.c
--- linux-2.6.24.2.old/drivers/video/s3fb.c	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24.2.new/drivers/video/s3fb.c	2008-02-11 11:12:16.000000000 +0100
@@ -886,7 +886,7 @@ static int __devinit s3_pci_probe(struct
 	}
 
 	/* Allocate and fill driver data structure */
-	info = framebuffer_alloc(sizeof(struct s3fb_info), NULL);
+	info = framebuffer_alloc(sizeof(struct s3fb_info), &(dev->dev));
 	if (!info) {
 		dev_err(&(dev->dev), "cannot allocate memory\n");
 		return -ENOMEM;
@@ -901,13 +901,13 @@ static int __devinit s3_pci_probe(struct
 	/* Prepare PCI device */
 	rc = pci_enable_device(dev);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot enable PCI device\n");
+		dev_err(info->dev, "cannot enable PCI device\n");
 		goto err_enable_device;
 	}
 
 	rc = pci_request_regions(dev, "s3fb");
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot reserve framebuffer region\n");
+		dev_err(info->dev, "cannot reserve framebuffer region\n");
 		goto err_request_regions;
 	}
 
@@ -919,7 +919,7 @@ static int __devinit s3_pci_probe(struct
 	info->screen_base = pci_iomap(dev, 0, 0);
 	if (! info->screen_base) {
 		rc = -ENOMEM;
-		dev_err(&(dev->dev), "iomap for framebuffer failed\n");
+		dev_err(info->dev, "iomap for framebuffer failed\n");
 		goto err_iomap;
 	}
 
@@ -963,19 +963,19 @@ static int __devinit s3_pci_probe(struct
 	rc = fb_find_mode(&(info->var), info, mode, NULL, 0, NULL, 8);
 	if (! ((rc == 1) || (rc == 2))) {
 		rc = -EINVAL;
-		dev_err(&(dev->dev), "mode %s not found\n", mode);
+		dev_err(info->dev, "mode %s not found\n", mode);
 		goto err_find_mode;
 	}
 
 	rc = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot allocate colormap\n");
+		dev_err(info->dev, "cannot allocate colormap\n");
 		goto err_alloc_cmap;
 	}
 
 	rc = register_framebuffer(info);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot register framebuffer\n");
+		dev_err(info->dev, "cannot register framebuffer\n");
 		goto err_reg_fb;
 	}
 
@@ -1051,7 +1051,7 @@ static int s3_pci_suspend(struct pci_dev
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct s3fb_info *par = info->par;
 
-	dev_info(&(dev->dev), "suspend\n");
+	dev_info(info->dev, "suspend\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
@@ -1083,7 +1083,7 @@ static int s3_pci_resume(struct pci_dev*
 	struct s3fb_info *par = info->par;
 	int err;
 
-	dev_info(&(dev->dev), "resume\n");
+	dev_info(info->dev, "resume\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
@@ -1100,7 +1100,7 @@ static int s3_pci_resume(struct pci_dev*
 	if (err) {
 		mutex_unlock(&(par->open_lock));
 		release_console_sem();
-		dev_err(&(dev->dev), "error %d enabling device for resume\n", err);
+		dev_err(info->dev, "error %d enabling device for resume\n", err);
 		return err;
 	}
 	pci_set_master(dev);
diff -uprN -X linux-2.6.24.2.old/Documentation/dontdiff linux-2.6.24.2.old/drivers/video/vt8623fb.c linux-2.6.24.2.new/drivers/video/vt8623fb.c
--- linux-2.6.24.2.old/drivers/video/vt8623fb.c	2008-02-13 23:29:54.000000000 +0100
+++ linux-2.6.24.2.new/drivers/video/vt8623fb.c	2008-02-11 11:12:16.000000000 +0100
@@ -659,7 +659,7 @@ static int __devinit vt8623_pci_probe(st
 	}
 
 	/* Allocate and fill driver data structure */
-	info = framebuffer_alloc(sizeof(struct vt8623fb_info), NULL);
+	info = framebuffer_alloc(sizeof(struct vt8623fb_info), &(dev->dev));
 	if (! info) {
 		dev_err(&(dev->dev), "cannot allocate memory\n");
 		return -ENOMEM;
@@ -675,13 +675,13 @@ static int __devinit vt8623_pci_probe(st
 
 	rc = pci_enable_device(dev);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot enable PCI device\n");
+		dev_err(info->dev, "cannot enable PCI device\n");
 		goto err_enable_device;
 	}
 
 	rc = pci_request_regions(dev, "vt8623fb");
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot reserve framebuffer region\n");
+		dev_err(info->dev, "cannot reserve framebuffer region\n");
 		goto err_request_regions;
 	}
 
@@ -694,14 +694,14 @@ static int __devinit vt8623_pci_probe(st
 	info->screen_base = pci_iomap(dev, 0, 0);
 	if (! info->screen_base) {
 		rc = -ENOMEM;
-		dev_err(&(dev->dev), "iomap for framebuffer failed\n");
+		dev_err(info->dev, "iomap for framebuffer failed\n");
 		goto err_iomap_1;
 	}
 
 	par->mmio_base = pci_iomap(dev, 1, 0);
 	if (! par->mmio_base) {
 		rc = -ENOMEM;
-		dev_err(&(dev->dev), "iomap for MMIO failed\n");
+		dev_err(info->dev, "iomap for MMIO failed\n");
 		goto err_iomap_2;
 	}
 
@@ -712,7 +712,7 @@ static int __devinit vt8623_pci_probe(st
 	if ((16 <= memsize1) && (memsize1 <= 64) && (memsize1 == memsize2))
 		info->screen_size = memsize1 << 20;
 	else {
-		dev_err(&(dev->dev), "memory size detection failed (%x %x), suppose 16 MB\n", memsize1, memsize2);
+		dev_err(info->dev, "memory size detection failed (%x %x), suppose 16 MB\n", memsize1, memsize2);
 		info->screen_size = 16 << 20;
 	}
 
@@ -729,19 +729,19 @@ static int __devinit vt8623_pci_probe(st
 	rc = fb_find_mode(&(info->var), info, mode, NULL, 0, NULL, 8);
 	if (! ((rc == 1) || (rc == 2))) {
 		rc = -EINVAL;
-		dev_err(&(dev->dev), "mode %s not found\n", mode);
+		dev_err(info->dev, "mode %s not found\n", mode);
 		goto err_find_mode;
 	}
 
 	rc = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot allocate colormap\n");
+		dev_err(info->dev, "cannot allocate colormap\n");
 		goto err_alloc_cmap;
 	}
 
 	rc = register_framebuffer(info);
 	if (rc < 0) {
-		dev_err(&(dev->dev), "cannot register framebugger\n");
+		dev_err(info->dev, "cannot register framebugger\n");
 		goto err_reg_fb;
 	}
 
@@ -815,7 +815,7 @@ static int vt8623_pci_suspend(struct pci
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
-	dev_info(&(dev->dev), "suspend\n");
+	dev_info(info->dev, "suspend\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
@@ -846,7 +846,7 @@ static int vt8623_pci_resume(struct pci_
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
-	dev_info(&(dev->dev), "resume\n");
+	dev_info(info->dev, "resume\n");
 
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
