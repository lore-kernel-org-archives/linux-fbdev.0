From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:10:37 +0000
Subject: [PATCH 16/19] video: s3c-fb: use dev_get_platdata()
Message-Id: <001601ceb364$3ecbacc0$bc630640$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2e7991c..62acae2 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1378,7 +1378,7 @@ static int s3c_fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pd = pdev->dev.platform_data;
+	pd = dev_get_platdata(&pdev->dev);
 	if (!pd) {
 		dev_err(dev, "no platform data specified\n");
 		return -EINVAL;
-- 
1.7.10.4


