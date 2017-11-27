From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:01:41 +0000
Subject: [PATCH] video: auo_k190x: Delete an error message for a failed memory allocation in auok190x_common_
Message-Id: <757f0d7c-e356-2e69-46e6-0bf5067877e1@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ingo Molnar <mingo@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:53:05 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/auo_k190x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 0d06038324e0..971d155d250f 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -1081,7 +1081,6 @@ int auok190x_common_probe(struct platform_device *pdev,
 				     sizeof(struct fb_deferred_io),
 				     GFP_KERNEL);
 	if (!info->fbdefio) {
-		dev_err(info->device, "Failed to allocate memory\n");
 		ret = -ENOMEM;
 		goto err_defio;
 	}
-- 
2.15.0

