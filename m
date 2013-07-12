From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 12 Jul 2013 13:20:03 +0000
Subject: [PATCH] video: sh7760fb: fix to pass correct device identity to free_irq()
Message-Id: <CAPgLHd9+d0Csf0kad8fnYQc4UQLdoJCo+-MZNNGKi_PTxeBJjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

free_irq() expects the same device identity that was passed to
corresponding request_irq(), otherwise the IRQ is not freed.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/sh7760fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index a8c6c43..1265b25 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -567,7 +567,7 @@ static int sh7760fb_remove(struct platform_device *dev)
 	fb_dealloc_cmap(&info->cmap);
 	sh7760fb_free_mem(info);
 	if (par->irq >= 0)
-		free_irq(par->irq, par);
+		free_irq(par->irq, &par->vsync);
 	iounmap(par->base);
 	release_mem_region(par->ioarea->start, resource_size(par->ioarea));
 	framebuffer_release(info);

