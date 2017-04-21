From: Martin Kaiser <martin@kaiser.cx>
Date: Fri, 21 Apr 2017 07:45:52 +0000
Subject: [PATCH 1/2 v3 resend] video: fbdev: imxfb: support AUS mode
Message-Id: <1492760753-8374-1-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1488193030-13064-1-git-send-email-martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>

Some displays require setting AUS mode in the LDCD AUS Mode Control
Register to work with the imxfb driver. Like the value of the Panel
Configuration Register, the AUS mode setting depends on the display
mode.

Allow setting AUS mode from the device tree by adding a boolean
property. Make this property optional to keep the DT ABI stable.
AUS mode can be set only on imx21 and compatible chipsets.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
re-sending v3, rebased against current linux-next
it seems this got lost along the way, there was a bit of confusion
whether to split this in two patches or not

v3:
   use a boolean DT property instead of the register value
   separate patches for DT binding and code changes

v2:
   re-sending DT bindings and code changes as one patch

 drivers/video/fbdev/imxfb.c               | 17 +++++++++++++++++
 include/linux/platform_data/video-imxfb.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 1b0faad..463fbf2 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -117,6 +117,9 @@
 
 #define IMXFB_LSCR1_DEFAULT 0x00120300
 
+#define LCDC_LAUSCR	0x80
+#define LAUSCR_AUS_MODE	(1<<31)
+
 /* Used fb-mode. Can be set on kernel command line, therefore file-static. */
 static const char *fb_mode;
 
@@ -158,6 +161,7 @@ struct imxfb_info {
 	dma_addr_t		dbar2;
 
 	u_int			pcr;
+	u_int			lauscr;
 	u_int			pwmr;
 	u_int			lscr1;
 	u_int			dmacr;
@@ -422,6 +426,11 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	pcr |= imxfb_mode->pcr & ~(0x3f | (7 << 25));
 
 	fbi->pcr = pcr;
+	/*
+	 * The LCDC AUS Mode Control Register does not exist on imx1.
+	 */
+	if (!is_imx1_fb(fbi) && imxfb_mode->aus_mode)
+		fbi->lauscr = LAUSCR_AUS_MODE;
 
 	/*
 	 * Copy the RGB parameters for this display
@@ -638,6 +647,9 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (fbi->dmacr)
 		writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
 
+	if (fbi->lauscr)
+		writel(fbi->lauscr, fbi->regs + LCDC_LAUSCR);
+
 	return 0;
 }
 
@@ -734,6 +746,11 @@ static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
 	imxfb_mode->bpp = bpp;
 	imxfb_mode->pcr = pcr;
 
+	/*
+	 * fsl,aus_mode is optional
+	 */
+	imxfb_mode->aus_mode = of_property_read_bool(np, "fsl,aus_mode");
+
 	return 0;
 }
 
diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index a5c0a71..cf9348b 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -50,6 +50,7 @@
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
+	bool aus_mode;
 	unsigned char	bpp;
 };
 
-- 
2.1.4

