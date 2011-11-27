From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 27 Nov 2011 22:51:07 +0000
Subject: [PATCH 1/2] video: s3c-fb: Unify runtime and system PM functions
Message-Id: <1322434268-25525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The s3c-fb driver has separate runtime and system PM functions but the
implementations are identical so far as I can tell so unify them for
simplicity.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is a slightly updated version of the patch, previously I forgot to
staticise the pm_ops.

 drivers/video/s3c-fb.c |   75 +-----------------------------------------------
 1 files changed, 1 insertions(+), 74 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 12eaee0..27971bc 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1590,77 +1590,9 @@ static int s3c_fb_resume(struct device *dev)
 
 	return 0;
 }
-
-static int s3c_fb_runtime_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
-	struct s3c_fb_win *win;
-	int win_no;
-
-	for (win_no = S3C_FB_MAX_WIN - 1; win_no >= 0; win_no--) {
-		win = sfb->windows[win_no];
-		if (!win)
-			continue;
-
-		/* use the blank function to push into power-down */
-		s3c_fb_blank(FB_BLANK_POWERDOWN, win->fbinfo);
-	}
-
-	if (!sfb->variant.has_clksel)
-		clk_disable(sfb->lcd_clk);
-
-	clk_disable(sfb->bus_clk);
-	return 0;
-}
-
-static int s3c_fb_runtime_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c_fb *sfb = platform_get_drvdata(pdev);
-	struct s3c_fb_platdata *pd = sfb->pdata;
-	struct s3c_fb_win *win;
-	int win_no;
-
-	clk_enable(sfb->bus_clk);
-
-	if (!sfb->variant.has_clksel)
-		clk_enable(sfb->lcd_clk);
-
-	/* setup gpio and output polarity controls */
-	pd->setup_gpio();
-	writel(pd->vidcon1, sfb->regs + VIDCON1);
-
-	/* zero all windows before we do anything */
-	for (win_no = 0; win_no < sfb->variant.nr_windows; win_no++)
-		s3c_fb_clear_win(sfb, win_no);
-
-	for (win_no = 0; win_no < sfb->variant.nr_windows - 1; win_no++) {
-		void __iomem *regs = sfb->regs + sfb->variant.keycon;
-
-		regs += (win_no * 8);
-		writel(0xffffff, regs + WKEYCON0);
-		writel(0xffffff, regs + WKEYCON1);
-	}
-
-	/* restore framebuffers */
-	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++) {
-		win = sfb->windows[win_no];
-		if (!win)
-			continue;
-
-		dev_dbg(&pdev->dev, "resuming window %d\n", win_no);
-		s3c_fb_set_par(win->fbinfo);
-	}
-
-	return 0;
-}
-
 #else
 #define s3c_fb_suspend NULL
 #define s3c_fb_resume  NULL
-#define s3c_fb_runtime_suspend NULL
-#define s3c_fb_runtime_resume NULL
 #endif
 
 
@@ -1985,12 +1917,7 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c_fb_driver_ids);
 
-static const struct dev_pm_ops s3cfb_pm_ops = {
-	.suspend	= s3c_fb_suspend,
-	.resume		= s3c_fb_resume,
-	.runtime_suspend	= s3c_fb_runtime_suspend,
-	.runtime_resume		= s3c_fb_runtime_resume,
-};
+static UNIVERSAL_DEV_PM_OPS(s3cfb_pm_ops, s3c_fb_suspend, s3c_fb_resume, NULL);
 
 static struct platform_driver s3c_fb_driver = {
 	.probe		= s3c_fb_probe,
-- 
1.7.7.3

