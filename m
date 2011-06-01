From: Julia Lawall <julia@diku.dk>
Date: Wed, 01 Jun 2011 17:10:11 +0000
Subject: [PATCH 8/10] drivers/video/imxfb.c: add missing clk_put
Message-Id: <1306948213-20767-8-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Reorder the labels at the end of the function to correspond to the order in
which the resources are allocated.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression e1,e2;
statement S;
@@

e1 = clk_get@p1(...);
... when != e1 = e2
    when != clk_put(e1)
    when any
if (...) { ... when != clk_put(e1)
               when != if (...) { ... clk_put(e1) ... }
* return@p3 ...;
 } else S
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/imxfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index d2ccfd6..f135dbe 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -856,10 +856,10 @@ failed_platform_init:
 		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
 			fbi->map_dma);
 failed_map:
-	clk_put(fbi->clk);
-failed_getclock:
 	iounmap(fbi->regs);
 failed_ioremap:
+	clk_put(fbi->clk);
+failed_getclock:
 	release_mem_region(res->start, resource_size(res));
 failed_req:
 	kfree(info->pseudo_palette);

