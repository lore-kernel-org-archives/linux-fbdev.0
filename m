From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 05 Mar 2012 15:06:22 +0000
Subject: [PATCH v2] fbdev: sh_mobile_meram: Implement system suspend/resume
Message-Id: <1330959982-21836-1-git-send-email-laurent.pinchart@ideasonboard.com>
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
 drivers/video/sh_mobile_meram.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

Thanks to Guennadi for telling me about UNIVERSAL_DEV_PM_OPS.

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index d9f7a44..82ba830 100644
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
@@ -582,10 +582,9 @@ static int sh_mobile_meram_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops sh_mobile_meram_dev_pm_ops = {
-	.runtime_suspend = sh_mobile_meram_runtime_suspend,
-	.runtime_resume = sh_mobile_meram_runtime_resume,
-};
+static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
+			    sh_mobile_meram_suspend,
+			    sh_mobile_meram_resume, NULL);
 
 /* -----------------------------------------------------------------------------
  * Probe/remove and driver init/exit
-- 
Regards,

Laurent Pinchart

