From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:59:43 +0000
Subject: [PATCH 17/21] video: savagefb: remove unnecessary pci_set_drvdata()
Message-Id: <002b01ceaf85$a8a57550$f9f05ff0$%han@samsung.com>
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
 drivers/video/savage/savagefb_driver.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 741b239..4dbf45f 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2362,12 +2362,6 @@ static void savagefb_remove(struct pci_dev *dev)
 		kfree(info->pixmap.addr);
 		pci_release_regions(dev);
 		framebuffer_release(info);
-
-		/*
-		 * Ensure that the driver data is no longer
-		 * valid.
-		 */
-		pci_set_drvdata(dev, NULL);
 	}
 }
 
-- 
1.7.10.4


