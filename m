From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Wed, 05 Feb 2020 15:41:31 +0000
Subject: [PATCH v4 11/17] drm/i915: Program DP SDPs with computed configs
Message-Id: <20200205154137.1202389-12-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200205154137.1202389-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200205154137.1202389-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

In order to use computed config for DP SDPs (DP VSC SDP and DP HDR Metadata
Infoframe SDP), it replaces intel_dp_vsc_enable() function and
intel_dp_hdr_metadata_enable() function to intel_dp_set_infoframes()
function.

Before applying it, routines of program SDP always calculated configs when
they called. And it removes unused functions.

v3: Rebased

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c |   3 +-
 drivers/gpu/drm/i915/display/intel_dp.c  | 226 -----------------------
 drivers/gpu/drm/i915/display/intel_dp.h  |   6 -
 3 files changed, 1 insertion(+), 234 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i91=
5/display/intel_ddi.c
index 1ab638e17046..857014fe5880 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3902,8 +3902,7 @@ static void intel_enable_ddi_dp(struct intel_encoder =
*encoder,
=20
 	intel_edp_backlight_on(crtc_state, conn_state);
 	intel_psr_enable(intel_dp, crtc_state);
-	intel_dp_vsc_enable(intel_dp, crtc_state, conn_state);
-	intel_dp_hdr_metadata_enable(intel_dp, crtc_state, conn_state);
+	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
 	intel_edp_drrs_enable(intel_dp, crtc_state);
=20
 	if (crtc_state->has_audio)
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index c30272e80dc7..acf943b9e1ec 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5101,232 +5101,6 @@ void intel_read_dp_sdp(struct intel_encoder *encode=
r,
 	}
 }
