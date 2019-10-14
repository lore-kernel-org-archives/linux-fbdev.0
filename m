From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:06 +0000
Subject: [PATCH v2 05/15] drm/fbconv: Add DRM <-> fbdev pixel-format conversion
Message-Id: <20191014140416.28517-6-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

DRM uses FOURCC constants to describe pixel formats, fbdev uses a
per-component bitfield structure. The functions in this patch convert
between the two.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 435 ++++++++++++++++++++++++++++
 include/drm/drm_fbconv_helper.h     |  23 ++
 2 files changed, 458 insertions(+)
 create mode 100644 include/drm/drm_fbconv_helper.h

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index 0cb46d2c98c3..af45358a156a 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -1 +1,436 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <asm/byteorder.h>
+
+#include <linux/fb.h>
+
+#include <drm/drm_fbconv_helper.h>
+
+/*
+ * Format conversion helpers
+ */
+
+static bool is_c8(const struct fb_var_screeninfo *fb_var)
+{
+	return fb_var->bits_per_pixel = 8;
+}
+
+static bool is_rgb565(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 16) &&
+	       (fb_var->red.offset = 11) &&
+	       (fb_var->red.length = 5) &&
+	       (fb_var->green.offset = 5) &&
+	       (fb_var->green.length = 6) &&
+	       (fb_var->blue.offset = 0) &&
+	       (fb_var->blue.length = 5);
+}
+
+static bool is_bgr565(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 16) &&
+	       (fb_var->red.offset = 0) &&
+	       (fb_var->red.length = 5) &&
+	       (fb_var->green.offset = 5) &&
+	       (fb_var->green.length = 6) &&
+	       (fb_var->blue.offset = 11) &&
+	       (fb_var->blue.length = 5);
+}
+
+static bool is_rgb888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 24) &&
+	       (fb_var->red.offset = 16) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 0) &&
+	       (fb_var->blue.length = 8);
+}
+
+static bool is_bgr888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 24) &&
+	       (fb_var->red.offset = 0) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 16) &&
+	       (fb_var->blue.length = 8);
+}
+
+static bool is_xrgb8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 16) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 0) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.length = 0);
+}
+
+static bool is_xbgr8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 0) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 16) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.length = 0);
+}
+
+static bool is_rgbx8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 24) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 16) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 8) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.length = 0);
+}
+
+static bool is_bgrx8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 8) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 16) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 24) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.length = 0);
+}
+
+static bool is_argb8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 16) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 0) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.offset = 24) &&
+	       (fb_var->transp.length = 8);
+}
+
+static bool is_abgr8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 0) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 8) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 16) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.offset = 24) &&
+	       (fb_var->transp.length = 8);
+}
+
+static bool is_rgba8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 24) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 16) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 8) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.offset = 0) &&
+	       (fb_var->transp.length = 8);
+}
+
+static bool is_bgra8888(const struct fb_var_screeninfo *fb_var)
+{
+	return (fb_var->bits_per_pixel = 32) &&
+	       (fb_var->red.offset = 8) &&
+	       (fb_var->red.length = 8) &&
+	       (fb_var->green.offset = 16) &&
+	       (fb_var->green.length = 8) &&
+	       (fb_var->blue.offset = 24) &&
+	       (fb_var->blue.length = 8) &&
+	       (fb_var->transp.offset = 0) &&
+	       (fb_var->transp.length = 8);
+}
+
+struct format_map {
+	bool (*is_format)(const struct fb_var_screeninfo *fb_var);
+	uint32_t format;
+};
+
+/**
+ * drm_fbconv_format_of_fb_var_screeninfo - Returns a DRM_FORMAT constant
+ *	from an fb_var_screeninfo structure
+ * @fb_info:	the fb_var_screeninfo structure
+ * Returns:
+ *	A DRM_FORMAT constant on success, or
+ *	DRM_FORMAT_INVALID otherwise.
+ */
+uint32_t
+drm_fbconv_format_of_fb_var_screeninfo(const struct fb_var_screeninfo *fb_var)
+{
+	static const struct format_map map[] = {
+		{ is_c8,       DRM_FORMAT_C8 }, /* 256-color palette */
+		{ is_rgb565,   DRM_FORMAT_RGB565 },
+		{ is_bgr565,   DRM_FORMAT_BGR565 },
+		{ is_rgb888,   DRM_FORMAT_RGB888 },
+		{ is_bgr888,   DRM_FORMAT_BGR888 },
+		{ is_xrgb8888, DRM_FORMAT_XRGB8888 },
+		{ is_xbgr8888, DRM_FORMAT_XBGR8888 },
+		{ is_rgbx8888, DRM_FORMAT_RGBX8888 },
+		{ is_bgrx8888, DRM_FORMAT_BGRX8888 },
+		{ is_argb8888, DRM_FORMAT_ARGB8888 },
+		{ is_abgr8888, DRM_FORMAT_ABGR8888 },
+		{ is_rgba8888, DRM_FORMAT_RGBA8888 },
+		{ is_bgra8888, DRM_FORMAT_BGRA8888 }
+	};
+
+	size_t i;
+
+	if (fb_var->bits_per_pixel < 8)
+		goto err; /* at least 8-bit color required */
+	if (fb_var->grayscale = 1)
+		goto err; /* grayscale output is not supported */
+
+	for (i = 0; i < ARRAY_SIZE(map); ++i) {
+		if (map[i].is_format(fb_var))
+			return map[i].format;
+	}
+
+err:
+	return DRM_FORMAT_INVALID;
+}
+EXPORT_SYMBOL(drm_fbconv_format_of_fb_var_screeninfo);
+
+/**
+ * drm_fbconv_format_of_fb_info - Returns a DRM_FORMAT constant from
+ *	an fb_info structure
+ * @fb_info:	the fb_info structure
+ * Returns:
+ *	A DRM_FORMAT constant on success, or
+ *	DRM_FORMAT_INVALID otherwise.
+ */
+uint32_t drm_fbconv_format_of_fb_info(const struct fb_info *fb_info)
+{
+	if (fb_info->fix.type != FB_TYPE_PACKED_PIXELS)
+		return DRM_FORMAT_INVALID; /* no multi-plane formats */
+
+	return drm_fbconv_format_of_fb_var_screeninfo(&fb_info->var);
+}
+EXPORT_SYMBOL(drm_fbconv_format_of_fb_info);
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
+static void set_rgb565(struct fb_var_screeninfo *fb_var)
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
+static void set_bgr565(struct fb_var_screeninfo *fb_var)
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
+static void set_rgb888(struct fb_var_screeninfo *fb_var)
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
+static void set_bgr888(struct fb_var_screeninfo *fb_var)
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
+static void set_xrgb8888(struct fb_var_screeninfo *fb_var)
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
+static void set_xbgr8888(struct fb_var_screeninfo *fb_var)
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
+static void set_rgbx8888(struct fb_var_screeninfo *fb_var)
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
+static void set_bgrx8888(struct fb_var_screeninfo *fb_var)
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
+static void set_argb8888(struct fb_var_screeninfo *fb_var)
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
+static void set_abgr8888(struct fb_var_screeninfo *fb_var)
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
+static void set_rgba8888(struct fb_var_screeninfo *fb_var)
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
+static void set_bgra8888(struct fb_var_screeninfo *fb_var)
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
+/**
+ * drm_fbconv_update_fb_var_screen_info_from_format - sets the pixel format
+ *	of a fb_var_screeninfo structure from a DRM_FORMAT constant
+ * @fb_var:	the fb_var_screeninfo structure to update
+ * @format:	a DRM_FORMAT constant
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise.
+ */
+int drm_fbconv_update_fb_var_screeninfo_from_format(
+	struct fb_var_screeninfo *fb_var, uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_C8:
+		set_c8(fb_var);
+		break;
+	case DRM_FORMAT_RGB565:
+		set_rgb565(fb_var);
+		break;
+	case DRM_FORMAT_BGR565:
+		set_bgr565(fb_var);
+		break;
+	case DRM_FORMAT_RGB888:
+		set_rgb888(fb_var);
+		break;
+	case DRM_FORMAT_BGR888:
+		set_bgr888(fb_var);
+		break;
+	case DRM_FORMAT_XRGB8888:
+		set_xrgb8888(fb_var);
+		break;
+	case DRM_FORMAT_XBGR8888:
+		set_xbgr8888(fb_var);
+		break;
+	case DRM_FORMAT_RGBX8888:
+		set_rgbx8888(fb_var);
+		break;
+	case DRM_FORMAT_BGRX8888:
+		set_bgrx8888(fb_var);
+		break;
+	case DRM_FORMAT_ARGB8888:
+		set_argb8888(fb_var);
+		break;
+	case DRM_FORMAT_ABGR8888:
+		set_abgr8888(fb_var);
+		break;
+	case DRM_FORMAT_RGBA8888:
+		set_rgba8888(fb_var);
+		break;
+	case DRM_FORMAT_BGRA8888:
+		set_bgra8888(fb_var);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_update_fb_var_screeninfo_from_format);
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
new file mode 100644
index 000000000000..6b2ed12b579a
--- /dev/null
+++ b/include/drm/drm_fbconv_helper.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_FBCONV_HELPER_H
+#define DRM_FBCONV_HELPER_H
+
+#include <drm/drm_fourcc.h>
+
+struct fb_info;
+struct fb_var_screeninfo;
+
+/*
+ * Format conversion helpers
+ */
+
+uint32_t
+drm_fbconv_format_of_fb_var_screeninfo(const struct fb_var_screeninfo *fb_var);
+
+uint32_t drm_fbconv_format_of_fb_info(const struct fb_info *fb_info);
+
+int drm_fbconv_update_fb_var_screeninfo_from_format(
+	struct fb_var_screeninfo *fb_var, uint32_t format);
+
+#endif
-- 
2.23.0
