From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/4] fbdev: Add NV30 pci_id and cleanup of probe error returns
Date: Mon, 22 Nov 2004 07:16:55 +0800
Message-ID: <200411220716.55082.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CW10Z-0002Xb-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:39 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CW10F-00046z-7U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:39 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1A0C59D8E2F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Nov 2004 23:20:02 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Guido Guenther <agx@sigxcpu.org>

=46rom Guido Guenther <agx@sigxcpu.org>
this patch against 2.6.10-rc2 finally detects rivafb on NV30 based power
books by adding the pciid. Wolfram Quester tested it and reported it
working. It also cleans up the error code reported from the probe
function.

=46rom Antonino Daplas <adaplas@pol.net>
=2D do not validate mode if monitor specifications are not available

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 drivers/video/riva/fbdev.c |   73 ++++++++++++++++++++++++++--------------=
=2D----
 include/linux/pci_ids.h    |    1
 2 files changed, 44 insertions(+), 30 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
=2D-- a/drivers/video/riva/fbdev.c	2004-11-17 18:15:21 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-11-22 06:48:45 +08:00
@@ -192,6 +192,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
@@ -1110,7 +1112,8 @@
 	}
=20
 	if (!strictmode) {
=2D		if (!fb_validate_mode(var, info))
+		if (!info->monspecs.vfmax || !info->monspecs.hfmax ||
+		    !info->monspecs.dclkmax || !fb_validate_mode(var, info))
 			mode_valid =3D 1;
 	}
=20
@@ -1894,31 +1897,37 @@
 {
 	struct riva_par *default_par;
 	struct fb_info *info;
+	int ret;
=20
 	NVTRACE_ENTER();
 	assert(pd !=3D NULL);
=20
 	info =3D framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
=2D
=2D	if (!info)
=2D		goto err_out;
=2D
+	if (!info) {
+		printk (KERN_ERR PFX "could not allocate memory\n");
+		ret =3D -ENOMEM;
+		goto err_ret;
+	}
 	default_par =3D (struct riva_par *) info->par;
 	default_par->pdev =3D pd;
=20
 	info->pixmap.addr =3D kmalloc(8 * 1024, GFP_KERNEL);
=2D	if (info->pixmap.addr =3D=3D NULL)
=2D		goto err_out_kfree;
+	if (info->pixmap.addr =3D=3D NULL) {
+	    	ret =3D -ENOMEM;
+		goto err_framebuffer_release;
+	}
 	memset(info->pixmap.addr, 0, 8 * 1024);
=20
=2D	if (pci_enable_device(pd)) {
+	ret =3D pci_enable_device(pd);
+	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
=2D		goto err_out_enable;
+		goto err_free_pixmap;
 	}
=20
=2D	if (pci_request_regions(pd, "rivafb")) {
+	ret =3D pci_request_regions(pd, "rivafb");
+	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
=2D		goto err_out_request;
+		goto err_disable_device;
 	}
=20
 	default_par->riva.Architecture =3D riva_get_arch(pd);
@@ -1932,7 +1941,8 @@
=20
 	if(default_par->riva.Architecture =3D=3D 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
=2D		goto err_out_free_base0;
+		ret=3D-ENODEV;
+		goto err_release_region;
 	}
 	if(default_par->riva.Architecture =3D=3D NV_ARCH_10 ||
 	   default_par->riva.Architecture =3D=3D NV_ARCH_20 ||
@@ -1966,11 +1976,10 @@
 					 rivafb_fix.mmio_len);
 	if (!default_par->ctrl_base) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
=2D		goto err_out_free_base0;
+		ret =3D -EIO;
+		goto err_release_region;
 	}
=20
=2D	info->par =3D default_par;
=2D
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
 		/* Riva128's PRAMIN is in the "framebuffer" space
@@ -1980,7 +1989,8 @@
 		default_par->riva.PRAMIN =3D ioremap(rivafb_fix.smem_start + 0x00C00000,=
 0x00008000);
 		if (!default_par->riva.PRAMIN) {
 			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
=2D			goto err_out_free_nv3_pramin;
+			ret =3D -EIO;
+			goto err_iounmap_ctrl_base;
 		}
 		break;
 	case NV_ARCH_04:
@@ -2006,7 +2016,8 @@
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "cannot ioremap FB base\n");
=2D		goto err_out_free_base1;
+		ret =3D -EIO;
+		goto err_iounmap_pramin;
 	}
=20
 #ifdef CONFIG_MTRR
@@ -2029,17 +2040,19 @@
 	riva_get_EDID(info, pd);
 	riva_get_edidinfo(info);
=20
=2D	if (riva_set_fbinfo(info) < 0) {
+	ret=3Driva_set_fbinfo(info);
+	if (ret < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
=2D		goto err_out_iounmap_fb;
+		goto err_iounmap_screen_base;
 	}
=20
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb =3D NULL;
=2D	if (register_framebuffer(info) < 0) {
+	ret =3D register_framebuffer(info);
+	if (ret < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
=2D		goto err_out_iounmap_fb;
+		goto err_iounmap_screen_base;
 	}
=20
 	pci_set_drvdata(pd, info);
@@ -2058,26 +2071,26 @@
 	NVTRACE_LEAVE();
 	return 0;
=20
=2Derr_out_iounmap_fb:
+err_iounmap_screen_base:
 #ifdef CONFIG_FB_RIVA_I2C
 	riva_delete_i2c_busses((struct riva_par *) info->par);
 #endif
 	iounmap(info->screen_base);
=2Derr_out_free_base1:
+err_iounmap_pramin:
 	if (default_par->riva.Architecture =3D=3D NV_ARCH_03)=20
 		iounmap(default_par->riva.PRAMIN);
=2Derr_out_free_nv3_pramin:
+err_iounmap_ctrl_base:
 	iounmap(default_par->ctrl_base);
=2Derr_out_free_base0:
+err_release_region:
 	pci_release_regions(pd);
=2Derr_out_request:
+err_disable_device:
 	pci_disable_device(pd);
=2Derr_out_enable:
+err_free_pixmap:
 	kfree(info->pixmap.addr);
=2Derr_out_kfree:
+err_framebuffer_release:
 	framebuffer_release(info);
=2Derr_out:
=2D	return -ENODEV;
+err_ret:
+	return ret;
 }
=20
 static void __exit rivafb_remove(struct pci_dev *pd)
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
=2D-- a/include/linux/pci_ids.h	2004-11-17 18:15:24 +08:00
+++ b/include/linux/pci_ids.h	2004-11-18 22:50:56 +08:00
@@ -1143,6 +1143,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
=20
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
