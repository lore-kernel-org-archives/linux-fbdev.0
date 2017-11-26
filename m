From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 12:19:17 +0000
Subject: [PATCH] video: sh_mobile_meram: Delete an error message for a failed memory allocation in sh_mobile_
Message-Id: <1feb3cf8-77e6-367e-5f5c-23fdd96339ec@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 13:08:43 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sh_mobile_meram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_meram.c b/drivers/video/fbdev/sh_mobile_meram.c
index baadfb207b2e..b5a6735aeb87 100644
--- a/drivers/video/fbdev/sh_mobile_meram.c
+++ b/drivers/video/fbdev/sh_mobile_meram.c
@@ -644,10 +644,8 @@ static int sh_mobile_meram_probe(struct platform_device *pdev)
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "cannot allocate device data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	/* Initialize private data. */
 	mutex_init(&priv->lock);
-- 
2.15.0

