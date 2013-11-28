From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:34:09 +0000
Subject: [PATCH 27/28] video: tridentfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <004301ceebea$b29f6bf0$17de43d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/tridentfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index 7ed9a22..ba7dc99 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -1559,7 +1559,7 @@ static void trident_pci_remove(struct pci_dev *dev)
 }
 
 /* List of boards that we are trying to support */
-static struct pci_device_id trident_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(trident_devices) = {
 	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-- 
1.7.10.4


