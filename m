From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sat, 25 Nov 2017 19:16:19 +0000
Subject: [PATCH v6 4/7] drm/fb-helper: Apply panel orientation connector prop to the primary plane, v6.
Message-Id: <20171125191622.16289-5-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125191622.16289-1-hdegoede@redhat.com>
In-Reply-To: <20171125191622.16289-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Apply the "panel orientation" drm connector prop to the primary plane so
that fbcon and fbdev using userspace programs display the right way up.

Changes in v3:
-Use a rotation member in struct drm_fb_helper_crtc and set that from
 drm_setup_crtcs instead of looping over all crtc's to find the right one
 later
-Since we now no longer look at rotation quirks directly in the fbcon
 code, set fb_info.fbcon_rotate_hint when the panel is not mounted upright
 and we cannot use hardware rotation

Changes in v4:
-Make drm_fb_helper_init() init drm_fb_helper_crtc.rotation to
 DRM_MODE_ROTATE_0 for all crtcs, so that we do not end up setting the
 plane_state's rotation to an invalid value for disabled crtcs
 (caught by Fi.CI)

Changes in v5:
-Only use hardware (crtc primary plane) rotation for DRM_ROTATE_180,
 90 / 270 degree rotation requires special handling which we lack atm
-Add a TODO comment for 90 / 270 degree hardware rotation
-Add some comments to better document the default case when mapping
 sw_rotations to fbcon_rotate_hints

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=94894
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 90 +++++++++++++++++++++++++++++++++++++=
+++-
 include/drm/drm_fb_helper.h     |  8 ++++
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 832739ff58bf..57d6bad379f8 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -41,6 +41,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
=20
+#include "drm_crtc_internal.h"
 #include "drm_crtc_helper_internal.h"
=20
 static bool drm_fbdev_emulation =3D true;
