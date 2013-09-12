From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:54:28 +0000
Subject: [PATCH 07/21] video: gxfb: remove unnecessary pci_set_drvdata()
Message-Id: <002101ceaf84$ecfe5d80$c6fb1880$%han@samsung.com>
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
 drivers/video/geode/gxfb_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 19f0c1ad..a42d74d 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -471,7 +471,6 @@ static void gxfb_remove(struct pci_dev *pdev)
 	pci_release_region(pdev, 1);
 
 	fb_dealloc_cmap(&info->cmap);
-	pci_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
 }
-- 
1.7.10.4


