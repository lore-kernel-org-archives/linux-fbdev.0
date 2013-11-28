From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:23:05 +0000
Subject: [PATCH 11/28] video: i810fb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003301ceebe9$27400f20$75c02d60$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/i810/i810_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 038192a..4d3e8a1 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -106,7 +106,7 @@ static const char * const i810_pci_list[] = {
 	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"
 };
 
-static struct pci_device_id i810fb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(i810fb_pci_tbl) = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
-- 
1.7.10.4


