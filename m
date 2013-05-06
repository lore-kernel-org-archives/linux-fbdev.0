From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 06 May 2013 18:05:59 +0000
Subject: [PATCH 11/13] video: mxsfb: Let device core handle pinctrl
Message-Id: <1367863561-11534-11-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for handling pinctrl.

So remove devm_pinctrl_get_select_default() from the driver. 

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: <linux-fbdev@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/mxsfb.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 45169cb..a27f028 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -47,7 +47,6 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/mxsfb.h>
 
 #define REG_SET	4
@@ -783,7 +782,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
-	struct pinctrl *pinctrl;
 	int panel_enable;
 	enum of_gpio_flags flags;
 	int i, ret;
@@ -826,12 +824,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	host->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto error_getpin;
-	}
-
 	host->clk = clk_get(&host->pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
@@ -906,7 +898,6 @@ error_pseudo_pallette:
 error_panel_enable:
 	clk_put(host->clk);
 error_getclock:
-error_getpin:
 	iounmap(host->base);
 error_ioremap:
 	framebuffer_release(fb_info);
-- 
1.7.9.5


