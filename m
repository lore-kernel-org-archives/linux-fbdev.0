From: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 25 Mar 2014 07:56:20 +0000
Subject: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
Message-Id: <1395734180-45012-1-git-send-email-dongsheng.wang@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: scottwood@freescale.com, timur@tabi.org
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Wang Dongsheng <dongsheng.wang@freescale.com>, Jason Jin <Jason.Jin@freescale.com>

From: Jason Jin <Jason.Jin@freescale.com>

For deep sleep, the diu module will power off, when wake up
from the deep sleep, the registers need to be reinitialized.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e8758b9..7ec780c 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1628,9 +1628,18 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	struct mfb_info *mfbi;
+	int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+
+	for (i = 0; i < NUM_AOIS; i++) {
+		mfbi = &data->mfb[i];
+		if (mfbi->count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
1.8.5


