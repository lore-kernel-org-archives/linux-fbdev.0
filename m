From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:45:14 +0000
Subject: [PATCH 01/15] video: bfin: remove unnecessary platform_set_drvdata()
Message-Id: <000101ce4e45$61e28c30$25a7a490$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/bf54x-lq043fb.c    |    1 -
 drivers/video/bfin-lq035q1-fb.c  |    2 --
 drivers/video/bfin-t350mcqb-fb.c |    2 --
 3 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 2726a5b..87f288b 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -681,7 +681,6 @@ out3:
 out2:
 	free_dma(CH_EPPI0);
 out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 29d8c04..be65bae 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -759,7 +759,6 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
  out2:
 	free_dma(CH_PPI);
  out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -788,7 +787,6 @@ static int bfin_lq035q1_remove(struct platform_device *pdev)
 	bfin_lq035q1_free_ports(info->disp_info->ppi_mode =
 				USE_RGB565_16_BIT_PPI);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	dev_info(&pdev->dev, "unregistered LCD driver\n");
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index d46da01..48c0c4e 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -578,7 +578,6 @@ out3:
 out2:
 	free_dma(CH_PPI);
 out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -608,7 +607,6 @@ static int bfin_t350mcqb_remove(struct platform_device *pdev)
 
 	bfin_t350mcqb_request_ports(0);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	printk(KERN_INFO DRIVER_NAME ": Unregister LCD driver.\n");
-- 
1.7.2.5


