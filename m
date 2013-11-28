From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:24:55 +0000
Subject: [PATCH 13/28] video: kyrofb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003501ceebe9$68dcef20$3a96cd60$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/kyro/fbdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 50c8574..708d97d 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -640,7 +640,7 @@ static int kyrofb_ioctl(struct fb_info *info,
 	return 0;
 }
 
-static struct pci_device_id kyrofb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(kyrofb_pci_tbl) = {
 	{ PCI_VENDOR_ID_ST, PCI_DEVICE_ID_STG4000,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
-- 
1.7.10.4


