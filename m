From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:23:53 +0000
Subject: [PATCH 12/28] video: imsttfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003401ceebe9$43b3d790$cb1b86b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/imsttfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index aae10ce..10c769c 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1319,7 +1319,7 @@ imsttfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 	}
 }
 
-static struct pci_device_id imsttfb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(imsttfb_pci_tbl) = {
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IBM },
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT3D,
-- 
1.7.10.4


