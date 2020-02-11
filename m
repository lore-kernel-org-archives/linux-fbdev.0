From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Tue, 11 Feb 2020 07:46:43 +0000
Subject: [PATCH v7 04/18] drm/i915/dp: Add writing of DP SDPs
Message-Id: <20200211074657.231405-5-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200211074657.231405-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200211074657.231405-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

It adds routines that write DP VSC SDP and DP HDR Metadata Infoframe SDP.
In order to pack DP VSC SDP, it adds intel_dp_vsc_sdp_pack() function.
It follows DP 1.4a spec. [Table 2-116: VSC SDP Header Bytes] and
[Table 2-117: VSC SDP Payload for DB16 through DB18]

In order to pack DP HDR Metadata Infoframe SDP, it adds
intel_dp_hdr_metadata_infoframe_sdp_pack() function.
And it follows DP 1.4a spec.
([Table 2-125: INFOFRAME SDP v1.2 Header Bytes] and
[Table 2-126: INFOFRAME SDP v1.2 Payload Data Bytes - DB0 through DB31])
and CTA-861-G spec. [Table-42 Dynamic Range and Mastering InfoFrame].

A mechanism and a naming rule of intel_dp_set_infoframes() function
references intel_encoder->set_infoframes() of intel_hdmi.c .
VSC SDP is used for PSR and Pixel Encoding and Colorimetry Formats cases.
Because PSR routine has its own routine of writing a VSC SDP, when the PSR
is enabled, intel_dp_set_infoframes() does not write a VSC SDP.

v3:
  - Explicitly disable unused DIPs (AVI, GCP, VS, SPD, DRM. They will be
    used for HDMI), when intel_dp_set_infoframes() function will be called.
  - Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp.
v4: Use struct drm_device logging macros
v5:
  - use intel_de_*() functions for register access
  - Addressed review comments from Uma
    Polish commit message and comments
    Add 6bpc to packing of VSC SDP

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 199 ++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.h |   3 +
 2 files changed, 202 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index fb008168ca83..5bbc55113325 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4741,6 +4741,205 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_stat=
e *crtc_state,
 	return false;
 }
