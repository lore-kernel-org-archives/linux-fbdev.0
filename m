From: Mans Rullgard <mans@mansr.com>
Date: Tue, 12 Jan 2016 10:22:21 +0000
Subject: [RESEND PATCH 2/2] video: mxsfb: manage LCD_RESET signal according to reset-active property
Message-Id: <1452594141-26073-2-git-send-email-mans@mansr.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1452594141-26073-1-git-send-email-mans@mansr.com>
In-Reply-To: <1452594141-26073-1-git-send-email-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Activate/deactivate the LCD_RESET signal as specified by the
reset-active DT property when the controller is disabled/enabled.
If the property is missing, leave the signal unchanged.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/video/fbdev/mxsfb.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 4e6608ceac09..0200a0f16675 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -99,6 +99,7 @@
 #define CTRL1_FIFO_CLEAR		(1 << 21)
 #define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
 #define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
+#define CTRL1_RESET			(1 << 0)
 
 #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
@@ -152,6 +153,9 @@
 #define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
 #define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negtive edge sampling */
 
+#define MXSFB_RESET_LOW			1
+#define MXSFB_RESET_HIGH		2
+
 enum mxsfb_devtype {
 	MXSFB_V3,
 	MXSFB_V4,
@@ -181,6 +185,7 @@ struct mxsfb_info {
 	unsigned dotclk_delay;
 	const struct mxsfb_devdata *devdata;
 	u32 sync;
+	u32 reset;
 	struct regulator *reg_lcd;
 };
 
@@ -362,6 +367,11 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
 
 	writel(CTRL_RUN, host->base + LCDC_CTRL + REG_SET);
 
+	if (host->reset = MXSFB_RESET_HIGH)
+		writel(CTRL1_RESET, host->base + LCDC_CTRL1 + REG_CLR);
+	else if (host->reset = MXSFB_RESET_LOW)
+		writel(CTRL1_RESET, host->base + LCDC_CTRL1 + REG_SET);
+
 	host->enabled = 1;
 }
 
@@ -388,6 +398,11 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 		loop--;
 	}
 
+	if (host->reset = MXSFB_RESET_HIGH)
+		writel(CTRL1_RESET, host->base + LCDC_CTRL1 + REG_SET);
+	else if (host->reset = MXSFB_RESET_LOW)
+		writel(CTRL1_RESET, host->base + LCDC_CTRL1 + REG_CLR);
+
 	reg = readl(host->base + LCDC_VDCTRL4);
 	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
 
@@ -410,7 +425,7 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 static int mxsfb_set_par(struct fb_info *fb_info)
 {
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
-	u32 ctrl, vdctrl0, vdctrl4;
+	u32 ctrl, ctrl1, vdctrl0, vdctrl4;
 	int line_size, fb_size;
 	int reenable = 0;
 
@@ -439,12 +454,13 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 
 	ctrl = CTRL_BYPASS_COUNT | CTRL_MASTER |
 		CTRL_SET_BUS_WIDTH(host->ld_intf_width);
+	ctrl1 = readl(host->base + LCDC_CTRL1) & CTRL1_RESET;
 
 	switch (fb_info->var.bits_per_pixel) {
 	case 16:
 		dev_dbg(&host->pdev->dev, "Setting up RGB565 mode\n");
 		ctrl |= CTRL_SET_WORD_LENGTH(0);
-		writel(CTRL1_SET_BYTE_PACKAGING(0xf), host->base + LCDC_CTRL1);
+		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0xf);
 		break;
 	case 32:
 		dev_dbg(&host->pdev->dev, "Setting up RGB888/666 mode\n");
@@ -462,7 +478,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 			break;
 		}
 		/* do not use packed pixels = one pixel per word instead */
-		writel(CTRL1_SET_BYTE_PACKAGING(0x7), host->base + LCDC_CTRL1);
+		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0x7);
 		break;
 	default:
 		mxsfb_disable_axi_clk(host);
@@ -472,6 +488,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 	}
 
 	writel(ctrl, host->base + LCDC_CTRL);
+	writel(ctrl1, host->base + LCDC_CTRL1);
 
 	writel(TRANSFER_COUNT_SET_VCOUNT(fb_info->var.yres) |
 			TRANSFER_COUNT_SET_HCOUNT(fb_info->var.xres),
@@ -736,6 +753,7 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
 	struct device_node *display_np;
 	struct videomode vm;
 	u32 width;
+	u32 reset;
 	int ret;
 
 	display_np = of_parse_phandle(np, "display", 0);
@@ -776,6 +794,10 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
 		goto put_display_node;
 	}
 
+	ret = of_property_read_u32(display_np, "reset-active", &reset);
+	if (!ret)
+		host->reset = reset ? MXSFB_RESET_HIGH : MXSFB_RESET_LOW;
+
 	ret = of_get_videomode(display_np, &vm, OF_USE_NATIVE_MODE);
 	if (ret) {
 		dev_err(dev, "failed to get videomode from DT\n");
-- 
2.7.0

