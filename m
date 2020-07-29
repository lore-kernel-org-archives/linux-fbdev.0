From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 29 Jul 2020 13:41:48 +0000
Subject: [PATCH 5/5] drm/vram_helper: Implement struct drm_gem_object_funcs.vmap_iomem
Message-Id: <20200729134148.6855-6-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200729134148.6855-1-tzimmermann@suse.de>
In-Reply-To: <20200729134148.6855-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org, kraxel@redhat.com, b.zolnierkie@samsung.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jani.nikula@intel.com, peda@axentia.se, dan.carpenter@oracle.com, natechancellor@gmail.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The vmap_iomem function in struct drm_gem_object_funcs returns the
memory of the buffer if located in I/O memory, or NULL if it isn't.
The patch also updates the semantics of the vmap function to return
NULL if the buffer is not in system memory.

The main user is the fb-helper's console, which is prepared of this
change. The other use if the ast cursor code. It maintains two GEM
buffers in VRAM. The patch changes ast to map the buffers by calling
drm_gem_vram_vmap_iomem().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_cursor.c      |  12 ++-
 drivers/gpu/drm/drm_gem_vram_helper.c | 106 +++++++++++++++++++++++---
 include/drm/drm_gem_vram_helper.h     |   1 +
 3 files changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index acf0d23514e8..fac0079d213f 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -77,12 +77,22 @@ int ast_cursor_init(struct ast_private *ast)
 			drm_gem_vram_put(gbo);
 			goto err_drm_gem_vram_put;
 		}
-		vaddr = drm_gem_vram_vmap(gbo);
+		vaddr = drm_gem_vram_vmap_iomem(gbo);
 		if (IS_ERR(vaddr)) {
 			ret = PTR_ERR(vaddr);
 			drm_gem_vram_unpin(gbo);
 			drm_gem_vram_put(gbo);
 			goto err_drm_gem_vram_put;
+		} else if (drm_WARN_ON(dev, !vaddr)) {
+			/*
+			 * BUG: We successfully pinned the cursor to VRAM,
+			 *      but cannot get an I/O memory mapping. This
+			 *      is a bug in the VRAM helpers.
+			 */
+			ret = -ENODEV;
+			drm_gem_vram_unpin(gbo);
+			drm_gem_vram_put(gbo);
+			goto err_drm_gem_vram_put;
 		}
 
 		ast->cursor.gbo[i] = gbo;
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 3296ed3df358..d36e8ba0b5e0 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -505,8 +505,11 @@ EXPORT_SYMBOL(drm_gem_vram_kunmap);
  *                       space
  * @gbo:	The GEM VRAM object to map
  *
- * The vmap function pins a GEM VRAM object to its current location, either
- * system or video memory, and maps its buffer into kernel address space.
+ * The vmap function pins a GEM VRAM object to its current location in
+ * system memory, and maps its buffer into kernel address space. The function
+ * returns NULL if the buffer is not located in system memory. You should
+ * call drm_gem_vram_vmap_iomem() in this case.
+ *
  * As pinned object cannot be relocated, you should avoid pinning objects
  * permanently. Call drm_gem_vram_vunmap() with the returned address to
  * unmap and unpin the GEM VRAM object.
@@ -515,13 +518,15 @@ EXPORT_SYMBOL(drm_gem_vram_kunmap);
  * call drm_gem_vram_pin() and drm_gem_vram_kmap() directly.
  *
  * Returns:
- * The buffer's virtual address on success, or
+ * The buffer's virtual address on success,
+ * NULL if the buffer is located in I/O memory, or
  * an ERR_PTR()-encoded error code otherwise.
  */
 void *drm_gem_vram_vmap(struct drm_gem_vram_object *gbo)
 {
 	int ret;
 	void *base;
+	bool is_iomem;
 
 	ret = ttm_bo_reserve(&gbo->bo, true, false, NULL);
 	if (ret)
@@ -530,10 +535,18 @@ void *drm_gem_vram_vmap(struct drm_gem_vram_object *gbo)
 	ret = drm_gem_vram_pin_locked(gbo, 0);
 	if (ret)
 		goto err_ttm_bo_unreserve;
-	base = drm_gem_vram_kmap_locked(gbo, true, NULL);
+	base = drm_gem_vram_kmap_locked(gbo, true, &is_iomem);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
 		goto err_drm_gem_vram_unpin_locked;
+	} else if (is_iomem) {
+		/*
+		 * The buffer is located in I/O memory. Unpin and
+		 * return NULL. This is not an error.
+		 */
+		drm_gem_vram_kunmap_locked(gbo);
+		drm_gem_vram_unpin_locked(gbo);
+		base = NULL;
 	}
 
 	ttm_bo_unreserve(&gbo->bo);