=20
+static ssize_t intel_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
+				     struct dp_sdp *sdp, size_t size)
+{
+	size_t length =3D sizeof(struct dp_sdp);
+
+	if (size < length)
+		return -ENOSPC;
+
+	memset(sdp, 0, size);
+
+	/*
+	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
+	 * VSC SDP Header Bytes
+	 */
+	sdp->sdp_header.HB0 =3D 0; /* Secondary-Data Packet ID =3D 0 */
+	sdp->sdp_header.HB1 =3D vsc->sdp_type; /* Secondary-data Packet Type */
+	sdp->sdp_header.HB2 =3D vsc->revision; /* Revision Number */
+	sdp->sdp_header.HB3 =3D vsc->length; /* Number of Valid Data Bytes */
+
+	/* VSC SDP Payload for DB16 through DB18 */
+	/* Pixel Encoding and Colorimetry Formats  */
+	sdp->db[16] =3D (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
+	sdp->db[16] |=3D vsc->colorimetry & 0xf; /* DB16[3:0] */
+
+	switch (vsc->bpc) {
+	case 6:
+		/* 6bpc: 0x0 */
+		break;
+	case 8:
+		sdp->db[17] =3D 0x1; /* DB17[3:0] */
+		break;
+	case 10:
+		sdp->db[17] =3D 0x2;
+		break;
+	case 12:
+		sdp->db[17] =3D 0x3;
+		break;
+	case 16:
+		sdp->db[17] =3D 0x4;
+		break;
+	default:
+		MISSING_CASE(vsc->bpc);
+		break;
+	}
+	/* Dynamic Range and Component Bit Depth */
+	if (vsc->dynamic_range =3D DP_DYNAMIC_RANGE_CTA)
+		sdp->db[17] |=3D 0x80;  /* DB17[7] */
+
+	/* Content Type */
+	sdp->db[18] =3D vsc->content_type & 0x7;
+
+	return length;
+}
+
+static ssize_t
+intel_dp_hdr_metadata_infoframe_sdp_pack(const struct hdmi_drm_infoframe *=
drm_infoframe,
+					 struct dp_sdp *sdp,
+					 size_t size)
+{
+	size_t length =3D sizeof(struct dp_sdp);
+	const int infoframe_size =3D HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFR=
AME_SIZE;
+	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
+	ssize_t len;
+
+	if (size < length)
+		return -ENOSPC;
+
+	memset(sdp, 0, size);
+
+	len =3D hdmi_drm_infoframe_pack_only(drm_infoframe, buf, sizeof(buf));
+	if (len < 0) {
+		DRM_DEBUG_KMS("buffer size is smaller than hdr metadata infoframe\n");
+		return -ENOSPC;
+	}
+
+	if (len !=3D infoframe_size) {
+		DRM_DEBUG_KMS("wrong static hdr metadata size\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * Set up the infoframe sdp packet for HDR static metadata.
+	 * Prepare VSC Header for SU as per DP 1.4a spec,
+	 * Table 2-100 and Table 2-101
+	 */
+
+	/* Secondary-Data Packet ID, 00h for non-Audio INFOFRAME */
+	sdp->sdp_header.HB0 =3D 0;
+	/*
+	 * Packet Type 80h + Non-audio INFOFRAME Type value
+	 * HDMI_INFOFRAME_TYPE_DRM: 0x87
+	 * - 80h + Non-audio INFOFRAME Type value
+	 * - InfoFrame Type: 0x07
+	 *    [CTA-861-G Table-42 Dynamic Range and Mastering InfoFrame]
+	 */
+	sdp->sdp_header.HB1 =3D drm_infoframe->type;
+	/*
+	 * Least Significant Eight Bits of (Data Byte Count =E2=80=93 1)
+	 * infoframe_size - 1
+	 */
+	sdp->sdp_header.HB2 =3D 0x1D;
+	/* INFOFRAME SDP Version Number */
+	sdp->sdp_header.HB3 =3D (0x13 << 2);
+	/* CTA Header Byte 2 (INFOFRAME Version Number) */
+	sdp->db[0] =3D drm_infoframe->version;
+	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
+	sdp->db[1] =3D drm_infoframe->length;
+	/*
+	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
+	 * HDMI_INFOFRAME_HEADER_SIZE
+	 */
+	BUILD_BUG_ON(sizeof(sdp->db) < HDMI_DRM_INFOFRAME_SIZE + 2);
+	memcpy(&sdp->db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
+	       HDMI_DRM_INFOFRAME_SIZE);
+
+	/*
+	 * Size of DP infoframe sdp packet for HDR static metadata consists of
+	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
+	 * - Two Data Blocks: 2 bytes
+	 *    CTA Header Byte2 (INFOFRAME Version Number)
+	 *    CTA Header Byte3 (Length of INFOFRAME)
+	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
+	 *
+	 * Prior to GEN11's GMP register size is identical to DP HDR static metad=
ata
+	 * infoframe size. But GEN11+ has larger than that size, write_infoframe
+	 * will pad rest of the size.
+	 */
+	return sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE;
+}
+
+static void intel_write_dp_sdp(struct intel_encoder *encoder,
+			       const struct intel_crtc_state *crtc_state,
+			       unsigned int type)
+{
+	struct intel_digital_port *intel_dig_port =3D enc_to_dig_port(encoder);
+	struct drm_i915_private *dev_priv =3D to_i915(encoder->base.dev);
+	struct dp_sdp sdp =3D {};
+	ssize_t len;
+
+	if ((crtc_state->infoframes.enable &
+	     intel_hdmi_infoframe_enable(type)) =3D 0)
+		return;
+
+	switch (type) {
+	case DP_SDP_VSC:
+		len =3D intel_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
+					    sizeof(sdp));
+		break;
+	case HDMI_PACKET_TYPE_GAMUT_METADATA:
+		len =3D intel_dp_hdr_metadata_infoframe_sdp_pack(&crtc_state->infoframes=
.drm.drm,
+							       &sdp, sizeof(sdp));
+		break;
+	default:
+		MISSING_CASE(type);
+		break;
+	}
+
+	if (drm_WARN_ON(&dev_priv->drm, len < 0))
+		return;
+
+	intel_dig_port->write_infoframe(encoder, crtc_state, type, &sdp, len);
+}
+
+void intel_dp_set_infoframes(struct intel_encoder *encoder,
+			     bool enable,
+			     const struct intel_crtc_state *crtc_state,
+			     const struct drm_connector_state *conn_state)
+{
+	struct drm_i915_private *dev_priv =3D to_i915(encoder->base.dev);
+	struct intel_dp *intel_dp =3D enc_to_intel_dp(encoder);
+	i915_reg_t reg =3D HSW_TVIDEO_DIP_CTL(crtc_state->cpu_transcoder);
+	u32 dip_enable =3D VIDEO_DIP_ENABLE_AVI_HSW | VIDEO_DIP_ENABLE_GCP_HSW |
+			 VIDEO_DIP_ENABLE_VS_HSW | VIDEO_DIP_ENABLE_GMP_HSW |
+			 VIDEO_DIP_ENABLE_SPD_HSW | VIDEO_DIP_ENABLE_DRM_GLK;
+	u32 val =3D intel_de_read(dev_priv, reg);
+
+	/* TODO: Add DSC case (DIP_ENABLE_PPS) */
+	/* When PSR is enabled, this routine doesn't disable VSC DIP */
+	if (intel_psr_enabled(intel_dp))
+		val &=3D ~dip_enable;
+	else
+		val &=3D ~(dip_enable | VIDEO_DIP_ENABLE_VSC_HSW);
+
+	if (!enable) {
+		intel_de_write(dev_priv, reg, val);
+		intel_de_posting_read(dev_priv, reg);
+		return;
+	}
+
+	intel_de_write(dev_priv, reg, val);
+	intel_de_posting_read(dev_priv, reg);
+
+	/* When PSR is enabled, VSC SDP is handled by PSR routine */
+	if (!intel_psr_enabled(intel_dp))
+		intel_write_dp_sdp(encoder, crtc_state, DP_SDP_VSC);
+
+	intel_write_dp_sdp(encoder, crtc_state, HDMI_PACKET_TYPE_GAMUT_METADATA);
+}
+
 static void
 intel_dp_setup_vsc_sdp(struct intel_dp *intel_dp,
 		       const struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915=
/display/intel_dp.h
index 3da166054788..0dc09a463ee1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -116,6 +116,9 @@ void intel_dp_vsc_enable(struct intel_dp *intel_dp,
 void intel_dp_hdr_metadata_enable(struct intel_dp *intel_dp,
 				  const struct intel_crtc_state *crtc_state,
 				  const struct drm_connector_state *conn_state);
+void intel_dp_set_infoframes(struct intel_encoder *encoder, bool enable,
+			     const struct intel_crtc_state *crtc_state,
+			     const struct drm_connector_state *conn_state);
 bool intel_digital_port_connected(struct intel_encoder *encoder);
=20
 static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
--=20
2.25.0
