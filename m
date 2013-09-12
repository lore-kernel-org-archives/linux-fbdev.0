From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:59:13 +0000
Subject: [PATCH 16/21] video: s3fb: remove unnecessary pci_set_drvdata()
Message-Id: <002a01ceaf85$96f23550$c4d69ff0$%han@samsung.com>
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
 drivers/video/s3fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 47ca86c..d158d2c 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1431,7 +1431,6 @@ static void s3_pci_remove(struct pci_dev *dev)
 		pci_release_regions(dev);
 /*		pci_disable_device(dev); */
 
-		pci_set_drvdata(dev, NULL);
 		framebuffer_release(info);
 	}
 }
-- 
1.7.10.4


