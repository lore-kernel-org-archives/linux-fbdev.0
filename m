From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 30 Jun 2014 19:14:32 +0000
Subject: [PATCH] video: fbdev: s3c2410fb: Move to clk_prepare_enable/clk_disable_unprepare
Message-Id: <1404155672-3158-1-git-send-email-anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/fbdev/s3c2410fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index 81af5a6..d68595d 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -932,7 +932,7 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 		goto release_irq;
 	}
 
-	clk_enable(info->clk);
+	clk_prepare_enable(info->clk);
 	dprintk("got and enabled clock\n");
 
 	usleep_range(1000, 1100);
@@ -996,7 +996,7 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 free_video_memory:
 	s3c2410fb_unmap_video_memory(fbinfo);
 release_clock:
-	clk_disable(info->clk);
+	clk_disable_unprepare(info->clk);
 	clk_put(info->clk);
 release_irq:
 	free_irq(irq, info);
@@ -1038,7 +1038,7 @@ static int s3c2410fb_remove(struct platform_device *pdev)
 	s3c2410fb_unmap_video_memory(fbinfo);
 
 	if (info->clk) {
-		clk_disable(info->clk);
+		clk_disable_unprepare(info->clk);
 		clk_put(info->clk);
 		info->clk = NULL;
 	}
@@ -1070,7 +1070,7 @@ static int s3c2410fb_suspend(struct platform_device *dev, pm_message_t state)
 	 * before the clock goes off again (bjd) */
 
 	usleep_range(1000, 1100);
-	clk_disable(info->clk);
+	clk_disable_unprepare(info->clk);
 
 	return 0;
 }
@@ -1080,7 +1080,7 @@ static int s3c2410fb_resume(struct platform_device *dev)
 	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	clk_enable(info->clk);
+	clk_prepare_enable(info->clk);
 	usleep_range(1000, 1100);
 
 	s3c2410fb_init_registers(fbinfo);
-- 
2.0.0

