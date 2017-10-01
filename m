From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sun, 01 Oct 2017 15:33:16 +0000
Subject: [PATCH v2 3/4] drm/i915: Add "panel orientation" property to the panel connector
Message-Id: <20171001153317.2343-4-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171001153317.2343-1-hdegoede@redhat.com>
In-Reply-To: <20171001153317.2343-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

Ideally we could use the VBT for this, that would be simple, in
intel_dsi_init() check dev_priv->vbt.dsi.config->rotation, set
connector->display_info.panel_orientation accordingly and call
drm_connector_init_panel_orientation_property(), done.

Unfortunately vbt.dsi.config->rotation is always 0 even on tablets
with an upside down LCD and where the GOP is properly rotating the
EFI fb in hardware.

So instead we end up reading the rotation from the primary plane,
which is a bit more complicated.

The code to read back the rotation from the hardware is based on an
earlier attempt to fix fdo#94894 by Ville Syrjala.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=94894
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rebased on 4.14-rc1
-Readback primary plane rotation from the hardware and use that to
 set the panel orientation
-This (readback) fixes fdo#94894, add Fixes: tag
---
 drivers/gpu/drm/i915/i915_drv.h      |  3 +++
 drivers/gpu/drm/i915/intel_display.c | 39 ++++++++++++++++++++++++++++++++=
+++-
 drivers/gpu/drm/i915/intel_drv.h     |  5 +++++
 drivers/gpu/drm/i915/intel_panel.c   | 33 ++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_dr=
v.h
index 18d9da53282b..c4c8590972b4 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2151,6 +2151,8 @@ struct intel_cdclk_state {
 	unsigned int cdclk, vco, ref;
 };
=20
+struct intel_panel;
+
 struct drm_i915_private {
 	struct drm_device drm;
=20
@@ -2200,6 +2202,7 @@ struct drm_i915_private {
 	struct i915_gem_context *kernel_context;
 	struct intel_engine_cs *engine[I915_NUM_ENGINES];
 	struct i915_vma *semaphore;
+	struct intel_panel *panel;
=20
 	struct drm_dma_handle *status_page_dmah;
 	struct resource mch_res;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/in=
tel_display.c
index 00cd17c76fdc..fbd61f92b60d 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2891,6 +2891,9 @@ intel_find_initial_plane_obj(struct intel_crtc *intel=
_crtc,
 		return;
 	}
=20
+	intel_panel_set_orientation_from_crtc(dev_priv->panel, intel_crtc,
+					      plane_config->panel_orientation);
+
 	plane_state->src_x =3D 0;
 	plane_state->src_y =3D 0;
 	plane_state->src_w =3D fb->width << 16;
@@ -7523,6 +7526,10 @@ i9xx_get_initial_plane_config(struct intel_crtc *crt=
c,
 			plane_config->tiling =3D I915_TILING_X;
 			fb->modifier =3D I915_FORMAT_MOD_X_TILED;
 		}
+
+		if (val & DISPPLANE_ROTATE_180)
+			plane_config->panel_orientation +				DRM_MODE_PANEL_ORIENTATION_BOTTOM_=
UP;
 	}
=20
 	pixel_format =3D val & DISPPLANE_PIXFORMAT_MASK;
@@ -8576,6 +8583,24 @@ skylake_get_initial_plane_config(struct intel_crtc *=
crtc,
 		goto error;
 	}
=20
+	/* The rotation is used to *correct* for the panel orientation */
+	switch (val & PLANE_CTL_ROTATE_MASK) {
+	case PLANE_CTL_ROTATE_0:
+		break;
+	case PLANE_CTL_ROTATE_90:
+		plane_config->panel_orientation +			DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+		break;
+	case PLANE_CTL_ROTATE_180:
+		plane_config->panel_orientation +			DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+		break;
+	case PLANE_CTL_ROTATE_270:
+		plane_config->panel_orientation +			DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+		break;
+	}
+
 	base =3D I915_READ(PLANE_SURF(pipe, 0)) & 0xfffff000;
 	plane_config->base =3D base;
=20
@@ -8661,6 +8686,10 @@ ironlake_get_initial_plane_config(struct intel_crtc =
*crtc,
 			plane_config->tiling =3D I915_TILING_X;
 			fb->modifier =3D I915_FORMAT_MOD_X_TILED;
 		}
+
+		if (val & DISPPLANE_ROTATE_180)
+			plane_config->panel_orientation +				DRM_MODE_PANEL_ORIENTATION_BOTTOM_=
UP;
 	}
