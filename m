From: Stefan Agner <stefan@agner.ch>
Date: Sun, 04 Sep 2016 04:26:27 +0000
Subject: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <20160904042627.30182-1-stefan@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

The lcd-supply is meant to be optional, there are several device-
trees not specifying it and the code handles error values silently.
Therefor, avoid creating a dummy regulator (and the associated
warning) by using devm_regulator_get_optional.

While at it, document that fact also in the device-tree bindings.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 3 +++
 drivers/video/fbdev/mxsfb.c                         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index 96ec517..0bc530f 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -7,6 +7,9 @@ Required properties:
 - interrupts: Should contain lcdif interrupts
 - display : phandle to display node (see below for details)
 
+Optional properties:
+- lcd-supply: Regulator for LCD supply voltage.
+
 * display node
 
 Required properties:
diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 4e6608c..4f7570f 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -920,7 +920,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk_disp_axi))
 		host->clk_disp_axi = NULL;
 
-	host->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
+	host->reg_lcd = devm_regulator_get_optional(&pdev->dev, "lcd");
 	if (IS_ERR(host->reg_lcd))
 		host->reg_lcd = NULL;
 
-- 
2.9.0

