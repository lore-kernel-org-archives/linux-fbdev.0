From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:52:30 +0000
Subject: [PATCH 04/21] video: cyber2000fb: remove unnecessary pci_set_drvdata()
Message-Id: <001e01ceaf84$a6b29b70$f417d250$%han@samsung.com>
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
 drivers/video/cyber2000fb.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index e78d9f2..42da9c8 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1874,11 +1874,6 @@ static void cyberpro_pci_remove(struct pci_dev *dev)
 		iounmap(cfb->region);
 		cyberpro_free_fb_info(cfb);
 
-		/*
-		 * Ensure that the driver data is no longer
-		 * valid.
-		 */
-		pci_set_drvdata(dev, NULL);
 		if (cfb = int_cfb_info)
 			int_cfb_info = NULL;
 
-- 
1.7.10.4


