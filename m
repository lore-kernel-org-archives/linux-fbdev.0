From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Apr 2011 07:22:58 +0000
Subject: [PATCH] video: s3c-fb: make runtime pm functions static
Message-Id: <1302506578-21676-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch makes runtime pm functions static.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6817d18..832c7e5 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1547,7 +1547,7 @@ static int s3c_fb_resume(struct device *dev)
 	return 0;
 }
 
-int s3c_fb_runtime_suspend(struct device *dev)
+static int s3c_fb_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
@@ -1567,7 +1567,7 @@ int s3c_fb_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-int s3c_fb_runtime_resume(struct device *dev)
+static int s3c_fb_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
-- 
1.7.1

