From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:17:25 +0000
Subject: [PATCH 1/4] video: sm501fb: Delete error messages for a failed memory allocation in two functions
Message-Id: <8d053c52-e3e6-32fe-87e9-f01a779b497e@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
In-Reply-To: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:10:31 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sm501fb.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 6f0a19501c6a..e8301c4e7d44 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1934,10 +1934,8 @@ static int sm501fb_probe(struct platform_device *pdev)
 	/* allocate our framebuffers */
 
 	info = kzalloc(sizeof(struct sm501fb_info), GFP_KERNEL);
-	if (!info) {
-		dev_err(dev, "failed to allocate state\n");
+	if (!info)
 		return -ENOMEM;
-	}
 
 	info->dev = dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
@@ -2121,16 +2119,12 @@ static int sm501fb_suspend_fb(struct sm501fb_info *info,
 	/* backup copies in case chip is powered down over suspend */
 
 	par->store_fb = vmalloc(par->screen.size);
-	if (par->store_fb = NULL) {
-		dev_err(info->dev, "no memory to store screen\n");
+	if (!par->store_fb)
 		return -ENOMEM;
-	}
 
 	par->store_cursor = vmalloc(par->cursor.size);
-	if (par->store_cursor = NULL) {
-		dev_err(info->dev, "no memory to store cursor\n");
+	if (!par->store_cursor)
 		goto err_nocursor;
-	}
 
 	dev_dbg(info->dev, "suspending screen to %p\n", par->store_fb);
 	dev_dbg(info->dev, "suspending cursor to %p\n", par->store_cursor);
-- 
2.15.0

