From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:40 +0000
Subject: [PATCH 07/11] drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
Message-Id: <20190326091744.11542-8-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/Makefile          |   1 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c | 441 +++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h |  26 ++
 3 files changed, 468 insertions(+)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index b8fab9d52faa..aef60d0f4888 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -2,6 +2,7 @@ ccflags-y = -Iinclude/drm
 fbdevdrm-y := fbdevdrm_bo.o \
 	      fbdevdrm_device.o \
 	      fbdevdrm_drv.o \
+	      fbdevdrm_format.o \
 	      fbdevdrm_modeset.o \
 	      fbdevdrm_ttm.o
 
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
new file mode 100644
index 000000000000..208f7c60e525
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
@@ -0,0 +1,441 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#include "fbdevdrm_format.h"
+#include <asm/byteorder.h>
+#include <linux/fb.h>
+
+#if defined __BIG_ENDIAN
+#define HOST_FUNC(_func) \
+	_func ## _be
+#elif defined __LITTLE_ENDIAN
+#define HOST_FUNC(_func) \
+	_func ## _le
+#else
+#error "Unsupported endianess"
+#endif
+
+static bool is_c8(const struct fb_info* fb_info)
+{
+	return fb_info->var.bits_per_pixel = 8;
+}
+
+static bool is_rgb565_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 16) &&
+	       (fb_info->var.red.offset = 0) &&
+	       (fb_info->var.red.length = 5) &&
+	       (fb_info->var.green.offset = 5) &&
+	       (fb_info->var.green.length = 6) &&
+	       (fb_info->var.blue.offset = 11) &&
+	       (fb_info->var.blue.length = 5);
+}
+
+static bool is_bgr565_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 16) &&
+	       (fb_info->var.red.offset = 11) &&
+	       (fb_info->var.red.length = 5) &&
+	       (fb_info->var.green.offset = 5) &&
+	       (fb_info->var.green.length = 6) &&
+	       (fb_info->var.blue.offset = 0) &&
+	       (fb_info->var.blue.length = 5);
+}
+
+static bool is_rgb888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 24) &&
+	       (fb_info->var.red.offset = 0) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 16) &&
+	       (fb_info->var.blue.length = 8);
+}
+
+static bool is_bgr888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 24) &&
+	       (fb_info->var.red.offset = 16) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 0) &&
+	       (fb_info->var.blue.length = 8);
+}
+
+static bool is_xrgb8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 8) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 16) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 24) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.length = 0);
+}
+
+static bool is_xbgr8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 24) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 16) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 8) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.length = 0);
+}
+
+static bool is_rgbx8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 0) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 16) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.length = 0);
+}
+
+static bool is_bgrx8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 16) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 0) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.length = 0);
+}
+
+static bool is_argb8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 8) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 16) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 24) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.offset = 0) &&
+	       (fb_info->var.transp.length = 8);
+}
+
+static bool is_abgr8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 24) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 16) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 8) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.offset = 0) &&
+	       (fb_info->var.transp.length = 8);
+}
+
+static bool is_rgba8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 0) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 16) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.offset = 24) &&
+	       (fb_info->var.transp.length = 8);
+}
+
+static bool is_bgra8888_be(const struct fb_info* fb_info)
+{
+	return (fb_info->var.bits_per_pixel = 32) &&
+	       (fb_info->var.red.offset = 16) &&
+	       (fb_info->var.red.length = 8) &&
+	       (fb_info->var.green.offset = 8) &&
+	       (fb_info->var.green.length = 8) &&
+	       (fb_info->var.blue.offset = 0) &&
+	       (fb_info->var.blue.length = 8) &&
+	       (fb_info->var.transp.offset = 24) &&
+	       (fb_info->var.transp.length = 8);
+}
+
+#define is_rgb565_le is_bgr565_be
+#define is_bgr565_le is_rgb565_be
+#define is_rgb888_le is_bgr888_be
+#define is_bgr888_le is_rgb888_be
+#define is_xrgb8888_le is_bgrx8888_be
+#define is_xbgr8888_le is_rgbx8888_be
+#define is_rgbx8888_le is_xbgr8888_be
+#define is_bgrx8888_le is_xrgb8888_be
+#define is_argb8888_le is_bgra8888_be
+#define is_abgr8888_le is_rgba8888_be
+#define is_rgba8888_le is_abgr8888_be
+#define is_bgra8888_le is_argb8888_be
+
+struct format_map {
+	bool (*is_format)(const struct fb_info*);
+	uint32_t format;
+};
+
+uint32_t fbdevdrm_format_of_fb_info(const struct fb_info *fb_info)
+{
+	static const struct format_map map[] = {
+		{ is_c8,                  DRM_FORMAT_C8 },      /* 256-color palette */
+		{ HOST_FUNC(is_rgb565),   DRM_FORMAT_RGB565 },
+		{ HOST_FUNC(is_bgr565),   DRM_FORMAT_BGR565 },
+		{ HOST_FUNC(is_rgb888),   DRM_FORMAT_RGB888 },
+		{ HOST_FUNC(is_bgr888),   DRM_FORMAT_BGR888 },
+		{ HOST_FUNC(is_xrgb8888), DRM_FORMAT_XRGB8888 },
+		{ HOST_FUNC(is_xbgr8888), DRM_FORMAT_XBGR8888 },
+		{ HOST_FUNC(is_rgbx8888), DRM_FORMAT_RGBX8888 },
+		{ HOST_FUNC(is_bgrx8888), DRM_FORMAT_BGRX8888 },
+		{ HOST_FUNC(is_argb8888), DRM_FORMAT_ARGB8888 },
+		{ HOST_FUNC(is_abgr8888), DRM_FORMAT_ABGR8888 },
+		{ HOST_FUNC(is_rgba8888), DRM_FORMAT_RGBA8888 },
+		{ HOST_FUNC(is_bgra8888), DRM_FORMAT_BGRA8888 }
+	};
+
+	size_t i;
+
+	if (fb_info->fix.type != FB_TYPE_PACKED_PIXELS)
+		goto err; /* multi-plane formats are not supported */
+	if (fb_info->var.bits_per_pixel < 8)
+		goto err; /* at least 8-bit color required */
+	if (fb_info->var.grayscale = 1)
+		goto err; /* grayscale output is not supported */
+
+	for (i = 0; i < ARRAY_SIZE(map); ++i) {
+		if (map[i].is_format(fb_info))
+			return map[i].format;
+	}
+
+err:
+	return DRM_FORMAT_INVALID;
+}
+
+static void set_fb_bitfield(struct fb_bitfield *bits, __u32 offset,
+			    __u32 length)
+{
+	bits->offset = offset;
+	bits->length = length;
+	bits->msb_right = 0;
+}
+
+static void set_c8(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 8;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    0, 8);
+	set_fb_bitfield(&fb_var->green,  0, 8);
+	set_fb_bitfield(&fb_var->blue,   0, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_rgb565_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 16;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    0, 5);
+	set_fb_bitfield(&fb_var->green,  5, 6);
+	set_fb_bitfield(&fb_var->blue,  11, 5);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_bgr565_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 16;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,   11, 5);
+	set_fb_bitfield(&fb_var->green,  5, 6);
+	set_fb_bitfield(&fb_var->blue,   0, 5);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_rgb888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 24;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    0, 8);
+	set_fb_bitfield(&fb_var->green,  8, 8);
+	set_fb_bitfield(&fb_var->blue,  16, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_bgr888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 24;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,   16, 8);
+	set_fb_bitfield(&fb_var->green,  8, 8);
+	set_fb_bitfield(&fb_var->blue,   0, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_xrgb8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    8, 8);
+	set_fb_bitfield(&fb_var->green, 16, 8);
+	set_fb_bitfield(&fb_var->blue,  24, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_xbgr8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,   24, 8);
+	set_fb_bitfield(&fb_var->green, 16, 8);
+	set_fb_bitfield(&fb_var->blue,   8, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_rgbx8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,     0, 8);
+	set_fb_bitfield(&fb_var->green,   8, 8);
+	set_fb_bitfield(&fb_var->blue,   16, 8);
+	set_fb_bitfield(&fb_var->transp, 24, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_bgrx8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    16, 8);
+	set_fb_bitfield(&fb_var->green,   8, 8);
+	set_fb_bitfield(&fb_var->blue,    0, 8);
+	set_fb_bitfield(&fb_var->transp, 24, 0);
+	fb_var->nonstd = 0;
+}
+
+static void set_argb8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    8, 8);
+	set_fb_bitfield(&fb_var->green, 16, 8);
+	set_fb_bitfield(&fb_var->blue,  24, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 8);
+	fb_var->nonstd = 0;
+}
+
+static void set_abgr8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,   24, 8);
+	set_fb_bitfield(&fb_var->green, 16, 8);
+	set_fb_bitfield(&fb_var->blue,   8, 8);
+	set_fb_bitfield(&fb_var->transp, 0, 8);
+	fb_var->nonstd = 0;
+}
+
+static void set_rgba8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,     0, 8);
+	set_fb_bitfield(&fb_var->green,   8, 8);
+	set_fb_bitfield(&fb_var->blue,   16, 8);
+	set_fb_bitfield(&fb_var->transp, 24, 8);
+	fb_var->nonstd = 0;
+}
+
+static void set_bgra8888_be(struct fb_var_screeninfo *fb_var)
+{
+	fb_var->bits_per_pixel = 32;
+	fb_var->grayscale = 0;
+	set_fb_bitfield(&fb_var->red,    16, 8);
+	set_fb_bitfield(&fb_var->green,   8, 8);
+	set_fb_bitfield(&fb_var->blue,    0, 8);
+	set_fb_bitfield(&fb_var->transp, 24, 8);
+	fb_var->nonstd = 0;
+}
+
+#define set_rgb565_le set_bgr565_be
+#define set_bgr565_le set_rgb565_be
+#define set_rgb888_le set_bgr888_be
+#define set_bgr888_le set_rgb888_be
+#define set_xrgb8888_le set_bgrx8888_be
+#define set_xbgr8888_le set_rgbx8888_be
+#define set_rgbx8888_le set_xbgr8888_be
+#define set_bgrx8888_le set_xrgb8888_be
+#define set_argb8888_le set_bgra8888_be
+#define set_abgr8888_le set_rgba8888_be
+#define set_rgba8888_le set_abgr8888_be
+#define set_bgra8888_le set_argb8888_be
+
+int fbdevdrm_update_fb_var_screeninfo_from_format(
+	struct fb_var_screeninfo *fb_var, uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_C8:
+		set_c8(fb_var);
+		break;
+	case DRM_FORMAT_RGB565:
+		HOST_FUNC(set_rgb565)(fb_var);
+		break;
+	case DRM_FORMAT_BGR565:
+		HOST_FUNC(set_bgr565)(fb_var);
+		break;
+	case DRM_FORMAT_RGB888:
+		HOST_FUNC(set_rgb888)(fb_var);
+		break;
+	case DRM_FORMAT_BGR888:
+		HOST_FUNC(set_bgr888)(fb_var);
+		break;
+	case DRM_FORMAT_XRGB8888:
+		HOST_FUNC(set_xrgb8888)(fb_var);
+		break;
+	case DRM_FORMAT_XBGR8888:
+		HOST_FUNC(set_xbgr8888)(fb_var);
+		break;
+	case DRM_FORMAT_RGBX8888:
+		HOST_FUNC(set_rgbx8888)(fb_var);
+		break;
+	case DRM_FORMAT_BGRX8888:
+		HOST_FUNC(set_bgrx8888)(fb_var);
+		break;
+	case DRM_FORMAT_ARGB8888:
+		HOST_FUNC(set_argb8888)(fb_var);
+		break;
+	case DRM_FORMAT_ABGR8888:
+		HOST_FUNC(set_abgr8888)(fb_var);
+		break;
+	case DRM_FORMAT_RGBA8888:
+		HOST_FUNC(set_rgba8888)(fb_var);
+		break;
+	case DRM_FORMAT_BGRA8888:
+		HOST_FUNC(set_bgra8888)(fb_var);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
new file mode 100644
index 000000000000..e837978ac8fc
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#ifndef FBDEVDRM_FORMAT_H
+#define FBDEVDRM_FORMAT_H
+
+#include <drm/drm_fourcc.h>
+
+struct fb_info;
+struct fb_var_screeninfo;
+
+uint32_t fbdevdrm_format_of_fb_info(const struct fb_info *fb_info);
+
+int fbdevdrm_update_fb_var_screeninfo_from_format(
+	struct fb_var_screeninfo *fb_var, uint32_t format);
+
+#endif
-- 
2.21.0
