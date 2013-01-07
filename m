From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 07 Jan 2013 05:23:00 +0000
Subject: [PATCH 05/10] video: da8xx-fb: reorganize panel detection
Message-Id: <a46b7387fd41865553cadb06199bfdf706ba89fb.1357304090.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1357304090.git.afzal@ti.com>
In-Reply-To: <cover.1357304090.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sekhar Nori <nsekhar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

Move panel detection to a separate function, this helps in readability
as well as makes DT support cleaner.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c |   42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 32ce385..991d9e3 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1257,6 +1257,27 @@ static struct fb_ops da8xx_fb_ops = {
 	.fb_blank = cfb_blank,
 };
 
+static struct fb_videomode *da8xx_fb_get_videomode(struct platform_device *dev)
+{
+	struct da8xx_lcdc_platform_data *fb_pdata = dev->dev.platform_data;
+	struct fb_videomode *lcdc_info;
+	int i;
+
+	for (i = 0, lcdc_info = known_lcd_panels;
+		i < ARRAY_SIZE(known_lcd_panels); i++, lcdc_info++) {
+		if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
+			break;
+	}
+
+	if (i = ARRAY_SIZE(known_lcd_panels)) {
+		dev_err(&dev->dev, "no panel found\n");
+		return NULL;
+	}
+	dev_info(&dev->dev, "found %s panel\n", lcdc_info->name);
+
+	return lcdc_info;
+}
+
 static int __devinit fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata @@ -1266,7 +1287,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
-	int ret, i;
+	int ret;
 	unsigned long ulcm;
 
 	if (fb_pdata = NULL) {
@@ -1274,6 +1295,10 @@ static int __devinit fb_probe(struct platform_device *device)
 		return -ENOENT;
 	}
 
+	lcdc_info = da8xx_fb_get_videomode(device);
+	if (lcdc_info = NULL)
+		return -ENODEV;
+
 	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
 	da8xx_fb_reg_base = devm_request_and_ioremap(&device->dev, lcdc_regs);
 	if (!da8xx_fb_reg_base) {
@@ -1307,21 +1332,6 @@ static int __devinit fb_probe(struct platform_device *device)
 		break;
 	}
 
-	for (i = 0, lcdc_info = known_lcd_panels;
-		i < ARRAY_SIZE(known_lcd_panels);
-		i++, lcdc_info++) {
-		if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
-			break;
-	}
-
-	if (i = ARRAY_SIZE(known_lcd_panels)) {
-		dev_err(&device->dev, "GLCD: No valid panel found\n");
-		ret = -ENODEV;
-		goto err_pm_runtime_disable;
-	} else
-		dev_info(&device->dev, "GLCD: Found %s panel\n",
-					fb_pdata->type);
-
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
 	if (!lcd_cfg) {
-- 
1.7.9.5

