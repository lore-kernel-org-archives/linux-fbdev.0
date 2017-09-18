From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 18 Sep 2017 16:20:21 +0000
Subject: [PATCH v2 4/4] drm/fb-helper: Apply panel orientation connector prop to the primary plane
Message-Id: <20170918162021.12021-4-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170918162021.12021-1-hdegoede@redhat.com>
In-Reply-To: <20170918162021.12021-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

Apply the "panel orientation" drm connector prop to the primary plane,
so that fbcon and fbdev using userspace programs display the right way
up.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=94894
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set
---
 drivers/gpu/drm/drm_fb_helper.c | 53 +++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 1b8f013ffa65..75c409430a26 100644
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
@@ -347,6 +348,53 @@ int drm_fb_helper_debug_leave(struct fb_info *info)
 }
 EXPORT_SYMBOL(drm_fb_helper_debug_leave);
=20
+static int get_plane_rotation_from_panel_orientation(
+	struct drm_fb_helper *fb_helper, struct drm_plane *plane)
+{
+	int i, rotation =3D DRM_MODE_ROTATE_0;
+	struct drm_connector *conn;
+	uint64_t valid_mask =3D 0;
+
+	drm_fb_helper_for_each_connector(fb_helper, i) {
+		conn =3D fb_helper->connector_info[i]->connector;
+		if (conn->state->crtc && conn->state->crtc->primary =3D plane) {
+			switch (conn->display_info.panel_orientation) {
+			case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
+				rotation =3D DRM_MODE_ROTATE_180;
+				break;
+			case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
+				rotation =3D DRM_MODE_ROTATE_90;
+				break;
+			case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
+				rotation =3D DRM_MODE_ROTATE_270;
+				break;
+			}
+			break;
+		}
+	}
+
+	/*
+	 * Check the necessary rotation to compensate for the panel orientation
+	 * is supported.
+	 * Note currently we simply leave things as is when not supported, maybe
+	 * we shouls set a hint in fb_info to tell fbcon to rotate in this case
+	 * so that atleast the console ends up the right way. Maybe, but this:
+	 * a) Is not necessary for any known models with a non upright panel
+	 * b) Is tricky because fbcon rotation applies to all outputs rather
+	 *    then a single one
+	 */
+	if (!plane->rotation_property)
+		return DRM_MODE_ROTATE_0;
+
+	for (i =3D 0; i < plane->rotation_property->num_values; i++)
+		valid_mask |=3D (1ULL << plane->rotation_property->values[i]);
+
+	if (rotation & ~valid_mask)
+		return DRM_MODE_ROTATE_0;
+
+	return rotation;
+}
+
 static int restore_fbdev_mode_atomic(struct drm_fb_helper *fb_helper, bool=
 active)
 {
 	struct drm_device *dev =3D fb_helper->dev;
@@ -376,8 +424,9 @@ static int restore_fbdev_mode_atomic(struct drm_fb_help=
er *fb_helper, bool activ
 			goto out_state;
 		}
=20
-		plane_state->rotation =3D DRM_MODE_ROTATE_0;
-
+		plane_state->rotation +			get_plane_rotation_from_panel_orientation(fb_h=
elper,
+								  plane);
 		plane->old_fb =3D plane->fb;
 		plane_mask |=3D 1 << drm_plane_index(plane);
=20
--=20
2.14.1