=20
 	pixel_format =3D val & DISPPLANE_PIXFORMAT_MASK;
@@ -14578,7 +14607,9 @@ int intel_modeset_init(struct drm_device *dev)
 	drm_modeset_unlock_all(dev);
=20
 	for_each_intel_crtc(dev, crtc) {
-		struct intel_initial_plane_config plane_config =3D {};
+		struct intel_initial_plane_config plane_config =3D {
+			.panel_orientation =3D DRM_MODE_PANEL_ORIENTATION_NORMAL,
+		};
=20
 		if (!crtc->active)
 			continue;
@@ -14600,6 +14631,12 @@ int intel_modeset_init(struct drm_device *dev)
 		intel_find_initial_plane_obj(crtc, &plane_config);
 	}
=20
+	/*
+	 * Init panel orientation prop now that intel_find_initial_plane_obj()
+	 * has had a chance to set panel orientation.
+	 */
+	intel_panel_init_orientation_prop(dev_priv->panel);
+
 	/*
 	 * Make sure hardware watermarks really match the state we read out.
 	 * Note that we need to do this after reconstructing the BIOS fb's
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_=
drv.h
index fa47285918f4..50fa0eeca655 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -447,6 +447,7 @@ struct intel_initial_plane_config {
 	unsigned int tiling;
 	int size;
 	u32 base;
+	int panel_orientation; /* DRM_MODE_PANEL_ORIENTATION_* */
 };
=20
 #define SKL_MIN_SRC_W 8
@@ -1703,6 +1704,10 @@ extern struct drm_display_mode *intel_find_panel_dow=
nclock(
 				struct drm_i915_private *dev_priv,
 				struct drm_display_mode *fixed_mode,
 				struct drm_connector *connector);
+void intel_panel_set_orientation_from_crtc(struct intel_panel *panel,
+					   struct intel_crtc *intel_crtc,
+					   int orientation);
+void intel_panel_init_orientation_prop(struct intel_panel *panel);
=20
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 int intel_backlight_device_register(struct intel_connector *connector);
diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/inte=
l_panel.c
index 0f7942a5dccf..fa7dfb9ac5f0 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -1925,11 +1925,44 @@ intel_panel_init_backlight_funcs(struct intel_panel=
 *panel)
 	}
 }
=20
+void intel_panel_set_orientation_from_crtc(struct intel_panel *panel,
+					   struct intel_crtc *intel_crtc,
+					   int orientation)
+{
+	struct intel_connector *panel_conn;
+
+	if (!panel)
+		return;
+
+	panel_conn =3D container_of(panel, struct intel_connector, panel);
+	if (panel_conn->base.state->crtc =3D &intel_crtc->base)
+		panel_conn->base.display_info.panel_orientation =3D orientation;
+}
+
+void intel_panel_init_orientation_prop(struct intel_panel *panel)
+{
+	struct intel_connector *panel_conn;
+
+	if (!panel || !panel->fixed_mode)
+		return;
+
+	panel_conn =3D container_of(panel, struct intel_connector, panel);
+	drm_connector_init_panel_orientation_property(&panel_conn->base,
+		panel->fixed_mode->hdisplay, panel->fixed_mode->vdisplay);
+}
+
 int intel_panel_init(struct intel_panel *panel,
 		     struct drm_display_mode *fixed_mode,
 		     struct drm_display_mode *alt_fixed_mode,
 		     struct drm_display_mode *downclock_mode)
 {
+	struct intel_connector *intel_connector +		container_of(panel, struct int=
el_connector, panel);
+	struct drm_i915_private *dev_priv =3D to_i915(intel_connector->base.dev);
+
+	if (!dev_priv->panel)
+		dev_priv->panel =3D panel;
+
 	intel_panel_init_backlight_funcs(panel);
=20
 	panel->fixed_mode =3D fixed_mode;
--=20
2.14.2

