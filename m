From: Martin Kaiser <martin@kaiser.cx>
Date: Mon, 27 Feb 2017 10:56:41 +0000
Subject: [PATCH 1/2] video: fbdev: imxfb: support AUS mode
Message-Id: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>, Sascha Hauer <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

Some displays require setting AUS mode in the LDCD AUS Mode Control
Register to work with the imxfb driver. Like the value of the Panel
Configuration Register, the AUS Mode Control Register's value depends on
the display mode.

Allow setting this register from the device tree. Make the device tree
node optional to keep the DT ABI stable. This register is available only
on imx21 and compatible chipsets.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/video/fbdev/imxfb.c               | 19 +++++++++++++++++++
 include/linux/platform_data/video-imxfb.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 1b0faad..a05cad4 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -117,6 +117,8 @@
 
 #define IMXFB_LSCR1_DEFAULT 0x00120300
 
+#define LCDC_LAUSCR	0x80
+
 /* Used fb-mode. Can be set on kernel command line, therefore file-static. */
 static const char *fb_mode;
 
@@ -158,6 +160,7 @@ struct imxfb_info {
 	dma_addr_t		dbar2;
 
 	u_int			pcr;
+	u_int			lauscr;
 	u_int			pwmr;
 	u_int			lscr1;
 	u_int			dmacr;
@@ -422,6 +425,11 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	pcr |= imxfb_mode->pcr & ~(0x3f | (7 << 25));
 
 	fbi->pcr = pcr;
+	/*
+	 * The LCDC AUS Mode Control Register does not exist on imx1.
+	 */
+	if (!is_imx1_fb(fbi))
+		fbi->lauscr = imxfb_mode->lauscr;
 
 	/*
 	 * Copy the RGB parameters for this display
@@ -638,6 +646,9 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (fbi->dmacr)
 		writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
 
+	if (fbi->lauscr)
+		writel(fbi->lauscr, fbi->regs + LCDC_LAUSCR);
+
 	return 0;
 }
 
@@ -707,6 +718,7 @@ static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
 	struct fb_videomode *of_mode = &imxfb_mode->mode;
 	u32 bpp;
 	u32 pcr;
+	u32 lauscr;
 
 	ret = of_property_read_string(np, "model", &of_mode->name);
 	if (ret)
@@ -734,6 +746,13 @@ static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
 	imxfb_mode->bpp = bpp;
 	imxfb_mode->pcr = pcr;
 
+	/*
+	 * fsl,lauscr is optional
+	 */
+	ret = of_property_read_u32(np, "fsl,lauscr", &lauscr);
+	if (ret = 0)
+		imxfb_mode->lauscr = lauscr;
+
 	return 0;
 }
 
diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index a5c0a71..fdd2d4c 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -50,6 +50,7 @@
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
+	u32 lauscr;
 	unsigned char	bpp;
 };
 
-- 
2.1.4

