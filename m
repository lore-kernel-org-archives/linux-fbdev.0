From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 04 Jul 2011 08:06:11 +0000
Subject: [PATCH 1/5] fbdev: sh_mobile_meram: Enable runtime PM
Message-Id: <1309766771-32452-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_meram.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 9170c82..61e106f 100644
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
@@ -515,6 +516,8 @@ static int __devinit sh_mobile_meram_probe(struct platform_device *pdev)
 	if (pdata->addr_mode = SH_MOBILE_MERAM_MODE1)
 		meram_write_reg(priv->base, MEVCR1, 1 << 29);
 
+	pm_runtime_enable(&pdev->dev);
+
 	dev_info(&pdev->dev, "sh_mobile_meram initialized.");
 
 	return 0;
@@ -530,6 +533,8 @@ static int sh_mobile_meram_remove(struct platform_device *pdev)
 {
 	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->base)
 		iounmap(priv->base);
 
-- 
1.7.1

