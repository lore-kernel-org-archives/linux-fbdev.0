From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:29:12 +0000
Subject: [PATCH 19/28] video: pm3fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003b01ceebea$01937a40$04ba6ec0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/pm3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 4bf3273..0c850db 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1493,7 +1493,7 @@ static void pm3fb_remove(struct pci_dev *dev)
 	}
 }
 
-static struct pci_device_id pm3fb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(pm3fb_id_table) = {
 	{ PCI_VENDOR_ID_3DLABS, 0x0a,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
-- 
1.7.10.4


