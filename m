From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:11 +0000
Subject: [PATCH 02/11] video: ARM CLCD: support DT signal inversion flags
Message-Id: <1454594660-7532-3-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The device tree bindings from display-timing.txt allows us to
specify if data enable, hsync, vsync or the pixed clock should be
inverted on the way to the display. The driver does not currently
handle this so add support for those flags as it is needed for
the Versatile Sanyo LCD display.

Note that the previous behaviour was to invert the pixel clock
for all displays, so unless the pixel clock polarity is
explicitly defined in the device tree (i.e. the timings node
has the "pixelclk-active" property) we fall back to inverting
the pixel clock. This needs some extra compatibility code.

Since the timing flags have to be set up inside the struct
clcd_panel, we need to refactor the code a bit to pass around
the panel rather than just the mode.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/amba-clcd.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index c5d1e9ca81ab..8903a42c4122 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -567,10 +567,11 @@ static int clcdfb_register(struct clcd_fb *fb)
 
 #ifdef CONFIG_OF
 static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
-		struct fb_videomode *mode)
+		struct clcd_panel *clcd_panel)
 {
 	int err;
 	struct display_timing timing;
+	struct device_node *timnp;
 	struct videomode video;
 
 	err = of_get_display_timing(node, "panel-timing", &timing);
@@ -579,10 +580,34 @@ static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
 
 	videomode_from_timing(&timing, &video);
 
-	err = fb_videomode_from_videomode(&video, mode);
+	err = fb_videomode_from_videomode(&video, &clcd_panel->mode);
 	if (err)
 		return err;
 
+	/* Set up some inversion flags */
+	timnp = of_get_child_by_name(node, "panel-timing");
+	if (timnp && of_property_read_bool(timnp, "pixelclk-active")) {
+		if (timing.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+			clcd_panel->tim2 |= TIM2_IPC;
+	} else {
+		/*
+		 * To preserve backwards compatibility, the IPC (inverted
+		 * pixel clock) flag needs to be set on any display that
+		 * doesn't explicitly specify that the pixel clock is
+		 * active on the negative edge.
+		 */
+		clcd_panel->tim2 |= TIM2_IPC;
+	}
+
+	if (timing.flags & DISPLAY_FLAGS_HSYNC_LOW)
+		clcd_panel->tim2 |= TIM2_IHS;
+
+	if (timing.flags & DISPLAY_FLAGS_VSYNC_LOW)
+		clcd_panel->tim2 |= TIM2_IVS;
+
+	if (timing.flags & DISPLAY_FLAGS_DE_LOW)
+		clcd_panel->tim2 |= TIM2_IOE;
+
 	return 0;
 }
 
@@ -615,10 +640,11 @@ static int clcdfb_of_get_backlight(struct device_node *endpoint,
 }
 
 static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
-		struct fb_videomode *mode)
+		struct clcd_panel *clcd_panel)
 {
 	int err;
 	struct device_node *panel;
+	struct fb_videomode *mode;
 	char *name;
 	int len;
 
@@ -628,11 +654,12 @@ static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
 
 	/* Only directly connected DPI panels supported for now */
 	if (of_device_is_compatible(panel, "panel-dpi"))
-		err = clcdfb_of_get_dpi_panel_mode(panel, mode);
+		err = clcdfb_of_get_dpi_panel_mode(panel, clcd_panel);
 	else
 		err = -ENOENT;
 	if (err)
 		return err;
+	mode = &clcd_panel->mode;
 
 	len = clcdfb_snprintf_mode(NULL, 0, mode);
 	name = devm_kzalloc(dev, len + 1, GFP_KERNEL);
@@ -663,8 +690,8 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 	};
 	int i;
 
-	/* Bypass pixel clock divider, data output on the falling edge */
-	fb->panel->tim2 = TIM2_BCD | TIM2_IPC;
+	/* Bypass pixel clock divider */
+	fb->panel->tim2 |= TIM2_BCD;
 
 	/* TFT display, vert. comp. interrupt at the start of the back porch */
 	fb->panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
@@ -704,7 +731,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (err)
 		return err;
 
-	err = clcdfb_of_get_mode(&fb->dev->dev, endpoint, &fb->panel->mode);
+	err = clcdfb_of_get_mode(&fb->dev->dev, endpoint, fb->panel);
 	if (err)
 		return err;
 
-- 
2.4.3

