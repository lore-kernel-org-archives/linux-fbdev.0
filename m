From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 17:00:42 +0000
Subject: RE: [PATCH v3 13/17] drm/i915: Add state readout for DP VSC SDP
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD0F4@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-14-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-14-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 13/17] drm/i915: Add state readout for DP VSC SDP
> 
> Added state readout for DP VSC SDP and enabled state validation for DP VSC SDP.
> 
> v2: Minor style fix
> v3: Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp

Looks good.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c     |  1 +
>  drivers/gpu/drm/i915/display/intel_display.c | 42 ++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index a9eaf7a6bc15..64e4edefa998 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4391,6 +4391,7 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
>  			     &pipe_config->infoframes.drm);
> 
>  	intel_read_dp_sdp(encoder, pipe_config,
> HDMI_PACKET_TYPE_GAMUT_METADATA);
> +	intel_read_dp_sdp(encoder, pipe_config, DP_SDP_VSC);
>  }
> 
>  static enum intel_output_type
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> b/drivers/gpu/drm/i915/display/intel_display.c
> index 4f187fd330e8..02471c7aa6e7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -13503,6 +13503,13 @@ intel_compare_infoframe(const union
> hdmi_infoframe *a,
>  	return memcmp(a, b, sizeof(*a)) = 0;
>  }
> 
> +static bool
> +intel_compare_dp_vsc_sdp(const struct drm_dp_vsc_sdp *a,
> +			 const struct drm_dp_vsc_sdp *b)
> +{
> +	return memcmp(a, b, sizeof(*a)) = 0;
> +}
> +
>  static void
>  pipe_config_infoframe_mismatch(struct drm_i915_private *dev_priv,
>  			       bool fastset, const char *name, @@ -13528,6
> +13535,30 @@ pipe_config_infoframe_mismatch(struct drm_i915_private
> *dev_priv,
>  	}
>  }
> 
> +static void
> +pipe_config_dp_vsc_sdp_mismatch(struct drm_i915_private *dev_priv,
> +				bool fastset, const char *name,
> +				const struct drm_dp_vsc_sdp *a,
> +				const struct drm_dp_vsc_sdp *b)
> +{
> +	if (fastset) {
> +		if (!drm_debug_enabled(DRM_UT_KMS))
> +			return;
> +
> +		DRM_DEBUG_KMS("fastset mismatch in %s dp sdp\n", name);
> +		DRM_DEBUG_KMS("expected:\n");
> +		drm_dp_vsc_sdp_log(KERN_DEBUG, dev_priv->drm.dev, a);
> +		DRM_DEBUG_KMS("found:\n");
> +		drm_dp_vsc_sdp_log(KERN_DEBUG, dev_priv->drm.dev, b);
> +	} else {
> +		DRM_ERROR("mismatch in %s dp sdp\n", name);
> +		DRM_ERROR("expected:\n");
> +		drm_dp_vsc_sdp_log(KERN_ERR, dev_priv->drm.dev, a);
> +		DRM_ERROR("found:\n");
> +		drm_dp_vsc_sdp_log(KERN_ERR, dev_priv->drm.dev, b);
> +	}
> +}
> +
>  static void __printf(4, 5)
>  pipe_config_mismatch(bool fastset, const struct intel_crtc *crtc,
>  		     const char *name, const char *format, ...) @@ -13729,6
> +13760,16 @@ intel_pipe_config_compare(const struct intel_crtc_state
> *current_config,
>  	} \
>  } while (0)
> 
> +#define PIPE_CONF_CHECK_DP_VSC_SDP(name) do { \
> +	if (!intel_compare_dp_vsc_sdp(&current_config->infoframes.name, \
> +				      &pipe_config->infoframes.name)) { \
> +		pipe_config_dp_vsc_sdp_mismatch(dev_priv, fastset,
> __stringify(name), \
> +						&current_config-
> >infoframes.name, \
> +						&pipe_config->infoframes.name);
> \
> +		ret = false; \
> +	} \
> +} while (0)
> +
>  #define PIPE_CONF_CHECK_COLOR_LUT(name1, name2, bit_precision) do { \
>  	if (current_config->name1 != pipe_config->name1) { \
>  		pipe_config_mismatch(fastset, crtc, __stringify(name1), \ @@ -
> 13902,6 +13943,7 @@ intel_pipe_config_compare(const struct intel_crtc_state
> *current_config,
>  	PIPE_CONF_CHECK_INFOFRAME(spd);
>  	PIPE_CONF_CHECK_INFOFRAME(hdmi);
>  	PIPE_CONF_CHECK_INFOFRAME(drm);
> +	PIPE_CONF_CHECK_DP_VSC_SDP(vsc);
> 
>  	PIPE_CONF_CHECK_X(sync_mode_slaves_mask);
>  	PIPE_CONF_CHECK_I(master_transcoder);
> --
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
