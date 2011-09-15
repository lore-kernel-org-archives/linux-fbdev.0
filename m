From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:56 +0000
Subject: [PATCH 11/13] drivers/video: fsl-diu-fb: use a normal for-loop to uninstall framebuffers
Message-Id: <1316123098-30967-12-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Uninstalling the framebuffers in reverse order is unnecessary and makes
the for-loop awkward.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index c66f6ed..5137fbb 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1543,9 +1543,9 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	for (i = ARRAY_SIZE(machine_data->fsl_diu_info);
-		i > 0; i--)
-		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
+	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
+		uninstall_fb(machine_data->fsl_diu_info[i]);
+
 	if (pool.ad.vaddr)
 		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
@@ -1575,8 +1575,8 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	machine_data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(machine_data->fsl_diu_info[0]);
 	free_irq_local(machine_data->irq);
-	for (i = ARRAY_SIZE(machine_data->fsl_diu_info); i > 0; i--)
-		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
+	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
+		uninstall_fb(machine_data->fsl_diu_info[i]);
 	if (pool.ad.vaddr)
 		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
-- 
1.7.3.4


