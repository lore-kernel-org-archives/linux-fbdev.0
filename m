From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 12 Jul 2013 13:20:23 +0000
Subject: [PATCH] video: nuc900fb: fix to pass correct device identity to free_irq()
Message-Id: <CAPgLHd_mMOOeMecVJbTQjiK+xJD+-8jvgH6oAFqTHK_uSpWOJw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

free_irq() expects the same device identity that was passed to
corresponding request_irq(), otherwise the IRQ is not freed.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/nuc900fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 8c527e5..ebd5501 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -661,7 +661,7 @@ release_clock:
 	clk_disable(fbi->clk);
 	clk_put(fbi->clk);
 release_irq:
-	free_irq(irq, fbi);
+	free_irq(irq, fbinfo);
 release_regs:
 	iounmap(fbi->io);
 release_mem_region:
@@ -702,7 +702,7 @@ static int nuc900fb_remove(struct platform_device *pdev)
 	iounmap(fbi->io);
 
 	irq = platform_get_irq(pdev, 0);
-	free_irq(irq, fbi);
+	free_irq(irq, fbinfo);
 
 	release_resource(fbi->mem);
 	kfree(fbi->mem);

