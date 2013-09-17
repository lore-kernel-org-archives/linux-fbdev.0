From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:11:04 +0000
Subject: [PATCH 17/19] video: simplefb: use dev_get_platdata()
Message-Id: <001701ceb364$4f42ea50$edc8bef0$%han@samsung.com>
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
 drivers/video/simplefb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d78106..ad46d2d 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -132,7 +132,7 @@ static int simplefb_parse_dt(struct platform_device *pdev,
 static int simplefb_parse_pd(struct platform_device *pdev,
 			     struct simplefb_params *params)
 {
-	struct simplefb_platform_data *pd = pdev->dev.platform_data;
+	struct simplefb_platform_data *pd = dev_get_platdata(&pdev->dev);
 	int i;
 
 	params->width = pd->width;
@@ -167,7 +167,7 @@ static int simplefb_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	ret = -ENODEV;
-	if (pdev->dev.platform_data)
+	if (dev_get_platdata(&pdev->dev))
 		ret = simplefb_parse_pd(pdev, &params);
 	else if (pdev->dev.of_node)
 		ret = simplefb_parse_dt(pdev, &params);
-- 
1.7.10.4


