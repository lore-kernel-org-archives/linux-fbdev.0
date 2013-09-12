From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:54:53 +0000
Subject: [PATCH 08/21] video: i740fb: remove unnecessary pci_set_drvdata()
Message-Id: <002201ceaf84$fc14ab80$f43e0280$%han@samsung.com>
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
 drivers/video/i740fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index 6c48388..6501ac1 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -1194,7 +1194,6 @@ static void i740fb_remove(struct pci_dev *dev)
 		pci_iounmap(dev, info->screen_base);
 		pci_release_regions(dev);
 /*		pci_disable_device(dev); */
-		pci_set_drvdata(dev, NULL);
 		framebuffer_release(info);
 	}
 }
-- 
1.7.10.4


