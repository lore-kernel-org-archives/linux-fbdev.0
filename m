From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Jul 2013 15:57:47 +0000
Subject: [PATCH 12/12] drivers/video: don't use devm_pinctrl_get_select_default() in probe
Message-Id: <1373471889-18107-12-git-send-email-wsa@the-dreams.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for setting the default pins. Compile tested only.

Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/video/mxsfb.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 3ba3771..5861ba2 100644
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
@@ -908,12 +906,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 
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
1.7.10.4

