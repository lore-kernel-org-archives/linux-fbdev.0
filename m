From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 14:51:44 +0000
Subject: RE: [PATCH v3 02/17] drm/i915/dp: Add compute routine for DP VSC SDP
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DCE2A@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-3-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-3-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>



> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Gwan-
> gyeong Mun
> Sent: Tuesday, February 4, 2020 4:50 AM
> To: intel-gfx@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org; dri-devel@lists.freedesktop.org
> Subject: [PATCH v3 02/17] drm/i915/dp: Add compute routine for DP VSC SDP
> 
> In order to support state readout for DP VSC SDP, we need to have a structure which
> holds DP VSC SDP payload data such as "union hdmi_infoframe drm" which is used
> for DRM infoframe.
> It adds a struct drm_dp_vsc_sdp vsc to intel_crtc_state.infoframes.
> 
> And it stores computed dp vsc sdp to infoframes.vsc of crtc state.
> While computing we'll also fill out the inforames.enable bitmask appropriately.
> 
> The compute routine follows DP 1.4 spec [Table 2-117: VSC SDP Payload for
> DB16 through DB18].
> 
> v3: Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp
>

With the structure names updated, this looks good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  .../drm/i915/display/intel_display_types.h    |  1 +
>  drivers/gpu/drm/i915/display/intel_dp.c       | 92 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 33ba93863488..6633c1061670 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1021,6 +1021,7 @@ struct intel_crtc_state {
>  		union hdmi_infoframe spd;
>  		union hdmi_infoframe hdmi;
>  		union hdmi_infoframe drm;
> +		struct drm_dp_vsc_sdp vsc;
>  	} infoframes;
> 
>  	/* HDMI scrambling status */
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> b/drivers/gpu/drm/i915/display/intel_dp.c
> index f4dede6253f8..2bdc43c80e03 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2372,6 +2372,97 @@ static bool intel_dp_port_has_audio(struct
> drm_i915_private *dev_priv,
>  	return true;
>  }
> 
> +static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state
> *crtc_state,
> +					     const struct drm_connector_state
> *conn_state,
> +					     struct drm_dp_vsc_sdp *vsc)
> +{
> +	/*
> +	 * Prepare VSC Header for SU as per DP 1.4 spec, Table 2-118
> +	 * VSC SDP supporting 3D stereo, PSR2, and Pixel Encoding/
> +	 * Colorimetry Format indication.
> +	 */
> +	vsc->revision = 0x5;
> +	vsc->length = 0x13;
> +
> +	/* DP 1.4a spec, Table 2-120 */
> +	switch (crtc_state->output_format) {
> +	case INTEL_OUTPUT_FORMAT_YCBCR444:
> +		vsc->colorspace = DP_COLORSPACE_YUV444;
> +		break;
> +	case INTEL_OUTPUT_FORMAT_YCBCR420:
> +		vsc->colorspace = DP_COLORSPACE_YUV420;
> +		break;
> +	case INTEL_OUTPUT_FORMAT_RGB:
> +	default:
> +		vsc->colorspace = DP_COLORSPACE_RGB;
> +	}
> +
> +	switch (conn_state->colorspace) {
> +	case DRM_MODE_COLORIMETRY_BT709_YCC:
> +		vsc->colorimetry = DP_COLORIMETRY_BT709_YCC;
> +		break;
> +	case DRM_MODE_COLORIMETRY_XVYCC_601:
> +		vsc->colorimetry = DP_COLORIMETRY_XVYCC_601;
> +		break;
> +	case DRM_MODE_COLORIMETRY_XVYCC_709:
> +		vsc->colorimetry = DP_COLORIMETRY_XVYCC_709;
> +		break;
> +	case DRM_MODE_COLORIMETRY_SYCC_601:
> +		vsc->colorimetry = DP_COLORIMETRY_SYCC_601;
> +		break;
> +	case DRM_MODE_COLORIMETRY_OPYCC_601:
> +		vsc->colorimetry = DP_COLORIMETRY_OPYCC_601;
> +		break;
> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
> +		vsc->colorimetry = DP_COLORIMETRY_BT2020_CYCC;
> +		break;
> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
> +		vsc->colorimetry = DP_COLORIMETRY_BT2020_RGB;
> +		break;
> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> +		vsc->colorimetry = DP_COLORIMETRY_BT2020_YCC;
> +		break;
> +	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
> +	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
> +		vsc->colorimetry = DP_COLORIMETRY_DCI_P3_RGB;
> +		break;
> +	default:
> +		/*
> +		 * RGB->YCBCR color conversion uses the BT.709
> +		 * color space.
> +		 */
> +		if (crtc_state->output_format =
> INTEL_OUTPUT_FORMAT_YCBCR420)
> +			vsc->colorimetry = DP_COLORIMETRY_BT709_YCC;
> +		else
> +			vsc->colorimetry = DP_COLORIMETRY_DEFAULT;
> +		break;
> +	}
> +
> +	vsc->bpc = crtc_state->pipe_bpp / 3;
> +	/* all YCbCr are always limited range */
> +	vsc->dynamic_range = DP_DYNAMIC_RANGE_CTA;
> +	vsc->content_type = DP_CONTENT_TYPE_NOT_DEFINED; }
> +
> +static void intel_dp_compute_vsc_sdp(struct intel_dp *intel_dp,
> +				     struct intel_crtc_state *crtc_state,
> +				     const struct drm_connector_state *conn_state) {
> +	struct drm_dp_vsc_sdp *vsc = &crtc_state->infoframes.vsc;
> +
> +	/* When PSR is enabled, VSC SDP is handled by PSR routine */
> +	if (intel_psr_enabled(intel_dp))
> +		return;
> +
> +	if (!intel_dp_needs_vsc_sdp(crtc_state, conn_state))
> +		return;
> +
> +	crtc_state->infoframes.enable |> intel_hdmi_infoframe_enable(DP_SDP_VSC);
> +	vsc->sdp_type = DP_SDP_VSC;
> +	intel_dp_compute_vsc_colorimetry(crtc_state, conn_state,
> +					 &crtc_state->infoframes.vsc);
> +}
> +
>  int
>  intel_dp_compute_config(struct intel_encoder *encoder,
>  			struct intel_crtc_state *pipe_config, @@ -2477,6 +2568,7
> @@ intel_dp_compute_config(struct intel_encoder *encoder,
>  		intel_dp_set_clock(encoder, pipe_config);
> 
>  	intel_psr_compute_config(intel_dp, pipe_config);
> +	intel_dp_compute_vsc_sdp(intel_dp, pipe_config, conn_state);
> 
>  	return 0;
>  }
> --
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
