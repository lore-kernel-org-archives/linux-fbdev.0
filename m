From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:57:09 +0000
Subject: [PATCH 12/21] video: mb862xxfb: remove unnecessary pci_set_drvdata()
Message-Id: <002601ceaf85$4ce880e0$e6b982a0$%han@samsung.com>
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
 drivers/video/mb862xx/mb862xxfbdrv.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 91c59c9..98d2f8c 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -1157,7 +1157,6 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	device_remove_file(&pdev->dev, &dev_attr_dispregs);
 
-	pci_set_drvdata(pdev, NULL);
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
 
-- 
1.7.10.4


