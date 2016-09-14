From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 14 Sep 2016 12:29:50 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: Return value is not handled correctly
Message-Id: <1473855470-16632-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: timur@tabi.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

-Free memory mapping after mapping done.
-uninstall framebuffer after framebuffer intallation done.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/fsl-diu-fb.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index fe00a07..12449b4 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1715,8 +1715,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	 */
 	if ((unsigned long)data & 31) {
 		dev_err(&pdev->dev, "misaligned allocation");
-		ret = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&data->reg_lock);
@@ -1752,8 +1751,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	data->diu_reg = of_iomap(np, 0);
 	if (!data->diu_reg) {
 		dev_err(&pdev->dev, "cannot map DIU registers\n");
-		ret = -EFAULT;
-		goto error;
+		return -EFAULT;
 	}
 
 	/* Get the IRQ of the DIU */
@@ -1762,7 +1760,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	if (!data->irq) {
 		dev_err(&pdev->dev, "could not get DIU IRQ\n");
 		ret = -EINVAL;
-		goto error;
+		goto err_unmap;
 	}
 	data->monitor_port = monitor_port;
 
@@ -1797,7 +1795,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 			  data->diu_reg);
 	if (ret) {
 		dev_err(&pdev->dev, "could not claim irq\n");
-		goto error;
+		goto err_unmap;
 	}
 
 	for (i = 0; i < NUM_AOIS; i++) {
@@ -1826,7 +1824,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 error:
 	for (i = 0; i < NUM_AOIS; i++)
 		uninstall_fb(&data->fsl_diu_info[i]);
-
+err_unmap:
 	iounmap(data->diu_reg);
 
 	return ret;
-- 
1.7.9.5

