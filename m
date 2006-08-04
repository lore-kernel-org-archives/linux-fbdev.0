From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.18-rc2-mm1] intelfb: cleanup pci IDs
Date: Fri,  4 Aug 2006 13:28:13 -0400 (EDT)
Message-ID: <20060804172813.B60A9126C95@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G93Pi-0006Nu-Vc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 10:24:47 -0700
Received: from mail2.sea5.speakeasy.net ([69.17.117.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G93Pi-00014F-Hk
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 10:24:46 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ehustvedt@cecropia.com, airlied@skynet.ie

From: Dennis Munsie <dmunsie@cecropia.com>

Little patch to the intelfb that uses include/linux/pci_ids.h instead of locally defining the PCI ids.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfb.h    |   10 ----------
 drivers/video/intelfb/intelfbdrv.c |   24 ++++++++++++------------
 drivers/video/intelfb/intelfbhw.c  |   30 +++++++++++++++---------------
 3 files changed, 27 insertions(+), 37 deletions(-)

diff -Naurp -X linux-2.6.18-rc2-patched/Documentation/dontdiff linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfb.h linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfb.h
--- linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfb.h	2006-07-18 05:15:21.000000000 -0500
+++ linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfb.h	2006-08-04 20:15:01.000000000 -0500
@@ -49,16 +49,6 @@
 #define INTELFB_FB_ACQUIRED                 1
 #define INTELFB_MMIO_ACQUIRED               2
 
-/* PCI ids for supported devices */
-#define PCI_DEVICE_ID_INTEL_830M	0x3577
-#define PCI_DEVICE_ID_INTEL_845G	0x2562
-#define PCI_DEVICE_ID_INTEL_85XGM	0x3582
-#define PCI_DEVICE_ID_INTEL_865G	0x2572
-#define PCI_DEVICE_ID_INTEL_915G	0x2582
-#define PCI_DEVICE_ID_INTEL_915GM	0x2592
-#define PCI_DEVICE_ID_INTEL_945G	0x2772
-#define PCI_DEVICE_ID_INTEL_945GM	0x27A2
-
 /* Size of MMIO region */
 #define INTEL_REG_SIZE			0x80000
 
diff -Naurp -X linux-2.6.18-rc2-patched/Documentation/dontdiff linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbdrv.c linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbdrv.c	2006-07-18 05:15:21.000000000 -0500
+++ linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfbdrv.c	2006-08-04 20:14:57.000000000 -0500
@@ -179,14 +179,14 @@ static int __devinit intelfb_set_fbinfo(
 #endif
 
 static struct pci_device_id intelfb_pci_table[] __devinitdata = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_830M, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_830M },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915GM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945G },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945GM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945GM },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82830_CGC, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_830M },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82845G_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82855GM_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82865_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82915G_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82915GM_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82945G_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82945GM_IG, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945GM },
 	{ 0, }
 };
 
@@ -559,10 +559,10 @@ intelfb_pci_register(struct pci_dev *pde
 	}
 
 	/* Set base addresses. */
