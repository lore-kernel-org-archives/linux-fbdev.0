From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 17:02:56 +0000
Subject: RE: [PATCH v3 14/17] drm/i915: Program DP SDPs on pipe updates
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD12A@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-15-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-15-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 14/17] drm/i915: Program DP SDPs on pipe updates
> 
> Call intel_dp_set_infoframes() function on pipe updates to make sure that we send
> VSC SDP and HDR Metadata Infoframe SDP (when applicable) on fastsets.

Looks good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 64e4edefa998..69073a15edb8 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4062,6 +4062,7 @@ static void intel_ddi_update_pipe_dp(struct intel_encoder
> *encoder,
>  	intel_ddi_set_dp_msa(crtc_state, conn_state);
> 
>  	intel_psr_update(intel_dp, crtc_state);
> +	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
>  	intel_edp_drrs_enable(intel_dp, crtc_state);
> 
>  	intel_panel_update_backlight(encoder, crtc_state, conn_state);
> --
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
