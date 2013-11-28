From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:27:54 +0000
Subject: [PATCH 17/28] video: nvidiafb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003901ceebe9$d3366db0$79a34910$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/nvidia/nvidia.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index ff22871..2ed0184 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -62,7 +62,7 @@
 /* HW cursor parameters */
 #define MAX_CURS		32
 
-static struct pci_device_id nvidiafb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(nvidiafb_pci_tbl) = {
 	{PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0},
 	{ 0, }
-- 
1.7.10.4


