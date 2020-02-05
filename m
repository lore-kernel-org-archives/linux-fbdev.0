From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 16:54:36 +0000
Subject: RE: [Intel-gfx] [PATCH v3 12/17] drm/i915: Add state readout for DP HDR Metadata Infoframe SDP
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD0D0@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-13-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-13-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>



> -----Original Message-----
> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Gwan-
> gyeong Mun
> Sent: Tuesday, February 4, 2020 4:50 AM
> To: intel-gfx@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org; dri-devel@lists.freedesktop.org
> Subject: [Intel-gfx] [PATCH v3 12/17] drm/i915: Add state readout for DP HDR
> Metadata Infoframe SDP
> 
> Added state readout for DP HDR Metadata Infoframe SDP.

Looks good.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 374ab6a3757c..a9eaf7a6bc15 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4322,6 +4322,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
>  				      pipe_config->fec_enable);
>  		}
> 
> +		pipe_config->infoframes.enable |> +			intel_hdmi_infoframes_enabled(encoder, pipe_config);
> +
>  		break;
>  	case TRANS_DDI_MODE_SELECT_DP_MST:
>  		pipe_config->output_types |= BIT(INTEL_OUTPUT_DP_MST); @@ -
> 4333,6 +4336,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
> 
> 	REG_FIELD_GET(TRANS_DDI_MST_TRANSPORT_SELECT_MASK, temp);
> 
>  		intel_dp_get_m_n(intel_crtc, pipe_config);
> +
> +		pipe_config->infoframes.enable |> +			intel_hdmi_infoframes_enabled(encoder, pipe_config);
>  		break;
>  	default:
>  		break;
> @@ -4383,6 +4389,8 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
>  	intel_read_infoframe(encoder, pipe_config,
>  			     HDMI_INFOFRAME_TYPE_DRM,
>  			     &pipe_config->infoframes.drm);
> +
> +	intel_read_dp_sdp(encoder, pipe_config,
> +HDMI_PACKET_TYPE_GAMUT_METADATA);
>  }
> 
>  static enum intel_output_type
> --
> 2.24.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
