From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:51 +0000
Subject: [PATCH 3/6] video: da8xx-fb: Staticize reg_context
Message-Id: <1380108594-19090-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'reg_context' is local to this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 70fc8e8..0670c85 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1548,7 +1548,7 @@ err_pm_runtime_disable:
 }
 
 #ifdef CONFIG_PM
-struct lcdc_context {
+static struct lcdc_context {
 	u32 clk_enable;
 	u32 ctrl;
 	u32 dma_ctrl;
-- 
1.7.9.5

