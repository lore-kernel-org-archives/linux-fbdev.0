From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:13:55 +0000
Subject: [PATCH 02/28] video: asiliantfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002a01ceebe7$df32e370$9d98aa50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/asiliantfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index d611f1a..f1ba0d8 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -593,7 +593,7 @@ static void asiliantfb_remove(struct pci_dev *dp)
 	framebuffer_release(p);
 }
 
-static struct pci_device_id asiliantfb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(asiliantfb_pci_tbl) = {
 	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_69000, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
-- 
1.7.10.4


