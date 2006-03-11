From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: Add ID for Quadro NVS280
Date: Sat, 11 Mar 2006 09:54:00 +0800
Message-ID: <44122DB8.2050806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtv5-0005wF-Mv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:33:27 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtOL-0003lQ-0q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:37 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:34 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Roskin <proski@gnu.org>

From: Pavel Roskin <proski@gnu.org>

Quadro NVS280 is a dual-head PCIe card with PCI ID 10de:00fd and
subsystem ID 10de:0215.

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |    2 ++
 include/linux/pci_ids.h       |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 018dd81..6d3e489 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -297,6 +297,8 @@ static struct pci_device_id nvidiafb_pci
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_QUADRO_NVS280,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0252,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0313,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5525f04..92cd59b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1051,6 +1051,7 @@
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT2 0x00f2
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6200_ALT1 0x00f3
 #define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT   0x00f9
+#define PCIE_DEVICE_ID_NVIDIA_QUADRO_NVS280	0x00fd
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
