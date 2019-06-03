From: Uma Shankar <uma.shankar@intel.com>
Date: Mon, 03 Jun 2019 12:44:30 +0000
Subject: [v2 2/3] drm: Fix docbook warnings in hdr metadata helper structures
Message-Id: <1559567330-25182-3-git-send-email-uma.shankar@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1559567330-25182-1-git-send-email-uma.shankar@intel.com>
In-Reply-To: <1559567330-25182-1-git-send-email-uma.shankar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, jonas@kwiboo.se, Maxime Ripard <maxime.ripard@bootlin.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>, seanpaul@chromium.org

Fixes the following warnings:
./include/drm/drm_mode_config.h:841: warning: Incorrect use of
kernel-doc format:          * hdr_output_metadata_property: Connector
property containing hdr
./include/drm/drm_mode_config.h:918: warning: Function parameter or member 'hdr_output_metadata_property' not described in 'drm_mode_config'
./include/drm/drm_connector.h:1251: warning: Function parameter or member 'hdr_output_metadata' not described in 'drm_connector'
./include/drm/drm_connector.h:1251: warning: Function parameter or member 'hdr_sink_metadata' not described in 'drm_connector'

Also adds some property documentation for HDR Metadata Connector
Property in connector property create function.

v2: Fixed Sean Paul's review comments.

v3: Fixed Daniel Vetter's review comments, added the UAPI structure
definition section in kernel docs.

v4: Fixed Daniel Vetter's review comments.

