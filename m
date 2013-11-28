From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:19:49 +0000
Subject: [PATCH 06/28] video: cirrusfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002e01ceebe8$b28a4830$179ed890$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/cirrusfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index d992aa5..aeb165b 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -255,7 +255,7 @@ static const struct cirrusfb_board_info_rec {
 #define CHIP(id, btype) \
 	{ PCI_VENDOR_ID_CIRRUS, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }
 
-static struct pci_device_id cirrusfb_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(cirrusfb_pci_table) = {
 	CHIP(PCI_DEVICE_ID_CIRRUS_5436, BT_ALPINE),
 	CHIP(PCI_DEVICE_ID_CIRRUS_5434_8, BT_SD64),
 	CHIP(PCI_DEVICE_ID_CIRRUS_5434_4, BT_SD64),
-- 
1.7.10.4


