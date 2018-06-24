From: Daniel Mack <daniel@zonque.org>
Date: Sun, 24 Jun 2018 15:38:17 +0000
Subject: [PATCH 4/4] video: fbdev: pxafb: Add support for lcd-supply regulator
Message-Id: <20180624153817.24387-4-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Optionally obtain a lcd-supply regulator during probe and use it in
__pxafb_lcd_power() to switch the power supply of LCD panels.

This helps boards booted from DT to control such voltages without
callbacks.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/display/marvell,pxa2xx-lcdc.txt  |  3 +++
 drivers/video/fbdev/pxafb.c                   | 24 +++++++++++++++++++
 drivers/video/fbdev/pxafb.h                   |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
index f79641bd5f18..45ffd6c41748 100644
--- a/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
@@ -10,6 +10,9 @@ Required properties:
  - interrupts : framebuffer controller interrupt.
  - clocks: phandle to input clocks
 
+Optional properties:
+ - lcd-supply: A phandle to a power regulator that controls the LCD voltage.
+
 Required nodes:
  - port: connection to the LCD panel (see video-interfaces.txt)
 	 This node must have its properties bus-width and remote-endpoint set.
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 68459b07d442..bbed039617a4 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -56,6 +56,7 @@
 #include <linux/freezer.h>
 #include <linux/console.h>
 #include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
 
@@ -1423,6 +1424,21 @@ static inline void __pxafb_lcd_power(struct pxafb_info *fbi, int on)
 
 	if (fbi->lcd_power)
 		fbi->lcd_power(on, &fbi->fb.var);
+
+	if (fbi->lcd_supply && fbi->lcd_supply_enabled != on) {
+		int ret;
+
+		if (on)
+			ret = regulator_enable(fbi->lcd_supply);
+		else
+			ret = regulator_disable(fbi->lcd_supply);
+
+		if (ret < 0)
+			pr_warn("Unable to %s LCD supply regulator: %d\n",
+				on ? "enable" : "disable", ret);
+		else
+			fbi->lcd_supply_enabled = on;
+	}
 }
 
 static void pxafb_enable_controller(struct pxafb_info *fbi)
@@ -2299,6 +2315,14 @@ static int pxafb_probe(struct platform_device *dev)
 	fbi->backlight_power = inf->pxafb_backlight_power;
 	fbi->lcd_power = inf->pxafb_lcd_power;
 
+	fbi->lcd_supply = devm_regulator_get_optional(&dev->dev, "lcd");
+	if (IS_ERR(fbi->lcd_supply)) {
+		if (PTR_ERR(fbi->lcd_supply) = -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		fbi->lcd_supply = NULL;
+	}
+
 	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (r = NULL) {
 		dev_err(&dev->dev, "no I/O memory resource defined\n");
diff --git a/drivers/video/fbdev/pxafb.h b/drivers/video/fbdev/pxafb.h
index 5dc414e26fc8..b641289c8a99 100644
--- a/drivers/video/fbdev/pxafb.h
+++ b/drivers/video/fbdev/pxafb.h
@@ -165,6 +165,9 @@ struct pxafb_info {
 	struct notifier_block	freq_policy;
 #endif
 
+	struct regulator *lcd_supply;
+	bool lcd_supply_enabled;
+
 	void (*lcd_power)(int, struct fb_var_screeninfo *);
 	void (*backlight_power)(int);
 
-- 
2.17.1

