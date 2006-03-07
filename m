From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add ID for Quadro NVS280
Date: Tue, 07 Mar 2006 17:43:49 -0500
Message-ID: <1141771429.13892.6.camel@dv>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FGkuL-0007vS-EA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Mar 2006 14:43:57 -0800
Received: from fencepost.gnu.org ([199.232.76.164])
	by mail.sourceforge.net with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.44)
	id 1FGkuL-0001Tz-7F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Mar 2006 14:43:57 -0800
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FGkuD-0003p6-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Mar 2006 17:43:51 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FGkuD-0003dc-As
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Mar 2006 17:43:49 -0500
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
To: linux-fbdev-devel@lists.sourceforge.net

Quadro NVS280 is a dual-head PCIe card with PCI ID 10de:00fd and
subsystem ID 10de:0215.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index a7c4e5e..f55bff0 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -296,6 +296,8 @@ static struct pci_device_id nvidiafb_pci
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_QUADRO_NVS280,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0252,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0313,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 82b83da..6726b43 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1049,6 +1049,7 @@
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT2 0x00f2
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6200_ALT1 0x00f3
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT   0x00f9
+#define PCIE_DEVICE_ID_NVIDIA_QUADRO_NVS280	0x00fd
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103


-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
