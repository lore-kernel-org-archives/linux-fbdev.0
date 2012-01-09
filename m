From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 09 Jan 2012 16:23:57 +0000
Subject: [PATCH v2] atmel_lcdfb: fix usage of CONTRAST_CTR in suspend/resume
Message-Id: <1326126237-4355-1-git-send-email-nicolas.ferre@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
In-Reply-To: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Hubert Feurstein <h.feurstein@gmail.com>

An error was existing in the saving of CONTRAST_CTR register
across suspend/resume.

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/video/atmel_lcdfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index d7e3712..d99505b 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1102,7 +1102,7 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 	 */
 	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
 
-	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
+	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
-- 
1.7.5.4

