From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:51 +0000
Subject: [PATCH 4/5 v3] fbdev: sh_mobile_meram: Backup/restore device registers on shutdown/resume
Message-Id: <1308728992-9660-5-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Save and reconfigure the MERAM registers when the MERAM is powered down
and restored

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
Changes from V2
=======
* The private data structure definition was moved from sh_mobile_meram.h to
  sh_mobile_meram.c.  This has been moved into a separate patch

 drivers/video/sh_mobile_meram.c |   71 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index cc71cbf..7afd77a 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -37,12 +37,31 @@
 #define MEQSEL1 0x40
 #define MEQSEL2 0x44
 
+static unsigned long common_regs[] = {
+	MEVCR1,
+	MEQSEL1,
+	MEQSEL2,
+};
+#define CMN_REGS_SIZE ARRAY_SIZE(common_regs)
+
+static unsigned long icb_regs[] = {
+	MExxCTL,
+	MExxBSIZE,
+	MExxMNCF,
+	MExxSARA,
+	MExxSARB,
+	MExxSBSIZE,
+};
+#define ICB_REGS_SIZE ARRAY_SIZE(icb_regs)
+
 struct sh_mobile_meram_priv {
 	void __iomem	*base;
 	struct mutex	lock;
 	unsigned long	used_icb;
 	int		used_meram_cache_regions;
 	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
+	unsigned long	cmn_saved_regs[CMN_REGS_SIZE];
+	unsigned long	icb_saved_regs[ICB_REGS_SIZE * SH_MOBILE_MERAM_ICB_NUM];
 };
 
 /* settings */
@@ -489,6 +508,57 @@ int sh_mobile_meram_pm_put_sync(struct sh_mobile_meram_info *pdata)
 	return 0;
 }
 
+static int sh_mobile_meram_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	int k, j;
+
+	for (k = 0; k < CMN_REGS_SIZE; k++)
+		priv->cmn_saved_regs[k] = meram_read_reg(priv->base,
+			common_regs[k]);
+
+	for (j = 0; j < 32; j++) {
+		if (!test_bit(j, &priv->used_icb))
+			continue;
+		for (k = 0; k < ICB_REGS_SIZE; k++) {
+			priv->icb_saved_regs[j * ICB_REGS_SIZE + k] +				meram_read_icb(priv->base, j, icb_regs[k]);
+			/* Reset ICB on resume */
+			if (icb_regs[k] = MExxCTL)
+				priv->icb_saved_regs[j * ICB_REGS_SIZE + k] +					0x70;
+		}
+	}
+	return 0;
+}
+
+static int sh_mobile_meram_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	int k, j;
+
+	for (j = 0; j < 32; j++) {
+		if (!test_bit(j, &priv->used_icb))
+			continue;
+		for (k = 0; k < ICB_REGS_SIZE; k++) {
+			meram_write_icb(priv->base, j, icb_regs[k],
+			priv->icb_saved_regs[j * ICB_REGS_SIZE + k]);
+		}
+	}
+
+	for (k = 0; k < CMN_REGS_SIZE; k++)
+		meram_write_reg(priv->base, common_regs[k],
+			priv->cmn_saved_regs[k]);
+	return 0;
+}
+
+static const struct dev_pm_ops sh_mobile_meram_dev_pm_ops = {
+	.runtime_suspend = sh_mobile_meram_runtime_suspend,
+	.runtime_resume = sh_mobile_meram_runtime_resume,
+};
+
 static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
 	.module			= THIS_MODULE,
 	.meram_register		= sh_mobile_meram_register,
@@ -579,6 +649,7 @@ static struct platform_driver sh_mobile_meram_driver = {
 	.driver	= {
 		.name		= "sh_mobile_meram",
 		.owner		= THIS_MODULE,
+		.pm		= &sh_mobile_meram_dev_pm_ops,
 	},
 	.probe		= sh_mobile_meram_probe,
 	.remove		= sh_mobile_meram_remove,
-- 
1.7.1

