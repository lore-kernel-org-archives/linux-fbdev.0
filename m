From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Mon, 23 Oct 2017 09:25:00 +0000
Subject: [PATCH v4 5/7] drm/i915: Add "panel orientation" property to the panel connector
Message-Id: <20171023092502.1095-6-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023092502.1095-1-hdegoede@redhat.com>
In-Reply-To: <20171023092502.1095-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

Ideally we could use the VBT for this, that would be simple, in
intel_dsi_init() check dev_priv->vbt.dsi.config->rotation, set
connector->display_info.panel_orientation accordingly and call
drm_connector_init_panel_orientation_property(), done.

Unfortunately vbt.dsi.config->rotation is always 0 even on tablets
with an upside down LCD and where the GOP is properly rotating the
EFI fb in hardware.

So instead we end up reading the rotation from the primary plane.
To read the info from the primary plane, we need to know which crtc
the panel is hooked up to, so we do this the first time the panel
encoder's get_config function get called, as by then the encoder
crtc routing has been set up.

This commit only implements the panel orientation property for DSI
panels on BYT / CHT / BXT hardware, as all known non normal oriented
panels are only found on this hardware.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Read back the rotation applied by the GOP from the primary plane
 instead of relying on dev_priv->vbt.dsi.config->rotation, because it
 seems that the VBT rotation filed is always 0 even on devices where the
 GOP does apply a rotation

Changes in v3:
-Rewrite the code to read back the orientation from the primary
 plane to contain all of this in intel_dsi.c instead of poking a bunch
 of holes between all the different layers
---
 drivers/gpu/drm/i915/intel_drv.h   |  1 +
 drivers/gpu/drm/i915/intel_dsi.c   | 48 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_dsi.h   |  2 ++
 drivers/gpu/drm/i915/intel_panel.c | 16 +++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 47d022d48718..11efc6cb74c8 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1727,6 +1727,7 @@ void intel_panel_enable_backlight(const struct intel_crtc_state *crtc_state,
 				  const struct drm_connector_state *conn_state);
 void intel_panel_disable_backlight(const struct drm_connector_state *old_conn_state);
 void intel_panel_destroy_backlight(struct drm_connector *connector);
+void intel_panel_set_orientation(struct intel_panel *panel, int orientation);
 enum drm_connector_status intel_panel_detect(struct drm_i915_private *dev_priv);
 extern struct drm_display_mode *intel_find_panel_downclock(
 				struct drm_i915_private *dev_priv,
diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i915/intel_dsi.c
index 83f15848098a..3e2f12db8d15 100644
--- a/drivers/gpu/drm/i915/intel_dsi.c
+++ b/drivers/gpu/drm/i915/intel_dsi.c
@@ -1084,13 +1084,16 @@ static void bxt_dsi_get_pipe_config(struct intel_encoder *encoder,
 	struct drm_display_mode *adjusted_mode_sw;
 	struct intel_crtc *intel_crtc;
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(&encoder->base);
+	struct intel_panel *panel = &intel_dsi->attached_connector->panel;
 	unsigned int lane_count = intel_dsi->lane_count;
 	unsigned int bpp, fmt;
+	int orientation;
 	enum port port;
 	u16 hactive, hfp, hsync, hbp, vfp, vsync, vbp;
 	u16 hfp_sw, hsync_sw, hbp_sw;
 	u16 crtc_htotal_sw, crtc_hsync_start_sw, crtc_hsync_end_sw,
 				crtc_hblank_start_sw, crtc_hblank_end_sw;
+	u32 val;
 
 	/* FIXME: hw readout should not depend on SW state */
 	intel_crtc = to_intel_crtc(encoder->base.crtc);
@@ -1234,6 +1237,49 @@ static void bxt_dsi_get_pipe_config(struct intel_encoder *encoder,
 	if (adjusted_mode->crtc_hblank_end = crtc_hblank_end_sw)
 		adjusted_mode->crtc_hblank_end  					adjusted_mode_sw->crtc_hblank_end;
+
+	if (!intel_dsi->got_panel_orientation) {
+		val = I915_READ(PLANE_CTL(intel_crtc->pipe, 0));
+		/* The rotation is used to correct for the panel orientation */
+		switch (val & PLANE_CTL_ROTATE_MASK) {
+		case PLANE_CTL_ROTATE_0:
+			orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+			break;
+		case PLANE_CTL_ROTATE_90:
+			orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+			break;
+		case PLANE_CTL_ROTATE_180:
+			orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+			break;
+		case PLANE_CTL_ROTATE_270:
+			orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+			break;
+		}
+		intel_panel_set_orientation(panel, orientation);
+		intel_dsi->got_panel_orientation = true;
+	}
+}
+
+static void vlv_dsi_get_pipe_config(struct intel_encoder *encoder)
+{
+	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_crtc *intel_crtc = to_intel_crtc(encoder->base.crtc);
+	struct intel_dsi *intel_dsi = enc_to_intel_dsi(&encoder->base);
+	struct intel_panel *panel = &intel_dsi->attached_connector->panel;
+	int orientation;
+	u32 val;
+
+	if (!intel_dsi->got_panel_orientation) {
+		val = I915_READ(DSPCNTR(intel_crtc->plane));
+
+		if (val & DISPPLANE_ROTATE_180)
+			orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+		else
+			orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+
+		intel_panel_set_orientation(panel, orientation);
+		intel_dsi->got_panel_orientation = true;
+	}
 }
 
 static void intel_dsi_get_config(struct intel_encoder *encoder,
@@ -1245,6 +1291,8 @@ static void intel_dsi_get_config(struct intel_encoder *encoder,
 
 	if (IS_GEN9_LP(dev_priv))
 		bxt_dsi_get_pipe_config(encoder, pipe_config);
+	else if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
+		vlv_dsi_get_pipe_config(encoder);
 
 	pclk = intel_dsi_get_pclk(encoder, pipe_config->pipe_bpp,
 				  pipe_config);
diff --git a/drivers/gpu/drm/i915/intel_dsi.h b/drivers/gpu/drm/i915/intel_dsi.h
index 7afeb9580f41..92c2fe31f3fd 100644
--- a/drivers/gpu/drm/i915/intel_dsi.h
+++ b/drivers/gpu/drm/i915/intel_dsi.h
@@ -52,6 +52,8 @@ struct intel_dsi {
 	/* if true, use HS mode, otherwise LP */
 	bool hs;
 
+	bool got_panel_orientation;
+
 	/* virtual channel */
 	int channel;
 
diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index 37e6211c1f25..536e40a892cb 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -1845,6 +1845,22 @@ void intel_panel_destroy_backlight(struct drm_connector *connector)
 	panel->backlight.present = false;
 }
 
+void intel_panel_set_orientation(struct intel_panel *panel, int orientation)
+{
+	struct intel_connector *panel_conn;
+	int width = 0, height = 0;
+
+	if (panel->fixed_mode) {
+		width = panel->fixed_mode->hdisplay;
+		height = panel->fixed_mode->vdisplay;
+	}
+
+	panel_conn = container_of(panel, struct intel_connector, panel);
+	panel_conn->base.display_info.panel_orientation = orientation;
+	drm_connector_init_panel_orientation_property(&panel_conn->base,
+						      width, height);
+}
+
 /* Set up chip specific backlight functions */
 static void
 intel_panel_init_backlight_funcs(struct intel_panel *panel)
-- 
2.14.2

