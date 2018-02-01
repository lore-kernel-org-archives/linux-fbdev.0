From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 01 Feb 2018 13:04:46 +0000
Subject: [PATCH] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <20180201130446.6165-1-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eric Anholt <eric@anholt.net>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Dave Airlie <airlied@redhat.com>, David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

The following happened when migrating an old fbdev driver to DRM:

The Integrator/CP PL111 supports 16BPP but only ARGB1555/ABGR1555
or XRGB1555/XBGR1555 i.e. the maximum depth is 15.

This makes the initialization of the framebuffer fail since
the code in drm_fb_helper_single_fb_probe() assigns the same value
to sizes.surface_bpp and sizes.surface_depth. I.e. it simply assumes
a 1-to-1 mapping between BPP and depth, which is true in most cases
but typically not for this hardware.

To support the odd case of a driver supporting 16BPP with only 15
bits of depth, this patch will make the code loop over the formats
supported on the primary plane and cap the depth to the maximum
supported.

On the PL110 Integrator, this makes drm_mode_legacy_fb_format()
select DRM_FORMAT_XRGB1555 which is acceptable for this driver, and
thus we get framebuffer, penguin and console on the Integrator/CP.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e56166334455..5076f9103740 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1720,6 +1720,8 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 	int i;
 	struct drm_fb_helper_surface_size sizes;
 	int gamma_size = 0;
+	struct drm_plane *plane;
+	int best_depth = 0;
 
 	memset(&sizes, 0, sizeof(struct drm_fb_helper_surface_size));
 	sizes.surface_depth = 24;
@@ -1727,7 +1729,10 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 	sizes.fb_width = (u32)-1;
 	sizes.fb_height = (u32)-1;
 
-	/* if driver picks 8 or 16 by default use that for both depth/bpp */
+	/*
+	 * If driver picks 8 or 16 by default use that for both depth/bpp
+	 * to begin with
+	 */
 	if (preferred_bpp != sizes.surface_bpp)
 		sizes.surface_depth = sizes.surface_bpp = preferred_bpp;
 
@@ -1762,6 +1767,39 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 		}
 	}
 
+	/*
+	 * If we run into a situation where, for example, the primary plane
+	 * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp, depth
+	 * 16) we need to scale down the depth of the sizes we request.
+	 */
+	drm_for_each_plane(plane, fb_helper->dev) {
+		/* Only check the primary plane */
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
+		for (i = 0; i < plane->format_count; i++) {
+			const struct drm_format_info *fmt;
+
+			fmt = drm_format_info(plane->format_types[i]);
+			/* We found a perfect fit, great */
+			if (fmt->depth = sizes.surface_depth)
+				break;
+
+			/* Skip depths above what we're looking for */
+			if (fmt->depth > sizes.surface_depth)
+				continue;
+
+			/* Best depth found so far */
+			if (fmt->depth > best_depth)
+				best_depth = fmt->depth;
+		}
+	}
+	if (sizes.surface_depth != best_depth) {
+		DRM_DEBUG("requested bpp %d, scaled depth down to %d",
+			  sizes.surface_bpp, best_depth);
+		sizes.surface_depth = best_depth;
+	}
+
 	crtc_count = 0;
 	for (i = 0; i < fb_helper->crtc_count; i++) {
 		struct drm_display_mode *desired_mode;
-- 
2.14.3

