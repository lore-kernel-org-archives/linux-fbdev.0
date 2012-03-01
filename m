From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:07:47 +0000
Subject: [PATCH v2 34/57] fbdev: sh_mobile_lcdc: Store the format in struct sh_mobile_lcdc_chan
Message-Id: <1330614490-14149-35-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Store the active format in the channel structure, and use it instead of
parsing info->var all over the place when the format is needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   21 ++++++++++-----------
 drivers/video/sh_mobile_lcdcfb.h |    4 +++-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c66f0f4..6d8c30b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -728,20 +728,15 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	/* Setup geometry, format, frame buffer memory and operation mode. */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		const struct sh_mobile_lcdc_format_info *format;
-		u32 fourcc;
-
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
 
 		sh_mobile_lcdc_geometry(ch);
 
-		fourcc = sh_mobile_format_fourcc(&ch->info->var);
-		format = sh_mobile_format_info(fourcc);
-		tmp = format->lddfr;
+		tmp = ch->format->lddfr;
 
-		if (format->yuv) {
+		if (ch->format->yuv) {
 			switch (ch->info->var.colorspace) {
 			case V4L2_COLORSPACE_REC709:
 				tmp |= LDDFR_CF1;
@@ -755,7 +750,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		lcdc_write_chan(ch, LDDFR, tmp);
 		lcdc_write_chan(ch, LDMLSR, ch->pitch);
 		lcdc_write_chan(ch, LDSA1R, ch->base_addr_y);
-		if (format->yuv)
+		if (ch->format->yuv)
 			lcdc_write_chan(ch, LDSA2R, ch->base_addr_c);
 
 		/* When using deferred I/O mode, configure the LCDC for one-shot
@@ -772,7 +767,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	}
 
 	/* Word and long word swap. */
-	switch (sh_mobile_format_fourcc(&priv->ch[0].info->var)) {
+	switch (priv->ch[0].format->fourcc) {
 	case V4L2_PIX_FMT_RGB565:
 	case V4L2_PIX_FMT_NV21:
 	case V4L2_PIX_FMT_NV61:
@@ -859,7 +854,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			ch->meram_enabled = 0;
 		}
 
-		switch (sh_mobile_format_fourcc(&ch->info->var)) {
+		switch (ch->format->fourcc) {
 		case V4L2_PIX_FMT_NV12:
 		case V4L2_PIX_FMT_NV21:
 		case V4L2_PIX_FMT_NV16:
@@ -1065,7 +1060,7 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 			    + info->var.xres * info->var.yres_virtual
 			    + c_offset;
 		/* Set x offset */
-		if (sh_mobile_format_fourcc(&info->var) = V4L2_PIX_FMT_NV24)
+		if (ch->format->fourcc = V4L2_PIX_FMT_NV24)
 			base_addr_c += 2 * var->xoffset;
 		else
 			base_addr_c += var->xoffset;
@@ -1353,6 +1348,8 @@ static int sh_mobile_set_par(struct fb_info *info)
 		info->fix.line_length = info->var.xres
 				      * info->var.bits_per_pixel / 8;
 
+	ch->format = sh_mobile_format_info(sh_mobile_format_fourcc(&info->var));
+
 	ret = sh_mobile_lcdc_start(ch->lcdc);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
@@ -1716,6 +1713,8 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 		return -EINVAL;
 	}
 
+	ch->format = format;
+
 	/* Allocate the frame buffer device. */
 	ch->info = framebuffer_alloc(0, priv->dev);
 	if (!ch->info) {
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 8e0d009..5ef7559 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -17,9 +17,10 @@ enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
 struct backlight_device;
 struct fb_info;
 struct module;
+struct sh_mobile_lcdc_chan;
 struct sh_mobile_lcdc_entity;
+struct sh_mobile_lcdc_format_info;
 struct sh_mobile_lcdc_priv;
-struct sh_mobile_lcdc_chan;
 
 #define SH_MOBILE_LCDC_DISPLAY_DISCONNECTED	0
 #define SH_MOBILE_LCDC_DISPLAY_CONNECTED	1
@@ -70,6 +71,7 @@ struct sh_mobile_lcdc_chan {
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
 
+	const struct sh_mobile_lcdc_format_info *format;
 	unsigned long base_addr_y;
 	unsigned long base_addr_c;
 	unsigned int pitch;
-- 
1.7.3.4

