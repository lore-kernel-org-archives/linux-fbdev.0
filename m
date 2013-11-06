From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Nov 2013 08:57:27 +0000
Subject: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used compiler warnings
Message-Id: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:

drivers/video/sh_mobile_meram.c:573: warning: ‘sh_mobile_meram_suspend’ defined but not used
drivers/video/sh_mobile_meram.c:597: warning: ‘sh_mobile_meram_resume’ defined but not used

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2: Both functions are used if CONFIG_PM_SLEEP || CONFIG_PM_RUNTIME,
    as pointed out by Laurent

 drivers/video/sh_mobile_meram.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index e0f098562a74..a297de5cc859 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -569,6 +569,7 @@ EXPORT_SYMBOL_GPL(sh_mobile_meram_cache_update);
  * Power management
  */
 
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
 static int sh_mobile_meram_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -611,6 +612,7 @@ static int sh_mobile_meram_resume(struct device *dev)
 		meram_write_reg(priv->base, common_regs[i], priv->regs[i]);
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP || CONFIG_PM_RUNTIME */
 
 static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
 			    sh_mobile_meram_suspend,
-- 
1.7.9.5

