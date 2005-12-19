From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/2] intelfb: Fix freeing of nonexistent resource
Date: Mon, 19 Dec 2005 15:11:40 +0800
Message-ID: <43A65D2C.4050800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoFCk-0000BY-UP
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Dec 2005 23:13:06 -0800
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoFCk-0002dv-8c
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Dec 2005 23:13:06 -0800
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-fbdev-devel@lists.sf.net

Fix intelfb trying to free a non-existent resource in its error path.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 intelfb.h    |    5 +++++
 intelfbdrv.c |    9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)


diff --git a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb.h
index f077ca3..da29d00 100644
--- a/drivers/video/intelfb/intelfb.h
+++ b/drivers/video/intelfb/intelfb.h
@@ -41,6 +41,10 @@
 
 /*** hw-related values ***/
 
+/* Resource Allocation */
+#define INTELFB_FB_ACQUIRED                 1
+#define INTELFB_MMIO_ACQUIRED               2
+
 /* PCI ids for supported devices */
 #define PCI_DEVICE_ID_INTEL_830M	0x3577
 #define PCI_DEVICE_ID_INTEL_845G	0x2562
@@ -257,6 +261,7 @@ struct intelfb_info {
 	int hwcursor;
 	int fixed_mode;
 	int ring_active;
+	int flag;
 
 	/* hw cursor */
 	int cursor_on;
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 427689e..ac8d661 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -473,9 +473,9 @@ cleanup(struct intelfb_info *dinfo)
 	if (dinfo->aperture.virtual)
 		iounmap((void __iomem *)dinfo->aperture.virtual);
 
-	if (dinfo->mmio_base_phys)
+	if (dinfo->flag & INTELFB_MMIO_ACQUIRED)
 		release_mem_region(dinfo->mmio_base_phys, INTEL_REG_SIZE);
-	if (dinfo->aperture.physical)
+	if (dinfo->flag & INTELFB_FB_ACQUIRED)
 		release_mem_region(dinfo->aperture.physical,
 				   dinfo->aperture.size);
 	framebuffer_release(dinfo->info);
@@ -572,6 +572,9 @@ intelfb_pci_register(struct pci_dev *pde
 		cleanup(dinfo);
 		return -ENODEV;
 	}
+
+	dinfo->flag |= INTELFB_FB_ACQUIRED;
+
 	if (!request_mem_region(dinfo->mmio_base_phys,
 				INTEL_REG_SIZE,
 				INTELFB_MODULE_NAME)) {
@@ -580,6 +583,8 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
+	dinfo->flag |= INTELFB_MMIO_ACQUIRED;
+
 	/* Get the chipset info. */
 	dinfo->pci_chipset = pdev->device;
 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
