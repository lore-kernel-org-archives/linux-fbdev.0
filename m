From: Vladimir Zapolskiy <vz@mleia.com>
Date: Wed, 21 Dec 2016 03:27:17 +0000
Subject: [PATCH 4/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <20161221032717.13154-5-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
In-Reply-To: <20161221032717.13154-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The change adds handling of "enable-gpios" property of panel-dpi device
node used with an ARM CLCD controller, note that the property already has
a description in display/panel/panel-dpi.txt documentation and it founds
practical usage while describing some panel devices connected to other
types of display controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/video/fbdev/amba-clcd.c | 29 +++++++++++++++++++++++++++++
 include/linux/amba/clcd.h       |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 0fab92c..0bb8646 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/fb.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -87,6 +88,9 @@ static void clcdfb_disable(struct clcd_fb *fb)
 		writel(val, fb->regs + fb->off_cntl);
 	}
 
+	if (fb->panel->enable_gpio)
+		gpiod_set_value_cansleep(fb->panel->enable_gpio, 0);
+
 	/*
 	 * Disable CLCD clock source.
 	 */
@@ -106,6 +110,9 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 		clk_enable(fb->clk);
 	}
 
+	if (fb->panel->enable_gpio)
+		gpiod_set_value_cansleep(fb->panel->enable_gpio, 1);
+
 	/*
 	 * Bring up by first enabling..
 	 */
@@ -624,6 +631,24 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
 			mode->refresh);
 }
 
+static int clcdfb_of_get_enable_gpio(struct device *dev,
+				     struct device_node *panel,
+				     struct clcd_panel *clcd_panel)
+{
+	int err;
+
+	clcd_panel->enable_gpio = devm_get_gpiod_from_child(dev, "enable",
+							    &panel->fwnode);
+	if (IS_ERR(clcd_panel->enable_gpio)) {
+		err = PTR_ERR(clcd_panel->enable_gpio);
+		clcd_panel->enable_gpio = NULL;
+		if (err != -ENOENT)
+			return err;
+	}
+
+	return 0;
+}
+
 static int clcdfb_of_get_backlight(struct device_node *panel,
 				   struct clcd_panel *clcd_panel)
 {
@@ -781,6 +806,10 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 			return err;
 	}
 
+	err = clcdfb_of_get_enable_gpio(&fb->dev->dev, panel, fb->panel);
+	if (err)
+		return err;
+
 	err = clcdfb_of_get_backlight(panel, fb->panel);
 	if (err)
 		return err;
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 1035879..a9c6007 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -105,6 +105,7 @@ enum {
 };
 
 struct backlight_device;
+struct gpio_desc;
 
 struct clcd_panel {
 	struct fb_videomode	mode;
@@ -119,6 +120,7 @@ struct clcd_panel {
 				grayscale:1;
 	unsigned int		connector;
 	struct backlight_device	*backlight;
+	struct gpio_desc	*enable_gpio;
 	/*
 	 * If the B/R lines are switched between the CLCD
 	 * and the panel we need to know this and not try to
-- 
2.10.2

