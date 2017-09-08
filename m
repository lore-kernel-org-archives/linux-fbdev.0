From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 08 Sep 2017 11:54:44 +0000
Subject: [PATCH 3/3] drm/i915: Add "panel orientation" property to the panel connector
Message-Id: <20170908115444.19122-4-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908115444.19122-1-hdegoede@redhat.com>
In-Reply-To: <20170908115444.19122-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

For now this is always set to DRM_MODE_PANEL_ORIENTATION_UNKNOWN
unless there is a dmi based quirk overriding the value.

In the future we should probably provide an initial value based on
the VBT (at least for some panel types).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/intel_panel.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index 72f8cbb237b1..4a52c9d5790a 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -1926,6 +1926,22 @@ int intel_panel_init(struct intel_panel *panel,
 		     struct drm_display_mode *alt_fixed_mode,
 		     struct drm_display_mode *downclock_mode)
 {
+	struct intel_connector *intel_connector +		container_of(panel, struct intel_connector, panel);
+	int ret;
+
+	if (fixed_mode) {
+		ret = drm_connector_create_panel_orientation_property(
+						intel_connector->base.dev);
+		if (ret)
+			return ret;
+
+		drm_connector_attach_panel_orientation_property(
+				&intel_connector->base,
+				fixed_mode->hdisplay, fixed_mode->vdisplay,
+				DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+	}
+
 	intel_panel_init_backlight_funcs(panel);
 
 	panel->fixed_mode = fixed_mode;
-- 
2.13.4

