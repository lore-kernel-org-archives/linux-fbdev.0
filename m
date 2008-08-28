From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 3/3] tdfxfb: do not make changes to
	default tdfx_fix
Date: Thu, 28 Aug 2008 22:20:30 +0200
Message-ID: <20080828222030.60fcba44.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYnsa-0006Fk-0B for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:14:04 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYnsY-0000k0-2d
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:14:04 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This was suggested by Geert Uytterhoeven
to avoid overwriting of default values
from the tdfx_fix.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

 drivers/video/tdfxfb.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 4599a43..14bd3f3 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -1195,57 +1195,58 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	default_par = info->par;
+	info->fix = tdfx_fix;
 
 	/* Configure the default fb_fix_screeninfo first */
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_3DFX_BANSHEE:
-		strcpy(tdfx_fix.id, "3Dfx Banshee");
+		strcpy(info->fix.id, "3Dfx Banshee");
 		default_par->max_pixclock = BANSHEE_MAX_PIXCLOCK;
 		break;
 	case PCI_DEVICE_ID_3DFX_VOODOO3:
-		strcpy(tdfx_fix.id, "3Dfx Voodoo3");
+		strcpy(info->fix.id, "3Dfx Voodoo3");
 		default_par->max_pixclock = VOODOO3_MAX_PIXCLOCK;
 		break;
 	case PCI_DEVICE_ID_3DFX_VOODOO5:
-		strcpy(tdfx_fix.id, "3Dfx Voodoo5");
+		strcpy(info->fix.id, "3Dfx Voodoo5");
 		default_par->max_pixclock = VOODOO5_MAX_PIXCLOCK;
 		break;
 	}
 
-	tdfx_fix.mmio_start = pci_resource_start(pdev, 0);
-	tdfx_fix.mmio_len = pci_resource_len(pdev, 0);
-	if (!request_mem_region(tdfx_fix.mmio_start, tdfx_fix.mmio_len,
+	info->fix.mmio_start = pci_resource_start(pdev, 0);
+	info->fix.mmio_len = pci_resource_len(pdev, 0);
+	if (!request_mem_region(info->fix.mmio_start, info->fix.mmio_len,
 				"tdfx regbase")) {
 		printk(KERN_ERR "tdfxfb: Can't reserve regbase\n");
 		goto out_err;
 	}
 
 	default_par->regbase_virt =
-		ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
+		ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
 	if (!default_par->regbase_virt) {
 		printk(KERN_ERR "fb: Can't remap %s register area.\n",
-				tdfx_fix.id);
+				info->fix.id);
 		goto out_err_regbase;
 	}
 
-	tdfx_fix.smem_start = pci_resource_start(pdev, 1);
-	tdfx_fix.smem_len = do_lfb_size(default_par, pdev->device);
-	if (!tdfx_fix.smem_len) {
-		printk(KERN_ERR "fb: Can't count %s memory.\n", tdfx_fix.id);
+	info->fix.smem_start = pci_resource_start(pdev, 1);
+	info->fix.smem_len = do_lfb_size(default_par, pdev->device);
+	if (!info->fix.smem_len) {
+		printk(KERN_ERR "fb: Can't count %s memory.\n", info->fix.id);
 		goto out_err_regbase;
 	}
 
-	if (!request_mem_region(tdfx_fix.smem_start,
+	if (!request_mem_region(info->fix.smem_start,
 				pci_resource_len(pdev, 1), "tdfx smem")) {
 		printk(KERN_ERR "tdfxfb: Can't reserve smem\n");
 		goto out_err_regbase;
 	}
 
-	info->screen_base = ioremap_nocache(tdfx_fix.smem_start,
-					    tdfx_fix.smem_len);
+	info->screen_base = ioremap_nocache(info->fix.smem_start,
+					    info->fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR "fb: Can't remap %s framebuffer.\n",
-				tdfx_fix.id);
+				info->fix.id);
 		goto out_err_screenbase;
 	}
 
@@ -1257,20 +1258,19 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 		goto out_err_screenbase;
 	}
 
-	printk(KERN_INFO "fb: %s memory = %dK\n", tdfx_fix.id,
-			tdfx_fix.smem_len >> 10);
+	printk(KERN_INFO "fb: %s memory = %dK\n", info->fix.id,
+			info->fix.smem_len >> 10);
 
 	default_par->mtrr_handle = -1;
 	if (!nomtrr)
 		default_par->mtrr_handle =
-			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
+			mtrr_add(info->fix.smem_start, info->fix.smem_len,
 				 MTRR_TYPE_WRCOMB, 1);
 
-	tdfx_fix.ypanstep	= nopan ? 0 : 1;
-	tdfx_fix.ywrapstep	= nowrap ? 0 : 1;
+	info->fix.ypanstep	= nopan ? 0 : 1;
+	info->fix.ywrapstep	= nowrap ? 0 : 1;
 
 	info->fbops		= &tdfxfb_ops;
-	info->fix		= tdfx_fix;
 	info->pseudo_palette	= default_par->palette;
 	info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_3DFX_ACCEL
@@ -1323,14 +1323,14 @@ out_err_iobase:
 out_err_screenbase:
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	release_mem_region(tdfx_fix.smem_start, pci_resource_len(pdev, 1));
+	release_mem_region(info->fix.smem_start, pci_resource_len(pdev, 1));
 out_err_regbase:
 	/*
 	 * Cleanup after anything that was remapped/allocated.
 	 */
 	if (default_par->regbase_virt)
 		iounmap(default_par->regbase_virt);
-	release_mem_region(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
+	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
 out_err:
 	framebuffer_release(info);
 	return -ENXIO;
-- 
1.5.2.2


----------------------------------------------------------------------
Tani telefon!
Sprawdz >>> http://link.interia.pl/f1ef5 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
