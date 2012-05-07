From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 07 May 2012 01:16:13 +0000
Subject: [PATCH RESEND 8/9] video: mxsfb: adopt pinctrl support
Message-Id: <1336353374-28939-9-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cc: linux-fbdev@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/mxsfb.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 4a89f88..6c6bc57 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -45,6 +45,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 #include <mach/mxsfb.h>
 
 #define REG_SET	4
@@ -756,6 +757,7 @@ static int __devinit mxsfb_probe(struct platform_device *pdev)
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
+	struct pinctrl *pinctrl;
 	int i, ret;
 
 	if (!pdata) {
@@ -793,6 +795,12 @@ static int __devinit mxsfb_probe(struct platform_device *pdev)
 
 	host->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto error_getpin;
+	}
+
 	host->clk = clk_get(&host->pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
@@ -848,6 +856,7 @@ error_init_fb:
 error_pseudo_pallette:
 	clk_put(host->clk);
 error_getclock:
+error_getpin:
 	iounmap(host->base);
 error_ioremap:
 	framebuffer_release(fb_info);
-- 
1.7.5.4

