From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:32:54 +0000
Subject: [PATCH 25/28] video: tdfxfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <004101ceebea$85e783e0$91b68ba0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/tdfxfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index f761fe3..61369ce 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -138,7 +138,7 @@ static struct fb_var_screeninfo tdfx_var = {
 static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void tdfxfb_remove(struct pci_dev *pdev);
 
-static struct pci_device_id tdfxfb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(tdfxfb_id_table) = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
-- 
1.7.10.4


