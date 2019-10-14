From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:12 +0000
Subject: [PATCH v2 11/15] drm/fbconv: Add helpers for init and cleanup of fb_info structures
Message-Id: <20191014140416.28517-12-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

The implementation of drm_fbconv_fill_fb_info() sets up an fbdev driver's
fb_info structure for use. It's similar to register_framebuffer(), but does
not create device files, register the driver with the fbdev code or create
a console. drm_fbconv_cleanup_fb_info() does the inverse.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 123 ++++++++++++++++++++++++++++
 include/drm/drm_fbconv_helper.h     |   7 ++
 2 files changed, 130 insertions(+)

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index f7f247e30a3d..7d7e4da2a29e 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -3,6 +3,7 @@
 #include <asm/byteorder.h>
 
 #include <linux/fb.h>
+#include <linux/major.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
@@ -1722,6 +1723,9 @@ int drm_fbconv_modeset_init(struct drm_fbconv_modeset *modeset,
 {
 	struct drm_mode_config *mode_config = &dev->mode_config;
 
+	if (WARN_ON(fb_info->node != FB_MAX))
+		return -EINVAL; /* forgot to run drm_fbconv_fill_fb_info()? */
+
 	modeset->dev = dev;
 	modeset->fb_info = fb_info;
 
@@ -1820,3 +1824,122 @@ drm_fbconv_modeset_setup_pipe(struct drm_fbconv_modeset *modeset,
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbconv_modeset_setup_pipe);
+
+/*
+ * Helpers for struct fb_info
+ *
+ * This is the setup and cleanup code for struct fb_info. It has been
+ * adapted from the fbdev core modules.
+ *
+ * The original implementation in fbdev also handles device files, console,
+ * and framebuffer events. As DRM drivers use DRM's framebuffer emulation,
+ * the respective code has been removed here.
+ *
+ * In contrast to the fbdev core, we don't need locking here. These don't
+ * interact with fbdev's internal state.
+ */
+
+static bool is_matroxfb(const struct fb_info *fb_info)
+{
+	return !!(fb_info->fix.accel & (FB_ACCEL_MATROX_MGA2064W |
+					FB_ACCEL_MATROX_MGA1064SG |
+					FB_ACCEL_MATROX_MGA2164W |
+					FB_ACCEL_MATROX_MGA2164W_AGP |
+					FB_ACCEL_MATROX_MGAG100 |
+					FB_ACCEL_MATROX_MGAG200 |
+					FB_ACCEL_MATROX_MGAG400));
+}
+
+/**
+ * drm_fbconv_fill_fb_info - prepares an fbdev driver's fb_info structure
+ *	for use
+ * @fb_info:	the fb_info structure to set up
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise.
+ *
+ * The fbdev driver provides fbconv helpers with an fb_info structure. Before
+ * use, the structure has to be set up correctly. In fbdev core,
+ * register_framebuffer() does this; here it's provided by
+ * drm_fbconv_fill_fb_info().
+ *
+ * Call drm_fbconv_cleanup_fb_info() during shutdown to clean up the fb_info
+ * structure.
+ */
+int drm_fbconv_fill_fb_info(struct fb_info *fb_info)
+{
+	struct fb_videomode mode;
+
+	/* Returing -ENOSYS on error is technically wrong, but it's
+	 * what the fbdev core code would do. So we do the same.
+	 */
+	if (fb_check_foreignness(fb_info))
+		return -ENOSYS;
+
+	fb_info->node = FB_MAX; /* not registered; filled by fbconv helpers */
+	atomic_set(&fb_info->count, 1);
+	mutex_init(&fb_info->lock);
+	mutex_init(&fb_info->mm_lock);
+
+	fb_info->dev = NULL; /* device file not needed for fbconv. */
+
+	if (fb_info->pixmap.addr = NULL) {
+		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
+		if (fb_info->pixmap.addr) {
+			fb_info->pixmap.size = FBPIXMAPSIZE;
+			fb_info->pixmap.buf_align = 1;
+			fb_info->pixmap.scan_align = 1;
+			fb_info->pixmap.access_align = 32;
+			fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
+		}
+	}
+	fb_info->pixmap.offset = 0;
+
+	if (!fb_info->pixmap.blit_x)
+		fb_info->pixmap.blit_x = ~(u32)0;
+
+	if (!fb_info->pixmap.blit_y)
+		fb_info->pixmap.blit_y = ~(u32)0;
+
+	if (!fb_info->modelist.prev || !fb_info->modelist.next)
+		INIT_LIST_HEAD(&fb_info->modelist);
+
+	fb_var_to_videomode(&mode, &fb_info->var);
+	fb_add_videomode(&mode, &fb_info->modelist);
+
+	/* matroxfb: Requries a call to fb_set_par() to initialize
+	 * fbinfo->fix.{smem_start,smem_len}. Otherwise, we won't be
+	 * able to initialize framebuffer memory management.
+	 */
+	if (is_matroxfb(fb_info)) {
+		if (fb_info->fbops->fb_set_par)
+			fb_info->fbops->fb_set_par(fb_info);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_fill_fb_info);
+
+/**
+ * drm_fbconv_cleanup_fb_info - cleans up an fbdev driver's fb_info structure
+ *	after use
+ * @fb_info:	the fb_info structure to clean up
+ */
+void drm_fbconv_cleanup_fb_info(struct fb_info *fb_info)
+{
+	if (fb_info->node != FB_MAX)
+		return;
+
+	if (fb_info->pixmap.addr &&
+	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
+		kfree(fb_info->pixmap.addr);
+
+	fb_destroy_modelist(&fb_info->modelist);
+
+	if (!atomic_dec_and_test(&fb_info->count))
+		return;
+
+	if (fb_info->fbops->fb_destroy)
+		fb_info->fbops->fb_destroy(fb_info);
+}
+EXPORT_SYMBOL(drm_fbconv_cleanup_fb_info);
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
index c7d211f40462..23d17ad14b81 100644
--- a/include/drm/drm_fbconv_helper.h
+++ b/include/drm/drm_fbconv_helper.h
@@ -140,4 +140,11 @@ int drm_fbconv_modeset_setup_pipe(
 	const uint32_t *formats, unsigned int format_count,
 	const uint64_t *format_modifiers, struct drm_connector *connector);
 
+/*
+ * Helpers for struct fb_info
+ */
+
+int drm_fbconv_fill_fb_info(struct fb_info *fb_info);
+void drm_fbconv_cleanup_fb_info(struct fb_info *fb_info);
+
 #endif
-- 
2.23.0
