From: Chuhong Yuan <hslester96@gmail.com>
Date: Thu, 05 Dec 2019 16:06:13 +0000
Subject: [PATCH] pxa168fb: fix release function mismatch in probe failure
Message-Id: <20191205160613.32075-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The driver uses kfree() to release the resource allocated by
framebuffer_alloc(), which does not match.
Use framebuffer_release() instead to fix it.

Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/pxa168fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 1410f476e135..b9435133b6f3 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -769,7 +769,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
 failed_free_info:
-	kfree(info);
+	framebuffer_release(info);
 
 	dev_err(&pdev->dev, "frame buffer device init failed with %d\n", ret);
 	return ret;
-- 
2.24.0
