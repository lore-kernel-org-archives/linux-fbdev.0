From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 30 Oct 2017 09:43:16 +0000
Subject: Re: [Intel-gfx] [PATCH v3 3/7] drm: Add support for a panel-orientation connector property
Message-Id: <20171030094316.5z2aozramrpasyea@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
 <20171023071425.5090-4-hdegoede@redhat.com>
In-Reply-To: <20171023071425.5090-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

On Mon, Oct 23, 2017 at 09:14:21AM +0200, Hans de Goede wrote:
> On some devices the LCD panel is mounted in the casing in such a way that
> the up/top side of the panel does not match with the top side of the
> device (e.g. it is mounted upside-down).
> 
> This commit adds the necessary infra for lcd-panel drm_connector-s to
> have a "panel orientation" property to communicate how the panel is
> orientated vs the casing.
> 
> Userspace can use this property to check for non-normal orientation and
> then adjust the displayed image accordingly by rotating it to compensate.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rebased on 4.14-rc1
> -Store panel_orientation in drm_display_info, so that drm_fb_helper.c can
>  access it easily
> -Have a single drm_connector_init_panel_orientation_property rather then
>  create and attach functions. The caller is expected to set
>  drm_display_info.panel_orientation before calling this, then this will
>  check for platform specific quirks overriding the panel_orientation and if
>  the panel_orientation is set after this then it will attach the property.
> ---
>  drivers/gpu/drm/Kconfig         |  1 +
>  drivers/gpu/drm/drm_connector.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     | 11 +++++++
>  include/drm/drm_mode_config.h   |  7 ++++
>  include/uapi/drm/drm_mode.h     |  7 ++++
>  5 files changed, 99 insertions(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 9d005ac98c2b..0b166e626eb6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -7,6 +7,7 @@
>  menuconfig DRM
>  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
>  	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
> +	select DRM_PANEL_ORIENTATION_QUIRKS
>  	select HDMI
>  	select FB_CMDLINE
>  	select I2C
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 704fc8934616..129c83a84320 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
> +#include <drm/drm_utils.h>
>  
>  #include "drm_crtc_internal.h"
>  #include "drm_internal.h"
> @@ -212,6 +213,8 @@ int drm_connector_init(struct drm_device *dev,
>  	mutex_init(&connector->mutex);
>  	connector->edid_blob_ptr = NULL;
>  	connector->status = connector_status_unknown;
> +	connector->display_info.panel_orientation > +		DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
>  
>  	drm_connector_get_cmdline_mode(connector);
>  
> @@ -664,6 +667,13 @@ static const struct drm_prop_enum_list drm_aspect_ratio_enum_list[] = {
>  	{ DRM_MODE_PICTURE_ASPECT_16_9, "16:9" },
>  };
>  
> +static const struct drm_prop_enum_list drm_panel_orientation_enum_list[] = {
> +	{ DRM_MODE_PANEL_ORIENTATION_NORMAL,	"Normal"	},
> +	{ DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP,	"Upside Down"	},
> +	{ DRM_MODE_PANEL_ORIENTATION_LEFT_UP,	"Left Side Up"	},
> +	{ DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,	"Right Side Up"	},
> +};
> +
>  static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] = {
>  	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
>  	{ DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
> @@ -768,6 +778,18 @@ DRM_ENUM_NAME_FN(drm_get_tv_subconnector_name,
>   *
>   * CRTC_ID:
>   * 	Mode object ID of the &drm_crtc this connector should be connected to.
> + *
> + * Connectors for LCD panels may also have one standardized property:
> + *
> + * panel orientation:
> + *	On some devices the LCD panel is mounted in the casing in such a way
> + *	that the up/top side of the panel does not match with the top side of
> + *	the device. Userspace can use this property to check for this.
> + *	Note that input coordinates from touchscreens (input devices with
> + *	INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
> + *	coordinates, so if userspace rotates the picture to adjust for
> + *	the orientation it must also apply the same transformation to the
> + *	touchscreen input coordinates.
>   */
>  
>  int drm_connector_create_standard_properties(struct drm_device *dev)
> @@ -1234,6 +1256,57 @@ void drm_mode_connector_set_link_status_property(struct drm_connector *connector
>  }
>  EXPORT_SYMBOL(drm_mode_connector_set_link_status_property);
>  
> +/**
> + * drm_connector_init_panel_orientation_property -
> + *	initialize the connecters panel_orientation property
> + * @connector: connector for which to init the panel-orientation property.
> + * @width: width in pixels of the panel, used for panel quirk detection
> + * @height: height in pixels of the panel, used for panel quirk detection
> + *
> + * This function should only be called for built-in panels, after setting
> + * connector->display_info.panel_orientation first (if known).
> + *
> + * This function will check for platform specific (e.g. DMI based) quirks
> + * overriding display_info.panel_orientation first, then if panel_orientation
> + * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> + * "panel orientation" property to the connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */

Hm, I think our more usual way is to set the prop up first, and then the
parsing mode updates the property (in case it's not quite as stable as we
thought). Not the property init function calling the parsing code.

I know that the panel rotation will probably not change, but I think it'd
be good to be consistent here. Or at least look into whether that makes
sense ...

Besides this bikeshed color question makes all sense.
-Daniel

> +int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector, int width, int height)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_display_info *info = &connector->display_info;
> +	struct drm_property *prop;
> +	int orientation_quirk;
> +
> +	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
> +	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> +		info->panel_orientation = orientation_quirk;
> +
> +	if (info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> +		return 0;
> +
> +	prop = dev->mode_config.panel_orientation_property;
> +	if (!prop) {
> +		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> +				"panel orientation",
> +				drm_panel_orientation_enum_list,
> +				ARRAY_SIZE(drm_panel_orientation_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		dev->mode_config.panel_orientation_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop,
> +				   info->panel_orientation);
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
> +
>  int drm_mode_connector_set_obj_prop(struct drm_mode_object *obj,
>  				    struct drm_property *property,
>  				    uint64_t value)
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index b4285c40e1e4..e6883065a461 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -222,6 +222,15 @@ struct drm_display_info {
>  #define DRM_COLOR_FORMAT_YCRCB422	(1<<2)
>  #define DRM_COLOR_FORMAT_YCRCB420	(1<<3)
>  
> +	/**
> +	 * @panel_orientation: Read only connector property for built-in panels,
> +	 * indicating the orientation of the panel vs the device's casing.
> +	 * drm_connector_init() sets this to DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
> +	 * When not UNKNOWN this gets used by the drm_fb_helpers to rotate the
> +	 * fb to compensate and gets exported as prop to userspace.
> +	 */
> +	int panel_orientation;
> +
>  	/**
>  	 * @color_formats: HDMI Color formats, selects between RGB and YCrCb
>  	 * modes. Used DRM_COLOR_FORMAT\_ defines, which are _not_ the same ones
> @@ -1019,6 +1028,8 @@ int drm_mode_connector_update_edid_property(struct drm_connector *connector,
>  					    const struct edid *edid);
>  void drm_mode_connector_set_link_status_property(struct drm_connector *connector,
>  						 uint64_t link_status);
> +int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector, int width, int height);
>  
>  /**
>   * struct drm_tile_group - Tile group metadata
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 0b4ac2ebc610..7d4ee1726e0a 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -728,6 +728,13 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *suggested_y_property;
>  
> +	/**
> +	 * @panel_orientation_property: Optional connector property indicating
> +	 * how the lcd-panel is mounted inside the casing (e.g. normal or
> +	 * upside-down).
> +	 */
> +	struct drm_property *panel_orientation_property;
> +
>  	/* dumb ioctl parameters */
>  	uint32_t preferred_depth, prefer_shadow;
>  
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 34b6bb34b002..f60fae67bc1f 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -127,6 +127,13 @@ extern "C" {
>  #define DRM_MODE_LINK_STATUS_GOOD	0
>  #define DRM_MODE_LINK_STATUS_BAD	1
>  
> +/* Panel Orientation options */
> +#define DRM_MODE_PANEL_ORIENTATION_UNKNOWN	-1
> +#define DRM_MODE_PANEL_ORIENTATION_NORMAL	0
> +#define DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP	1
> +#define DRM_MODE_PANEL_ORIENTATION_LEFT_UP	2
> +#define DRM_MODE_PANEL_ORIENTATION_RIGHT_UP	3
> +
>  /*
>   * DRM_MODE_ROTATE_<degrees>
>   *
> -- 
> 2.14.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
