From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:53:49 +0000
Subject: [PATCH 06/21] video: gx1fb: remove unnecessary pci_set_drvdata()
Message-Id: <002001ceaf84$d5e9b450$81bd1cf0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From fbb1885952efb15a46d03aac050c38fc9179594e Mon Sep 17 00:00:00 2001
From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 14:42:45 +0900
Subject: [PATCH 06/21] video: gx1fb: remove unnecessary pci_set_drvdata()

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/geode/gx1fb_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index ebbaada..7551a04 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -399,7 +399,6 @@ static void gx1fb_remove(struct pci_dev *pdev)
 	release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 
 	fb_dealloc_cmap(&info->cmap);
-	pci_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
 }
-- 
1.7.10.4


