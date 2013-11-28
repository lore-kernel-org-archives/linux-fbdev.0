From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:29:46 +0000
Subject: [PATCH 20/28] video: rivafb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003c01ceebea$15d3a6b0$417af410$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/riva/fbdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index a5514ac..bb17eac 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -108,7 +108,7 @@ static int rivafb_blank(int blank, struct fb_info *info);
  *
  * ------------------------------------------------------------------------- */
 
-static struct pci_device_id rivafb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(rivafb_pci_tbl) = {
 	{ PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
-- 
1.7.10.4


