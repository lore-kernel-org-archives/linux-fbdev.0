From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 15:06:55 +0000
Subject: RE: [PATCH v3 03/17] drm/i915/dp: Add compute routine for DP HDR Metadata Infoframe SDP
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DCE62@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-4-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-4-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 03/17] drm/i915/dp: Add compute routine for DP HDR Metadata
> Infoframe SDP
> 
> It stores computed dp hdr metadata infoframe sdp to infoframes.drm of crtc state.
> It referenced intel_hdmi_compute_drm_infoframe().
> 
> While computing, we'll also fill out the inforames.enable bitmask appropriately.

Typo in infoframes

With the above fixed, this is
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> 
> v2: Wrap a long line.
> 
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> b/drivers/gpu/drm/i915/display/intel_dp.c
> index 2bdc43c80e03..b265b5c599f2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2463,6 +2463,27 @@ static void intel_dp_compute_vsc_sdp(struct intel_dp
> *intel_dp,
>  					 &crtc_state->infoframes.vsc);
>  }
> 
> +static void
> +intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_crtc_state
> *crtc_state,
> +					    const struct drm_connector_state
> *conn_state) {
> +	int ret;
> +	struct hdmi_drm_infoframe *drm_infoframe > +&crtc_state->infoframes.drm.drm;
> +
> +	if (!conn_state->hdr_output_metadata)
> +		return;
> +
> +	ret = drm_hdmi_infoframe_set_hdr_metadata(drm_infoframe, conn_state);
> +
> +	if (ret) {
> +		DRM_DEBUG_KMS("couldn't set HDR metadata in infoframe\n");
> +		return;
> +	}
> +
> +	crtc_state->infoframes.enable |> +
> 	intel_hdmi_infoframe_enable(HDMI_PACKET_TYPE_GAMUT_METADATA);
> +}
> +
>  int
>  intel_dp_compute_config(struct intel_encoder *encoder,
>  			struct intel_crtc_state *pipe_config, @@ -2569,6 +2590,7
> @@ intel_dp_compute_config(struct intel_encoder *encoder,
> 
>  	intel_psr_compute_config(intel_dp, pipe_config);
>  	intel_dp_compute_vsc_sdp(intel_dp, pipe_config, conn_state);
> +	intel_dp_compute_hdr_metadata_infoframe_sdp(pipe_config, conn_state);
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
