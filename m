From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:16:30 +0000
Subject: [PATCH 03/28] video: aty: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <002b01ceebe8$3ba2fb40$b2e8f1c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/aty/aty128fb.c    |    2 +-
 drivers/video/aty/atyfb_base.c  |    2 +-
 drivers/video/aty/radeon_base.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 12ca031..699b587 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -171,7 +171,7 @@ static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
-static struct pci_device_id aty128_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(aty128_pci_tbl) = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3_pci },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LF,
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 28fafbf..bfc2893 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3772,7 +3772,7 @@ static void atyfb_pci_remove(struct pci_dev *pdev)
 	atyfb_remove(info);
 }
 
-static struct pci_device_id atyfb_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(atyfb_pci_tbl) = {
 #ifdef CONFIG_FB_ATY_GX
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GX) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64CX) },
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 26d80a4..e2ad734 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -101,7 +101,7 @@
 #define CHIP_DEF(id, family, flags)					\
 	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
 
-static struct pci_device_id radeonfb_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(radeonfb_pci_table) = {
         /* Radeon Xpress 200m */
 	CHIP_DEF(PCI_CHIP_RS480_5955,   RS480,  CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RS482_5975,	RS480,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
-- 
1.7.10.4


