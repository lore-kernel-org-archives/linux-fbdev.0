From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:26:40 +0000
Subject: [PATCH 15/28] video: mb862xxfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003701ceebe9$a77d5800$f6780800$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/mb862xx/mb862xxfbdrv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 0cd4c33..034abbb 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -982,7 +982,7 @@ static inline int mb862xx_pci_gdc_init(struct mb862xxfb_par *par)
 #define CHIP_ID(id)	\
 	{ PCI_DEVICE(PCI_VENDOR_ID_FUJITSU_LIMITED, id) }
 
-static struct pci_device_id mb862xx_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(mb862xx_pci_tbl) = {
 	/* MB86295/MB86296 */
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALP),
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALPA),
-- 
1.7.10.4


