From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: Only request resources we need
Date: Wed, 31 Aug 2005 15:01:57 +1000
Message-ID: <1125464517.5382.10.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAKjh-0007SU-71
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 22:02:09 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EAKjg-00010P-TM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 22:02:09 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

from: Daniel Burcaw <dburcaw@terrasoftsolutions.com>

This patch changes radeon to request only resources 0 and 2 instead of
all 3. This works around problems with some setups where BAR 1 (IO BAR)
has not been assigned by the firmware since it's not used on the machine
and the kernel fails to assign something to it due to the card being
between a P2P bridge that was configured without an IO range at all.

This typically fixes radeonfb on some Apple Xserve G5 machines

Signed-off-by: Daniel Burcaw <dburcaw@terrasoftsolutions.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-08-01 22:03:46.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2005-08-31 14:59:50.000000000 +1000
@@ -2312,19 +2312,27 @@
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
 	/* request the mem regions */
-	ret = pci_request_regions(pdev, "radeonfb");
+	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
-		printk( KERN_ERR "radeonfb (%s): cannot reserve PCI regions."
-			"  Someone already got them?\n", pci_name(rinfo->pdev));
+		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
+			pci_name(rinfo->pdev));
 		goto err_release_fb;
 	}
 
+	ret = pci_request_region(pdev, 2, "radeonfb mmio");
+	if (ret < 0) {
+		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
+			pci_name(rinfo->pdev));
+		goto err_release_pci0;
+	}
+
 	/* map the regions */
 	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
-		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n", pci_name(rinfo->pdev));
+		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n",
+		       pci_name(rinfo->pdev));
 		ret = -EIO;
-		goto err_release_pci;
+		goto err_release_pci2;
 	}
 
 	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
@@ -2499,10 +2507,12 @@
 	if (rinfo->bios_seg)
 		radeon_unmap_ROM(rinfo, pdev);
 	iounmap(rinfo->mmio_base);
-err_release_pci:
-	pci_release_regions(pdev);
+err_release_pci2:
+	pci_release_region(pdev, 2);
+err_release_pci0:
+	pci_release_region(pdev, 0);
 err_release_fb:
-	framebuffer_release(info);
+        framebuffer_release(info);
 err_disable:
 	pci_disable_device(pdev);
 err_out:
@@ -2548,7 +2558,8 @@
         iounmap(rinfo->mmio_base);
         iounmap(rinfo->fb_base);
  
- 	pci_release_regions(pdev);
+	pci_release_region(pdev, 2);
+	pci_release_region(pdev, 0);
 
 	kfree(rinfo->mon1_EDID);
 	kfree(rinfo->mon2_EDID);




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
