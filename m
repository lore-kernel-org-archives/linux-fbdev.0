From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][RIVAFB]: Rivafb fixes
Date: Wed, 30 Jun 2004 10:47:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406301047.52653.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfVCh-0005K7-2o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:52:07 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BfVCg-0002Dy-Az
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:52:07 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id AEF337889F
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jun 2004 01:44:53 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James, Andrew

The patch below fixes the following to rivafb:

1. Seems that nVidia hardware has a limit on clipping coordinates
that is also dependent on the color depth of the framebuffer.

2. From Pawel Goleniowski <pawelg@dabrowa.pl>:
Fix for wrong colors at 16bpp (RGB565).  The fix has been submitted
several times in lkml and this list but was never applied.

3. Search all I2C/DDC busses for the EDID block instead of
just the first bus.

4. Updated request_mem_region/release_mem_region to
pci_request_regions/pci_release_regions.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.7-mm4/drivers/video/riva/fbdev.c
--- linux-2.6.7-mm4-orig/drivers/video/riva/fbdev.c	2004-06-30 01:55:19.263987464 +0000
+++ linux-2.6.7-mm4/drivers/video/riva/fbdev.c	2004-06-30 01:57:49.191195064 +0000
@@ -882,13 +882,13 @@
 		       var->xres_virtual, var->yres_virtual);
 	} else if (var->xres_virtual == -1) {
 		var->xres_virtual = (info->fix.smem_len * den /
-			(nom * var->yres_virtual * 2)) & ~15;
+			(nom * var->yres_virtual)) & ~15;
 		printk(KERN_WARNING PFX
 		       "setting virtual X resolution to %d\n", var->xres_virtual);
 	} else if (var->yres_virtual == -1) {
 		var->xres_virtual = (var->xres_virtual + 15) & ~15;
 		var->yres_virtual = info->fix.smem_len * den /
-			(nom * var->xres_virtual * 2);
+			(nom * var->xres_virtual);
 		printk(KERN_WARNING PFX
 		       "setting virtual Y resolution to %d\n", var->yres_virtual);
 	} else {
@@ -920,10 +920,11 @@
 		       "virtual Y resolution (%d) is smaller than real\n", var->yres_virtual);
 		return -EINVAL;
 	}
-	if (var->xres_virtual > 0x7fff)
-	    var->xres_virtual = 0x7fff;
-	if (var->yres_virtual > 0x7fff)
-	    var->yres_virtual = 0x7fff;
+	if (var->yres_virtual > 0x7fff/nom)
+		var->yres_virtual = 0x7fff/nom;
+	if (var->xres_virtual > 0x7fff/nom)
+		var->xres_virtual = 0x7fff/nom;
+
 	return 0;
 }
 
@@ -955,11 +956,14 @@
 
 }
 
-void riva_setup_accel(struct riva_par *par)
+void riva_setup_accel(struct fb_info *info)
 {
+	struct riva_par *par = (struct riva_par *) info->par;
+
 	RIVA_FIFO_FREE(par->riva, Clip, 2);
 	par->riva.Clip->TopLeft     = 0x0;
-	par->riva.Clip->WidthHeight = 0x7fff7fff;
+	par->riva.Clip->WidthHeight = (info->var.xres_virtual & 0xffff) | 
+		(info->var.yres_virtual << 16);
 	riva_set_rop_solid(par, 0xcc);
 	wait_for_idle(par);
 }
@@ -1194,9 +1198,16 @@
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 
+	riva_common_setup(par);
+	RivaGetConfig(&par->riva, par->Chipset);
+	/* vgaHWunlock() + riva unlock (0x7F) */
+	CRTCout(par, 0x11, 0xFF);
+	par->riva.LockUnlock(&par->riva, 0);
+			
 	riva_load_video_mode(info);
-	riva_setup_accel(par);
+	riva_setup_accel(info);
 	
+	memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
@@ -1444,8 +1455,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-		| ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+		| ((*col & 0x00007E0) << 5)
 		| ((*col & 0x0000001F) << 3)
 		|	   0xFF000000;
 	mb();
@@ -1759,9 +1770,16 @@
 	/* XXX use other methods later */
 #ifdef CONFIG_FB_RIVA_I2C
 	struct riva_par *par = (struct riva_par *) info->par;
+	int i;
 
 	riva_create_i2c_busses(par);
-	riva_probe_i2c_connector(par, 1, &par->EDID);
+	for (i = par->bus; i >= 1; i--) {
+		riva_probe_i2c_connector(par, i, &par->EDID);
+		if (par->EDID) {
+			printk("rivafb: Found EDID Block from BUS %i\n", i);
+			break;
+		}
+	}
 	riva_delete_i2c_busses(par);
 #endif
 #endif
@@ -1814,6 +1832,16 @@
 		goto err_out_kfree1;
 	memset(info->pixmap.addr, 0, 64 * 1024);
 
