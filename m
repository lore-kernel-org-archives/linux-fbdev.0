From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 10:01:42 +0000
Subject: [PATCH 5/7 v2] video: ARM CLCD: support Nomadik variant
Message-Id: <1456221704-5792-6-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Nomadik variant has a few special quirks that need to be respected
to make the driver work:

- The block need to be clocked during writing of the TIMn registers
  or the bus will stall.
- Special bits in the control register select how many of the output
  display lines get activated.
- Special bits in the control register select how to manage the
  different 565 and 5551 modes.
- There is a packed 24bit graphics mode, i.e 888 pixels can be stored
  in memory is three consecutive bytes, not evenly aligned to a 32bit
  word.

This patch uses the vendor data pointer from the AMBA matching mechanism
to track the quirks for this variant, and adds two hooks that variants
can use to initialize boards and panels during start-up. These will
later be used to adopt a Nomadik board profile.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes. Just reposting.
---
 drivers/video/fbdev/amba-clcd.c | 106 ++++++++++++++++++++++++++++++++++++----
 include/linux/amba/clcd.h       |  42 ++++++++++++++++
 2 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9a631a8e2c04..24f4b596d502 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -227,6 +227,15 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 			var->blue.length = 4;
 		}
 		break;
+	case 24:
+		if (fb->vendor->packed_24_bit_pixels) {
+			var->red.length = 8;
+			var->green.length = 8;
+			var->blue.length = 8;
+		} else {
+			ret = -EINVAL;
+		}
+		break;
 	case 32:
 		/* If we can't do 888, reject */
 		caps &= CLCD_CAP_888;
@@ -313,6 +322,12 @@ static int clcdfb_set_par(struct fb_info *info)
 
 	clcdfb_disable(fb);
 
+	/* Some variants must be clocked here */
+	if (fb->vendor->clock_timregs && !fb->clk_enabled) {
+		fb->clk_enabled = true;
+		clk_enable(fb->clk);
+	}
+
 	writel(regs.tim0, fb->regs + CLCD_TIM0);
 	writel(regs.tim1, fb->regs + CLCD_TIM1);
 	writel(regs.tim2, fb->regs + CLCD_TIM2);
@@ -716,6 +731,42 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 	if (r0 != 0 && b0 = 0)
 		fb->panel->bgr_connection = true;
 
+	if (fb->panel->caps && fb->vendor->st_bitmux_control) {
+		/*
+		 * Set up the special bits for the Nomadik control register
+		 * (other platforms tend to do this through an external
+		 * register).
+		 */
+
+		/* Offset of the highest used color */
+		int maxoff = max3(r0, g0, b0);
+		/* Most significant bit out, highest used bit */
+		int msb = 0;
+
+		if (fb->panel->caps & CLCD_CAP_888) {
+			msb = maxoff + 8 - 1;
+		} else if (fb->panel->caps & CLCD_CAP_565) {
+			msb = maxoff + 5 - 1;
+			fb->panel->cntl |= CNTL_ST_1XBPP_565;
+		} else if (fb->panel->caps & CLCD_CAP_5551) {
+			msb = maxoff + 5 - 1;
+			fb->panel->cntl |= CNTL_ST_1XBPP_5551;
+		} else if (fb->panel->caps & CLCD_CAP_444) {
+			msb = maxoff + 4 - 1;
+			fb->panel->cntl |= CNTL_ST_1XBPP_444;
+		}
+
+		/* Send out as many bits as we need */
+		if (msb > 17)
+			fb->panel->cntl |= CNTL_ST_CDWID_24;
+		else if (msb > 15)
+			fb->panel->cntl |= CNTL_ST_CDWID_18;
+		else if (msb > 11)
+			fb->panel->cntl |= CNTL_ST_CDWID_16;
+		else
+			fb->panel->cntl |= CNTL_ST_CDWID_12;
+	}
+
 	return fb->panel->caps ? 0 : -EINVAL;
 }
 
@@ -731,9 +782,21 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!fb->panel)
 		return -ENOMEM;
 
-	endpoint = of_graph_get_next_endpoint(fb->dev->dev.of_node, NULL);
-	if (!endpoint)
-		return -ENODEV;
+	/*
+	 * Fetch the panel endpoint.
+	 */
+	if (!endpoint) {
+		endpoint = of_graph_get_next_endpoint(fb->dev->dev.of_node,
+						      NULL);
+		if (!endpoint)
+			return -ENODEV;
+	}
+
+	if (fb->vendor->init_panel) {
+		err = fb->vendor->init_panel(fb, endpoint);
+		if (err)
+			return err;
+	}
 
 	err = clcdfb_of_get_backlight(endpoint, fb->panel);
 	if (err)
@@ -770,11 +833,11 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 
 	if (of_property_read_u32_array(endpoint,
 			"arm,pl11x,tft-r0g0b0-pads",
-			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) = 0)
-		return clcdfb_of_init_tft_panel(fb, tft_r0b0g0[0],
-				 tft_r0b0g0[1],  tft_r0b0g0[2]);
+			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) != 0)
+		return -ENOENT;
 
