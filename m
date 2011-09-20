From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:21:28 +0000
Subject: [PATCH v2 2/4] fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
Message-Id: <1316546490-4639-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Validate as much of the requested ICB configuration as possible outside
of the mutex-protected region when registering ICBs.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 569888c..f7e77f6 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -413,24 +413,22 @@ static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 		xres, yres, (!pixelformat) ? "yuv" : "rgb",
 		base_addr_y, base_addr_c);
 
-	mutex_lock(&priv->lock);
-
 	/* we can't handle wider than 8192px */
 	if (xres > 8192) {
 		dev_err(&pdev->dev, "width exceeding the limit (> 8192).");
-		error = -EINVAL;
-		goto err;
-	}
-
-	if (priv->used_meram_cache_regions + 2 > SH_MOBILE_MERAM_ICB_NUM) {
-		dev_err(&pdev->dev, "no more ICB available.");
-		error = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	/* do we have at least one ICB config? */
 	if (cfg->icb[0].marker_icb < 0 || cfg->icb[0].cache_icb < 0) {
 		dev_err(&pdev->dev, "at least one ICB is required.");
+		return -EINVAL;
+	}
+
+	mutex_lock(&priv->lock);
+
+	if (priv->used_meram_cache_regions + 2 > SH_MOBILE_MERAM_ICB_NUM) {
+		dev_err(&pdev->dev, "no more ICB available.");
 		error = -EINVAL;
 		goto err;
 	}
-- 
1.7.3.4

