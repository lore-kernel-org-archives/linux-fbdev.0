From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:21:22 +0000
Subject: [PATCH 08/28] video: lxfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003001ceebe8$e9c19100$bd44b300$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/geode/lxfb_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 9e1d19d..c6cec41 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -608,7 +608,7 @@ static void lxfb_remove(struct pci_dev *pdev)
 	framebuffer_release(info);
 }
 
-static struct pci_device_id lxfb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(lxfb_id_table) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_VIDEO) },
 	{ 0, }
 };
-- 
1.7.10.4


