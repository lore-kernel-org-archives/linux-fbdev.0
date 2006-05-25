From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc4-mm3] intelfb stolen memory patch
Date: Wed, 24 May 2006 21:15:46 -0400
Message-ID: <5D20BF35-5FD4-4803-864F-E37DD182EDC0@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fj4S7-0002ZQ-JQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 18:15:51 -0700
Received: from mail2.sea5.speakeasy.net ([69.17.117.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Fj4S7-0005jr-8x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 18:15:51 -0700
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: airlied@skynet.ie, sylvain.meyer@worldonline.fr, Eric Hustvedt <ehustvedt@cecropia.com>

Passing along a patch here -- this patch was developed against 2.6.17- 
rc4-mm3 because it depends on the 945G/GM support that Dave Airlie  
put together.

dennis


From: Eric Hustvedt <ehustvedt@cecropia.com>

Adds support for 256MB aperture on 945 chipsets to the intelfb driver
and corrects calculation of stolen memory overhead.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

intelfbhw.c |   46 +++++++++++++++++++++++++++++++++-------------
1 file changed, 33 insertions(+), 13 deletions(-)

diff -Naurp linux-2.6.17-rc4-mmpatches/drivers/video/intelfb/ 
intelfbhw.c linux-2.6.17-rc4-stolen/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-mmpatches/drivers/video/intelfb/intelfbhw.c	 
2006-05-24 11:26:40.000000000 -0600
+++ linux-2.6.17-rc4-stolen/drivers/video/intelfb/intelfbhw.c	 
2006-05-24 12:16:07.000000000 -0600
@@ -156,6 +156,7 @@ intelfbhw_get_memory(struct pci_dev *pde
{
	struct pci_dev *bridge_dev;
	u16 tmp;
+	int stolen_overhead;
	if (!pdev || !aperture_size || !stolen_size)
		return 1;
@@ -170,21 +171,41 @@ intelfbhw_get_memory(struct pci_dev *pde
	tmp = 0;
	pci_read_config_word(bridge_dev, INTEL_GMCH_CTRL, &tmp);
	switch (pdev->device) {
-	case PCI_DEVICE_ID_INTEL_830M:
-	case PCI_DEVICE_ID_INTEL_845G:
+	case PCI_DEVICE_ID_INTEL_915G:
+	case PCI_DEVICE_ID_INTEL_915GM:
+	case PCI_DEVICE_ID_INTEL_945G:
+	case PCI_DEVICE_ID_INTEL_945GM:
+		/* 915 and 945 chipsets support a 256MB aperture.
+		   Aperture size is determined by inspecting the
+		   base address of the aperture. */
+		if (pci_resource_start(pdev, 2) & 0x08000000)
+			*aperture_size = MB(128);
+		else
+			*aperture_size = MB(256);
+		break;
+	default:
		if ((tmp & INTEL_GMCH_MEM_MASK) == INTEL_GMCH_MEM_64M)
			*aperture_size = MB(64);
		else
			*aperture_size = MB(128);
+		break;
+	}
+	
+	/* Stolen memory size is reduced by the GTT and the popup.
+	   GTT is 1K per MB of aperture size, and popup is 4K. */
+	stolen_overhead = (*aperture_size / MB(1)) + 4;
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_INTEL_830M:
+	case PCI_DEVICE_ID_INTEL_845G:
		switch (tmp & INTEL_830_GMCH_GMS_MASK) {
		case INTEL_830_GMCH_GMS_STOLEN_512:
-			*stolen_size = KB(512) - KB(132);
+			*stolen_size = KB(512) - KB(stolen_overhead);
			return 0;
		case INTEL_830_GMCH_GMS_STOLEN_1024:
-			*stolen_size = MB(1) - KB(132);
+			*stolen_size = MB(1) - KB(stolen_overhead);
			return 0;
		case INTEL_830_GMCH_GMS_STOLEN_8192:
-			*stolen_size = MB(8) - KB(132);
+			*stolen_size = MB(8) - KB(stolen_overhead);
			return 0;
		case INTEL_830_GMCH_GMS_LOCAL:
			ERR_MSG("only local memory found\n");
@@ -199,28 +220,27 @@ intelfbhw_get_memory(struct pci_dev *pde
		}
		break;
	default:
-		*aperture_size = MB(128);
		switch (tmp & INTEL_855_GMCH_GMS_MASK) {
		case INTEL_855_GMCH_GMS_STOLEN_1M:
-			*stolen_size = MB(1) - KB(132);
+			*stolen_size = MB(1) - KB(stolen_overhead);
			return 0;
		case INTEL_855_GMCH_GMS_STOLEN_4M:
-			*stolen_size = MB(4) - KB(132);
+			*stolen_size = MB(4) - KB(stolen_overhead);
			return 0;
		case INTEL_855_GMCH_GMS_STOLEN_8M:
-			*stolen_size = MB(8) - KB(132);
+			*stolen_size = MB(8) - KB(stolen_overhead);
			return 0;
		case INTEL_855_GMCH_GMS_STOLEN_16M:
-			*stolen_size = MB(16) - KB(132);
+			*stolen_size = MB(16) - KB(stolen_overhead);
			return 0;
		case INTEL_855_GMCH_GMS_STOLEN_32M:
-			*stolen_size = MB(32) - KB(132);
+			*stolen_size = MB(32) - KB(stolen_overhead);
			return 0;
		case INTEL_915G_GMCH_GMS_STOLEN_48M:
-			*stolen_size = MB(48) - KB(132);
+			*stolen_size = MB(48) - KB(stolen_overhead);
			return 0;
		case INTEL_915G_GMCH_GMS_STOLEN_64M:
-			*stolen_size = MB(64) - KB(132);
+			*stolen_size = MB(64) - KB(stolen_overhead);
			return 0;
		case INTEL_855_GMCH_GMS_DISABLED:
			ERR_MSG("video memory is disabled\n");



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
