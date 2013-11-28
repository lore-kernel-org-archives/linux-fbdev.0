From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:20:29 +0000
Subject: [PATCH 07/28] video: cyber2000fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002f01ceebe8$ca281e90$5e785bb0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/cyber2000fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index b0a950f..760200d 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1837,7 +1837,7 @@ static int cyberpro_pci_resume(struct pci_dev *dev)
 	return 0;
 }
 
-static struct pci_device_id cyberpro_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(cyberpro_pci_table) = {
 /*	Not yet
  *	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
  *		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
-- 
1.7.10.4


