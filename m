From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:36 +0000
Subject: [PATCH 03/11] drm/fbdevdrm: Add memory management
Message-Id: <20190326091744.11542-4-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Memory management in fbdevdrm is provided by TTM. Fbdev implements page
flipping via display pan operations, which require scanout buffers to be
aligned at scanline boundaries. At the same time memory-mapping operations
of individual buffers requires page alignment of each buffer. Fbdevdrm
ensures that both requirements are met.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/Makefile          |   6 +-
 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c     | 276 +++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h     |  58 +++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c |  10 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h |   9 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c    | 202 +++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h    |  35 +++
 7 files changed, 594 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index 750940d38509..fdfdb5233831 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -1,5 +1,7 @@
 ccflags-y = -Iinclude/drm
-fbdevdrm-y := fbdevdrm_device.o \
-	      fbdevdrm_drv.o
+fbdevdrm-y := fbdevdrm_bo.o \
+	      fbdevdrm_device.o \
+	      fbdevdrm_drv.o \
+	      fbdevdrm_ttm.o
 
 obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm.o
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
new file mode 100644
index 000000000000..78370db6c504
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
@@ -0,0 +1,276 @@
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
+#include "fbdevdrm_bo.h"
+#include "fbdevdrm_device.h"
+
+static void fbdevdrm_bo_cleanup(struct fbdevdrm_bo *fbo)
+{
+	drm_gem_object_release(&fbo->gem);
+}
+
+static void fbdevdrm_bo_destroy(struct fbdevdrm_bo *fbo)
+{
+	/* We got here via ttm_bo_put(), which means that the
+	 * TTM buffer object in 'bo' has already been cleaned
+	 * up. */
+
+	fbdevdrm_bo_cleanup(fbo);
+	kfree(fbo);
+}
+
+static void fbdevdrm_bo_ttm_destroy(struct ttm_buffer_object *bo)
+{
+	struct fbdevdrm_bo *fbo = fbdevdrm_bo_of_bo(bo);
+	fbdevdrm_bo_destroy(fbo);
+}
+
+static void fbdevdrm_bo_ttm_placement(struct fbdevdrm_bo *bo, int pl_flag)
+{
+	unsigned int i;
+	unsigned int c = 0;
+
+	bo->placement.placement = bo->placements;
+	bo->placement.busy_placement = bo->placements;
+
+	if (pl_flag & TTM_PL_FLAG_VRAM)
+		bo->placements[c++].flags = TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_VRAM;
+
+	if (pl_flag & TTM_PL_FLAG_SYSTEM)
+		bo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM;
+
+	if (!c)
+		bo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM;
+
+	bo->placement.num_placement = c;
+	bo->placement.num_busy_placement = c;
+
+	for (i = 0; i < c; ++i) {
+		bo->placements[i].fpfn = 0;
+		bo->placements[i].lpfn = 0;
+	}
+}
+
+static int fbdevdrm_bo_init(struct fbdevdrm_bo *fbo, struct drm_device *dev,
+			    int size, int align, uint32_t flags)
+{
+	struct fbdevdrm_device *fdev;
+	int ret;
+	size_t acc_size;
+
+	fdev = fbdevdrm_device_of_dev(dev);
+
+	ret = drm_gem_object_init(dev, &fbo->gem, size);
+	if (ret < 0)
+		return ret;
+
+	fbo->bo.bdev = &fdev->ttm.bdev;
+
+	fbdevdrm_bo_ttm_placement(fbo, TTM_PL_FLAG_VRAM | TTM_PL_FLAG_SYSTEM);
+
+	acc_size = ttm_bo_dma_acc_size(&fdev->ttm.bdev, size, sizeof(*fbo));
+
+	ret = ttm_bo_init(&fdev->ttm.bdev, &fbo->bo, size,
+			  ttm_bo_type_device, &fbo->placement,
+			  align >> PAGE_SHIFT, false, acc_size,
+			  NULL, NULL, fbdevdrm_bo_ttm_destroy);
+	if (ret < 0)
+		goto err_drm_gem_object_release;
+
+	return 0;
+
+err_drm_gem_object_release:
+	drm_gem_object_release(&fbo->gem);
+	return ret;
+}
+
+/* Returns the least common multiple of a value and the page size
+ */
+static u32 lcm_with_page_size(u32 size)
+{
+	if (!size)
+		return size; /* 0 is always correct */
+	while (size && (size & ~PAGE_MASK))
+		size <<= 1;
+	if (!size)
+		return (u32)-EINVAL; /* no common multiple found */
+	return size;
+}
+
+static int fbdevdrm_bo_init_with_pitch(struct fbdevdrm_bo *fbo,
+				       struct drm_device *dev, int size,
+				       int pitch, uint32_t flags)
+{
+	u32 align = lcm_with_page_size(pitch);
+	if (align = (u32)-EINVAL) {
+		DRM_ERROR("fbdevdrm: buffer pitch of %d bytes has no "
+			  "common multiple with page size.\n", pitch);
+		return -EINVAL;
+	}
+
+	return fbdevdrm_bo_init(fbo, dev, size, align, flags);
+}
+
+/*
+ * Public interface
+ */
+
+struct fbdevdrm_bo* fbdevdrm_bo_create(struct drm_device *dev, int size,
+				       int align, uint32_t flags)
+{
+	struct fbdevdrm_bo *fbo;
+	int ret;
+
+	fbo = kzalloc(sizeof(*fbo), GFP_KERNEL);
+	if (!fbo)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fbdevdrm_bo_init(fbo, dev, size, align, flags);
+	if (ret < 0)
+		goto err_kfree;
+
+	return fbo;
+
+err_kfree:
+	kfree(fbo);
+	return ERR_PTR(ret);
+}
+
+struct fbdevdrm_bo* fbdevdrm_bo_create_with_pitch(struct drm_device *dev,
+						  int size, int pitch,
+						  uint32_t flags)
+{
+	struct fbdevdrm_bo *fbo;
+	int ret;
+
+	fbo = kzalloc(sizeof(*fbo), GFP_KERNEL);
+	if (!fbo)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fbdevdrm_bo_init_with_pitch(fbo, dev, size, pitch, flags);
+	if (ret < 0)
+		goto err_kfree;
+
+	return fbo;
+
+err_kfree:
+	kfree(fbo);
+	return ERR_PTR(ret);
+}
+
+void fbdevdrm_bo_put(struct fbdevdrm_bo *fbo)
+{
+	ttm_bo_put(&fbo->bo);
+}
+
+int fbdevdrm_bo_reserve(struct fbdevdrm_bo *fbo, bool no_wait)
+{
+	int ret;
+
+	ret = ttm_bo_reserve(&fbo->bo, true, no_wait, NULL);
+	if (ret < 0) {
+		if (ret != -ERESTARTSYS && ret != -EBUSY)
+			DRM_ERROR("fbdevdrm: ttm_bo_reserve(%p) failed,"
+				  " error %d\n", fbo, -ret);
+		return ret;
+	}
+	return 0;
+}
+
+void fbdevdrm_bo_unreserve(struct fbdevdrm_bo *fbo)
+{
+	ttm_bo_unreserve(&fbo->bo);
+}
+
+u64 fbdevdrm_bo_mmap_offset(struct fbdevdrm_bo *fbo)
+{
+	return drm_vma_node_offset_addr(&fbo->bo.vma_node);
+}
+
+int fbdevdrm_bo_pin(struct fbdevdrm_bo *fbo, u32 pl_flag)
+{
+	int i, ret;
+	struct ttm_operation_ctx ctx = { false, false };
+
+	if (fbo->pin_count) {
+		++fbo->pin_count;
+		return 0;
+	}
+
+	fbdevdrm_bo_ttm_placement(fbo, pl_flag);
+	for (i = 0; i < fbo->placement.num_placement; ++i)
+		fbo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
+
+	ret = ttm_bo_validate(&fbo->bo, &fbo->placement, &ctx);
+	if (ret < 0) {
+		DRM_ERROR("fbdevdrm: ttm_bo_validate failed, error %d\n", -ret);
+		return ret;
+	}
+
+	fbo->pin_count = 1;
+
+	return 0;
+}
+
+int fbdevdrm_bo_unpin(struct fbdevdrm_bo *fbo)
+{
+	int i, ret;
+	struct ttm_operation_ctx ctx = { false, false };
+
+	if (!fbo->pin_count) {
+		DRM_ERROR("fbdevdrm: BO %p is not pinned \n", fbo);
+		return 0;
+	}
+	--fbo->pin_count;
+	if (fbo->pin_count)
+		return 0;
+
+	for (i = 0; i < fbo->placement.num_placement ; ++i)
+		fbo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
+
+	ret = ttm_bo_validate(&fbo->bo, &fbo->placement, &ctx);
+	if (ret < 0) {
+		DRM_ERROR("fbdevdrm: ttm_bo_validate failed, error %d\n", -ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fbdevdrm_bo_push_to_system(struct fbdevdrm_bo *fbo)
+{
+	int i, ret;
+	struct ttm_operation_ctx ctx = { false, false };
+
+	if (!fbo->pin_count) {
+		DRM_ERROR("fbdevdrm: BO %p is not pinned \n", fbo);
+		return 0;
+	}
+	--fbo->pin_count;
+	if (fbo->pin_count)
+		return 0;
+
+	if (fbo->kmap.virtual)
+		ttm_bo_kunmap(&fbo->kmap);
+
+	fbdevdrm_bo_ttm_placement(fbo, TTM_PL_FLAG_SYSTEM);
+	for (i = 0; i < fbo->placement.num_placement ; ++i)
+		fbo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
+
+	ret = ttm_bo_validate(&fbo->bo, &fbo->placement, &ctx);
+	if (ret) {
+		DRM_ERROR("fbdevdrm: ttm_bo_validate failed, error %d\n", -ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
new file mode 100644
index 000000000000..7602a0fbd6a5
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
@@ -0,0 +1,58 @@
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
+#ifndef FBDEVDRM_BO_H
+#define FBDEVDRM_BO_H
+
+#include <drm/drm_gem.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_placement.h>
+#include <linux/kernel.h> /* for container_of() */
+
+struct fbdevdrm_bo {
+        struct ttm_buffer_object bo;
+        struct ttm_placement placement;
+        struct ttm_bo_kmap_obj kmap;
+        struct drm_gem_object gem;
+
+        /* Supported placements are VRAM and SYSTEM */
+        struct ttm_place placements[3];
+        int pin_count;
+};
+
+static inline struct fbdevdrm_bo* fbdevdrm_bo_of_bo(
+	struct ttm_buffer_object *bo)
+{
+	return container_of(bo, struct fbdevdrm_bo, bo);
+}
+
+static inline struct fbdevdrm_bo* fbdevdrm_bo_of_gem(
+	struct drm_gem_object *gem)
+{
+	return container_of(gem, struct fbdevdrm_bo, gem);
+}
+
+struct fbdevdrm_bo* fbdevdrm_bo_create(struct drm_device *dev, int size,
+				       int align, uint32_t flags);
+struct fbdevdrm_bo* fbdevdrm_bo_create_with_pitch(struct drm_device *dev,
+						  int size, int pitch,
+						  uint32_t flags);
+void fbdevdrm_bo_put(struct fbdevdrm_bo *fbo);
+
+int fbdevdrm_bo_reserve(struct fbdevdrm_bo *fbo, bool no_wait);
+void fbdevdrm_bo_unreserve(struct fbdevdrm_bo *fbo);
+u64 fbdevdrm_bo_mmap_offset(struct fbdevdrm_bo *fbo);
+int fbdevdrm_bo_pin(struct fbdevdrm_bo *fbo, u32 pl_flag);
+int fbdevdrm_bo_unpin(struct fbdevdrm_bo *fbo);
+int fbdevdrm_bo_push_to_system(struct fbdevdrm_bo *fbo);
+
+#endif
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
index 0abf41cf05bb..c8054eac271d 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
@@ -33,9 +33,17 @@ int fbdevdrm_device_init(struct fbdevdrm_device *fdev, struct drm_driver *drv,
 	fdev->dev.pdev = container_of(fb_info->device, struct pci_dev, dev);
 	fdev->fb_info = fb_info;
 
+	ret = fbdevdrm_ttm_init(&fdev->ttm, &fdev->dev, fb_info);
+	if (ret)
+		goto err_drm_dev_fini;
+
 	INIT_LIST_HEAD(&fdev->device_list);
 
 	return 0;
+
+err_drm_dev_fini:
+	drm_dev_fini(&fdev->dev);
+	return ret;
 }
 
 void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev)
@@ -47,6 +55,8 @@ void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev)
 			  "in device list\n");
 	}
 
+	fbdevdrm_ttm_cleanup(&fdev->ttm);
+
 	drm_dev_fini(dev);
 	dev->dev_private = NULL;
 }
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
index 85878f60bba4..381d9cfb1450 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
@@ -16,6 +16,7 @@
 #include <drm/drm_device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include "fbdevdrm_ttm.h"
 
 struct drm_driver;
 struct fb_info;
@@ -24,6 +25,8 @@ struct fbdevdrm_device {
 	struct drm_device dev;
 	struct fb_info *fb_info;
 
+	struct fbdevdrm_ttm ttm;
+
 	struct list_head device_list; /* entry in global device list */
 };
 
@@ -33,6 +36,12 @@ static inline struct fbdevdrm_device* fbdevdrm_device_of_device_list(
 	return list_entry(device_list, struct fbdevdrm_device, device_list);
 }
 
+static inline struct fbdevdrm_device* fbdevdrm_device_of_dev(
+	struct drm_device *dev)
+{
+	return container_of(dev, struct fbdevdrm_device, dev);
+}
+
 int fbdevdrm_device_init(struct fbdevdrm_device *fdev, struct drm_driver *drv,
 			 struct fb_info *fb_info);
 void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev);
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
new file mode 100644
index 000000000000..f7aeff755c30
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
@@ -0,0 +1,202 @@
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
+#include "fbdevdrm_ttm.h"
+#include <drm/drmP.h>
+#include <drm/ttm/ttm_page_alloc.h>
+#include "fbdevdrm_bo.h"
+
+static struct fbdevdrm_ttm* fbdevdrm_ttm_of_bdev(
+	struct ttm_bo_device *bdev)
+{
+	return container_of(bdev, struct fbdevdrm_ttm, bdev);
+}
+
+/*
+ * TTM BO device
+ */
+
+static void fbdevdrm_ttm_backend_destroy(struct ttm_tt *tt)
+{
+	ttm_tt_fini(tt);
+	kfree(tt);
+}
+
+static struct ttm_backend_func fbdevdrm_ttm_backend_func = {
+	.destroy = fbdevdrm_ttm_backend_destroy
+};
+
+static struct ttm_tt *fbdevdrm_ttm_tt_create(struct ttm_buffer_object *bo,
+					     uint32_t page_flags)
+{
+	struct ttm_tt *tt;
+	int ret;
+
+	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+	if (!tt)
+		return NULL;
+
+	tt->func = &fbdevdrm_ttm_backend_func;
+
+	ret = ttm_tt_init(tt, bo, page_flags);
+	if (ret < 0)
+		goto err_ttm_tt_init;
+
+	return tt;
+
+err_ttm_tt_init:
+	kfree(tt);
+	return NULL;
+}
+
+static int fbdevdrm_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
+				     struct ttm_mem_type_manager *man)
+{
+	switch (type) {
+	case TTM_PL_SYSTEM:
+		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE;
+		man->available_caching = TTM_PL_MASK_CACHING;
+		man->default_caching = TTM_PL_FLAG_CACHED;
+		break;
+	case TTM_PL_VRAM:
+		man->func = &ttm_bo_manager_func;
+		man->flags = TTM_MEMTYPE_FLAG_FIXED |
+			     TTM_MEMTYPE_FLAG_MAPPABLE;
+		man->available_caching = TTM_PL_FLAG_UNCACHED |
+					 TTM_PL_FLAG_WC;
+		man->default_caching = TTM_PL_FLAG_WC;
+		break;
+	default:
+		DRM_ERROR("fbdevdrm: Unsupported memory type %u\n", (unsigned)type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void fbdevdrm_bo_evict_flags(struct ttm_buffer_object *bo,
+				    struct ttm_placement *pl)
+{ }
+
+static int fbdevdrm_bo_verify_access(struct ttm_buffer_object *bo,
+				     struct file *filp)
+{
+	struct fbdevdrm_bo *fbo = fbdevdrm_bo_of_bo(bo);
+
+	return drm_vma_node_verify_access(&fbo->gem.vma_node,
+					  filp->private_data);
+}
+
+static int fbdevdrm_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
+				       struct ttm_mem_reg *mem)
+{
+	struct ttm_mem_type_manager *man = bdev->man + mem->mem_type;
+	struct fbdevdrm_ttm *ttm = fbdevdrm_ttm_of_bdev(bdev);
+
+	if (!(man->flags & TTM_MEMTYPE_FLAG_MAPPABLE))
+		return -EINVAL;
+
+	mem->bus.addr = NULL;
+	mem->bus.size = mem->num_pages << PAGE_SHIFT;
+
+	switch (mem->mem_type) {
+	case TTM_PL_SYSTEM:	/* nothing to do */
+		mem->bus.offset = 0;
+		mem->bus.base = 0;
+		mem->bus.is_iomem = false;
+		break;
+	case TTM_PL_VRAM:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.base = ttm->fb_info->fix.smem_start;
+		mem->bus.is_iomem = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void fbdevdrm_ttm_io_mem_free(struct ttm_bo_device *bdev,
+				   struct ttm_mem_reg *mem)
+{ }
+
+static struct ttm_bo_driver fbdevdrm_bo_driver = {
+	.ttm_tt_create = fbdevdrm_ttm_tt_create,
+	.ttm_tt_populate = ttm_pool_populate,
+	.ttm_tt_unpopulate = ttm_pool_unpopulate,
+	.init_mem_type = fbdevdrm_bo_init_mem_type,
+	.eviction_valuable = ttm_bo_eviction_valuable,
+	.evict_flags = fbdevdrm_bo_evict_flags,
+	.verify_access = fbdevdrm_bo_verify_access,
+	.io_mem_reserve = fbdevdrm_ttm_io_mem_reserve,
+	.io_mem_free = fbdevdrm_ttm_io_mem_free,
+};
+
+static int fbdevdrm_init_ttm_bo_device(struct fbdevdrm_ttm *ttm,
+				       struct drm_device *dev,
+				       unsigned long p_size)
+{
+	int ret;
+
+	ret = ttm_bo_device_init(&ttm->bdev,
+				 &fbdevdrm_bo_driver,
+				 dev->anon_inode->i_mapping,
+				 DRM_FILE_PAGE_OFFSET,
+				 true);
+	if (ret) {
+		DRM_ERROR("fbdevdrm: ttm_bo_device_init failed; %d\n", ret);
+		return ret;
+	}
+
+	ret = ttm_bo_init_mm(&ttm->bdev, TTM_PL_VRAM, p_size);
+	if (ret) {
+		DRM_ERROR("fbdevdrm: ttm_bo_init_mm failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * struct fbdevdrm_ttm
+ */
+
+int fbdevdrm_ttm_init(struct fbdevdrm_ttm *ttm, struct drm_device *dev,
+		      struct fb_info *fb_info)
+{
+	int ret;
+
+	ttm->dev = dev;
+	ttm->fb_info = fb_info;
+
+	/* DRM porting notes: programming the linear scanout buffer is
+	 * implemented via display panning. To make this work, all BOs
+	 * have to end at scanline boundaries. The final BO could be placed
+	 * at the very end of the display memory, which might not align
+	 * with the end of the final scanline. Fbdev would reject such a
+	 * coordinate for display panning. To avoid this, we don't use the
+	 * display memory's final 4 pages. If you convert an fbdev driver
+	 * to DRM, remove this workaround and hand-over all memory to TTM.
+	 */
+	ttm->vram_size = fb_info->fix.smem_len - 4 * PAGE_SIZE;
+
+	ret = fbdevdrm_init_ttm_bo_device(ttm, dev, ttm->vram_size >> PAGE_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+void fbdevdrm_ttm_cleanup(struct fbdevdrm_ttm *ttm)
+{
+	ttm_bo_device_release(&ttm->bdev);
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
new file mode 100644
index 000000000000..d3e964cd8215
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
@@ -0,0 +1,35 @@
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
+#ifndef FBDEVDRM_TTM_H
+#define FBDEVDRM_TTM_H
+
+#include <drm/ttm/ttm_bo_driver.h>
+
+#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
+
+struct drm_device;
+struct fb_info;
+
+struct fbdevdrm_ttm {
+	struct drm_device *dev;
+	struct fb_info *fb_info;
+
+	size_t vram_size;
+	struct ttm_bo_device bdev;
+};
+
+int fbdevdrm_ttm_init(struct fbdevdrm_ttm *ttm, struct drm_device *dev,
+		      struct fb_info *fb_info);
+void fbdevdrm_ttm_cleanup(struct fbdevdrm_ttm *ttm);
+
+#endif
-- 
2.21.0
