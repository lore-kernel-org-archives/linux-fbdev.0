From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 07:01:53 +0000
Subject: [PATCH 21/21] video: vt8623fb: remove unnecessary pci_set_drvdata()
Message-Id: <002f01ceaf85$f658a9c0$e309fd40$%han@samsung.com>
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
 drivers/video/vt8623fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index e9557fa..6b424dd 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -829,7 +829,6 @@ static void vt8623_pci_remove(struct pci_dev *dev)
 		pci_release_regions(dev);
 /*		pci_disable_device(dev); */
 
-		pci_set_drvdata(dev, NULL);
 		framebuffer_release(info);
 	}
 }
-- 
1.7.10.4


