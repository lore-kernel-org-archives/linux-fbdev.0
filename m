From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 03 Apr 2013 01:30:53 +0000
Subject: [PATCH 2/2] video: mxsfb: Use of_get_display_gpio_enable()
Message-Id: <1364952653-7567-2-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Use of_get_display_gpio_enable() helper to retrieve the GPIO from devicetree 
that turns on the display.

This lets the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/Kconfig |    1 +
 drivers/video/mxsfb.c |   21 ++++-----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7607f42..810f990 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2445,6 +2445,7 @@ config FB_MXS
 	select FB_CFB_IMAGEBLIT
 	select FB_MODE_HELPERS
 	select OF_VIDEOMODE
+	select OF_DISPLAY_ENABLE_GPIO
 	help
 	  Framebuffer support for the MXS SoC.
 
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index eac7c1a..50b041a9 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -51,6 +51,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/fb.h>
 #include <video/videomode.h>
+#include <video/of_display_gpio.h>
 
 #define REG_SET	4
 #define REG_CLR	8
@@ -859,8 +860,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
 	struct pinctrl *pinctrl;
-	int panel_enable;
-	enum of_gpio_flags flags;
 	int ret;
 
 	if (of_id)
@@ -904,21 +903,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
-	panel_enable = of_get_named_gpio_flags(pdev->dev.of_node,
-					       "panel-enable-gpios", 0, &flags);
-	if (gpio_is_valid(panel_enable)) {
-		unsigned long f = GPIOF_OUT_INIT_HIGH;
-		if (flags = OF_GPIO_ACTIVE_LOW)
-			f = GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&pdev->dev, panel_enable,
-					    f, "panel-enable");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to request gpio %d: %d\n",
-				panel_enable, ret);
-			goto fb_release;
-		}
-	}
+	ret = of_get_display_gpio_enable(pdev);
+	if (ret)
+		goto fb_release;
 
 	fb_info->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
 					       GFP_KERNEL);
-- 
1.7.9.5

