From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:31:38 +0000
Subject: [PATCH 23/28] video: sisfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003f01ceebea$58eec240$0acc46c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/sis/sis_main.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/sis/sis_main.h b/drivers/video/sis/sis_main.h
index 32e23c2..91dd282 100644
--- a/drivers/video/sis/sis_main.h
+++ b/drivers/video/sis/sis_main.h
@@ -113,7 +113,7 @@ static struct sisfb_chip_info {
 	{ XGI_40,     SIS_315_VGA, 1, HW_CURSOR_AREA_SIZE_315 * 4, SIS_CRT2_WENABLE_315, "XGI V3XT/V5/V8" },
 };
 
-static struct pci_device_id sisfb_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(sisfb_pci_table) = {
 #ifdef CONFIG_FB_SIS_300
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_300,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_540_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-- 
1.7.10.4


