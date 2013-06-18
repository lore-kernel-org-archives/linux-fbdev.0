From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Tue, 18 Jun 2013 15:18:43 +0000
Subject: [PATCH v2 2/2] i915: i915_gem: Print a size_t with %z
Message-Id: <1371568723-27486-2-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371568723-27486-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371568723-27486-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, geert@linux-m68k.org, Dave Airlie <airlied@redhat.com>, festevam@gmail.com

Fix the following build warning:

drivers/gpu/drm/i915/i915_gem.c:3129:3: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' [-Wformat]

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: <intel-gfx@lists.freedesktop.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use %zu instead of %zd, since size_t is unsigned

 drivers/gpu/drm/i915/i915_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 6e469e6..d497ca5 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -3126,7 +3126,7 @@ i915_gem_object_bind_to_gtt(struct drm_i915_gem_object *obj,
 	 * before evicting everything in a vain attempt to find space.
 	 */
 	if (obj->base.size > gtt_max) {
-		DRM_ERROR("Attempting to bind an object larger than the aperture: object=%zd > %s aperture=%ld\n",
+		DRM_ERROR("Attempting to bind an object larger than the aperture: object=%zd > %s aperture=%zu\n",
 			  obj->base.size,
 			  map_and_fenceable ? "mappable" : "total",
 			  gtt_max);
-- 
1.8.1.2


