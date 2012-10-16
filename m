From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 16 Oct 2012 07:21:25 +0000
Subject: [PATCH] video: s3c-fb: use dev_get_drvdata() instead of platform_get_drvdata()
Message-Id: <006f01cdab6e$d9fd70b0$8df85210$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Because there is no need to access to the platform device in
suspend/resume and runtime_suspend/resume, dev_get_drvdata()
can be used instead of platform_get_drvdata() to make the code
smaller.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2ed7b63..95c6e30 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1544,8 +1544,7 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int s3c_fb_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb *sfb = dev_get_drvdata(dev);
 	struct s3c_fb_win *win;
 	int win_no;
 
@@ -1572,8 +1571,7 @@ static int s3c_fb_suspend(struct device *dev)
 
 static int s3c_fb_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb *sfb = dev_get_drvdata(dev);
 	struct s3c_fb_platdata *pd = sfb->pdata;
 	struct s3c_fb_win *win;
 	int win_no;
@@ -1623,7 +1621,7 @@ static int s3c_fb_resume(struct device *dev)
 		if (!win)
 			continue;
 
-		dev_dbg(&pdev->dev, "resuming window %d\n", win_no);
+		dev_dbg(dev, "resuming window %d\n", win_no);
 		s3c_fb_set_par(win->fbinfo);
 	}
 
@@ -1636,8 +1634,7 @@ static int s3c_fb_resume(struct device *dev)
 #ifdef CONFIG_PM_RUNTIME
 static int s3c_fb_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb *sfb = dev_get_drvdata(dev);
 
 	if (!sfb->variant.has_clksel)
 		clk_disable_unprepare(sfb->lcd_clk);
@@ -1649,8 +1646,7 @@ static int s3c_fb_runtime_suspend(struct device *dev)
 
 static int s3c_fb_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb *sfb = dev_get_drvdata(dev);
 	struct s3c_fb_platdata *pd = sfb->pdata;
 
 	clk_prepare_enable(sfb->bus_clk);
-- 
1.7.1


