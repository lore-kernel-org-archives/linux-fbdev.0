From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 09:24:03 +0000
Subject: [PATCH v3] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <20190110092403.28324-1-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eric Anholt <eric@anholt.net>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Dave Airlie <airlied@redhat.com>, David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

The following happened when migrating an old fbdev driver to DRM:

The Integrator/CP PL111 supports 16BPP but only ARGB1555/ABGR1555
or XRGB1555/XBGR1555 i.e. the maximum depth is 15.

This makes the initialization of the framebuffer fail since
the code in drm_fb_helper_single_fb_probe() assigns the same value
to sizes.surface_bpp and sizes.surface_depth. I.e. it simply assumes
a 1-to-1 mapping between BPP and depth, which is true in most cases
but not for this hardware that only support odd formats.

To support the odd case of a driver supporting 16BPP with only 15
bits of depth, this patch will make the code loop over the formats
supported on the primary plane on each CRTC managed by the FB
helper and cap the depth to the maximum supported on any primary
plane.

On the PL110 Integrator, this makes drm_mode_legacy_fb_format()
select DRM_FORMAT_XRGB1555 which is acceptable for this driver, and
thus we get framebuffer, penguin and console on the Integrator/CP.

Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebased and tested with v5.0-rc1
- Skip any formats with fmt->depth = 0
- Collected Daniels review tag.
ChangeLog v1->v2:
- Loop over the CRTCs managed by the helper and check the
  crtc->primary on each CRTC for the applicable formats and
  thus depths.
- Skip over YUV formats. The framebuffer emulation cannot
  handle these formats.

The v1 was sent some while back in february and I only recently
got back to fixing this up to support the last CLCD displays.
It was agreed that it is probably best to augment the framebuffer
initializer to pass a desired pixel format instead of just
BPP as today, but that is a bit daunting, and Daniel said that
we would probably anyways need a fallback like this.
---
 drivers/gpu/drm/drm_fb_helper.c | 53 ++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d3af098b0922..e29432e486f4 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1797,6 +1797,7 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 	int i;
 	struct drm_fb_helper_surface_size sizes;
 	int gamma_size = 0;
+	int best_depth = 0;
 
 	memset(&sizes, 0, sizeof(struct drm_fb_helper_surface_size));
 	sizes.surface_depth = 24;
@@ -1804,7 +1805,10 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 	sizes.fb_width = (u32)-1;
 	sizes.fb_height = (u32)-1;
 
-	/* if driver picks 8 or 16 by default use that for both depth/bpp */
+	/*
+	 * If driver picks 8 or 16 by default use that for both depth/bpp
+	 * to begin with
+	 */
 	if (preferred_bpp != sizes.surface_bpp)
 		sizes.surface_depth = sizes.surface_bpp = preferred_bpp;
 
@@ -1839,6 +1843,53 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 		}
 	}
 
+	/*
+	 * If we run into a situation where, for example, the primary plane
+	 * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp, depth
+	 * 16) we need to scale down the depth of the sizes we request.
+	 */
+	for (i = 0; i < fb_helper->crtc_count; i++) {
+		struct drm_mode_set *mode_set = &fb_helper->crtc_info[i].mode_set;
+		struct drm_crtc *crtc = mode_set->crtc;
+		struct drm_plane *plane = crtc->primary;
+		int j;
+
+		DRM_DEBUG("test CRTC %d primary plane\n", i);
+
+		for (j = 0; j < plane->format_count; j++) {
+			const struct drm_format_info *fmt;
+
+			fmt = drm_format_info(plane->format_types[j]);
+
+			/*
+			 * Do not consider YUV or other complicated formats
+			 * for framebuffers. This means only legacy formats
+			 * are supported (fmt->depth is a legacy field) but
+			 * the framebuffer emulation can only deal with such
+			 * formats, specifically RGB/BGA formats.
+			 */
+			if (fmt->depth = 0)
+				continue;
+
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
+		DRM_INFO("requested bpp %d, scaled depth down to %d",
+			  sizes.surface_bpp, best_depth);
+		sizes.surface_depth = best_depth;
+	}
+
 	crtc_count = 0;
 	for (i = 0; i < fb_helper->crtc_count; i++) {
 		struct drm_display_mode *desired_mode;
-- 
2.19.2