-	if ((ent->device == PCI_DEVICE_ID_INTEL_915G) ||
-	    (ent->device == PCI_DEVICE_ID_INTEL_915GM) ||
-	    (ent->device == PCI_DEVICE_ID_INTEL_945G)  ||
-	    (ent->device == PCI_DEVICE_ID_INTEL_945GM)) {
+	if ((ent->device == PCI_DEVICE_ID_INTEL_82915G_IG) ||
+	    (ent->device == PCI_DEVICE_ID_INTEL_82915GM_IG) ||
+	    (ent->device == PCI_DEVICE_ID_INTEL_82945G_IG)  ||
+	    (ent->device == PCI_DEVICE_ID_INTEL_82945GM_IG)) {
 		aperture_bar = 2;
 		mmio_bar = 0;
 	}
diff -Naurp -X linux-2.6.18-rc2-patched/Documentation/dontdiff linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c	2006-07-24 16:47:39.000000000 -0500
+++ linux-2.6.18-rc2-device-id/drivers/video/intelfb/intelfbhw.c	2006-08-04 20:14:47.000000000 -0500
@@ -73,19 +73,19 @@ intelfbhw_get_chipset(struct pci_dev *pd
 		return 1;
 
 	switch (pdev->device) {
-	case PCI_DEVICE_ID_INTEL_830M:
+	case PCI_DEVICE_ID_INTEL_82830_CGC:
 		dinfo->name = "Intel(R) 830M";
 		dinfo->chipset = INTEL_830M;
 		dinfo->mobile = 1;
 		dinfo->pll_index = PLLS_I8xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_845G:
+	case PCI_DEVICE_ID_INTEL_82845G_IG:
 		dinfo->name = "Intel(R) 845G";
 		dinfo->chipset = INTEL_845G;
 		dinfo->mobile = 0;
 		dinfo->pll_index = PLLS_I8xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_85XGM:
+	case PCI_DEVICE_ID_INTEL_82855GM_IG:
 		tmp = 0;
 		dinfo->mobile = 1;
 		dinfo->pll_index = PLLS_I8xx;
@@ -114,31 +114,31 @@ intelfbhw_get_chipset(struct pci_dev *pd
 			return 0;
 		}
 		break;
-	case PCI_DEVICE_ID_INTEL_865G:
+	case PCI_DEVICE_ID_INTEL_82865_IG:
 		dinfo->name = "Intel(R) 865G";
 		dinfo->chipset = INTEL_865G;
 		dinfo->mobile = 0;
 		dinfo->pll_index = PLLS_I8xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_915G:
+	case PCI_DEVICE_ID_INTEL_82915G_IG:
 		dinfo->name = "Intel(R) 915G";
 		dinfo->chipset = INTEL_915G;
 		dinfo->mobile = 0;
 		dinfo->pll_index = PLLS_I9xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_915GM:
+	case PCI_DEVICE_ID_INTEL_82915GM_IG:
 		dinfo->name = "Intel(R) 915GM";
 		dinfo->chipset = INTEL_915GM;
 		dinfo->mobile = 1;
 		dinfo->pll_index = PLLS_I9xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_945G:
+	case PCI_DEVICE_ID_INTEL_82945G_IG:
 		dinfo->name = "Intel(R) 945G";
 		dinfo->chipset = INTEL_945G;
 		dinfo->mobile = 0;
 		dinfo->pll_index = PLLS_I9xx;
 		return 0;
-	case PCI_DEVICE_ID_INTEL_945GM:
+	case PCI_DEVICE_ID_INTEL_82945GM_IG:
 		dinfo->name = "Intel(R) 945GM";
 		dinfo->chipset = INTEL_945GM;
 		dinfo->mobile = 1;
@@ -170,10 +170,10 @@ intelfbhw_get_memory(struct pci_dev *pde
 	tmp = 0;
 	pci_read_config_word(bridge_dev, INTEL_GMCH_CTRL, &tmp);
 	switch (pdev->device) {
-	case PCI_DEVICE_ID_INTEL_915G:
-	case PCI_DEVICE_ID_INTEL_915GM:
-	case PCI_DEVICE_ID_INTEL_945G:
-	case PCI_DEVICE_ID_INTEL_945GM:
+	case PCI_DEVICE_ID_INTEL_82915G_IG:
+	case PCI_DEVICE_ID_INTEL_82915GM_IG:
+	case PCI_DEVICE_ID_INTEL_82945G_IG:
+	case PCI_DEVICE_ID_INTEL_82945GM_IG:
 		/* 915 and 945 chipsets support a 256MB aperture.
 		   Aperture size is determined by inspected the
 		   base address of the aperture. */
@@ -194,8 +194,8 @@ intelfbhw_get_memory(struct pci_dev *pde
 	   GTT is 1K per MB of aperture size, and popup is 4K. */
 	stolen_overhead = (*aperture_size / MB(1)) + 4;
 	switch(pdev->device) {
-	case PCI_DEVICE_ID_INTEL_830M:
-	case PCI_DEVICE_ID_INTEL_845G:
+	case PCI_DEVICE_ID_INTEL_82830_CGC:
+	case PCI_DEVICE_ID_INTEL_82845G_IG:
 		switch (tmp & INTEL_830_GMCH_GMS_MASK) {
 		case INTEL_830_GMCH_GMS_STOLEN_512:
 			*stolen_size = KB(512) - KB(stolen_overhead);
@@ -1387,7 +1387,7 @@ intelfbhw_program_mode(struct intelfb_in
 	OUTREG(ADPA, tmp);
 
 	/* setup display plane */
-	if (dinfo->pdev->device == PCI_DEVICE_ID_INTEL_830M) {
+	if (dinfo->pdev->device == PCI_DEVICE_ID_INTEL_82830_CGC) {
 		/*
 		 *      i830M errata: the display plane must be enabled
 		 *      to allow writes to the other bits in the plane

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
