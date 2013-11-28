From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:30:53 +0000
Subject: [PATCH 22/28] video: savagefb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003e01ceebea$3e4f6bb0$baee4310$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/savage/savagefb_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 4dbf45f..d2d8fcf 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2440,7 +2440,7 @@ static int savagefb_resume(struct pci_dev* dev)
 }
 
 
-static struct pci_device_id savagefb_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(savagefb_devices) = {
 	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
 
-- 
1.7.10.4


