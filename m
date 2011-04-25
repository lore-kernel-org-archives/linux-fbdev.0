From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 25 Apr 2011 10:38:29 +0000
Subject: [PATCH] video: s3c-fb: add gpio setup function to resume function
Message-Id: <1303727909-20934-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds gpio setup function to resume function to ensure
gpio used by FIMD IP and LCD panel during a resume.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 3fa7911..9457546 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1528,7 +1528,8 @@ static int s3c_fb_resume(struct device *dev)
 
 	clk_enable(sfb->bus_clk);
 
-	/* setup registers */
+	/* setup gpio and output polarity controls */
+	pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	/* zero all windows before we do anything */
@@ -1586,7 +1587,8 @@ static int s3c_fb_runtime_resume(struct device *dev)
 
 	clk_enable(sfb->bus_clk);
 
-	/* setup registers */
+	/* setup gpio and output polarity controls */
+	pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	/* zero all windows before we do anything */
-- 
1.7.1

