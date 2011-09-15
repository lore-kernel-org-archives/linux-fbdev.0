From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:53 +0000
Subject: [PATCH 08/13] drivers/video: fsl-diu-fb: set the driver name to "fsl-diu-fb"
Message-Id: <1316123098-30967-9-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the name "fsl-diu-fb" in the Freescale DIU framebuffer driver
during registrations.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4d22399..19bfbf5 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1274,7 +1274,7 @@ static int request_irq_local(int irq)
 	/* Read to clear the status */
 	in_be32(&hw->int_status);
 
-	ret = request_irq(irq, fsl_diu_isr, 0, "diu", NULL);
+	ret = request_irq(irq, fsl_diu_isr, 0, "fsl-diu-fb", NULL);
 	if (!ret) {
 		ints = INT_PARERR | INT_LS_BF_VS;
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
@@ -1634,7 +1634,7 @@ MODULE_DEVICE_TABLE(of, fsl_diu_match);
 
 static struct platform_driver fsl_diu_driver = {
 	.driver = {
-		.name = "fsl_diu",
+		.name = "fsl-diu-fb",
 		.owner = THIS_MODULE,
 		.of_match_table = fsl_diu_match,
 	},
-- 
1.7.3.4