@@ -356,6 +357,7 @@ EXPORT_SYMBOL(drm_fb_helper_debug_leave);
 static int restore_fbdev_mode_atomic(struct drm_fb_helper *fb_helper, bool=
 active)
 {
 	struct drm_device *dev =3D fb_helper->dev;
+	struct drm_plane_state *plane_state;
 	struct drm_plane *plane;
 	struct drm_atomic_state *state;
 	int i, ret;
@@ -374,8 +376,6 @@ static int restore_fbdev_mode_atomic(struct drm_fb_help=
er *fb_helper, bool activ
 retry:
 	plane_mask =3D 0;
 	drm_for_each_plane(plane, dev) {
-		struct drm_plane_state *plane_state;
-
 		plane_state =3D drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
 			ret =3D PTR_ERR(plane_state);
@@ -398,6 +398,11 @@ static int restore_fbdev_mode_atomic(struct drm_fb_hel=
per *fb_helper, bool activ
=20
 	for (i =3D 0; i < fb_helper->crtc_count; i++) {
 		struct drm_mode_set *mode_set =3D &fb_helper->crtc_info[i].mode_set;
+		struct drm_plane *primary =3D mode_set->crtc->primary;
+
+		/* Cannot fail as we've already gotten the plane state above */
+		plane_state =3D drm_atomic_get_new_plane_state(state, primary);
+		plane_state->rotation =3D fb_helper->crtc_info[i].rotation;
=20
 		ret =3D __drm_atomic_helper_set_config(mode_set, state);
 		if (ret !=3D 0)
@@ -829,6 +834,7 @@ int drm_fb_helper_init(struct drm_device *dev,
 		if (!fb_helper->crtc_info[i].mode_set.connectors)
 			goto out_free;
 		fb_helper->crtc_info[i].mode_set.num_connectors =3D 0;
+		fb_helper->crtc_info[i].rotation =3D DRM_MODE_ROTATE_0;
 	}
=20
 	i =3D 0;
@@ -2353,6 +2359,62 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_h=
elper,
 	return best_score;
 }
=20
+/*
+ * This function checks if rotation is necessary because of panel orientat=
ion
+ * and if it is, if it is supported.
+ * If rotation is necessary and supported, its gets set in fb_crtc.rotatio=
n.
+ * If rotation is necessary but not supported, a DRM_MODE_ROTATE_* flag ge=
ts
+ * or-ed into fb_helper->sw_rotations. In drm_setup_crtcs_fb() we check if=
 only
+ * one bit is set and then we set fb_info.fbcon_rotate_hint to make fbcon =
do
+ * the unsupported rotation.
+ */
+static void drm_setup_crtc_rotation(struct drm_fb_helper *fb_helper,
+				    struct drm_fb_helper_crtc *fb_crtc,
+				    struct drm_connector *connector)
+{
+	struct drm_plane *plane =3D fb_crtc->mode_set.crtc->primary;
+	uint64_t valid_mask =3D 0;
+	int i, rotation;
+
+	fb_crtc->rotation =3D DRM_MODE_ROTATE_0;
+
+	switch (connector->display_info.panel_orientation) {
+	case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
+		rotation =3D DRM_MODE_ROTATE_180;
+		break;
+	case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
+		rotation =3D DRM_MODE_ROTATE_90;
+		break;
+	case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
+		rotation =3D DRM_MODE_ROTATE_270;
+		break;
+	default:
+		rotation =3D DRM_MODE_ROTATE_0;
+	}
+
+	/*
+	 * TODO: support 90 / 270 degree hardware rotation,
+	 * depending on the hardware this may require the framebuffer
+	 * to be in a specific tiling format.
+	 */
+	if (rotation !=3D DRM_MODE_ROTATE_180 || !plane->rotation_property) {
+		fb_helper->sw_rotations |=3D rotation;
+		return;
+	}
+
+	for (i =3D 0; i < plane->rotation_property->num_values; i++)
+		valid_mask |=3D (1ULL << plane->rotation_property->values[i]);
+
+	if (!(rotation & valid_mask)) {
+		fb_helper->sw_rotations |=3D rotation;
+		return;
+	}
+
+	fb_crtc->rotation =3D rotation;
+	/* Rotating in hardware, fbcon should not rotate */
+	fb_helper->sw_rotations |=3D DRM_MODE_ROTATE_0;
+}
+
 static void drm_setup_crtcs(struct drm_fb_helper *fb_helper,
 			    u32 width, u32 height)
 {
@@ -2412,6 +2474,7 @@ static void drm_setup_crtcs(struct drm_fb_helper *fb_=
helper,
 		drm_fb_helper_modeset_release(fb_helper,
 					      &fb_helper->crtc_info[i].mode_set);
=20
+	fb_helper->sw_rotations =3D 0;
 	drm_fb_helper_for_each_connector(fb_helper, i) {
 		struct drm_display_mode *mode =3D modes[i];
 		struct drm_fb_helper_crtc *fb_crtc =3D crtcs[i];
@@ -2431,6 +2494,7 @@ static void drm_setup_crtcs(struct drm_fb_helper *fb_=
helper,
 			modeset->mode =3D drm_mode_duplicate(dev,
 							   fb_crtc->desired_mode);
 			drm_connector_get(connector);
+			drm_setup_crtc_rotation(fb_helper, fb_crtc, connector);
 			modeset->connectors[modeset->num_connectors++] =3D connector;
 			modeset->x =3D offset->x;
 			modeset->y =3D offset->y;
@@ -2472,6 +2536,28 @@ static void drm_setup_crtcs_fb(struct drm_fb_helper =
*fb_helper)
 		}
 	}
 	mutex_unlock(&fb_helper->dev->mode_config.mutex);
+
+	switch (fb_helper->sw_rotations) {
+	case DRM_MODE_ROTATE_0:
+		info->fbcon_rotate_hint =3D FB_ROTATE_UR;
+		break;
+	case DRM_MODE_ROTATE_90:
+		info->fbcon_rotate_hint =3D FB_ROTATE_CCW;
+		break;
+	case DRM_MODE_ROTATE_180:
+		info->fbcon_rotate_hint =3D FB_ROTATE_UD;
+		break;
+	case DRM_MODE_ROTATE_270:
+		info->fbcon_rotate_hint =3D FB_ROTATE_CW;
+		break;
+	default:
+		/*
+		 * Multiple bits are set / multiple rotations requested
+		 * fbcon cannot handle separate rotation settings per
+		 * output, so fallback to unrotated.
+		 */
+		info->fbcon_rotate_hint =3D FB_ROTATE_UR;
+	}
 }
=20
 /* Note: Drops fb_helper->lock before returning. */
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 877e5b395c02..1494b12a984a 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -48,6 +48,7 @@ struct drm_fb_helper_crtc {
 	struct drm_mode_set mode_set;
 	struct drm_display_mode *desired_mode;
 	int x, y;
+	int rotation;
 };
=20
 /**
@@ -158,6 +159,13 @@ struct drm_fb_helper {
 	struct drm_fb_helper_crtc *crtc_info;
 	int connector_count;
 	int connector_info_alloc_count;
+	/**
+	 * @sw_rotations:
+	 * Bitmask of all rotations requested for panel-orientation which
+	 * could not be handled in hardware. If only one bit is set
+	 * fbdev->fbcon_rotate_hint gets set to the requested rotation.
+	 */
+	int sw_rotations;
 	/**
 	 * @connector_info:
 	 *
--=20
2.14.3

