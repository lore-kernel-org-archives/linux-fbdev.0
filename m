From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Jul 2013 21:31:24 +0000
Subject: [PATCH RESEND] video: mxsfb: Let device core handle pinctrl
Message-Id: <1373923884-13332-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
we can rely on device core for handling pinctrl, so remove 
devm_pinctrl_get_select_default() from the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
Andrew,

Should this go via your tree?

 drivers/video/mxsfb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..9d6a286 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -46,7 +46,6 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/fb.h>
 #include <linux/regulator/consumer.h>
 #include <video/of_display_timing.h>
@@ -877,7 +876,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
-	struct pinctrl *pinctrl;
 	int ret;
 
 	if (of_id)
@@ -909,12 +907,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	host->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto fb_release;
-	}
-
 	host->clk = devm_clk_get(&host->pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
-- 
1.8.1.2