@@ -548,6 +561,67 @@ void *drm_gem_vram_vmap(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_vmap);
 
+/**
+ * drm_gem_vram_vmap_iomem() - Pins and maps a GEM VRAM object into kernel
+ *                             address space
+ * @gbo:	The GEM VRAM object to map
+ *
+ * The vmap_iomem function pins a GEM VRAM object to its current location in
+ * I/O memory, and maps its buffer into kernel address space. The function
+ * returns NULL if the buffer is not located in I/O memory. You should call
+ * drm_gem_vram_vmap() in this case.
+ *
+ * If you have special requirements for the pinning or mapping operations,
+ * call drm_gem_vram_pin() and drm_gem_vram_kmap() directly.
+ *
+ * As pinned object cannot be relocated, you should avoid pinning objects
+ * permanently. Call drm_gem_vram_vunmap() with the returned address to
+ * unmap and unpin the GEM VRAM object.
+ *
+ * Returns:
+ * The buffer's virtual address on success, or
+ * NULL if the buffer is not located in I/O memory, or
+ * an ERR_PTR()-encoded error code otherwise.
+ */
+void __iomem *drm_gem_vram_vmap_iomem(struct drm_gem_vram_object *gbo)
+{
+	int ret;
+	void __iomem *base;
+	bool is_iomem;
+
+	ret = ttm_bo_reserve(&gbo->bo, true, false, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drm_gem_vram_pin_locked(gbo, 0);
+	if (ret)
+		goto err_ttm_bo_unreserve;
+	base = drm_gem_vram_kmap_locked(gbo, true, &is_iomem);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_drm_gem_vram_unpin_locked;
+	} else if (!is_iomem) {
+		/*
+		 * The buffer is not located in I/O memory. Unpin and
+		 * return NULL. This is not an error.
+		 */
+		drm_gem_vram_kunmap_locked(gbo);
+		drm_gem_vram_unpin_locked(gbo);
+		base = NULL;
+	}
+
+	ttm_bo_unreserve(&gbo->bo);
+
+	return base;
+
+err_drm_gem_vram_unpin_locked:
+	drm_gem_vram_unpin_locked(gbo);
+err_ttm_bo_unreserve:
+	ttm_bo_unreserve(&gbo->bo);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(drm_gem_vram_vmap_iomem);
+
 /**
  * drm_gem_vram_vunmap() - Unmaps and unpins a GEM VRAM object
  * @gbo:	The GEM VRAM object to unmap
@@ -931,6 +1005,17 @@ static void *drm_gem_vram_object_vmap(struct drm_gem_object *gem)
 	return base;
 }
 
+static void __iomem *drm_gem_vram_object_vmap_iomem(struct drm_gem_object *gem)
+{
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
+	void __iomem *base;
+
+	base = drm_gem_vram_vmap(gbo);
+	if (IS_ERR(base))
+		return NULL;
+	return base;
+}
+
 /**
  * drm_gem_vram_object_vunmap() - \
 	Implements &struct drm_gem_object_funcs.vunmap
@@ -950,12 +1035,13 @@ static void drm_gem_vram_object_vunmap(struct drm_gem_object *gem,
  */
 
 static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
-	.free	= drm_gem_vram_object_free,
-	.pin	= drm_gem_vram_object_pin,
-	.unpin	= drm_gem_vram_object_unpin,
-	.vmap	= drm_gem_vram_object_vmap,
-	.vunmap	= drm_gem_vram_object_vunmap,
-	.mmap   = drm_gem_ttm_mmap,
+	.free	    = drm_gem_vram_object_free,
+	.pin	    = drm_gem_vram_object_pin,
+	.unpin	    = drm_gem_vram_object_unpin,
+	.vmap	    = drm_gem_vram_object_vmap,
+	.vmap_iomem = drm_gem_vram_object_vmap_iomem,
+	.vunmap	    = drm_gem_vram_object_vunmap,
+	.mmap	    = drm_gem_ttm_mmap,
 	.print_info = drm_gem_ttm_print_info,
 };
 
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 035332f3723f..ea53a475edc9 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -105,6 +105,7 @@ void *drm_gem_vram_kmap(struct drm_gem_vram_object *gbo, bool map,
 			bool *is_iomem);
 void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo);
 void *drm_gem_vram_vmap(struct drm_gem_vram_object *gbo);
+void __iomem *drm_gem_vram_vmap_iomem(struct drm_gem_vram_object *gbo);
 void drm_gem_vram_vunmap(struct drm_gem_vram_object *gbo, void *vaddr);
 
 int drm_gem_vram_fill_create_dumb(struct drm_file *file,
-- 
2.27.0
