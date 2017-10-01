From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sun, 01 Oct 2017 15:33:15 +0000
Subject: [PATCH v2 2/4] drm: Add support for a panel-orientation connector property
Message-Id: <20171001153317.2343-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171001153317.2343-1-hdegoede@redhat.com>
In-Reply-To: <20171001153317.2343-1-hdegoede@redhat.com>
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
Changes in v2:
-Rebased on 4.14-rc1
-Store panel_orientation in drm_display_info, so that drm_fb_helper.c can
 access it easily
-Have a single drm_connector_init_panel_orientation_property rather then
 create and attach functions. The caller is expected to set
 drm_display_info.panel_orientation before calling this, then this will
 check for platform specific quirks overriding the panel_orientation and if
 the panel_orientation is set after this then it will attach the property.
---
 drivers/gpu/drm/drm_connector.c | 86 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     | 11 ++++++
 include/drm/drm_mode_config.h   |  7 ++++
 include/uapi/drm/drm_mode.h     |  7 ++++
 4 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ba9f36cef68c..0159800b30a7 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -212,6 +212,8 @@ int drm_connector_init(struct drm_device *dev,
 	mutex_init(&connector->mutex);
 	connector->edid_blob_ptr = NULL;
 	connector->status = connector_status_unknown;
+	connector->display_info.panel_orientation +		DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
 
 	drm_connector_get_cmdline_mode(connector);
 
@@ -665,6 +667,13 @@ static const struct drm_prop_enum_list drm_aspect_ratio_enum_list[] = {
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
@@ -746,6 +755,18 @@ DRM_ENUM_NAME_FN(drm_get_tv_subconnector_name,
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
@@ -1212,6 +1233,71 @@ void drm_mode_connector_set_link_status_property(struct drm_connector *connector
 }
 EXPORT_SYMBOL(drm_mode_connector_set_link_status_property);
 
+/**
+ * drm_connector_init_panel_orientation_property -
+ *	initialize the connecters panel_orientation property
+ * @connector: connector for which to init the panel-orientation property.
+ * @width: width in pixels of the panel, used for panel quirk detection
+ * @height: height in pixels of the panel, used for panel quirk detection
+ *
+ * This function should only be called for built-in panels, after setting
+ * connector->display_info.panel_orientation first (if known).
+ *
+ * This function will check for platform specific (e.g. DMI based) quirks
+ * overriding display_info.panel_orientation first, then if panel_orientation
+ * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
+ * "panel orientation" property to the connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_init_panel_orientation_property(
+	struct drm_connector *connector, int width, int height)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_property *prop;
+
+	/*
+	 * Note fb_get_panel_rotate_quirk returns the rotation needed to
+	 * *correct* for the panel orientation.
+	 */
+	switch (fb_get_panel_rotate_quirk(width, height)) {
+	case FB_ROTATE_UR:
+		info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+		break;
+	case FB_ROTATE_CW:
+		info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+		break;
+	case FB_ROTATE_UD:
+		info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+		break;
+	case FB_ROTATE_CCW:
+		info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+		break;
+	}
+
+	if (info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+		return 0;
+
+	prop = dev->mode_config.panel_orientation_property;
+	if (!prop) {
+		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+				"panel orientation",
+				drm_panel_orientation_enum_list,
+				ARRAY_SIZE(drm_panel_orientation_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		dev->mode_config.panel_orientation_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop,
+				   info->panel_orientation);
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
+
 int drm_mode_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ea8da401c93c..04592f9daa46 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -222,6 +222,15 @@ struct drm_display_info {
 #define DRM_COLOR_FORMAT_YCRCB422	(1<<2)
 #define DRM_COLOR_FORMAT_YCRCB420	(1<<3)
 
+	/**
+	 * @panel_orientation: Read only connector property for built-in panels,
+	 * indicating the orientation of the panel vs the device's casing.
+	 * drm_connector_init() sets this to DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
+	 * When not UNKNOWN this gets used by the drm_fb_helpers to rotate the
+	 * fb to compensate and gets exported as prop to userspace.
+	 */
+	int panel_orientation;
+
 	/**
 	 * @color_formats: HDMI Color formats, selects between RGB and YCrCb
 	 * modes. Used DRM_COLOR_FORMAT\_ defines, which are _not_ the same ones
@@ -1012,6 +1021,8 @@ int drm_mode_connector_update_edid_property(struct drm_connector *connector,
 					    const struct edid *edid);
 void drm_mode_connector_set_link_status_property(struct drm_connector *connector,
 						 uint64_t link_status);
+int drm_connector_init_panel_orientation_property(
+	struct drm_connector *connector, int width, int height);
 
 /**
  * struct drm_tile_group - Tile group metadata
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
index 54fc38c3c3f1..1a5dae7ba01c 100644
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
2.14.2

