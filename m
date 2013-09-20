From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:21 +0000
Subject: [PATCH 12/15] video: platinumfb: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-13-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/platinumfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 3d86bac..b644037 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -639,7 +639,6 @@ static int platinumfb_probe(struct platform_device* odev)
 		iounmap(pinfo->frame_buffer);
 		iounmap(pinfo->platinum_regs);
 		iounmap(pinfo->cmap_regs);
-		dev_set_drvdata(&odev->dev, NULL);
 		framebuffer_release(info);
 	}
 
-- 
1.7.9.5

