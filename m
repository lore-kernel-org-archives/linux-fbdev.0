From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 17:15:09 +0000
Subject: RE: [Intel-gfx] [PATCH v3 17/17] drm/i915/psr: Use new DP VSC SDP compute routine on PSR
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD190@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-18-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-18-gwan-gyeong.mun@intel.com>
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
> Subject: [Intel-gfx] [PATCH v3 17/17] drm/i915/psr: Use new DP VSC SDP compute
> routine on PSR
> 
> In order to use a common VSC SDP Colorimetry calculating code on PSR, it uses a
> new psr vsc sdp compute routine.
> Because PSR routine has its own scenario and timings of writing a VSC SDP, the
> current PSR routine needs to have its own drm_dp_vsc_sdp structure member
> variable on struct i915_psr.
> 
> In order to calculate colorimetry information, intel_psr_update() function and
> intel_psr_enable() function extend a drm_connector_state argument.
> 
> There are no changes to PSR mechanism.
> 
> v3: Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp

Looks good.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

Note: Please rebase, fix the comments and resend to trigger a full CI run.

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c |  4 +-
> drivers/gpu/drm/i915/display/intel_psr.c | 54 +++++++-----------------
> drivers/gpu/drm/i915/display/intel_psr.h |  6 ++-
>  drivers/gpu/drm/i915/i915_drv.h          |  1 +
>  4 files changed, 22 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 8509cd33569e..00b46c45f6a8 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3901,7 +3901,7 @@ static void intel_enable_ddi_dp(struct intel_encoder
> *encoder,
>  		intel_dp_stop_link_train(intel_dp);
> 
>  	intel_edp_backlight_on(crtc_state, conn_state);
> -	intel_psr_enable(intel_dp, crtc_state);
> +	intel_psr_enable(intel_dp, crtc_state, conn_state);
>  	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
>  	intel_edp_drrs_enable(intel_dp, crtc_state);
> 
> @@ -4063,7 +4063,7 @@ static void intel_ddi_update_pipe_dp(struct intel_encoder
> *encoder,
> 
>  	intel_ddi_set_dp_msa(crtc_state, conn_state);
> 
> -	intel_psr_update(intel_dp, crtc_state);
> +	intel_psr_update(intel_dp, crtc_state, conn_state);
>  	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
>  	intel_edp_drrs_enable(intel_dp, crtc_state);
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c
> b/drivers/gpu/drm/i915/display/intel_psr.c
> index e41ed962aa80..a4564607b6c5 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -330,39 +330,6 @@ void intel_psr_init_dpcd(struct intel_dp *intel_dp)
>  	}
>  }
> 
> -static void intel_psr_setup_vsc(struct intel_dp *intel_dp,
> -				const struct intel_crtc_state *crtc_state)
> -{
> -	struct intel_digital_port *intel_dig_port = dp_to_dig_port(intel_dp);
> -	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
> -	struct dp_sdp psr_vsc;
> -
> -	if (dev_priv->psr.psr2_enabled) {
> -		/* Prepare VSC Header for SU as per EDP 1.4 spec, Table 6.11 */
> -		memset(&psr_vsc, 0, sizeof(psr_vsc));
> -		psr_vsc.sdp_header.HB0 = 0;
> -		psr_vsc.sdp_header.HB1 = 0x7;
> -		if (dev_priv->psr.colorimetry_support) {
> -			psr_vsc.sdp_header.HB2 = 0x5;
> -			psr_vsc.sdp_header.HB3 = 0x13;
> -		} else {
> -			psr_vsc.sdp_header.HB2 = 0x4;
> -			psr_vsc.sdp_header.HB3 = 0xe;
> -		}
> -	} else {
> -		/* Prepare VSC packet as per EDP 1.3 spec, Table 3.10 */
> -		memset(&psr_vsc, 0, sizeof(psr_vsc));
> -		psr_vsc.sdp_header.HB0 = 0;
> -		psr_vsc.sdp_header.HB1 = 0x7;
> -		psr_vsc.sdp_header.HB2 = 0x2;
> -		psr_vsc.sdp_header.HB3 = 0x8;
> -	}
> -
> -	intel_dig_port->write_infoframe(&intel_dig_port->base,
> -					crtc_state,
> -					DP_SDP_VSC, &psr_vsc, sizeof(psr_vsc));
> -}
> -
>  static void hsw_psr_setup_aux(struct intel_dp *intel_dp)  {
>  	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp); @@ -841,9
> +808,12 @@ static void intel_psr_enable_source(struct intel_dp *intel_dp,  }
> 
>  static void intel_psr_enable_locked(struct drm_i915_private *dev_priv,
> -				    const struct intel_crtc_state *crtc_state)
> +				    const struct intel_crtc_state *crtc_state,
> +				    const struct drm_connector_state *conn_state)
>  {
>  	struct intel_dp *intel_dp = dev_priv->psr.dp;
> +	struct intel_digital_port *intel_dig_port = dp_to_dig_port(intel_dp);
> +	struct intel_encoder *encoder = &intel_dig_port->base;
>  	u32 val;
> 
>  	WARN_ON(dev_priv->psr.enabled);
> @@ -881,7 +851,9 @@ static void intel_psr_enable_locked(struct drm_i915_private
> *dev_priv,
> 
>  	DRM_DEBUG_KMS("Enabling PSR%s\n",
>  		      dev_priv->psr.psr2_enabled ? "2" : "1");
> -	intel_psr_setup_vsc(intel_dp, crtc_state);
> +	intel_dp_compute_psr_vsc_sdp(intel_dp, crtc_state, conn_state,
> +				     &dev_priv->psr.vsc);
> +	intel_write_dp_vsc_sdp(encoder, crtc_state, &dev_priv->psr.vsc);
>  	intel_psr_enable_sink(intel_dp);
>  	intel_psr_enable_source(intel_dp, crtc_state);
>  	dev_priv->psr.enabled = true;
> @@ -893,11 +865,13 @@ static void intel_psr_enable_locked(struct
> drm_i915_private *dev_priv,
>   * intel_psr_enable - Enable PSR
>   * @intel_dp: Intel DP
>   * @crtc_state: new CRTC state
> + * @conn_state: new CONNECTOR state
>   *
>   * This function can only be called after the pipe is fully trained and enabled.
>   */
>  void intel_psr_enable(struct intel_dp *intel_dp,
> -		      const struct intel_crtc_state *crtc_state)
> +		      const struct intel_crtc_state *crtc_state,
> +		      const struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
> 
> @@ -916,7 +890,7 @@ void intel_psr_enable(struct intel_dp *intel_dp,
>  		goto unlock;
>  	}
> 
> -	intel_psr_enable_locked(dev_priv, crtc_state);
> +	intel_psr_enable_locked(dev_priv, crtc_state, conn_state);
> 
>  unlock:
>  	mutex_unlock(&dev_priv->psr.lock);
> @@ -1049,13 +1023,15 @@ static void psr_force_hw_tracking_exit(struct
> drm_i915_private *dev_priv)
>   * intel_psr_update - Update PSR state
>   * @intel_dp: Intel DP
>   * @crtc_state: new CRTC state
> + * @conn_state: new CONNECTOR state
>   *
>   * This functions will update PSR states, disabling, enabling or switching PSR
>   * version when executing fastsets. For full modeset, intel_psr_disable() and
>   * intel_psr_enable() should be called instead.
>   */
>  void intel_psr_update(struct intel_dp *intel_dp,
> -		      const struct intel_crtc_state *crtc_state)
> +		      const struct intel_crtc_state *crtc_state,
> +		      const struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
>  	struct i915_psr *psr = &dev_priv->psr; @@ -1090,7 +1066,7 @@ void
> intel_psr_update(struct intel_dp *intel_dp,
>  		intel_psr_disable_locked(intel_dp);
> 
>  	if (enable)
> -		intel_psr_enable_locked(dev_priv, crtc_state);
> +		intel_psr_enable_locked(dev_priv, crtc_state, conn_state);
> 
>  unlock:
>  	mutex_unlock(&dev_priv->psr.lock);
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.h
> b/drivers/gpu/drm/i915/display/intel_psr.h
> index c58a1d438808..a003fb18105a 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.h
> +++ b/drivers/gpu/drm/i915/display/intel_psr.h
> @@ -17,11 +17,13 @@ struct intel_dp;
>  #define CAN_PSR(dev_priv) (HAS_PSR(dev_priv) && dev_priv->psr.sink_support)
> void intel_psr_init_dpcd(struct intel_dp *intel_dp);  void intel_psr_enable(struct
> intel_dp *intel_dp,
> -		      const struct intel_crtc_state *crtc_state);
> +		      const struct intel_crtc_state *crtc_state,
> +		      const struct drm_connector_state *conn_state);
>  void intel_psr_disable(struct intel_dp *intel_dp,
>  		       const struct intel_crtc_state *old_crtc_state);  void
> intel_psr_update(struct intel_dp *intel_dp,
> -		      const struct intel_crtc_state *crtc_state);
> +		      const struct intel_crtc_state *crtc_state,
> +		      const struct drm_connector_state *conn_state);
>  int intel_psr_debug_set(struct drm_i915_private *dev_priv, u64 value);  void
> intel_psr_invalidate(struct drm_i915_private *dev_priv,
>  			  unsigned frontbuffer_bits,
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index a8a08c63278e..fa2f1a18ffe0 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -504,6 +504,7 @@ struct i915_psr {
>  	u32 dc3co_exit_delay;
>  	struct delayed_work idle_work;
>  	bool initially_probed;
> +	struct drm_dp_vsc_sdp vsc;
>  };
> 
>  #define QUIRK_LVDS_SSC_DISABLE (1<<1)
> --
> 2.24.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
