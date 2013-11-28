From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:30:22 +0000
Subject: [PATCH 21/28] video: s3fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003d01ceebea$2b79a4b0$826cee10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 968b299..6392d53 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1503,7 +1503,7 @@ static int s3_pci_resume(struct pci_dev* dev)
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id s3_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(s3_devices) = {
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8810), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8811), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8812), .driver_data = CHIP_M65_AURORA64VP},
-- 
1.7.10.4


