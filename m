From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 16:46:22 +0000
Subject: RE: [PATCH v3 10/17] drm/i915: Include DP VSC SDP in the crtc state dump
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD092@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-11-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-11-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 10/17] drm/i915: Include DP VSC SDP in the crtc state dump
> 
> Dump out the DP VSC SDP in the normal crtc state dump
> 
> v3: Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp
>     Use drm core's DP VSC SDP logging function

Looks good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> b/drivers/gpu/drm/i915/display/intel_display.c
> index 593c63f51210..4f187fd330e8 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -12878,6 +12878,16 @@ intel_dump_infoframe(struct drm_i915_private
> *dev_priv,
>  	hdmi_infoframe_log(KERN_DEBUG, dev_priv->drm.dev, frame);  }
> 
> +static void
> +intel_dump_dp_vsc_sdp(struct drm_i915_private *dev_priv,
> +		      const struct drm_dp_vsc_sdp *vsc) {
> +	if (!drm_debug_enabled(DRM_UT_KMS))
> +		return;
> +
> +	drm_dp_vsc_sdp_log(KERN_DEBUG, dev_priv->drm.dev, vsc); }
> +
>  #define OUTPUT_TYPE(x) [INTEL_OUTPUT_ ## x] = #x
> 
>  static const char * const output_type_str[] = { @@ -13036,6 +13046,9 @@ static
> void intel_dump_pipe_config(const struct intel_crtc_state *pipe_config,
>  	if (pipe_config->infoframes.enable &
>  	    intel_hdmi_infoframe_enable(HDMI_PACKET_TYPE_GAMUT_METADATA))
>  		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.drm);
> +	if (pipe_config->infoframes.enable &
> +	    intel_hdmi_infoframe_enable(DP_SDP_VSC))
> +		intel_dump_dp_vsc_sdp(dev_priv, &pipe_config->infoframes.vsc);
> 
>  	drm_dbg_kms(&dev_priv->drm, "requested mode:\n");
>  	drm_mode_debug_printmodeline(&pipe_config->hw.mode);
> --
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
