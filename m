From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:32:15 +0000
Subject: [PATCH 24/28] video: sstfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <004001ceebea$6f0f9590$4d2ec0b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/sstfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index f0cb279..f132691 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1477,7 +1477,7 @@ static void sstfb_remove(struct pci_dev *pdev)
 }
 
 
-static const struct pci_device_id sstfb_id_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(sstfb_id_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO ),
 		.driver_data = ID_VOODOO1, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO2),
-- 
1.7.10.4


