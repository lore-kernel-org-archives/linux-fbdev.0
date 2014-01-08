From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 08 Jan 2014 00:46:24 +0000
Subject: [PATCH RESEND 4/4] video: vmlfb: remove unnecessary pci_set_drvdata()
Message-Id: <001c01cf0c0b$0ea4f920$2beeeb60$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/vermilion/vermilion.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 09a1366..048a666 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -383,7 +383,6 @@ static void vmlfb_disable_mmio(struct vml_par *par)
 static void vmlfb_release_devices(struct vml_par *par)
 {
 	if (atomic_dec_and_test(&par->refcount)) {
-		pci_set_drvdata(par->vdc, NULL);
 		pci_disable_device(par->gpu);
 		pci_disable_device(par->vdc);
 	}
-- 
1.7.10.4


