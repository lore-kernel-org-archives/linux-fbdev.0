From: "Shankar, Uma" <uma.shankar@intel.com>
Date: Wed, 05 Feb 2020 16:42:41 +0000
Subject: RE: [PATCH v3 08/17] drm/i915: Include HDMI DRM infoframe in the crtc state dump
Message-Id: <E7C9878FBA1C6D42A1CA3F62AEB6945F823DD04E@BGSMSX104.gar.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200203232014.906651-1-gwan-gyeong.mun@intel.com>
 <20200203232014.906651-9-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200203232014.906651-9-gwan-gyeong.mun@intel.com>
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
> Subject: [PATCH v3 08/17] drm/i915: Include HDMI DRM infoframe in the crtc state
> dump
> 
> Dump out the HDMI Dynamic Range and Mastering (DRM) infoframe in the normal
> crtc state dump.

Looks good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> b/drivers/gpu/drm/i915/display/intel_display.c
> index c0e5002ce64c..239861bcedba 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -13030,6 +13030,9 @@ static void intel_dump_pipe_config(const struct
> intel_crtc_state *pipe_config,
>  	if (pipe_config->infoframes.enable &
>  	    intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_VENDOR))
>  		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.hdmi);
> +	if (pipe_config->infoframes.enable &
> +	    intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_DRM))
> +		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.drm);
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
