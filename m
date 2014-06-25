From: Archit Taneja <archit@ti.com>
Date: Wed, 25 Jun 2014 11:15:49 +0000
Subject: Re: [PATCH 15/15] drm/omap: Add infoframe & dvi/hdmi mode support
Message-Id: <53AAAC95.3070409@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jyri Sarha <jsarha@ti.com>, Rob Clark <robdclark@gmail.com>

Hi,

On Tuesday 24 June 2014 03:34 PM, Tomi Valkeinen wrote:
> Make the omapdrm driver use the new HDMI ops when possible.
>
> omapdrm will call set_hdmi_mode (when available) to tell the encoder
> driver whether the monitor is a DVI or HDMI monitor, and if it's an HDMI
> monitor, omapdrm will call set_hdmi_infoframe to to set the AVI
> infoframe.

<snip>


> @@ -89,6 +91,31 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
>   				struct drm_display_mode *mode,
>   				struct drm_display_mode *adjusted_mode)
>   {
> +	struct drm_device *dev = encoder->dev;
> +	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
> +	struct omap_dss_device *dssdev = omap_encoder->dssdev;
> +	struct drm_connector *connector;
> +	bool hdmi_mode;
> +	int r;
> +
> +	hdmi_mode = false;
> +	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> +		if (connector->encoder = encoder) {
> +			hdmi_mode = omap_connector_get_hdmi_mode(connector);
> +			break;
> +		}
> +	}
> +
> +	if (dssdev->driver->set_hdmi_mode)
> +		dssdev->driver->set_hdmi_mode(dssdev, hdmi_mode);

When a HDMI monitor is replaced with a DVI one, we call the 
set_hdmi_mode() driver op to set the mode to DVI. But we don't call 
set_hdmi_infoframe() when the mode is set back to DVI. Do we need to set 
avi infoframe registers back to a default value, or are those registers 
just ignored in DVI mode?

> +
> +	if (hdmi_mode && dssdev->driver->set_hdmi_infoframe) {
> +		struct hdmi_avi_infoframe avi;
> +
> +		r = drm_hdmi_avi_infoframe_from_display_mode(&avi, adjusted_mode);
> +		if (r = 0)
> +			dssdev->driver->set_hdmi_infoframe(dssdev, &avi);
> +	}
>   }
>

Archit

