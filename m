From: Jason Jin <Jason.Jin@freescale.com>
Date: Thu, 27 Mar 2014 11:37:22 +0000
Subject: [PATCH 1/2] video/fsl: Fix the sleep function for FSL DIU module
Message-Id: <1395920242-1004-1-git-send-email-Jason.Jin@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b07421@freescale.com, timur@tabi.org
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, r58472@freescale.com, jason.jin@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>

For deep sleep, the diu module will power off, when wake up from the deep
sleep, more registers need to be reinitialized.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
---
V2: Coding style clean up based on Timur's comments.

 drivers/video/fsl-diu-fb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e8758b9..4bc4730 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1628,9 +1628,15 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	unsigned int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+	for (i = 0; i < NUM_AOIS; i++) {
+		if (data->mfb[i].count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
1.8.0