=20
-static void
-intel_dp_setup_vsc_sdp(struct intel_dp *intel_dp,
-		       const struct intel_crtc_state *crtc_state,
-		       const struct drm_connector_state *conn_state)
-{
-	struct intel_digital_port *intel_dig_port =3D dp_to_dig_port(intel_dp);
-	struct dp_sdp vsc_sdp =3D {};
-
-	/* Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119 */
-	vsc_sdp.sdp_header.HB0 =3D 0;
-	vsc_sdp.sdp_header.HB1 =3D 0x7;
-
-	/*
-	 * VSC SDP supporting 3D stereo, PSR2, and Pixel Encoding/
-	 * Colorimetry Format indication.
-	 */
-	vsc_sdp.sdp_header.HB2 =3D 0x5;
-
-	/*
-	 * VSC SDP supporting 3D stereo, + PSR2, + Pixel Encoding/
-	 * Colorimetry Format indication (HB2 =3D 05h).
-	 */
-	vsc_sdp.sdp_header.HB3 =3D 0x13;
-
-	/* DP 1.4a spec, Table 2-120 */
-	switch (crtc_state->output_format) {
-	case INTEL_OUTPUT_FORMAT_YCBCR444:
-		vsc_sdp.db[16] =3D 0x1 << 4; /* YCbCr 444 : DB16[7:4] =3D 1h */
-		break;
-	case INTEL_OUTPUT_FORMAT_YCBCR420:
-		vsc_sdp.db[16] =3D 0x3 << 4; /* YCbCr 420 : DB16[7:4] =3D 3h */
-		break;
-	case INTEL_OUTPUT_FORMAT_RGB:
-	default:
-		/* RGB: DB16[7:4] =3D 0h */
-		break;
-	}
-
-	switch (conn_state->colorspace) {
-	case DRM_MODE_COLORIMETRY_BT709_YCC:
-		vsc_sdp.db[16] |=3D 0x1;
-		break;
-	case DRM_MODE_COLORIMETRY_XVYCC_601:
-		vsc_sdp.db[16] |=3D 0x2;
-		break;
-	case DRM_MODE_COLORIMETRY_XVYCC_709:
-		vsc_sdp.db[16] |=3D 0x3;
-		break;
-	case DRM_MODE_COLORIMETRY_SYCC_601:
-		vsc_sdp.db[16] |=3D 0x4;
-		break;
-	case DRM_MODE_COLORIMETRY_OPYCC_601:
-		vsc_sdp.db[16] |=3D 0x5;
-		break;
-	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
-	case DRM_MODE_COLORIMETRY_BT2020_RGB:
-		vsc_sdp.db[16] |=3D 0x6;
-		break;
-	case DRM_MODE_COLORIMETRY_BT2020_YCC:
-		vsc_sdp.db[16] |=3D 0x7;
-		break;
-	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
-	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
-		vsc_sdp.db[16] |=3D 0x4; /* DCI-P3 (SMPTE RP 431-2) */
-		break;
-	default:
-		/* sRGB (IEC 61966-2-1) / ITU-R BT.601: DB16[0:3] =3D 0h */
-
-		/* RGB->YCBCR color conversion uses the BT.709 color space. */
-		if (crtc_state->output_format =3D INTEL_OUTPUT_FORMAT_YCBCR420)
-			vsc_sdp.db[16] |=3D 0x1; /* 0x1, ITU-R BT.709 */
-		break;
-	}
-
-	/*
-	 * For pixel encoding formats YCbCr444, YCbCr422, YCbCr420, and Y Only,
-	 * the following Component Bit Depth values are defined:
-	 * 001b =3D 8bpc.
-	 * 010b =3D 10bpc.
-	 * 011b =3D 12bpc.
-	 * 100b =3D 16bpc.
-	 */
-	switch (crtc_state->pipe_bpp) {
-	case 24: /* 8bpc */
-		vsc_sdp.db[17] =3D 0x1;
-		break;
-	case 30: /* 10bpc */
-		vsc_sdp.db[17] =3D 0x2;
-		break;
-	case 36: /* 12bpc */
-		vsc_sdp.db[17] =3D 0x3;
-		break;
-	case 48: /* 16bpc */
-		vsc_sdp.db[17] =3D 0x4;
-		break;
-	default:
-		MISSING_CASE(crtc_state->pipe_bpp);
-		break;
-	}
-
-	/*
-	 * Dynamic Range (Bit 7)
-	 * 0 =3D VESA range, 1 =3D CTA range.
-	 * all YCbCr are always limited range
-	 */
-	vsc_sdp.db[17] |=3D 0x80;
-
-	/*
-	 * Content Type (Bits 2:0)
-	 * 000b =3D Not defined.
-	 * 001b =3D Graphics.
-	 * 010b =3D Photo.
-	 * 011b =3D Video.
-	 * 100b =3D Game
-	 * All other values are RESERVED.
-	 * Note: See CTA-861-G for the definition and expected
-	 * processing by a stream sink for the above contect types.
-	 */
-	vsc_sdp.db[18] =3D 0;
-
-	intel_dig_port->write_infoframe(&intel_dig_port->base,
-			crtc_state, DP_SDP_VSC, &vsc_sdp, sizeof(vsc_sdp));
-}
-
-static void
-intel_dp_setup_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
-					  const struct intel_crtc_state *crtc_state,
-					  const struct drm_connector_state *conn_state)
-{
-	struct intel_digital_port *intel_dig_port =3D dp_to_dig_port(intel_dp);
-	struct dp_sdp infoframe_sdp =3D {};
-	struct hdmi_drm_infoframe drm_infoframe =3D {};
-	const int infoframe_size =3D HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFR=
AME_SIZE;
-	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
-	ssize_t len;
-	int ret;
-
-	ret =3D drm_hdmi_infoframe_set_hdr_metadata(&drm_infoframe, conn_state);
-	if (ret) {
-		DRM_DEBUG_KMS("couldn't set HDR metadata in infoframe\n");
-		return;
-	}
-
-	len =3D hdmi_drm_infoframe_pack_only(&drm_infoframe, buf, sizeof(buf));
-	if (len < 0) {
-		DRM_DEBUG_KMS("buffer size is smaller than hdr metadata infoframe\n");
-		return;
-	}
-
-	if (len !=3D infoframe_size) {
-		DRM_DEBUG_KMS("wrong static hdr metadata size\n");
-		return;
-	}
-
-	/*
-	 * Set up the infoframe sdp packet for HDR static metadata.
-	 * Prepare VSC Header for SU as per DP 1.4a spec,
-	 * Table 2-100 and Table 2-101
-	 */
-
-	/* Packet ID, 00h for non-Audio INFOFRAME */
-	infoframe_sdp.sdp_header.HB0 =3D 0;
-	/*
-	 * Packet Type 80h + Non-audio INFOFRAME Type value
-	 * HDMI_INFOFRAME_TYPE_DRM: 0x87,
-	 */
-	infoframe_sdp.sdp_header.HB1 =3D drm_infoframe.type;
-	/*
-	 * Least Significant Eight Bits of (Data Byte Count =E2=80=93 1)
-	 * infoframe_size - 1,
-	 */
-	infoframe_sdp.sdp_header.HB2 =3D 0x1D;
-	/* INFOFRAME SDP Version Number */
-	infoframe_sdp.sdp_header.HB3 =3D (0x13 << 2);
-	/* CTA Header Byte 2 (INFOFRAME Version Number) */
-	infoframe_sdp.db[0] =3D drm_infoframe.version;
-	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
-	infoframe_sdp.db[1] =3D drm_infoframe.length;
-	/*
-	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
-	 * HDMI_INFOFRAME_HEADER_SIZE
-	 */
-	BUILD_BUG_ON(sizeof(infoframe_sdp.db) < HDMI_DRM_INFOFRAME_SIZE + 2);
-	memcpy(&infoframe_sdp.db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
-	       HDMI_DRM_INFOFRAME_SIZE);
-
-	/*
-	 * Size of DP infoframe sdp packet for HDR static metadata is consist of
-	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
-	 * - Two Data Blocks: 2 bytes
-	 *    CTA Header Byte2 (INFOFRAME Version Number)
-	 *    CTA Header Byte3 (Length of INFOFRAME)
-	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
-	 *
-	 * Prior to GEN11's GMP register size is identical to DP HDR static metad=
ata
-	 * infoframe size. But GEN11+ has larger than that size, write_infoframe
-	 * will pad rest of the size.
-	 */
-	intel_dig_port->write_infoframe(&intel_dig_port->base, crtc_state,
-					HDMI_PACKET_TYPE_GAMUT_METADATA,
-					&infoframe_sdp,
-					sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE);
-}
-
-void intel_dp_vsc_enable(struct intel_dp *intel_dp,
-			 const struct intel_crtc_state *crtc_state,
-			 const struct drm_connector_state *conn_state)
-{
-	if (!intel_dp_needs_vsc_sdp(crtc_state, conn_state))
-		return;
-
-	intel_dp_setup_vsc_sdp(intel_dp, crtc_state, conn_state);
-}
-
-void intel_dp_hdr_metadata_enable(struct intel_dp *intel_dp,
-				  const struct intel_crtc_state *crtc_state,
-				  const struct drm_connector_state *conn_state)
-{
-	if (!conn_state->hdr_output_metadata)
-		return;
-
-	intel_dp_setup_hdr_metadata_infoframe_sdp(intel_dp,
-						  crtc_state,
-						  conn_state);
-}
-
 static u8 intel_dp_autotest_link_training(struct intel_dp *intel_dp)
 {
 	int status =3D 0;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915=
/display/intel_dp.h
index e8f9ba962d09..6562bb8edeba 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -110,12 +110,6 @@ int intel_dp_link_required(int pixel_clock, int bpp);
 int intel_dp_max_data_rate(int max_link_clock, int max_lanes);
 bool intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
 			    const struct drm_connector_state *conn_state);
-void intel_dp_vsc_enable(struct intel_dp *intel_dp,
-			 const struct intel_crtc_state *crtc_state,
-			 const struct drm_connector_state *conn_state);
-void intel_dp_hdr_metadata_enable(struct intel_dp *intel_dp,
-				  const struct intel_crtc_state *crtc_state,
-				  const struct drm_connector_state *conn_state);
 void intel_dp_set_infoframes(struct intel_encoder *encoder, bool enable,
 			     const struct intel_crtc_state *crtc_state,
 			     const struct drm_connector_state *conn_state);
--=20
2.24.1
