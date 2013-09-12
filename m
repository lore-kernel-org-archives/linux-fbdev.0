From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:53:11 +0000
Subject: [PATCH 05/21] video: lxfb: remove unnecessary pci_set_drvdata()
Message-Id: <001f01ceaf84$bed8dbb0$3c8a9310$%han@samsung.com>
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
 drivers/video/geode/lxfb_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 4dd7b55..10de31b 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -606,7 +606,6 @@ static void lxfb_remove(struct pci_dev *pdev)
 	pci_release_region(pdev, 3);
 
 	fb_dealloc_cmap(&info->cmap);
-	pci_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 }
 
-- 
1.7.10.4


