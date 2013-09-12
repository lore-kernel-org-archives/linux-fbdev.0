From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 07:00:31 +0000
Subject: [PATCH 18/21] video: sisfb: remove unnecessary pci_set_drvdata()
Message-Id: <002c01ceaf85$c51cc030$4f564090$%han@samsung.com>
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
 drivers/video/sis/sis_main.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 977e279..793b402 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -5994,7 +5994,6 @@ static int sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if(!ivideo->sisvga_enabled) {
 		if(pci_enable_device(pdev)) {
 			if(ivideo->nbridge) pci_dev_put(ivideo->nbridge);
-			pci_set_drvdata(pdev, NULL);
 			framebuffer_release(sis_fb_info);
 			return -EIO;
 		}
@@ -6211,7 +6210,6 @@ error_3:	vfree(ivideo->bios_abase);
 			pci_dev_put(ivideo->lpcdev);
 		if(ivideo->nbridge)
 			pci_dev_put(ivideo->nbridge);
-		pci_set_drvdata(pdev, NULL);
 		if(!ivideo->sisvga_enabled)
 			pci_disable_device(pdev);
 		framebuffer_release(sis_fb_info);
@@ -6523,8 +6521,6 @@ static void sisfb_remove(struct pci_dev *pdev)
 		mtrr_del(ivideo->mtrr, ivideo->video_base, ivideo->video_size);
 #endif
 
-	pci_set_drvdata(pdev, NULL);
-
 	/* If device was disabled when starting, disable
 	 * it when quitting.
 	 */
-- 
1.7.10.4


