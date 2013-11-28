From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:35:06 +0000
Subject: [PATCH 28/28] video: vt8623fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <004401ceebea$d4ba8030$7e2f8090$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/vt8623fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 8bc6e09..f210d0f 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -907,7 +907,7 @@ fail:
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id vt8623_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(vt8623_devices) = {
 	{PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x3122)},
 	{0, 0, 0, 0, 0, 0, 0}
 };
-- 
1.7.10.4


