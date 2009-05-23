From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 03/14] [FB] viafb: Fix various resource
	leaks during module_init()
Date: Sat, 23 May 2009 17:41:25 +0800
Message-ID: <1243071696-9334-3-git-send-email-HaraldWelte@viatech.com>
References: <1243071696-9334-1-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-2-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M7nsE-0005K6-84
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:38 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7ns6-0005OE-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:38 +0000
In-Reply-To: <1243071696-9334-2-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

The current code executed from module_init() in viafb does not have
proper error checking and [partial] resoure release paths in case
an error happens half way through driver initialization.

This patch adresses the most obvious of those issues, such as a
leftover i2c bus if module_init (and thus module load) fails.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/via/viafbdev.c |   52 ++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 02e7a72..72387d4 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
  * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
 
  * This program is free software; you can redistribute it and/or
@@ -2109,7 +2109,7 @@ static int __devinit via_pci_probe(void)
 	unsigned long default_xres, default_yres;
 	char *tmpc, *tmpm;
 	char *tmpc_sec, *tmpm_sec;
-	int vmode_index;
+	int rc, vmode_index;
 	u32 tmds_length, lvds_length, crt_length, chip_length, viafb_par_length;
 
 	DEBUG_MSG(KERN_INFO "VIAFB PCI Probe!!\n");
@@ -2130,7 +2130,7 @@ static int __devinit via_pci_probe(void)
 	tmds_length + crt_length + chip_length, NULL);
 	if (!viafbinfo) {
 		printk(KERN_ERR"Could not allocate memory for viafb_info.\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 
 	viaparinfo = (struct viafb_par *)viafbinfo->par;
@@ -2157,7 +2157,9 @@ static int __devinit via_pci_probe(void)
 		viafb_dual_fb = 0;
 
 	/* Set up I2C bus stuff */
-	viafb_create_i2c_bus(viaparinfo);
+	rc = viafb_create_i2c_bus(viaparinfo);
+	if (rc)
+		goto out_fb_release;
 
 	viafb_init_chip_info();
 	viafb_get_fb_info(&viaparinfo->fbmem, &viaparinfo->memsize);
@@ -2169,7 +2171,8 @@ static int __devinit via_pci_probe(void)
 
 	if (!viaparinfo->fbmem_virt) {
 		printk(KERN_INFO "ioremap failed\n");
-		return -1;
+		rc = -EIO;
+		goto out_delete_i2c;
 	}
 
 	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
@@ -2281,8 +2284,7 @@ static int __devinit via_pci_probe(void)
 		if (!viafbinfo1) {
 			printk(KERN_ERR
 			"allocate the second framebuffer struct error\n");
-			framebuffer_release(viafbinfo);
-			return -ENOMEM;
+			goto out_delete_i2c;
 		}
 		viaparinfo1 = viafbinfo1->par;
 		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
@@ -2343,21 +2345,26 @@ static int __devinit via_pci_probe(void)
 	viafb_update_viafb_par(viafbinfo);
 	viafb_update_fix(&viafbinfo->fix, viafbinfo);
 	default_var.activate = FB_ACTIVATE_NOW;
-	fb_alloc_cmap(&viafbinfo->cmap, 256, 0);
+	rc = fb_alloc_cmap(&viafbinfo->cmap, 256, 0);
+	if (rc)
+		goto out_fb1_release;
 
 	if (viafb_dual_fb && (viafb_primary_dev == LCD_Device)
 	    && (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)) {
-		if (register_framebuffer(viafbinfo1) < 0)
-			return -EINVAL;
+		rc = register_framebuffer(viafbinfo1);
+		if (rc)
+			goto out_dealloc_cmap;
 	}
-	if (register_framebuffer(viafbinfo) < 0)
-		return -EINVAL;
+	rc = register_framebuffer(viafbinfo);
+	if (rc)
+		goto out_fb1_unreg_lcd_cle266;
 
 	if (viafb_dual_fb && ((viafb_primary_dev != LCD_Device)
 			|| (viaparinfo->chip_info->gfx_chip_name !=
 			UNICHROME_CLE266))) {
-		if (register_framebuffer(viafbinfo1) < 0)
-			return -EINVAL;
+		rc = register_framebuffer(viafbinfo1);
+		if (rc)
+			goto out_fb_unreg;
 	}
 	DEBUG_MSG(KERN_INFO "fb%d: %s frame buffer device %dx%d-%dbpp\n",
 		  viafbinfo->node, viafbinfo->fix.id, default_var.xres,
@@ -2366,6 +2373,23 @@ static int __devinit via_pci_probe(void)
 	viafb_init_proc(&viaparinfo->proc_entry);
 	viafb_init_dac(IGA2);
 	return 0;
+
+out_fb_unreg:
+	unregister_framebuffer(viafbinfo);
+out_fb1_unreg_lcd_cle266:
+	if (viafb_dual_fb && (viafb_primary_dev == LCD_Device)
+            && (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266))
+		unregister_framebuffer(viafbinfo1);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&viafbinfo->cmap);
+out_fb1_release:
+	if (viafbinfo1)
+		framebuffer_release(viafbinfo1);
+out_delete_i2c:
+	viafb_delete_i2c_buss(viaparinfo);
+out_fb_release:
+	framebuffer_release(viafbinfo);
+	return rc;
 }
 
 static void __devexit via_pci_remove(void)
-- 
1.6.2.4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
