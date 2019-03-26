From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:38 +0000
Subject: [PATCH 05/11] drm/fbdevdrm: Add GEM and dumb interfaces
Message-Id: <20190326091744.11542-6-tzimmermann@suse.de>
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
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
index 4a6ba6c85c5c..4724e3df6ace 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
@@ -18,6 +18,7 @@
 #include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include "fbdevdrm_bo.h"
 #include "fbdevdrm_device.h"
 
 /* DRM porting note: Here are some general information about the driver,
@@ -64,7 +65,82 @@ static const struct file_operations driver_fops = {
 	.read = drm_read
 };
 
+static void driver_gem_free_object(struct drm_gem_object *gobj)
+{
+	struct fbdevdrm_bo *fbo = fbdevdrm_bo_of_gem(gobj);
+	fbdevdrm_bo_put(fbo);
+}
+
+static int driver_dumb_create(struct drm_file *file_priv,
+			      struct drm_device *dev,
+			      struct drm_mode_create_dumb *args)
+{
+	int ret;
+	struct fbdevdrm_bo *fbo;
+	u32 size, handle;
+
+	args->pitch = args->width * ((args->bpp + 7) / 8);
+	args->size = args->pitch * args->height;
+
+	size = roundup(args->size, PAGE_SIZE);
+	if (!size)
+		return -EINVAL;
+
+	/* DRM porting note: FBdev aligns scanout buffers to multiples
+	 * of the scanline size in bytes. TTM aligns buffers to page
+	 * boundaries. To maintain FBdev buffers with TTM, we align BOs
+	 * at both, the scanline offsets and the page offsets. Depending
+	 * on resolution and color depth, this may result in some memory
+	 * overhead. After porting an FBdev driver to DRM, you can remove
+	 * this constrain and simply align to page boundaries.
+	 */
+	fbo = fbdevdrm_bo_create_with_pitch(dev, size, args->pitch, 0);
+	if (IS_ERR(fbo)) {
+		ret = PTR_ERR(fbo);
+		if (ret != -ERESTARTSYS)
+			DRM_ERROR("fbdevdrm: fbdevdrm_bo_create_with_pitch() "
+				  "failed, error %d\n", -ret);
+		return ret;
+	}
+
+	ret = drm_gem_handle_create(file_priv, &fbo->gem, &handle);
+	drm_gem_object_put_unlocked(&fbo->gem); /* TODO: verify ref-count */
+	if (ret < 0)
+		goto err_fbdevdrm_bo_put;
+
+	args->handle = handle;
+
+	return 0;
+
+err_fbdevdrm_bo_put:
+	fbdevdrm_bo_put(fbo);
+	return ret;
+}
+
+static int driver_dumb_mmap_offset(struct drm_file *file_priv,
+				   struct drm_device *dev, uint32_t handle,
+				   uint64_t *offset)
+{
+	struct drm_gem_object *obj;
+	struct fbdevdrm_bo *fbo;
+
+	obj = drm_gem_object_lookup(file_priv, handle);
+	if (obj = NULL)
+		return -ENOENT;
+
+	fbo = fbdevdrm_bo_of_gem(obj);
+	*offset = fbdevdrm_bo_mmap_offset(fbo);
+
+	drm_gem_object_put_unlocked(obj);
+	return 0;
+}
+
 static struct drm_driver fbdevdrm_drv = {
+	/* GEM interfaces */
+	.gem_free_object = driver_gem_free_object,
+	/* Dumb interfaces */
+	.dumb_create = driver_dumb_create,
+	.dumb_map_offset = driver_dumb_mmap_offset,
 	/* data fields */
 	.major = DRIVER_MAJOR,
 	.minor = DRIVER_MINOR,
@@ -72,6 +148,7 @@ static struct drm_driver fbdevdrm_drv = {
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESCRIPTION,
 	.date = DRIVER_DATE,
+	.driver_features = DRIVER_GEM,
 	.fops = &driver_fops
 };
 
-- 
2.21.0
