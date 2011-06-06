From: Hubert Feurstein <h.feurstein@gmail.com>
Date: Mon, 06 Jun 2011 08:50:51 +0000
Subject: [PATCH] atmel_lcdfb: fix usage of wrong registers in suspend/resume
Message-Id: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I assume the intention was to set the contrast value to 0 and not
the contrast control register (in atmel_lcdfb_suspend). And in
atmel_lcdfb_resume the contrast value should be restored.

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/video/atmel_lcdfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 4484c72..2ed7ec1 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1086,7 +1086,7 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
 
 	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
-	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, 0);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
 
@@ -1105,7 +1105,7 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
 	atmel_lcdfb_start(sinfo);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(1);
-	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lcdcon);
+	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, sinfo->saved_lcdcon);
 
 	/* Enable FIFO & DMA errors */
 	lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI
-- 
1.7.1

