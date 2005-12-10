From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/18] nvidiafb: Add support for some pci-e chipsets
Date: Sat, 10 Dec 2005 14:15:16 +0800
Message-ID: <439A7274.9090003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky6j-0002sj-Qn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:21:21 -0800
Received: from zproxy.gmail.com ([64.233.162.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky6j-0007sx-Dr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:21:21 -0800
Received: by zproxy.gmail.com with SMTP id r28so1047208nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:21:20 -0800 (PST)
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

Chipsets with PCI device ids & 0xf0 == 0x00f0 has their actual
chipset type in offset 0x1800 of the mmio space.  Add support for this.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |   42 ++++++++++++++++++++++++++++++++++++-----
 include/linux/pci_ids.h       |    5 +++++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index dcf2e7a..b350cd7 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -284,6 +284,16 @@ static struct pci_device_id nvidiafb_pci
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_6200,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_ALT1,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT1,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT2,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6200_ALT1,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0252,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x0313,
@@ -1448,11 +1458,34 @@ static int __devinit nvidia_set_fbinfo(s
 	return nvidiafb_check_var(&info->var, info);
 }
 
-static u32 __devinit nvidia_get_arch(struct pci_dev *pd)
+static u32 __devinit nvidia_get_chipset(struct fb_info *info)
 {
+	struct nvidia_par *par = info->par;
+	u32 id = (par->pci_dev->vendor << 16) | par->pci_dev->device;
+
+	printk("nvidiafb: PCI id - %x\n", id);
+	if ((id & 0xfff0) == 0x00f0) {
+		/* pci-e */
+		printk("nvidiafb: PCI-E card\n");
+		id = NV_RD32(par->REGS, 0x1800);
+
+		if ((id & 0x0000ffff) == 0x000010DE) 
+			id = 0x10DE0000 | (id >> 16);
+		else if ((id & 0xffff0000) == 0xDE100000) /* wrong endian */
+			id = 0x10DE0000 | ((id << 8) & 0x0000ff00) |
+                            ((id >> 8) & 0x000000ff);
+	}
+
+	printk("nvidiafb: Actual id - %x\n", id);
+	return id;
+}
+
+static u32 __devinit nvidia_get_arch(struct fb_info *info)
+{
+	struct nvidia_par *par = info->par;
 	u32 arch = 0;
 
-	switch (pd->device & 0x0ff0) {
+	switch (par->Chipset & 0x0ff0) {
 	case 0x0100:		/* GeForce 256 */
 	case 0x0110:		/* GeForce2 MX */
 	case 0x0150:		/* GeForce2 */
@@ -1535,9 +1568,6 @@ static int __devinit nvidiafb_probe(stru
 		goto err_out_request;
 	}
 
-	par->Architecture = nvidia_get_arch(pd);
-
-	par->Chipset = (pd->vendor << 16) | pd->device;
 	printk(KERN_INFO PFX "nVidia device/chipset %X\n", par->Chipset);
 
 	if (par->Architecture == 0) {
@@ -1572,6 +1602,8 @@ static int __devinit nvidiafb_probe(stru
 		goto err_out_free_base0;
 	}
 
+	par->Chipset = nvidia_get_chipset(info);
+	par->Architecture = nvidia_get_arch(info);
 	NVCommonSetup(info);
 
 	par->FbAddress = nvidiafb_fix.smem_start;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f08ff15..17d60e0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1037,6 +1037,11 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_6		0x00e6
 #define PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO		0x00ea
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
+#define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_ALT1 0x00f0
+#define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT1 0x00f1
+#define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6600_ALT2 0x00f2
+#define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6200_ALT1 0x00f3
+#define PCIE_DEVICE_ID_NVIDIA_GEFORCE_6800_GT   0x00f9
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
