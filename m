From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:33:30 +0000
Subject: [PATCH 26/28] video: tgafb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <004201ceebea$9bcf1ec0$d36d5c40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/tgafb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index f28674f..09f662f 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -96,7 +96,7 @@ static struct fb_ops tgafb_ops = {
 static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
 static void tgafb_pci_unregister(struct pci_dev *);
 
-static struct pci_device_id const tgafb_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(tgafb_pci_table) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA) },
 	{ }
 };
-- 
1.7.10.4


