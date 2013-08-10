From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 10 Aug 2013 07:33:57 +0000
Subject: [PATCH v2] video: imxfb: Fix retrieve values from DT
Message-Id: <1376120037-23777-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Display settings should be retrieved from "display" node, not from
root fb node. This patch fix this bug.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/imxfb.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 38733ac..8e104c4 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -753,12 +753,12 @@ static int imxfb_resume(struct platform_device *dev)
 #define imxfb_resume	NULL
 #endif
 
-static int imxfb_init_fbinfo(struct platform_device *pdev)
+static int imxfb_init_fbinfo(struct platform_device *pdev,
+			     struct device_node *np)
 {
 	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
 	struct fb_info *info = dev_get_drvdata(&pdev->dev);
 	struct imxfb_info *fbi = info->par;
-	struct device_node *np;
 
 	pr_debug("%s\n",__func__);
 
@@ -799,7 +799,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 		fbi->lcd_power			= pdata->lcd_power;
 		fbi->backlight_power		= pdata->backlight_power;
 	} else {
-		np = pdev->dev.of_node;
 		info->var.grayscale = of_property_read_bool(np,
 						"cmap-greyscale");
 		fbi->cmap_inverse = of_property_read_bool(np, "cmap-inverse");
@@ -858,6 +857,7 @@ static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
 
 static int imxfb_probe(struct platform_device *pdev)
 {
+	struct device_node *display_np = NULL;
 	struct imxfb_info *fbi;
 	struct fb_info *info;
 	struct imx_fb_platform_data *pdata;
@@ -887,7 +887,17 @@ static int imxfb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	ret = imxfb_init_fbinfo(pdev);
+	if (pdev->dev.of_node) {
+		display_np = of_parse_phandle(pdev->dev.of_node, "display", 0);
+		if (!display_np) {
+			dev_err(&pdev->dev,
+				"No display defined in devicetree\n");
+			ret = -EINVAL;
+			goto failed_init;
+		}
+	}
+
+	ret = imxfb_init_fbinfo(pdev, display_np);
 	if (ret < 0)
 		goto failed_init;
 
@@ -898,16 +908,8 @@ static int imxfb_probe(struct platform_device *pdev)
 		fbi->mode = pdata->mode;
 		fbi->num_modes = pdata->num_modes;
 	} else {
-		struct device_node *display_np;
 		fb_mode = NULL;
 
-		display_np = of_parse_phandle(pdev->dev.of_node, "display", 0);
-		if (!display_np) {
-			dev_err(&pdev->dev, "No display defined in devicetree\n");
-			ret = -EINVAL;
-			goto failed_of_parse;
-		}
-
 		/*
 		 * imxfb does not support more modes, we choose only the native
 		 * mode.
-- 
1.8.1.5

