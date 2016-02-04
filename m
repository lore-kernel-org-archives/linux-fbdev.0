From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:10 +0000
Subject: [PATCH 01/11] video: ARM CLCD: backlight support for OF
Message-Id: <1454594660-7532-2-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

If the device is probed from device tree, we can support
backlight. This is used with some systems such as the
ST Microelectronics Nomadik.

We have to add HAS_IOMEM to the dependencies of CLCD since
the backlight class device will now be selected, and if it
gets selected on an arch that does not have IOMEM,
compilation will fail.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/Kconfig     |  4 +++-
 drivers/video/fbdev/amba-clcd.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/clcd.h       |  3 +++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8ea45a5cd806..6dcd91237551 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -284,12 +284,14 @@ config FB_PM2_FIFO_DISCONNECT
 config FB_ARMCLCD
 	tristate "ARM PrimeCell PL110 support"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on FB && ARM_AMBA
+	depends on FB && ARM_AMBA && HAS_IOMEM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_MODE_HELPERS if OF
 	select VIDEOMODE_HELPERS if OF
+	select BACKLIGHT_LCD_SUPPORT if OF
+	select BACKLIGHT_CLASS_DEVICE if OF
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index f9ef06d0cd48..c5d1e9ca81ab 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/backlight.h>
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
@@ -73,6 +74,11 @@ static void clcdfb_disable(struct clcd_fb *fb)
 	if (fb->board->disable)
 		fb->board->disable(fb);
 
+	if (fb->panel->backlight) {
+		fb->panel->backlight->props.power = FB_BLANK_POWERDOWN;
+		backlight_update_status(fb->panel->backlight);
+	}
+
 	val = readl(fb->regs + fb->off_cntl);
 	if (val & CNTL_LCDPWR) {
 		val &= ~CNTL_LCDPWR;
@@ -119,6 +125,14 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	writel(cntl, fb->regs + fb->off_cntl);
 
 	/*
+	 * Turn on backlight
+	 */
+	if (fb->panel->backlight) {
+		fb->panel->backlight->props.power = FB_BLANK_UNBLANK;
+		backlight_update_status(fb->panel->backlight);
+	}
+
+	/*
 	 * finally, enable the interface.
 	 */
 	if (fb->board->enable)
@@ -578,6 +592,28 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
 			mode->refresh);
 }
 
+static int clcdfb_of_get_backlight(struct device_node *endpoint,
+				   struct clcd_panel *clcd_panel)
+{
+	struct device_node *panel;
+	struct device_node *backlight;
+
+	panel = of_graph_get_remote_port_parent(endpoint);
+	if (!panel)
+		return -ENODEV;
+
+	/* Look up the optional backlight phandle */
+	backlight = of_parse_phandle(panel, "backlight", 0);
+	if (backlight) {
+		clcd_panel->backlight = of_find_backlight_by_node(backlight);
+		of_node_put(backlight);
+
+		if (!clcd_panel->backlight)
+			return -EPROBE_DEFER;
+	}
+	return 0;
+}
+
 static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
 		struct fb_videomode *mode)
 {
@@ -664,6 +700,10 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!endpoint)
 		return -ENODEV;
 
+	err = clcdfb_of_get_backlight(endpoint, fb->panel);
+	if (err)
+		return err;
+
 	err = clcdfb_of_get_mode(&fb->dev->dev, endpoint, &fb->panel->mode);
 	if (err)
 		return err;
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index e82e3ee2c54a..e64c1ccebb76 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -93,6 +93,8 @@ enum {
 	CLCD_CAP_ALL		= CLCD_CAP_BGR | CLCD_CAP_RGB,
 };
 
+struct backlight_device;
+
 struct clcd_panel {
 	struct fb_videomode	mode;
 	signed short		width;	/* width in mm */
@@ -105,6 +107,7 @@ struct clcd_panel {
 				fixedtimings:1,
 				grayscale:1;
 	unsigned int		connector;
+	struct backlight_device	*backlight;
 };
 
 struct clcd_regs {
-- 
2.4.3

