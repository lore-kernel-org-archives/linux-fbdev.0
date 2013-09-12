From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:57:54 +0000
Subject: [PATCH 13/21] video: neofb: remove unnecessary pci_set_drvdata()
Message-Id: <002701ceaf85$67c44430$374ccc90$%han@samsung.com>
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
 drivers/video/neofb.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 7ef079c..891b0bf 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -2146,12 +2146,6 @@ static void neofb_remove(struct pci_dev *dev)
 		fb_destroy_modedb(info->monspecs.modedb);
 		neo_unmap_mmio(info);
 		neo_free_fb_info(info);
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


