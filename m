From: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Fri, 14 Aug 2015 05:54:09 +0000
Subject: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU module
Message-Id: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: timur@tabi.org
Cc: scottwood@freescale.com, Jason.Jin@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, Wang
 Dongsheng <dongsheng.wang@freescale.com>

From: Jason Jin <Jason.Jin@freescale.com>

For deep sleep, the diu module will power off, when wake up
from the deep sleep, the registers need to be reinitialized.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v2*
Changes:
- int i -> unsigned int i.

Rmove:
- struct mfb_info *mfbi;

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 7fa2e6f..b335c1a 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1628,9 +1628,16 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	unsigned int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+	for (i = 0; i < NUM_AOIS; i++) {
+		if (data->mfb[i].count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
2.1.0.27.g96db324

