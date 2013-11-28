From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:22:05 +0000
Subject: [PATCH 09/28] video: gx1fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003101ceebe9$032692d0$0973b870$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/geode/gx1fb_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 2794ba1..a701452 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -427,7 +427,7 @@ static void __init gx1fb_setup(char *options)
 }
 #endif
 
-static struct pci_device_id gx1fb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(gx1fb_id_table) = {
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
-- 
1.7.10.4


