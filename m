From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 20 May 2016 14:31:43 +0000
Subject: Re: [PATCH 2/3] drm/imx: convey the pixelclk-active and de-active flags from DT to the ipu-di driver
Message-Id: <1463754703.4322.42.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
 <1463751294-24769-3-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1463751294-24769-3-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Lothar,

Am Freitag, den 20.05.2016, 15:34 +0200 schrieb Lothar Waßmann:
> Currently these flags are lost in the call
> drm_display_mode_from_videomode()
> 
> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>

thank you for the patches. The other two look fine to me, could you
rebase this one on top of:
https://patchwork.kernel.org/patch/9113791/ ("drm/imx: use bus_flags for
pixel clock polarity")?

regards
Philipp

> ---
>  drivers/gpu/drm/imx/imx-drm-core.c     | 12 +++++++----
>  drivers/gpu/drm/imx/imx-drm.h          |  7 ++++---
>  drivers/gpu/drm/imx/imx-ldb.c          | 37 ++++++++++++++++++++++++++--------
>  drivers/gpu/drm/imx/ipuv3-crtc.c       |  7 ++++---
>  drivers/gpu/drm/imx/parallel-display.c | 31 ++++++++++++++++++++++++----
>  drivers/gpu/ipu-v3/ipu-di.c            | 14 +++++++------
>  include/video/imx-ipu-v3.h             |  5 +----
>  7 files changed, 81 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 2453fb1..51735b1 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -96,7 +96,8 @@ static struct imx_drm_crtc *imx_drm_find_crtc(struct drm_crtc *crtc)
>  	return NULL;
>  }
>  
> -int imx_drm_set_bus_format_pins(struct drm_encoder *encoder, u32 bus_format,
> +int imx_drm_set_bus_format_pins(struct drm_encoder *encoder,
> +		u32 bus_format, u32 bus_flags,
>  		int hsync_pin, int vsync_pin)
>  {
>  	struct imx_drm_crtc_helper_funcs *helper;
> @@ -109,14 +110,17 @@ int imx_drm_set_bus_format_pins(struct drm_encoder *encoder, u32 bus_format,
>  	helper = &imx_crtc->imx_drm_helper_funcs;
>  	if (helper->set_interface_pix_fmt)
>  		return helper->set_interface_pix_fmt(encoder->crtc,
> -					bus_format, hsync_pin, vsync_pin);
> +					bus_format, bus_flags,
> +					hsync_pin, vsync_pin);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(imx_drm_set_bus_format_pins);
>  
> -int imx_drm_set_bus_format(struct drm_encoder *encoder, u32 bus_format)
> +int imx_drm_set_bus_format(struct drm_encoder *encoder, u32 bus_format,
> +		u32 bus_flags)
>  {
> -	return imx_drm_set_bus_format_pins(encoder, bus_format, 2, 3);
> +	return imx_drm_set_bus_format_pins(encoder, bus_format, bus_flags,
> +					2, 3);
>  }
>  EXPORT_SYMBOL_GPL(imx_drm_set_bus_format);
>  
> diff --git a/drivers/gpu/drm/imx/imx-drm.h b/drivers/gpu/drm/imx/imx-drm.h
> index b0241b9..b74baf7 100644
> --- a/drivers/gpu/drm/imx/imx-drm.h
> +++ b/drivers/gpu/drm/imx/imx-drm.h
> @@ -19,7 +19,8 @@ struct imx_drm_crtc_helper_funcs {
>  	int (*enable_vblank)(struct drm_crtc *crtc);
>  	void (*disable_vblank)(struct drm_crtc *crtc);
>  	int (*set_interface_pix_fmt)(struct drm_crtc *crtc,
> -			u32 bus_format, int hsync_pin, int vsync_pin);
> +			u32 bus_format, u32 bus_flags,
> +			int hsync_pin, int vsync_pin);
>  	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
>  	const struct drm_crtc_funcs *crtc_funcs;
>  };
> @@ -42,9 +43,9 @@ void imx_drm_mode_config_init(struct drm_device *drm);
>  struct drm_gem_cma_object *imx_drm_fb_get_obj(struct drm_framebuffer *fb);
>  
>  int imx_drm_set_bus_format_pins(struct drm_encoder *encoder,
> -		u32 bus_format, int hsync_pin, int vsync_pin);
> +		u32 bus_format, u32 bus_flags, int hsync_pin, int vsync_pin);
>  int imx_drm_set_bus_format(struct drm_encoder *encoder,
> -		u32 bus_format);
> +		u32 bus_format, u32 bus_flags);
>  
>  int imx_drm_encoder_parse_of(struct drm_device *drm,
>  	struct drm_encoder *encoder, struct device_node *np);
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index b2dc4df..67706eea 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_graph.h>
>  #include <video/of_display_timing.h>
>  #include <video/of_videomode.h>
> +#include <video/videomode.h>
>  #include <linux/regmap.h>
>  #include <linux/videodev2.h>
>  
> @@ -65,7 +66,8 @@ struct imx_ldb_channel {
>  	int edid_len;
>  	struct drm_display_mode mode;
>  	int mode_valid;
> -	int bus_format;
> +	u32 bus_format;
> +	u32 bus_flags;
>  };
>  
>  struct bus_mux {
> @@ -102,8 +104,10 @@ static int imx_ldb_connector_get_modes(struct drm_connector *connector)
>  		struct drm_display_info *di = &connector->display_info;
>  
>  		num_modes = imx_ldb_ch->panel->funcs->get_modes(imx_ldb_ch->panel);
> -		if (!imx_ldb_ch->bus_format && di->num_bus_formats)
> +		if (!imx_ldb_ch->bus_format && di->num_bus_formats) {
>  			imx_ldb_ch->bus_format = di->bus_formats[0];
> +			imx_ldb_ch->bus_flags = di->bus_flags;
> +		}
>  		if (num_modes > 0)
>  			return num_modes;
>  	}
> @@ -202,7 +206,8 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
>  		break;
>  	}
>  
> -	imx_drm_set_bus_format(encoder, bus_format);
> +	imx_drm_set_bus_format(encoder, bus_format,
> +			imx_ldb_ch->bus_flags);
>  }
>  
>  static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
> @@ -558,7 +563,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>  
>  		ret = of_property_read_u32(child, "reg", &i);
>  		if (ret || i < 0 || i > 1)
> -			return -EINVAL;
> +			return ret ?: -EINVAL;
>  
>  		if (dual && i > 0) {
>  			dev_warn(dev, "dual-channel mode, ignoring second output\n");
> @@ -601,10 +606,26 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>  			channel->edid = kmemdup(edidp, channel->edid_len,
>  						GFP_KERNEL);
>  		} else if (!channel->panel) {
> -			ret = of_get_drm_display_mode(child, &channel->mode,
> -						OF_USE_NATIVE_MODE);
> -			if (!ret)
> -				channel->mode_valid = 1;
> +			struct videomode vm;
> +
> +			ret = of_get_videomode(child, &vm, OF_USE_NATIVE_MODE);
> +			if (ret)
> +				return ret;
> +
> +			drm_display_mode_from_videomode(&vm, &channel->mode);
> +
> +			if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +				channel->bus_flags |= DRM_BUS_FLAG_PIXDATA_POSEDGE;
> +			if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +				channel->bus_flags |= DRM_BUS_FLAG_PIXDATA_NEGEDGE;
> +
> +			if (vm.flags & DISPLAY_FLAGS_DE_LOW)
> +				channel->bus_flags |= DRM_BUS_FLAG_DE_LOW;
> +			if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +				channel->bus_flags |= DRM_BUS_FLAG_DE_HIGH;
> +
> +			drm_mode_debug_printmodeline(&channel->mode);
> +			channel->mode_valid = 1;
>  		}
>  
>  		channel->bus_format = of_get_bus_format(dev, child);
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index dee8e8b..3fb9ac7 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -66,6 +66,7 @@ struct ipu_crtc {
>  	struct ipu_flip_work	*flip_work;
>  	int			irq;
>  	u32			bus_format;
> +	u32			bus_flags;
>  	int			di_hsync_pin;
>  	int			di_vsync_pin;
>  };
> @@ -271,9 +272,8 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
>  	else
>  		sig_cfg.clkflags = 0;
>  
> -	sig_cfg.enable_pol = 1;
> -	sig_cfg.clk_pol = 0;
>  	sig_cfg.bus_format = ipu_crtc->bus_format;
> +	sig_cfg.bus_flags = ipu_crtc->bus_flags;
>  	sig_cfg.v_to_h_sync = 0;
>  	sig_cfg.hsync_pin = ipu_crtc->di_hsync_pin;
>  	sig_cfg.vsync_pin = ipu_crtc->di_vsync_pin;
> @@ -396,11 +396,12 @@ static void ipu_disable_vblank(struct drm_crtc *crtc)
>  }
>  
>  static int ipu_set_interface_pix_fmt(struct drm_crtc *crtc,
> -		u32 bus_format, int hsync_pin, int vsync_pin)
> +		u32 bus_format, u32 bus_flags, int hsync_pin, int vsync_pin)
>  {
>  	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
>  
>  	ipu_crtc->bus_format = bus_format;
> +	ipu_crtc->bus_flags = bus_flags;
>  	ipu_crtc->di_hsync_pin = hsync_pin;
>  	ipu_crtc->di_vsync_pin = vsync_pin;
>  
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index 363e2c7..440f34d 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -19,9 +19,12 @@
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_panel.h>
> +#include <linux/of_graph.h>
>  #include <linux/videodev2.h>
> +#include <video/display_timing.h>
>  #include <video/of_display_timing.h>
> -#include <linux/of_graph.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
>  
>  #include "imx-drm.h"
>  
> @@ -35,6 +38,7 @@ struct imx_parallel_display {
>  	void *edid;
>  	int edid_len;
>  	u32 bus_format;
> +	u32 bus_flags;
>  	int mode_valid;
>  	struct drm_display_mode mode;
>  	struct drm_panel *panel;
> @@ -57,8 +61,10 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
>  		struct drm_display_info *di = &connector->display_info;
>  
>  		num_modes = imxpd->panel->funcs->get_modes(imxpd->panel);
> -		if (!imxpd->bus_format && di->num_bus_formats)
> +		if (!imxpd->bus_format && di->num_bus_formats) {
>  			imxpd->bus_format = di->bus_formats[0];
> +			imxpd->bus_flags = di->bus_flags;
> +		}
>  		if (num_modes > 0)
>  			return num_modes;
>  	}
> @@ -81,10 +87,27 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
>  
>  	if (np) {
>  		struct drm_display_mode *mode = drm_mode_create(connector->dev);
> +		struct videomode vm;
> +		int ret;
>  
>  		if (!mode)
>  			return -EINVAL;
> -		of_get_drm_display_mode(np, &imxpd->mode, OF_USE_NATIVE_MODE);
> +
> +		ret = of_get_videomode(np, &vm, OF_USE_NATIVE_MODE);
> +		if (ret)
> +			return ret;
> +		drm_display_mode_from_videomode(&vm, &imxpd->mode);
> +		drm_mode_debug_printmodeline(&imxpd->mode);
> +
> +		if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +			imxpd->bus_flags |= DRM_BUS_FLAG_PIXDATA_POSEDGE;
> +		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +			imxpd->bus_flags |= DRM_BUS_FLAG_PIXDATA_NEGEDGE;
> +
> +		if (vm.flags & DISPLAY_FLAGS_DE_LOW)
> +			imxpd->bus_flags |= DRM_BUS_FLAG_DE_LOW;
> +		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +			imxpd->bus_flags |= DRM_BUS_FLAG_DE_HIGH;
>  		drm_mode_copy(mode, &imxpd->mode);
>  		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>  		drm_mode_probed_add(connector, mode);
> @@ -116,7 +139,7 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
>  {
>  	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
>  
> -	imx_drm_set_bus_format(encoder, imxpd->bus_format);
> +	imx_drm_set_bus_format(encoder, imxpd->bus_format, imxpd->bus_flags);
>  }
>  
>  static void imx_pd_encoder_commit(struct drm_encoder *encoder)
> diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
> index 359268e..bff4701 100644
> --- a/drivers/gpu/ipu-v3/ipu-di.c
> +++ b/drivers/gpu/ipu-v3/ipu-di.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  
> +#include <drm/drm_crtc.h>
>  #include <video/imx-ipu-v3.h>
>  #include "ipu-prv.h"
>  
> @@ -622,7 +623,9 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  	if (sig->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH)
>  		di_gen |= ipu_di_gen_polarity(sig->vsync_pin);
>  
> -	if (sig->clk_pol)
> +	if (sig->bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> +		di_gen &= ~DI_GEN_POLARITY_DISP_CLK;
> +	else if (sig->bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
>  		di_gen |= DI_GEN_POLARITY_DISP_CLK;
>  
>  	ipu_di_write(di, di_gen, DI_GENERAL);
> @@ -630,13 +633,12 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  	ipu_di_write(di, (--vsync_cnt << DI_VSYNC_SEL_OFFSET) | 0x00000002,
>  		     DI_SYNC_AS_GEN);
>  
> -	reg = ipu_di_read(di, DI_POL);
> -	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
> +	reg = ipu_di_read(di, DI_POL) & ~DI_POL_DRDY_DATA_POLARITY;
>  
> -	if (sig->enable_pol)
> +	if (sig->bus_flags & DRM_BUS_FLAG_DE_HIGH)
>  		reg |= DI_POL_DRDY_POLARITY_15;
> -	if (sig->data_pol)
> -		reg |= DI_POL_DRDY_DATA_POLARITY;
> +	else if (sig->bus_flags & DRM_BUS_FLAG_DE_LOW)
> +		reg &= ~DI_POL_DRDY_POLARITY_15;
>  
>  	ipu_di_write(di, reg, DI_POL);
>  
> diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
> index ad66589..7c64c55 100644
> --- a/include/video/imx-ipu-v3.h
> +++ b/include/video/imx-ipu-v3.h
> @@ -33,13 +33,10 @@ enum ipuv3_type {
>   * Bitfield of Display Interface signal polarities.
>   */
>  struct ipu_di_signal_cfg {
> -	unsigned data_pol:1;	/* true = inverted */
> -	unsigned clk_pol:1;	/* true = rising edge */
> -	unsigned enable_pol:1;
> -
>  	struct videomode mode;
>  
>  	u32 bus_format;
> +	u32 bus_flags;
>  	u32 v_to_h_sync;
>  
>  #define IPU_DI_CLKMODE_SYNC	(1 << 0)


