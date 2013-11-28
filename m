From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:19:09 +0000
Subject: [PATCH 05/28] video: chipsfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002d01ceebe8$9a57fa00$cf07ee00$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/chipsfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index 206a66b..edc74ce 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -483,7 +483,7 @@ static int chipsfb_pci_resume(struct pci_dev *pdev)
 #endif /* CONFIG_PM */
 
 
-static struct pci_device_id chipsfb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(chipsfb_pci_tbl) = {
 	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_65550, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
-- 
1.7.10.4


