From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 16:33:27 +0000
Subject: [PATCH] video: bf537-lq035: Delete an error message for a failed memory allocation in bfin_lq035_pro
Message-Id: <b59ec60f-0975-0d15-6d33-5e245e1d2790@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:27:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/bf537-lq035.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/bf537-lq035.c b/drivers/video/fbdev/bf537-lq035.c
index ef29fb425122..5142e5724f57 100644
--- a/drivers/video/fbdev/bf537-lq035.c
+++ b/drivers/video/fbdev/bf537-lq035.c
@@ -741,7 +741,6 @@ static int bfin_lq035_probe(struct platform_device *pdev)
 						    sizeof(u32) * 16,
 						    GFP_KERNEL);
 	if (bfin_lq035_fb.pseudo_palette = NULL) {
-		pr_err("failed to allocate pseudo_palette\n");
 		ret = -ENOMEM;
 		goto out_table;
 	}
-- 
2.15.0

