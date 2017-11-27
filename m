From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 10:17:00 +0000
Subject: [PATCH] video: bf54x-lq043fb: Delete an error message for a failed memory allocation in bfin_bf54x_p
Message-Id: <9eff0ce0-070d-77aa-8855-73a96eb778fd@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 11:04:22 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/bf54x-lq043fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/bf54x-lq043fb.c b/drivers/video/fbdev/bf54x-lq043fb.c
index 8f1f97c75619..69a8c5d82ad7 100644
--- a/drivers/video/fbdev/bf54x-lq043fb.c
+++ b/drivers/video/fbdev/bf54x-lq043fb.c
@@ -605,9 +605,6 @@ static int bfin_bf54x_probe(struct platform_device *pdev)
 	fbinfo->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
 					      GFP_KERNEL);
 	if (!fbinfo->pseudo_palette) {
-		printk(KERN_ERR DRIVER_NAME
-		       "Fail to allocate pseudo_palette\n");
-
 		ret = -ENOMEM;
 		goto out4;
 	}
-- 
2.15.0

