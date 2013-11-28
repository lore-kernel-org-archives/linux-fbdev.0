From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:17:22 +0000
Subject: [PATCH 04/28] video: carminefb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002c01ceebe8$5a5da670$0f18f350$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/carminefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index 65f7c15..2eb9a35 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -750,7 +750,7 @@ static void carminefb_remove(struct pci_dev *dev)
 }
 
 #define PCI_VENDOR_ID_FUJITU_LIMITED 0x10cf
-static struct pci_device_id carmine_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(carmine_devices) = {
 {
 	PCI_DEVICE(PCI_VENDOR_ID_FUJITU_LIMITED, 0x202b)},
 	{0, 0, 0, 0, 0, 0, 0}
-- 
1.7.10.4


