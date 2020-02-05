From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 17:05:48 +0000
Subject: RE: [PATCH v3 15/17] drm/i915: Stop sending DP SDPs on intel_ddi_post_disable_dp()
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD14C@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-16-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-16-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 15/17] drm/i915: Stop sending DP SDPs on
> intel_ddi_post_disable_dp()

Just say " Stop sending DP SDPs on ddi disable"

> Call intel_dp_set_infoframes(false) function on intel_ddi_post_disable_dp() to make
> sure not to send VSC SDP and HDR Metadata Infoframe SDP.

With the above fixed.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 69073a15edb8..8509cd33569e 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3713,6 +3713,8 @@ static void intel_ddi_post_disable_dp(struct intel_encoder
> *encoder,
>  					  INTEL_OUTPUT_DP_MST);
>  	enum phy phy = intel_port_to_phy(dev_priv, encoder->port);
> 
> +	intel_dp_set_infoframes(encoder, false, old_crtc_state,
> +old_conn_state);
> +
>  	/*
>  	 * Power down sink before disabling the port, otherwise we end
>  	 * up getting interrupts from the sink on detecting link loss.
> --
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
