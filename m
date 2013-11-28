From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:22:33 +0000
Subject: [PATCH 10/28] video: gxt4500: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003201ceebe9$14104140$3c30c3c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/gxt4500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 135d78a..c09d5e5 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -738,7 +738,7 @@ static void gxt4500_remove(struct pci_dev *pdev)
 }
 
 /* supported chipsets */
-static const struct pci_device_id gxt4500_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(gxt4500_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
 	  .driver_data = GXT4500P },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6500P),
-- 
1.7.10.4


