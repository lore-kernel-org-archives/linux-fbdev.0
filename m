From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 03:25:44 +0000
Subject: [PATCH 14/28] video: matroxfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003601ceebe9$85f4bfc0$91de3f40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/matrox/matroxfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 87c64ff..ccd34c9 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -1594,7 +1594,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 	unsigned int memsize;
 	int err;
 
-	static struct pci_device_id intel_82437[] = {
+	static DEFINE_PCI_DEVICE_TABLE(intel_82437) = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
 		{ },
 	};
@@ -2087,7 +2087,7 @@ static void pci_remove_matrox(struct pci_dev* pdev) {
 	matroxfb_remove(minfo, 1);
 }
 
-static struct pci_device_id matroxfb_devices[] = {
+static DEFINE_PCI_DEVICE_TABLE(matroxfb_devices) = {
 #ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-- 
1.7.10.4


