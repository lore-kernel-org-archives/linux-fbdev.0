From: Himanshu Jha <himanshujha199640@gmail.com>
Date: Sun, 31 Dec 2017 12:37:57 +0000
Subject: [PATCH] fbdev: auo_k190x: Use zeroing memory allocator than allocator/memset
Message-Id: <1514723157-5675-1-git-send-email-himanshujha199640@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>

Use vzalloc for allocating zeroed memory and remove unnecessary
memset function.

Done using Coccinelle.
Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci
0-day tested with no failures.

Suggested-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/video/fbdev/auo_k190x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 0d060383..b889401 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -1056,13 +1056,12 @@ int auok190x_common_probe(struct platform_device *pdev,
 	/* videomemory handling */
 
 	videomemorysize = roundup((panel->w * panel->h) * 2, PAGE_SIZE);
-	videomemory = vmalloc(videomemorysize);
+	videomemory = vzalloc(videomemorysize);
 	if (!videomemory) {
 		ret = -ENOMEM;
 		goto err_irq;
 	}
 
-	memset(videomemory, 0, videomemorysize);
 	info->screen_base = (char *)videomemory;
 	info->fix.smem_len = videomemorysize;
 
-- 
2.7.4

