From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:48 +0000
Subject: [PATCH 1/5 v3] fbdev: sh_mobile_meram: Add enable/disble hooks for LCDC
Message-Id: <1308728992-9660-2-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add hooks to allow the LCDC to increase/decrease the MERAM PM reference
counts

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
Changes from V2
=======
* Change the names of the clk_on/clk_off callbacks to pm_get_sync/pm_put_sync
  to better reflect their actual functionality

* Make these callback functions static

 drivers/video/sh_mobile_meram.c |   27 +++++++++++++++++++++++++++
 include/video/sh_mobile_meram.h |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 9170c82..371f129 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -460,11 +461,33 @@ static int sh_mobile_meram_update(struct sh_mobile_meram_info *pdata,
 	return 0;
 }
 
+static int sh_mobile_meram_pm_get_sync(struct sh_mobile_meram_info *pdata)
+{
+	if (!pdata || !pdata->pdev)
+		return -EINVAL;
+
+	dev_dbg(&pdata->pdev->dev, "Enabling sh_mobile_meram clock.");
+	pm_runtime_get_sync(&pdata->pdev->dev);
+	return 0;
+}
+
+static int sh_mobile_meram_pm_put_sync(struct sh_mobile_meram_info *pdata)
+{
+	if (!pdata || !pdata->pdev)
+		return -EINVAL;
+
+	dev_dbg(&pdata->pdev->dev, "Disabling sh_mobile_meram clock.");
+	pm_runtime_put_sync(&pdata->pdev->dev);
+	return 0;
+}
+
 static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
 	.module			= THIS_MODULE,
 	.meram_register		= sh_mobile_meram_register,
 	.meram_unregister	= sh_mobile_meram_unregister,
 	.meram_update		= sh_mobile_meram_update,
+	.meram_pm_put_sync	= sh_mobile_meram_pm_put_sync,
+	.meram_pm_get_sync	= sh_mobile_meram_pm_get_sync,
 };
 
 /*
@@ -515,6 +538,8 @@ static int __devinit sh_mobile_meram_probe(struct platform_device *pdev)
 	if (pdata->addr_mode = SH_MOBILE_MERAM_MODE1)
 		meram_write_reg(priv->base, MEVCR1, 1 << 29);
 
+	pm_runtime_enable(&pdev->dev);
+
 	dev_info(&pdev->dev, "sh_mobile_meram initialized.");
 
 	return 0;
@@ -530,6 +555,8 @@ static int sh_mobile_meram_remove(struct platform_device *pdev)
 {
 	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->base)
 		iounmap(priv->base);
 
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index af602d6..f213b6d 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -63,6 +63,12 @@ struct sh_mobile_meram_ops {
 			    unsigned long base_addr_c,
 			    unsigned long *icb_addr_y,
 			    unsigned long *icb_addr_c);
+
+	/* enable meram clock */
+	int (*meram_pm_get_sync)(struct sh_mobile_meram_info *meram_dev);
+
+	/* disable meram clock */
+	int (*meram_pm_put_sync)(struct sh_mobile_meram_info *meram_dev);
 };
 
 #endif /* __VIDEO_SH_MOBILE_MERAM_H__  */
-- 
1.7.1

