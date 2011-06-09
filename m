From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 09 Jun 2011 04:26:31 +0000
Subject: [PATCH] [resend] video: s3c-fb: fix misleading kfree in remove function
Message-Id: <1307593591-4507-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes misleading kfree in remove function.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0352afa..148e19d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1487,11 +1487,10 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	release_mem_region(sfb->regs_res->start, resource_size(sfb->regs_res));
 
-	kfree(sfb);
-
 	pm_runtime_put_sync(sfb->dev);
 	pm_runtime_disable(sfb->dev);
 
+	kfree(sfb);
 	return 0;
 }
 
-- 
1.7.1

