From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:28:31 +0000
Subject: [PATCH 18/28] video: pm2fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003a01ceebe9$e97b1cb0$bc715610$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/pm2fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 3b85b64..78efd82 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1749,7 +1749,7 @@ static void pm2fb_remove(struct pci_dev *pdev)
 	framebuffer_release(info);
 }
 
-static struct pci_device_id pm2fb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(pm2fb_id_table) = {
 	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_TVP4020,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2,
-- 
1.7.10.4


