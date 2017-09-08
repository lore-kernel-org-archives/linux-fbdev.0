From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 08 Sep 2017 11:54:43 +0000
Subject: [PATCH 2/3] drm: Add support for a panel-orientation connector property
Message-Id: <20170908115444.19122-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908115444.19122-1-hdegoede@redhat.com>
In-Reply-To: <20170908115444.19122-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

On some devices the LCD panel is mounted in the casing in such a way that
the up/top side of the panel does not match with the top side of the
device (e.g. it is mounted upside-down).

This commit adds the necessary infra for lcd-panel drm_connector-s to
have a "panel orientation" property to communicate how the panel is
orientated vs the casing.

Userspace can use this property to check for non-normal orientation and
then adjust the displayed image accordingly by rotating it to compensate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_connector.c | 92 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  4 ++
 include/drm/drm_mode_config.h   |  7 ++++
 include/uapi/drm/drm_mode.h     |  7 ++++
 4 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ba9f36cef68c..ea4cded1e328 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -665,6 +665,13 @@ static const struct drm_prop_enum_list drm_aspect_ratio_enum_list[] = {
 	{ DRM_MODE_PICTURE_ASPECT_16_9, "16:9" },
 };
 
+static const struct drm_prop_enum_list drm_panel_orientation_enum_list[] = {
+	{ DRM_MODE_PANEL_ORIENTATION_NORMAL,	"Normal"	},
+	{ DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP,	"Upside Down"	},
+	{ DRM_MODE_PANEL_ORIENTATION_LEFT_UP,	"Left Side Up"	},
+	{ DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,	"Right Side Up"	},
+};
+
 static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
 	{ DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
@@ -746,6 +753,18 @@ DRM_ENUM_NAME_FN(drm_get_tv_subconnector_name,
  *
  * CRTC_ID:
  * 	Mode object ID of the &drm_crtc this connector should be connected to.
+ *
+ * Connectors for LCD panels may also have one standardized property:
+ *
+ * panel orientation:
+ *	On some devices the LCD panel is mounted in the casing in such a way
+ *	that the up/top side of the panel does not match with the top side of
+ *	the device. Userspace can use this property to check for this.
+ *	Note that input coordinates from touchscreens (input devices with
+ *	INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
+ *	coordinates, so if userspace rotates the picture to adjust for
+ *	the orientation it must also apply the same transformation to the
+ *	touchscreen input coordinates.
  */
 
 int drm_connector_create_standard_properties(struct drm_device *dev)
@@ -1148,6 +1167,79 @@ int drm_mode_connector_set_tile_property(struct drm_connector *connector)
 EXPORT_SYMBOL(drm_mode_connector_set_tile_property);
 
 /**
+ * drm_mode_create_panel_orientation_property - create scaling mode property
+ * @dev: DRM device
+ *
+ * Called by a driver the first time it's needed, must be attached to desired
+ * connectors.
+ */
+int drm_connector_create_panel_orientation_property(struct drm_device *dev)
+{
+	struct drm_property *panel_orientation;
+
+	if (dev->mode_config.panel_orientation_property)
+		return 0;
+
+	panel_orientation +		drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+				"panel orientation",
+				drm_panel_orientation_enum_list,
+				ARRAY_SIZE(drm_panel_orientation_enum_list));
+
+	dev->mode_config.panel_orientation_property = panel_orientation;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_create_panel_orientation_property);
+
+/**
+ * drm_connector_attach_panel_orientation_property -
+ *	attach panel-orientation property
+ * @connector: connector to attach panel-orientation property on.
+ * @width: width in pixels of the panel, used for panel quirk detection
+ * @height: height in pixels of the panel, used for panel quirk detection
+ * @panel_orientation: a DRM_MODE_PANEL_ORIENTATION_* value
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_panel_orientation_property(
+	struct drm_connector *connector, int width, int height,
+	int panel_orientation)
+{
+	int orientation;
+
+	/*
+	 * Note fb_get_panel_rotate_quirk returns the rotation needed to
+	 * *correct* for the panel orientation.
+	 */
+	switch (fb_get_panel_rotate_quirk(width, height)) {
+	case FB_ROTATE_UR:
+		orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+		break;
+	case FB_ROTATE_CW:
+		orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+		break;
+	case FB_ROTATE_UD:
+		orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+		break;
+	case FB_ROTATE_CCW:
+		orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+		break;
+	default:
+		orientation = panel_orientation;
+	}
+
+	if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+		drm_object_attach_property(&connector->base,
+			connector->dev->mode_config.panel_orientation_property,
+			orientation);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_panel_orientation_property);
+
+/**
  * drm_mode_connector_update_edid_property - update the edid property of a connector
  * @connector: drm connector
  * @edid: new value of the edid property
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ea8da401c93c..42cd07ee58fb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1004,6 +1004,10 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
 int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
 int drm_mode_create_suggested_offset_properties(struct drm_device *dev);
+int drm_connector_create_panel_orientation_property(struct drm_device *dev);
+int drm_connector_attach_panel_orientation_property(
+	struct drm_connector *connector, int width, int height,
+	int panel_orientation);
 
 int drm_mode_connector_set_path_property(struct drm_connector *connector,
 					 const char *path);
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 1b37368416c8..6db187e4c747 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -741,6 +741,13 @@ struct drm_mode_config {
 	 */
 	struct drm_property *suggested_y_property;
 
+	/**
+	 * @panel_orientation_property: Optional connector property indicating
+	 * how the lcd-panel is mounted inside the casing (e.g. normal or
+	 * upside-down).
+	 */
+	struct drm_property *panel_orientation_property;
+
 	/* dumb ioctl parameters */
 	uint32_t preferred_depth, prefer_shadow;
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index a2bb7161f020..b8b9f5abae53 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -127,6 +127,13 @@ extern "C" {
 #define DRM_MODE_LINK_STATUS_GOOD	0
 #define DRM_MODE_LINK_STATUS_BAD	1
 
+/* Panel Orientation options */
+#define DRM_MODE_PANEL_ORIENTATION_UNKNOWN	-1
+#define DRM_MODE_PANEL_ORIENTATION_NORMAL	0
+#define DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP	1
+#define DRM_MODE_PANEL_ORIENTATION_LEFT_UP	2
+#define DRM_MODE_PANEL_ORIENTATION_RIGHT_UP	3
+
 /*
  * DRM_MODE_ROTATE_<degrees>
  *
-- 
2.13.4

