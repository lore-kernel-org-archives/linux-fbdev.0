From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 23 Sep 2013 15:00:15 +0000
Subject: [PATCH] s3fb: fix error return code in s3_pci_probe()
Message-Id: <CAPgLHd_wsqGQ2eSnKY6SzGan0fZLZJWyN03A+_aFmaQ51q73AQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -EINVAL when virtual vertical size smaller than real
instead of 0, as done elsewhere in this function. Also remove dup code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/s3fb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 47ca86c..d838ba8 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1336,14 +1336,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			(info->var.bits_per_pixel * info->var.xres_virtual);
 	if (info->var.yres_virtual < info->var.yres) {
 		dev_err(info->device, "virtual vertical size smaller than real\n");
-		goto err_find_mode;
-	}
-
-	/* maximize virtual vertical size for fast scrolling */
-	info->var.yres_virtual = info->fix.smem_len * 8 /
-			(info->var.bits_per_pixel * info->var.xres_virtual);
-	if (info->var.yres_virtual < info->var.yres) {
-		dev_err(info->device, "virtual vertical size smaller than real\n");
+		rc = -EINVAL;
 		goto err_find_mode;
 	}
 

