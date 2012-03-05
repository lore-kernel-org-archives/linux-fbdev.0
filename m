From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 05 Mar 2012 14:53:39 +0000
Subject: [PATCH] fbdev: sh_mobile_meram: Implement system suspend/resume
Message-Id: <1330959219-16176-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Supporting runtime PM is very nice, but that's not a reason not to
implement system suspend/resume properly.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

I'll add this patch to my LCDC patch series.

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index d9f7a44..0d9bc2d 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -539,7 +539,7 @@ static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
  * Power management
  */
 
-static int sh_mobile_meram_runtime_suspend(struct device *dev)
+static int sh_mobile_meram_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
@@ -563,7 +563,7 @@ static int sh_mobile_meram_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sh_mobile_meram_runtime_resume(struct device *dev)
+static int sh_mobile_meram_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
@@ -583,8 +583,10 @@ static int sh_mobile_meram_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops sh_mobile_meram_dev_pm_ops = {
-	.runtime_suspend = sh_mobile_meram_runtime_suspend,
-	.runtime_resume = sh_mobile_meram_runtime_resume,
+	.suspend = sh_mobile_meram_suspend,
+	.resume = sh_mobile_meram_resume,
+	.runtime_suspend = sh_mobile_meram_suspend,
+	.runtime_resume = sh_mobile_meram_resume,
 };
 
 /* -----------------------------------------------------------------------------
-- 
Regards,

Laurent Pinchart

