From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 17 Dec 2010 07:45:46 +0000
Subject: [PATCH] s3c-fb: add support for runtime pm
Message-Id: <1292571946-13595-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, Ilho Lee <ilho215.lee@samsung.com>, Jingoo Han <jg1.han@samsung.com>

This patch adds support for runtime pm using the functions.
 - pm_runtime_get_sync()
 - pm_runtime_put_sync()

pm_runtime_get_sync() and pm_runtime_put_sync() are called when
open or release function of framebufer driver is called to inform
the system if hardware is idle or not.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index f9aca9d..83ce9a0 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/map.h>
 #include <plat/regs-fb-v4.h>
@@ -1013,8 +1014,30 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	return ret;
 }
 
+static int s3c_fb_open(struct fb_info *info, int user)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb *sfb = win->parent;
+
+	pm_runtime_get_sync(sfb->dev);
+
+	return 0;
+}
+
+static int s3c_fb_release(struct fb_info *info, int user)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb *sfb = win->parent;
+
+	pm_runtime_put_sync(sfb->dev);
+
+	return 0;
+}
+
 static struct fb_ops s3c_fb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_open	= s3c_fb_open,
+	.fb_release	= s3c_fb_release,
 	.fb_check_var	= s3c_fb_check_var,
 	.fb_set_par	= s3c_fb_set_par,
 	.fb_blank	= s3c_fb_blank,
@@ -1322,6 +1345,8 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	clk_enable(sfb->bus_clk);
 
+	pm_runtime_enable(sfb->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "failed to find registers\n");
@@ -1360,6 +1385,9 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "got resources (regs %p), probing windows\n", sfb->regs);
 
+	platform_set_drvdata(pdev, sfb);
+	pm_runtime_get_sync(sfb->dev);
+
 	/* setup gpio and output polarity controls */
 
 	pd->setup_gpio();
@@ -1400,6 +1428,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sfb);
+	pm_runtime_put_sync(sfb->dev);
 
 	return 0;
 
@@ -1434,6 +1463,8 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	int win;
 
+	pm_runtime_get_sync(sfb->dev);
+
 	for (win = 0; win < S3C_FB_MAX_WIN; win++)
 		if (sfb->windows[win])
 			s3c_fb_release_win(sfb, sfb->windows[win]);
@@ -1450,12 +1481,74 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	kfree(sfb);
 
+	pm_runtime_put_sync(sfb->dev);
+	pm_runtime_disable(sfb->dev);
+
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int s3c_fb_suspend(struct platform_device *pdev, pm_message_t state)
+static int s3c_fb_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb_win *win;
+	int win_no;
+
+	for (win_no = S3C_FB_MAX_WIN - 1; win_no >= 0; win_no--) {
+		win = sfb->windows[win_no];
+		if (!win)
+			continue;
+
+		/* use the blank function to push into power-down */
+		s3c_fb_blank(FB_BLANK_POWERDOWN, win->fbinfo);
+	}
+
+	clk_disable(sfb->bus_clk);
+	return 0;
+}
+
+static int s3c_fb_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb_platdata *pd = sfb->pdata;
+	struct s3c_fb_win *win;
+	int win_no;
+
+	clk_enable(sfb->bus_clk);
+
+	/* setup registers */
+	writel(pd->vidcon1, sfb->regs + VIDCON1);
+
+	/* zero all windows before we do anything */
+	for (win_no = 0; win_no < sfb->variant.nr_windows; win_no++)
+		s3c_fb_clear_win(sfb, win_no);
+
+	for (win_no = 0; win_no < sfb->variant.nr_windows - 1; win_no++) {
+		void __iomem *regs = sfb->regs + sfb->variant.keycon;
+
+		regs += (win_no * 8);
+		writel(0xffffff, regs + WKEYCON0);
+		writel(0xffffff, regs + WKEYCON1);
+	}
+
+	/* restore framebuffers */
+	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++) {
+		win = sfb->windows[win_no];
+		if (!win)
+			continue;
+
+		dev_dbg(&pdev->dev, "resuming window %d\n", win_no);
+		s3c_fb_set_par(win->fbinfo);
+	}
+
+	return 0;
+}
+
+int s3c_fb_runtime_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	struct s3c_fb_win *win;
 	int win_no;
@@ -1473,8 +1566,9 @@ static int s3c_fb_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int s3c_fb_resume(struct platform_device *pdev)
+int s3c_fb_runtime_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	struct s3c_fb_platdata *pd = sfb->pdata;
 	struct s3c_fb_win *win;
@@ -1509,9 +1603,12 @@ static int s3c_fb_resume(struct platform_device *pdev)
 
 	return 0;
 }
+
 #else
 #define s3c_fb_suspend NULL
 #define s3c_fb_resume  NULL
+#define s3c_fb_runtime_suspend NULL
+#define s3c_fb_runtime_resume NULL
 #endif
 
 
@@ -1710,15 +1807,21 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c_fb_driver_ids);
 
+static const struct dev_pm_ops s3cfb_pm_ops = {
+	.suspend	= s3c_fb_suspend,
+	.resume		= s3c_fb_resume,
+	.runtime_suspend	= s3c_fb_runtime_suspend,
+	.runtime_resume		= s3c_fb_runtime_resume,
+};
+
 static struct platform_driver s3c_fb_driver = {
 	.probe		= s3c_fb_probe,
 	.remove		= __devexit_p(s3c_fb_remove),
-	.suspend	= s3c_fb_suspend,
-	.resume		= s3c_fb_resume,
 	.id_table	= s3c_fb_driver_ids,
 	.driver		= {
 		.name	= "s3c-fb",
 		.owner	= THIS_MODULE,
+		.pm	= &s3cfb_pm_ops,
 	},
 };
 
-- 
1.6.2.5

