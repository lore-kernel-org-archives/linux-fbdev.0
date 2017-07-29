From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:17:46 +0000
Subject: [PATCH 2/6] drm/tinydrm: add helpers for ST7586 controllers
Message-Id: <1501355870-13960-3-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This adds helper functions and support for ST7586 controllers. These
controllers have an unusual memory layout where 3 pixels are packed into
1 byte.

+-------+-----------------+
| bit   | 7 6 5 4 3 2 1 0 |
+-------+-----------------+
| pixel | 0 0 0 1 1 1 2 2 |
+-------+-----------------+

So, there are a nuber of places in the tinydrm pipline where this format
needs to be taken into consideration.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c | 148 +++++++++++++++++++++++++
 drivers/gpu/drm/tinydrm/mipi-dbi.c             |  96 ++++++++++++----
 include/drm/tinydrm/tinydrm-helpers.h          |   6 +
 include/video/mipi_display.h                   |   2 +
 4 files changed, 232 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
index d4cda33..4a36441 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
@@ -181,6 +181,154 @@ void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
 
 /**
+ * tinydrm_rgb565_to_st7586 - Convert RGB565 to ST7586 clip buffer
+ * @dst: ST7586 destination buffer
+ * @vaddr: RGB565 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @swap: Swap bytes
+ *
+ * The ST7586 controller has a non-standard pixel layout. It is 2-bit grayscale
+ * (or 1-bit monochrome) packed into 3 pixels per byte.
+ *
+ * Note: the @clip x values are modified! They are aligned to the 3 pixel
+ * boundtry and divied by 3 to get the starting and ending byte (+ 1) in the
+ * @dst buffer.
+ */
+void tinydrm_rgb565_to_st7586(u8 *dst, void *vaddr,
+				struct drm_framebuffer *fb,
+				struct drm_clip_rect *clip)
+{
+	size_t len;
+	unsigned int x, y;
+	u16 *src, *buf;
+	u8 val;
+
+	/* 3 pixels per byte, so align to dst byte */
+	clip->x1 -= clip->x1 % 3;
+	clip->x2 = (clip->x2 + 2) / 3 * 3;
+	len = (clip->x2 - clip->x1) * sizeof(u16);
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		src = vaddr + (y * fb->pitches[0]);
+		src += clip->x1;
+		memcpy(buf, src, len);
+		src = buf;
+		for (x = clip->x1; x < clip->x2; x += 3) {
+			/*
+			 * TODO: There is probably a better algorithm to get
+			 * a better downsampling.
+			 * If red or green is > 50%, set the high bit, which is
+			 * bright gray. If blue is greater than 50%, set the
+			 * low bit, which is dark gray.
+			 */
+			val =   ((*src & 0x8000) >>  8) |
+				((*src & 0x0400) >>  3) |
+				((*src & 0x0010) <<  2);
+			if (val & 0xC0)
+				val |= 0x20;
+			src++;
+			val |=  ((*src & 0x8000) >> 11) |
+				((*src & 0x0400) >>  6) |
+				((*src & 0x0010) >>  1);
+			if (val & 0x18)
+				val |= 0x04;
+			src++;
+			val |=  ((*src & 0x8000) >> 14) |
+				((*src & 0x0400) >>  9) |
+				((*src & 0x0010) >>  4);
+			src++;
+			*dst++ = ~val;
+		}
+	}
+
+	/* now adjust the clip so it applies to dst */
+	clip->x1 /= 3;
+	clip->x2 /= 3;
+
+	kfree(buf);
+}
+EXPORT_SYMBOL(tinydrm_rgb565_to_st7586);
+
+/**
+ * tinydrm_xrgb8888_to_st7586 - Convert XRGB8888 to ST7586 clip buffer
+ * @dst: ST7586 destination buffer
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @swap: Swap bytes
+ *
+ * The ST7586 controller has a non-standard pixel layout. It is 2-bit grayscale
+ * (or 1-bit monochrome) packed into 3 pixels per byte.
+ *
+ * Note: the @clip x values are modified! They are aligned to the 3 pixel
+ * boundtry and divied by 3 to get the starting and ending byte (+ 1) in the
+ * @dst buffer.
+ */
+void tinydrm_xrgb8888_to_st7586(u8 *dst, void *vaddr,
+				struct drm_framebuffer *fb,
+				struct drm_clip_rect *clip)
+{
+	size_t len;
+	unsigned int x, y;
+	u32 *src, *buf;
+	u8 val;
+
+	/* 3 pixels per byte, so align to dst byte */
+	clip->x1 -= clip->x1 % 3;
+	clip->x2 = (clip->x2 + 2) / 3 * 3;
+	len = (clip->x2 - clip->x1) * sizeof(u32);
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		src = vaddr + (y * fb->pitches[0]);
+		src += clip->x1;
+		memcpy(buf, src, len);
+		src = buf;
+		for (x = clip->x1; x < clip->x2; x += 3) {
+			/*
+			 * TODO: There is probably a better algorithm to get
+			 * a better downsampling.
+			 * If red or green is > 50%, set the high bit, which is
+			 * bright gray. If blue is greater than 50%, set the
+			 * low bit, which is dark gray.
+			 */
+			val =   ((*src & 0x00800000) >> 16) |
+				((*src & 0x00008000) >>  8) |
+				((*src & 0x00000080) >>  1);
+			if (val & 0xC0)
+				val |= 0x20;
+			src++;
+			val |=  ((*src & 0x00800000) >> 19) |
+				((*src & 0x00008000) >> 11) |
+				((*src & 0x00000080) >>  4);
+			if (val & 0x18)
+				val |= 0x04;
+			src++;
+			val |=  ((*src & 0x00800000) >> 22) |
+				((*src & 0x00008000) >> 14) |
+				((*src & 0x00000080) >>  7);
+			src++;
+			*dst++ = ~val;
+		}
+	}
+
+	/* now adjust the clip so it applies to dst */
+	clip->x1 /= 3;
+	clip->x2 /= 3;
+
+	kfree(buf);
+}
+EXPORT_SYMBOL(tinydrm_xrgb8888_to_st7586);
+
+/**
  * tinydrm_of_find_backlight - Find backlight device in device-tree
  * @dev: Device
  *
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index 7d49366..c8fb622 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -154,7 +154,8 @@ int mipi_dbi_command_buf(struct mipi_dbi *mipi, u8 cmd, u8 *data, size_t len)
 EXPORT_SYMBOL(mipi_dbi_command_buf);
 
 static int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
-				struct drm_clip_rect *clip, bool swap)
+				struct drm_clip_rect *clip,
+				enum mipi_dcs_pixel_format pixel_fmt, bool swap)
 {
 	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
 	struct dma_buf_attachment *import_attach = cma_obj->base.import_attach;
@@ -169,21 +170,45 @@ static int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 			return ret;
 	}
 
-	switch (fb->format->format) {
-	case DRM_FORMAT_RGB565:
-		if (swap)
-			tinydrm_swab16(dst, src, fb, clip);
-		else
-			tinydrm_memcpy(dst, src, fb, clip);
+	switch (pixel_fmt) {
+	case MIPI_DCS_PIXEL_FMT_16BIT:
+		switch (fb->format->format) {
+		case DRM_FORMAT_RGB565:
+			if (swap)
+				tinydrm_swab16(dst, src, fb, clip);
+			else
+				tinydrm_memcpy(dst, src, fb, clip);
+			break;
+		case DRM_FORMAT_XRGB8888:
+			tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 		break;
-	case DRM_FORMAT_XRGB8888:
-		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
+	case MIPI_DCS_PIXEL_FMT_ST7586_332:
+		switch (fb->format->format) {
+		case DRM_FORMAT_RGB565:
+			tinydrm_rgb565_to_st7586(dst, src, fb, clip);
+			break;
+		case DRM_FORMAT_XRGB8888:
+			tinydrm_xrgb8888_to_st7586(dst, src, fb, clip);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
+		ret = -EINVAL;
+		break;
+	}
+	if (ret) {
 		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
-			     drm_get_format_name(fb->format->format,
-						 &format_name));
-		return -EINVAL;
+			drm_get_format_name(fb->format->format,
+						&format_name));
+		return ret;
 	}
 
 	if (import_attach)
@@ -204,8 +229,9 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
 	bool swap = mipi->swap_bytes;
 	struct drm_clip_rect clip;
 	int ret = 0;
-	bool full;
+	bool full, pixel_fmt_match;
 	void *tr;
+	size_t len;
 
 	mutex_lock(&tdev->dirty_lock);
 
@@ -218,20 +244,24 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
 
 	full = tinydrm_merge_clips(&clip, clips, num_clips, flags,
 				   fb->width, fb->height);
+	pixel_fmt_match = !swap && fb->format->format = DRM_FORMAT_RGB565 &&
+				mipi->pixel_fmt = MIPI_DCS_PIXEL_FMT_16BIT;
 
 	DRM_DEBUG("Flushing [FB:%d] x1=%u, x2=%u, y1=%u, y2=%u\n", fb->base.id,
 		  clip.x1, clip.x2, clip.y1, clip.y2);
 
-	if (!mipi->dc || !full || swap ||
-	    fb->format->format = DRM_FORMAT_XRGB8888) {
+	if (!mipi->dc || !full || !pixel_fmt_match) {
 		tr = mipi->tx_buf;
-		ret = mipi_dbi_buf_copy(mipi->tx_buf, fb, &clip, swap);
+		ret = mipi_dbi_buf_copy(mipi->tx_buf, fb, &clip,
+					mipi->pixel_fmt, swap);
 		if (ret)
 			goto out_unlock;
 	} else {
 		tr = cma_obj->vaddr;
 	}
 
+	/* NB: mipi_dbi_buf_copy() may modify clip! */
+
 	mipi_dbi_command(mipi, MIPI_DCS_SET_COLUMN_ADDRESS,
 			 (clip.x1 >> 8) & 0xFF, clip.x1 & 0xFF,
 			 (clip.x2 >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
@@ -239,8 +269,16 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
 			 (clip.y1 >> 8) & 0xFF, clip.y1 & 0xFF,
 			 (clip.y2 >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
 
-	ret = mipi_dbi_command_buf(mipi, MIPI_DCS_WRITE_MEMORY_START, tr,
-				(clip.x2 - clip.x1) * (clip.y2 - clip.y1) * 2);
+	len = (clip.x2 - clip.x1) * (clip.y2 - clip.y1);
+	switch (mipi->pixel_fmt) {
+	case MIPI_DCS_PIXEL_FMT_16BIT:
+		len *= sizeof(u16);
+		break;
+	default:
+		break;
+	}
+
+	ret = mipi_dbi_command_buf(mipi, MIPI_DCS_WRITE_MEMORY_START, tr, len);
 
 out_unlock:
 	mutex_unlock(&tdev->dirty_lock);
@@ -288,7 +326,20 @@ static void mipi_dbi_blank(struct mipi_dbi *mipi)
 	struct drm_device *drm = mipi->tinydrm.drm;
 	u16 height = drm->mode_config.min_height;
 	u16 width = drm->mode_config.min_width;
-	size_t len = width * height * 2;
+	size_t len;
+
+	switch (mipi->pixel_fmt) {
+	case MIPI_DCS_PIXEL_FMT_16BIT:
+		len = width * height * sizeof(u16);
+		break;
+	case MIPI_DCS_PIXEL_FMT_ST7586_332:
+		width = (width + 2) / 3;
+		len = width * height;
+		break;
+	default:
+		/* unsupported pixel format */
+		return;
+	}
 
 	memset(mipi->tx_buf, 0, len);
 
@@ -367,6 +418,10 @@ int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 	case MIPI_DCS_PIXEL_FMT_16BIT:
 		bufsize = mode->vdisplay * mode->hdisplay * sizeof(u16);
 		break;
+	case MIPI_DCS_PIXEL_FMT_ST7586_332:
+		/* 3 pixels per byte */
+		bufsize = (mode->vdisplay + 2) / 3 * mode->hdisplay;
+		break;
 	default:
 		DRM_ERROR("Pixel format is not supported\n");
 		return -EINVAL;
@@ -776,7 +831,8 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
 	if (ret || !num)
 		return ret;
 
-	if (cmd = MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes)
+	if (cmd = MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes &&
+	    mipi->pixel_fmt != MIPI_DCS_PIXEL_FMT_ST7586_332)
 		bpw = 16;
 
 	gpiod_set_value_cansleep(mipi->dc, 1);
diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
index 9b9b6cf..94792fb 100644
--- a/include/drm/tinydrm/tinydrm-helpers.h
+++ b/include/drm/tinydrm/tinydrm-helpers.h
@@ -43,6 +43,12 @@ void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 				struct drm_framebuffer *fb,
 				struct drm_clip_rect *clip, bool swap);
+void tinydrm_rgb565_to_st7586(u8 *dst, void *vaddr,
+				struct drm_framebuffer *fb,
+				struct drm_clip_rect *clip);
+void tinydrm_xrgb8888_to_st7586(u8 *dst, void *vaddr,
+				struct drm_framebuffer *fb,
+				struct drm_clip_rect *clip);
 
 struct backlight_device *tinydrm_of_find_backlight(struct device *dev);
 int tinydrm_enable_backlight(struct backlight_device *backlight);
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index 84b70cd..1c134c4 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -135,6 +135,8 @@ enum mipi_dcs_pixel_format {
 	MIPI_DCS_PIXEL_FMT_12BIT	= 3,
 	MIPI_DCS_PIXEL_FMT_8BIT		= 2,
 	MIPI_DCS_PIXEL_FMT_3BIT		= 1,
+	/* non-standard format packing 1 or 2bpp in 3:3:2 bits */
+	MIPI_DCS_PIXEL_FMT_ST7586_332	= -1,
 };
 
 #endif
-- 
2.7.4