Cc: Shashank Sharma <shashank.sharma@intel.com>
Cc: Ville Syrjä <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Ville Syrjä" <ville.syrjala@linux.intel.com>
Cc: Hans Verkuil <hansverk@cisco.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/drm_connector.c | 37 +++++++++++++++++++++
 include/drm/drm_connector.h     |  1 +
 include/drm/drm_mode_config.h   |  4 +--
 include/linux/hdmi.h            | 12 +++++++
 include/uapi/drm/drm_mode.h     | 74 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c9ac8b9..c445d57 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -956,6 +956,43 @@ int drm_display_info_set_bus_formats(struct drm_display_info *info,
  *	  is no longer protected and userspace should take appropriate action
  *	  (whatever that might be).
  *
+ * HDR_OUTPUT_METADATA:
+ *	Connector property to enable userspace to send HDR Metadata to
+ *	driver. This metadata is based on the composition and blending
+ *	policies decided by user, taking into account the hardware and
+ *	sink capabilities. The driver gets this metadata and creates a
+ *	Dynamic Range and Mastering Infoframe (DRM) in case of HDMI,
+ *	SDP packet (Non-audio INFOFRAME SDP v1.3) for DP. This is then
+ *	sent to sink. This notifies the sink of the upcoming frame's Color
+ *	Encoding and Luminance parameters.
+ *
+ *	Userspace first need to detect the HDR capabilities of sink by
+ *	reading and parsing the EDID. Details of HDR metadata for HDMI
+ *	are added in CTA 861.G spec. For DP , its defined in VESA DP
+ *	Standard v1.4. It needs to then get the metadata information
+ *	of the video/game/app content which are encoded in HDR (basically
+ *	using HDR transfer functions). With this information it needs to
+ *	decide on a blending policy and compose the relevant
+ *	layers/overlays into a common format. Once this blending is done,
+ *	userspace will be aware of the metadata of the composed frame to
+ *	be send to sink. It then uses this property to communicate this
+ *	metadata to driver which then make a Infoframe packet and sends
+ *	to sink based on the type of encoder connected.
+ *
+ *	Userspace will be responsible to do Tone mapping operation in case:
+ *		- Some layers are HDR and others are SDR
+ *		- HDR layers luminance is not same as sink
+ *	It will even need to do colorspace conversion and get all layers
+ *	to one common colorspace for blending. It can use either GL, Media
+ *	or display engine to get this done based on the capabilties of the
+ *	associated hardware.
+ *
+ *	Driver expects metadata to be put in &hdr_output_metadata structure
+ *	from userspace. It parses EDID and saves the sink metadata in
+ *	&hdr_sink_metadata. Driver uses &drm_hdmi_infoframe_set_hdr_metadata
+ *	helper to set the HDR metadata, &hdmi_drm_infoframe_pack to pack the
+ *	infoframe as per spec, in case of HDMI encoder.
+ *
  * max bpc:
  *	This range property is used by userspace to limit the bit depth. When
  *	used the driver would limit the bpc in accordance with the valid range
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5476561..47e749b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1244,6 +1244,7 @@ struct drm_connector {
 	 */
 	struct llist_node free_node;
 
+	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
 	struct hdr_sink_metadata hdr_sink_metadata;
 };
 
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 4f88cc9..759d462 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -837,8 +837,8 @@ struct drm_mode_config {
 	struct drm_property *writeback_out_fence_ptr_property;
 
 	/**
-	 * hdr_output_metadata_property: Connector property containing hdr
-	 * metatda. This will be provided by userspace compositors based
+	 * @hdr_output_metadata_property: Connector property containing hdr
+	 * metatada. This will be provided by userspace compositors based
 	 * on HDR content
 	 */
 	struct drm_property *hdr_output_metadata_property;
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index ee55ba5..9918a6c 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -367,8 +367,19 @@ struct hdr_static_metadata {
 	__u16 min_cll;
 };
 
+/**
+ * struct hdr_sink_metadata - HDR sink metadata
+ *
+ * Metadata Information read from Sink's EDID
+ */
 struct hdr_sink_metadata {
+	/**
+	 * @metadata_type: Static_Metadata_Descriptor_ID.
+	 */
 	__u32 metadata_type;
+	/**
+	 * @hdmi_type1: HDR Metadata Infoframe.
+	 */
 	union {
 		struct hdr_static_metadata hdmi_type1;
 	};
@@ -398,6 +409,7 @@ ssize_t hdmi_vendor_infoframe_pack_only(const struct hdmi_vendor_infoframe *fram
  * @spd: spd infoframe
  * @vendor: union of all vendor infoframes
  * @audio: audio infoframe
+ * @drm: Dynamic Range and Mastering infoframe
  *
  * This is used by the generic pack function. This works since all infoframes
  * have the same header which also indicates which type of infoframe should be
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 19b5cf3..5ab331e 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -33,6 +33,15 @@
 extern "C" {
 #endif
 
+/**
+ * DOC: overview
+ *
+ * DRM exposes many UAPI and structure definition to have a consistent
+ * and standardized interface with user.
+ * Userspace can refer to these structure definitions and UAPI formats
+ * to communicate to driver
+ */
+
 #define DRM_CONNECTOR_NAME_LEN	32
 #define DRM_DISPLAY_MODE_LEN	32
 #define DRM_PROP_NAME_LEN	32
@@ -630,24 +639,87 @@ struct drm_color_lut {
 	__u16 reserved;
 };
 
-/* HDR Metadata Infoframe as per 861.G spec */
+/**
+ * struct hdr_metadata_infoframe - HDR Metadata Infoframe Data.
+ *
+ * HDR Metadata Infoframe as per CTA 861.G spec. This is expected
+ * to match exactly with the spec.
+ *
+ * Userspace is expected to pass the metadata information as per
+ * the format described in this structure.
+ */
 struct hdr_metadata_infoframe {
+	/**
+	 * @eotf: Electro-Optical Transfer Function (EOTF)
+	 * used in the stream.
+	 */
 	__u8 eotf;
+	/**
+	 * @metadata_type: Static_Metadata_Descriptor_ID.
+	 */
 	__u8 metadata_type;
+	/**
+	 * @display_primaries: Color Primaries of the Data.
+	 * These are coded as unsigned 16-bit values in units of
+	 * 0.00002, where 0x0000 represents zero and 0xC350
+	 * represents 1.0000.
+	 * @display_primaries.x: X cordinate of color primary.
+	 * @display_primaries.y: Y cordinate of color primary.
+	 */
 	struct {
 		__u16 x, y;
 		} display_primaries[3];
+	/**
+	 * @white_point: White Point of Colorspace Data.
+	 * These are coded as unsigned 16-bit values in units of
+	 * 0.00002, where 0x0000 represents zero and 0xC350
+	 * represents 1.0000.
+	 * @white_point.x: X cordinate of whitepoint of color primary.
+	 * @white_point.y: Y cordinate of whitepoint of color primary.
+	 */
 	struct {
 		__u16 x, y;
 		} white_point;
+	/**
+	 * @max_display_mastering_luminance: Max Mastering Display Luminance.
+	 * This value is coded as an unsigned 16-bit value in units of 1 cd/m2,
+	 * where 0x0001 represents 1 cd/m2 and 0xFFFF represents 65535 cd/m2.
+	 */
 	__u16 max_display_mastering_luminance;
+	/**
+	 * @min_display_mastering_luminance: Min Mastering Display Luminance.
+	 * This value is coded as an unsigned 16-bit value in units of
+	 * 0.0001 cd/m2, where 0x0001 represents 0.0001 cd/m2 and 0xFFFF
+	 * represents 6.5535 cd/m2.
+	 */
 	__u16 min_display_mastering_luminance;
+	/**
+	 * @max_cll: Max Content Light Level.
+	 * This value is coded as an unsigned 16-bit value in units of 1 cd/m2,
+	 * where 0x0001 represents 1 cd/m2 and 0xFFFF represents 65535 cd/m2.
+	 */
 	__u16 max_cll;
+	/**
+	 * @max_fall: Max Frame Average Light Level.
+	 * This value is coded as an unsigned 16-bit value in units of 1 cd/m2,
+	 * where 0x0001 represents 1 cd/m2 and 0xFFFF represents 65535 cd/m2.
+	 */
 	__u16 max_fall;
 };
 
+/**
+ * struct hdr_output_metadata - HDR output metadata
+ *
+ * Metadata Information to be passed from userspace
+ */
 struct hdr_output_metadata {
+	/**
+	 * @metadata_type: Static_Metadata_Descriptor_ID.
+	 */
 	__u32 metadata_type;
+	/**
+	 * @hdmi_metadata_type1: HDR Metadata Infoframe.
+	 */
 	union {
 		struct hdr_metadata_infoframe hdmi_metadata_type1;
 	};
-- 
1.9.1
