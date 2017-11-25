From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sat, 25 Nov 2017 19:16:20 +0000
Subject: [PATCH v6 5/7] drm/i915: Add "panel orientation" property to the panel connector, v6.
Message-Id: <20171125191622.16289-6-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125191622.16289-1-hdegoede@redhat.com>
In-Reply-To: <20171125191622.16289-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Ideally we could use the VBT for this, that would be simple, in
intel_dsi_init() check dev_priv->vbt.dsi.config->rotation, set
connector->display_info.panel_orientation accordingly and call
drm_connector_init_panel_orientation_property(), done.

Unfortunately vbt.dsi.config->rotation is always 0 even on tablets
with an upside down LCD and where the GOP is properly rotating the
EFI fb in hardware.

So instead we end up reading the rotation from the primary plane.

This commit only implements the panel orientation property for DSI
panels on BYT / CHT hardware, as all known non normal oriented panels
sofar are only found on this hardware.

Changes in v2:
-Read back the rotation applied by the GOP from the primary plane
 instead of relying on dev_priv->vbt.dsi.config->rotation, because it
 seems that the VBT rotation filed is always 0 even on devices where the
 GOP does apply a rotation

Changes in v3:
-Rewrite the code to read back the orientation from the primary
 plane to contain all of this in intel_dsi.c instead of poking a bunch
 of holes between all the different layers

Changes in v6:
-Move hardware readout to intel_dsi_init()

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/intel_dsi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i915/intel_dsi.c
index f09474b0c4d3..f67d321376e4 100644
--- a/drivers/gpu/drm/i915/intel_dsi.c
+++ b/drivers/gpu/drm/i915/intel_dsi.c
@@ -1666,6 +1666,27 @@ static const struct drm_connector_funcs intel_dsi_connector_funcs = {
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
 };
 
+static int intel_dsi_get_panel_orientation(struct intel_connector *connector)
+{
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
+	int orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+	enum i9xx_plane_id plane;
+	u32 val;
+
+	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
+		if (connector->encoder->crtc_mask = BIT(PIPE_B))
+			plane = PLANE_B;
+		else
+			plane = PLANE_A;
+
+		val = I915_READ(DSPCNTR(plane));
+		if (val & DISPPLANE_ROTATE_180)
+			orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+	}
+
+	return orientation;
+}
+
 static void intel_dsi_add_properties(struct intel_connector *connector)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
@@ -1681,6 +1702,13 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 								allowed_scalers);
 
 		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
+
+		connector->base.display_info.panel_orientation +			intel_dsi_get_panel_orientation(connector);
+		drm_connector_init_panel_orientation_property(
+				&connector->base,
+				connector->panel.fixed_mode->hdisplay,
+				connector->panel.fixed_mode->vdisplay);
 	}
 }
 
-- 
2.14.3