+	if (pci_enable_device(pd)) {
+		printk(KERN_ERR PFX "cannot enable PCI device\n");
+		goto err_out_enable;
+	}
+
+	if (pci_request_regions(pd, "rivafb")) {
+		printk(KERN_ERR PFX "cannot request PCI regions\n");
+		goto err_out_request;
+	}
+
 	strcat(rivafb_fix.id, rci->name);
 	default_par->riva.Architecture = rci->arch_rev;
 
@@ -1840,12 +1868,6 @@
 	rivafb_fix.mmio_start = pci_resource_start(pd, 0);
 	rivafb_fix.smem_start = pci_resource_start(pd, 1);
 
-	if (!request_mem_region(rivafb_fix.mmio_start,
-				rivafb_fix.mmio_len, "rivafb")) {
-		printk(KERN_ERR PFX "cannot reserve MMIO region\n");
-		goto err_out_kfree2;
-	}
-
 	default_par->ctrl_base = ioremap(rivafb_fix.mmio_start,
 					 rivafb_fix.mmio_len);
 	if (!default_par->ctrl_base) {
@@ -1861,17 +1883,13 @@
 		 * Since these cards were never made with more than 8 megabytes
 		 * we can safely allocate this separately.
 		 */
-		if (!request_mem_region(rivafb_fix.smem_start + 0x00C00000,
-					 0x00008000, "rivafb")) {
-			printk(KERN_ERR PFX "cannot reserve PRAMIN region\n");
-			goto err_out_iounmap_ctrl;
-		}
 		default_par->riva.PRAMIN = ioremap(rivafb_fix.smem_start + 0x00C00000, 0x00008000);
 		if (!default_par->riva.PRAMIN) {
 			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
 			goto err_out_free_nv3_pramin;
 		}
 		rivafb_fix.accel = FB_ACCEL_NV3;
+		default_par->bus = 1;
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
@@ -1879,6 +1897,7 @@
 		default_par->riva.PCRTC0 = (unsigned *)(default_par->ctrl_base + 0x00600000);
 		default_par->riva.PRAMIN = (unsigned *)(default_par->ctrl_base + 0x00710000);
 		rivafb_fix.accel = FB_ACCEL_NV4;
+		default_par->bus = 2;
 		break;
 	}
 
@@ -1891,12 +1910,6 @@
 	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
 	default_par->dclk_max = riva_get_maxdclk(default_par) * 1000;
 
-	if (!request_mem_region(rivafb_fix.smem_start,
-				rivafb_fix.smem_len, "rivafb")) {
-		printk(KERN_ERR PFX "cannot reserve FB region\n");
-		goto err_out_iounmap_nv3_pramin;
-	}
-	
 	info->screen_base = ioremap(rivafb_fix.smem_start,
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
@@ -1949,18 +1962,15 @@
 err_out_iounmap_fb:
 	iounmap(info->screen_base);
 err_out_free_base1:
-	release_mem_region(rivafb_fix.smem_start, rivafb_fix.smem_len);
-err_out_iounmap_nv3_pramin:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
 		iounmap((caddr_t)default_par->riva.PRAMIN);
 err_out_free_nv3_pramin:
-	if (default_par->riva.Architecture == NV_ARCH_03)
-		release_mem_region(rivafb_fix.smem_start + 0x00C00000, 0x00008000);
-err_out_iounmap_ctrl:
 	iounmap(default_par->ctrl_base);
 err_out_free_base0:
-	release_mem_region(rivafb_fix.mmio_start, rivafb_fix.mmio_len);
-err_out_kfree2:
+	pci_release_regions(pd);
+err_out_request:
+	pci_disable_device(pd);
+err_out_enable:
 	kfree(info->pixmap.addr);
 err_out_kfree1:
 	kfree(default_par);
@@ -1987,16 +1997,11 @@
 
 	iounmap(par->ctrl_base);
 	iounmap(info->screen_base);
-
-	release_mem_region(info->fix.mmio_start,
-			   info->fix.mmio_len);
-	release_mem_region(info->fix.smem_start,
-			   info->fix.smem_len);
-
-	if (par->riva.Architecture == NV_ARCH_03) {
+	if (par->riva.Architecture == NV_ARCH_03)
 		iounmap((caddr_t)par->riva.PRAMIN);
-		release_mem_region(info->fix.smem_start + 0x00C00000, 0x00008000);
-	}
+	pci_release_regions(pd);
+	pci_disable_device(pd);
+	fb_destroy_modedb(info->monspecs.modedb);
 	kfree(info->pixmap.addr);
 	kfree(par);
 	kfree(info);
diff -Naur linux-2.6.7-mm4-orig/drivers/video/riva/rivafb.h linux-2.6.7-mm4/drivers/video/riva/rivafb.h
--- linux-2.6.7-mm4-orig/drivers/video/riva/rivafb.h	2004-06-30 01:55:16.915344512 +0000
+++ linux-2.6.7-mm4/drivers/video/riva/rivafb.h	2004-06-30 01:54:34.916729272 +0000
@@ -60,6 +60,7 @@
 	Bool SecondCRTC;
 	int FlatPanel;
 	struct pci_dev *pdev;
+	int bus;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