-	return -ENOENT;
+	return clcdfb_of_init_tft_panel(fb, tft_r0b0g0[0],
+					tft_r0b0g0[1],  tft_r0b0g0[2]);
 }
 
 static int clcdfb_of_vram_setup(struct clcd_fb *fb)
@@ -895,6 +958,7 @@ static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
 static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct clcd_board *board = dev_get_platdata(&dev->dev);
+	struct clcd_vendor_data *vendor = id->data;
 	struct clcd_fb *fb;
 	int ret;
 
@@ -904,6 +968,12 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!board)
 		return -EINVAL;
 
+	if (vendor->init_board) {
+		ret = vendor->init_board(dev, board);
+		if (ret)
+			return ret;
+	}
+
 	ret = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		goto out;
@@ -922,10 +992,11 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	fb->dev = dev;
+	fb->vendor = vendor;
 	fb->board = board;
 
-	dev_info(&fb->dev->dev, "PL%03x rev%u at 0x%08llx\n",
-		amba_part(dev), amba_rev(dev),
+	dev_info(&fb->dev->dev, "PL%03x designer %02x rev%u at 0x%08llx\n",
+		amba_part(dev), amba_manf(dev), amba_rev(dev),
 		(unsigned long long)dev->res.start);
 
 	ret = fb->board->setup(fb);
@@ -968,10 +1039,27 @@ static int clcdfb_remove(struct amba_device *dev)
 	return 0;
 }
 
+static struct clcd_vendor_data vendor_arm = {
+	/* No special business */
+};
+
+static struct clcd_vendor_data vendor_nomadik = {
+	.clock_timregs = true,
+	.packed_24_bit_pixels = true,
+	.st_bitmux_control = true,
+};
+
 static struct amba_id clcdfb_id_table[] = {
 	{
 		.id	= 0x00041110,
 		.mask	= 0x000ffffe,
+		.data	= &vendor_arm,
+	},
+	/* ST Electronics Nomadik variant */
+	{
+		.id	= 0x00180110,
+		.mask	= 0x00fffffe,
+		.data	= &vendor_nomadik,
 	},
 	{ 0, 0 },
 };
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index c60f32e23a83..7d95633250a4 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -67,6 +67,17 @@
 #define CNTL_LDMAFIFOTIME	(1 << 15)
 #define CNTL_WATERMARK		(1 << 16)
 
+/* ST Microelectronics variant bits */
+#define CNTL_ST_1XBPP_444	0x0
+#define CNTL_ST_1XBPP_5551	(1 << 17)
+#define CNTL_ST_1XBPP_565	(1 << 18)
+#define CNTL_ST_CDWID_12	0x0
+#define CNTL_ST_CDWID_16	(1 << 19)
+#define CNTL_ST_CDWID_18	(1 << 20)
+#define CNTL_ST_CDWID_24	((1 << 19)|(1 << 20))
+#define CNTL_ST_CEAEN		(1 << 21)
+#define CNTL_ST_LCDBPP24_PACKED	(6 << 1)
+
 enum {
 	/* individual formats */
 	CLCD_CAP_RGB444		= (1 << 0),
@@ -179,11 +190,38 @@ struct clcd_board {
 struct amba_device;
 struct clk;
 
+/**
+ * struct clcd_vendor_data - holds hardware (IP-block) vendor-specific
+ * variant information
+ *
+ * @clock_timregs: the CLCD needs to be clocked when accessing the
+ * timer registers, or the hardware will hang.
+ * @packed_24_bit_pixels: this variant supports 24bit packed pixel data,
+ * so that RGB accesses 3 bytes at a time, not just on even 32bit
+ * boundaries, packing the pixel data in memory. ST Microelectronics
+ * have this.
+ * @st_bitmux_control: ST Microelectronics have implemented output
+ * bit line multiplexing into the CLCD control register. This indicates
+ * that we need to use this.
+ * @init_board: custom board init function for this variant
+ * @init_panel: custom panel init function for this variant
+ */
+struct clcd_vendor_data {
+	bool	clock_timregs;
+	bool	packed_24_bit_pixels;
+	bool	st_bitmux_control;
+	int	(*init_board)(struct amba_device *adev,
+			      struct clcd_board *board);
+	int	(*init_panel)(struct clcd_fb *fb,
+			      struct device_node *panel);
+};
+
 /* this data structure describes each frame buffer device we find */
 struct clcd_fb {
 	struct fb_info		fb;
 	struct amba_device	*dev;
 	struct clk		*clk;
+	struct clcd_vendor_data	*vendor;
 	struct clcd_panel	*panel;
 	struct clcd_board	*board;
 	void			*board_data;
@@ -290,6 +328,10 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 		else
 			val |= CNTL_LCDBPP16_444;
 		break;
+	case 24:
+		/* Modified variant supporting 24 bit packed pixels */
+		val |= CNTL_ST_LCDBPP24_PACKED;
+		break;
 	case 32:
 		val |= CNTL_LCDBPP24;
 		break;
-- 
2.4.3

