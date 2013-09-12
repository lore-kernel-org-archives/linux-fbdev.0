From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:50:40 +0000
Subject: [PATCH 01/21] video: arkfb: remove unnecessary pci_set_drvdata()
Message-Id: <001b01ceaf84$64d222c0$2e766840$%han@samsung.com>
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
 drivers/video/arkfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 94a51f1..ff6e304b 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1108,7 +1108,6 @@ static void ark_pci_remove(struct pci_dev *dev)
 		pci_release_regions(dev);
 /*		pci_disable_device(dev); */
 
-		pci_set_drvdata(dev, NULL);
 		framebuffer_release(info);
 	}
 }
-- 
1.7.10.4


