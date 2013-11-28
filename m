From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:27:16 +0000
Subject: [PATCH 16/28] video: neofb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003801ceebe9$bcfa2320$36ee6960$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/neofb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 44f99a6..2c7c19e 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -2150,7 +2150,7 @@ static void neofb_remove(struct pci_dev *dev)
 	}
 }
 
-static struct pci_device_id neofb_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(neofb_devices) = {
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2070,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2070},
 
-- 
1.7.10.4


