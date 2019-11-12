From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 12 Nov 2019 14:04:29 +0000
Subject: [PATCH v3 3/5] drm/udl: Remove udl implementation of GEM's free_object()
Message-Id: <20191112140431.7895-4-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191112140431.7895-1-tzimmermann@suse.de>
In-Reply-To: <20191112140431.7895-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Udl used to have a custom implementation for free_object() of
struct drm_gem_object_funcs. It unmapped the memory buffer of
the fbdev emulation. With the switch to generic fbdev emulation,
this is now handled by the fbdev code internally.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_gem.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
index 6eade6b4b0dc..b6e26f98aa0a 100644
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -17,22 +17,6 @@
  * GEM object funcs
  */
 
-static void udl_gem_object_free_object(struct drm_gem_object *obj)
-{
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-
-	/* Fbdev emulation vmaps the buffer. Unmap it here for consistency
-	 * with the original udl GEM code.
-	 *
-	 * TODO: Switch to generic fbdev emulation and release the
-	 *       GEM object with drm_gem_shmem_free_object().
-	 */
-	if (shmem->vaddr)
-		drm_gem_shmem_vunmap(obj, shmem->vaddr);
-
-	drm_gem_shmem_free_object(obj);
-}
-
 static int udl_gem_object_mmap(struct drm_gem_object *obj,
 			       struct vm_area_struct *vma)
 {
@@ -91,7 +75,7 @@ static void *udl_gem_object_vmap(struct drm_gem_object *obj)
 }
 
 static const struct drm_gem_object_funcs udl_gem_object_funcs = {
-	.free = udl_gem_object_free_object,
+	.free = drm_gem_shmem_free_object,
 	.print_info = drm_gem_shmem_print_info,
 	.pin = drm_gem_shmem_pin,
 	.unpin = drm_gem_shmem_unpin,
-- 
2.23.0
