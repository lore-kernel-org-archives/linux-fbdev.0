From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 07:00:58 +0000
Subject: [PATCH 19/21] video: tdfxfb: remove unnecessary pci_set_drvdata()
Message-Id: <002d01ceaf85$d540fbc0$7fc2f340$%han@samsung.com>
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
 drivers/video/tdfxfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 64bc28b..f761fe3 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -1646,7 +1646,6 @@ static void tdfxfb_remove(struct pci_dev *pdev)
 			   pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 0),
 			   pci_resource_len(pdev, 0));
-	pci_set_drvdata(pdev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
 }
-- 
1.7.10.4


