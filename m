From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Wed, 01 Jan 2020 17:49:47 +0000
Subject: [PATCH 07/10] video: fbdev: use resource_size
Message-Id: <1577900990-8588-8-git-send-email-Julia.Lawall@inria.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/video/fbdev/cg14.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index a620b51cf7d0..6a745eb46ca1 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -509,8 +509,7 @@ static int cg14_probe(struct platform_device *op)
 	if (!par->regs || !par->clut || !par->cursor || !info->screen_base)
 		goto out_unmap_regs;
 
-	is_8mb = (((op->resource[1].end - op->resource[1].start) + 1) =
-		  (8 * 1024 * 1024));
+	is_8mb = (resource_size(&op->resource[1]) = (8 * 1024 * 1024));
 
 	BUILD_BUG_ON(sizeof(par->mmap_map) != sizeof(__cg14_mmap_map));
 		
