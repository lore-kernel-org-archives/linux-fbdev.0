From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 21 Jan 2013 10:09:23 +0000
Subject: [PATCH 30/33] video: Convert to devm_ioremap_resource()
Message-Id: <1358762966-20791-31-git-send-email-thierry.reding@avionic-design.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/exynos/exynos_dp_core.c | 8 +++-----
 drivers/video/jz4740_fb.c             | 6 +++---
 drivers/video/omap2/dss/hdmi.c        | 8 +++-----
 drivers/video/omap2/vrfb.c            | 9 ++++-----
 drivers/video/s3c-fb.c                | 7 +++----
 5 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 4ef18e2..7aae0bf 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -1076,11 +1076,9 @@ static int exynos_dp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	dp->reg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!dp->reg_base) {
-		dev_err(&pdev->dev, "failed to ioremap\n");
-		return -ENOMEM;
-	}
+	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dp->reg_base))
+		return PTR_ERR(dp->reg_base);
 
 	dp->irq = platform_get_irq(pdev, 0);
 	if (dp->irq = -ENXIO) {
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index d999bb5..36979b4 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -660,9 +660,9 @@ static int jzfb_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	jzfb->base = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!jzfb->base) {
-		ret = -EBUSY;
+	jzfb->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(jzfb->base)) {
+		ret = PTR_ERR(jzfb->base);
 		goto err_framebuffer_release;
 	}
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 769d082..7292364 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1080,11 +1080,9 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	}
 
 	/* Base address taken from platform */
-	hdmi.ip_data.base_wp = devm_request_and_ioremap(&pdev->dev, res);
-	if (!hdmi.ip_data.base_wp) {
-		DSSERR("can't ioremap WP\n");
-		return -ENOMEM;
-	}
+	hdmi.ip_data.base_wp = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hdmi.ip_data.base_wp))
+		return PTR_ERR(hdmi.ip_data.base_wp);
 
 	r = hdmi_get_clocks(pdev);
 	if (r) {
diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
index 5d8fdac..10560ef 100644
--- a/drivers/video/omap2/vrfb.c
+++ b/drivers/video/omap2/vrfb.c
@@ -20,6 +20,7 @@
 
 /*#define DEBUG*/
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
@@ -357,11 +358,9 @@ static int __init vrfb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	vrfb_base = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!vrfb_base) {
-		dev_err(&pdev->dev, "can't ioremap vrfb memory\n");
-		return -ENOMEM;
-	}
+	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(vrfb_base))
+		return PTR_ERR(vrfb_base);
 
 	num_ctxs = pdev->num_resources - 1;
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9b57a23..968a625 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1421,10 +1421,9 @@ static int s3c_fb_probe(struct platform_device *pdev)
 	pm_runtime_enable(sfb->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sfb->regs = devm_request_and_ioremap(dev, res);
-	if (!sfb->regs) {
-		dev_err(dev, "failed to map registers\n");
-		ret = -ENXIO;
+	sfb->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sfb->regs)) {
+		ret = PTR_ERR(sfb->regs);
 		goto err_lcd_clk;
 	}
 
-- 
1.8.1.1

