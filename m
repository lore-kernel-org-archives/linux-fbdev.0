From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 21 Sep 2012 13:07:04 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <201209211507.04866.hverkuil@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree-discuss@lists.ozlabs.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed September 19 2012 10:20:43 Steffen Trumtrar wrote:
> This patch adds a helper function for parsing videomodes from the devicetree.
> The videomode can be either converted to a struct drm_display_mode or a
> struct fb_videomode.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> 
> Hi!
> 
> changes since v3:
> 	- print error messages
> 	- free alloced memory
> 	- general cleanup
> 
> Regards
> Steffen
> 
>  .../devicetree/bindings/video/displaymode          |   74 +++++
>  drivers/of/Kconfig                                 |    5 +
>  drivers/of/Makefile                                |    1 +
>  drivers/of/of_videomode.c                          |  283 ++++++++++++++++++++
>  include/linux/of_videomode.h                       |   56 ++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/displaymode
>  create mode 100644 drivers/of/of_videomode.c
>  create mode 100644 include/linux/of_videomode.h
> 
> diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode
> new file mode 100644
> index 0000000..990ca52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/displaymode
> @@ -0,0 +1,74 @@
> +videomode bindings
> +=========
> +
> +Required properties:
> + - hactive, vactive: Display resolution
> + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing parameters
> +   in pixels
> +   vfront-porch, vback-porch, vsync-len: Vertical display timing parameters in
> +   lines

In the case of interlaced formats, can the vfront-porch, vback-porch and vsync-len
for the second field always be calculated from these values? Is that fully
standardized or can there be exceptions? struct v4l2_bt_timings has separate fields
for these, but that may have been overkill.

> + - clock: displayclock in Hz

CEA-861 defined the option to slightly lower the clock frequency by 1.000/1.001 to
achieve frequencies like 29.97 or 59.94. In v4l2_bt_timings I made a flag for that.
I'm not sure whether it is better to just set the clock to the correct frequency
(which is a weird value) or mark it with a bool.

> +
> +Optional properties:
> + - width-mm, height-mm: Display dimensions in mm
> + - hsync-active-high (bool): Hsync pulse is active high
> + - vsync-active-high (bool): Vsync pulse is active high
> + - interlaced (bool): This is an interlaced mode
> + - doublescan (bool): This is a doublescan mode
> +
> +There are different ways of describing a display mode. The devicetree representation
> +corresponds to the one commonly found in datasheets for displays.
> +The description of the display and its mode is split in two parts: first the display
> +properties like size in mm and (optionally) multiple subnodes with the supported modes.
> +
> +Example:
> +
> +	display@0 {
> +		width-mm = <800>;
> +		height-mm = <480>;
> +		modes {
> +			mode0: mode@0 {
> +				/* 1920x1080p24 */
> +				clock = <52000000>;
> +				hactive = <1920>;
> +				vactive = <1080>;
> +				hfront-porch = <25>;
> +				hback-porch = <25>;
> +				hsync-len = <25>;
> +				vback-porch = <2>;
> +				vfront-porch = <2>;
> +				vsync-len = <2>;
> +				hsync-active-high;
> +			};
> +		};
> +	};
> +
> +Every property also supports the use of ranges, so the commonly used datasheet
> +description with <min typ max>-tuples can be used.
> +
> +Example:
> +
> +	mode1: mode@1 {
> +		/* 1920x1080p24 */
> +		clock = <148500000>;
> +		hactive = <1920>;
> +		vactive = <1080>;
> +		hsync-len = <0 44 60>;
> +		hfront-porch = <80 88 95>;
> +		hback-porch = <100 148 160>;
> +		vfront-porch = <0 4 6>;
> +		vback-porch = <0 36 50>;
> +		vsync-len = <0 5 6>;
> +	};
> +
> +The videomode can be linked to a connector via phandles. The connector has to
> +support the display- and default-mode-property to link to and select a mode.
> +
> +Example:
> +
> +	hdmi@00120000 {
> +		status = "okay";
> +		display = <&benq>;
> +		default-mode = <&mode1>;
> +	};
> +
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index dfba3e6..a3acaa3 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -83,4 +83,9 @@ config OF_MTD
>  	depends on MTD
>  	def_bool y
>  
> +config OF_VIDEOMODE
> +	def_bool y
> +	help
> +	  helper to parse videomodes from the devicetree
> +
>  endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e027f44..80e6db3 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
>  obj-$(CONFIG_OF_PCI)	+= of_pci.o
>  obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
>  obj-$(CONFIG_OF_MTD)	+= of_mtd.o
> +obj-$(CONFIG_OF_VIDEOMODE)	+= of_videomode.o
> diff --git a/drivers/of/of_videomode.c b/drivers/of/of_videomode.c
> new file mode 100644
> index 0000000..52bfc74
> --- /dev/null
> +++ b/drivers/of/of_videomode.c
> @@ -0,0 +1,283 @@
> +/*
> + * OF helpers for parsing display modes
> + *
> + * Copyright (c) 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> + * Copyright (c) 2012 Steffen Trumtrar <s.trumtrar@pengutronix.de>, Pengutronix
> + *
> + * This file is released under the GPLv2
> + */
> +#include <linux/of.h>
> +#include <linux/fb.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <linux/of_videomode.h>
> +
> +static u32 of_video_get_value(struct mode_property *prop)
> +{
> +	return (prop->min >= prop->typ) ? prop->min : prop->typ;
> +}
> +
> +/* read property into new mode_property */
> +static int of_video_parse_property(struct device_node *np, char *name,
> +				struct mode_property *result)
> +{
> +	struct property *prop;
> +	int length;
> +	int cells;
> +	int ret;
> +
> +	prop = of_find_property(np, name, &length);
> +	if (!prop) {
> +		pr_err("%s: could not find property %s\n", __func__,
> +			name);
> +		return -EINVAL;
> +	}
> +
> +	cells = length / sizeof(u32);
> +
> +	memset(result, 0, sizeof(*result));
> +
> +	ret = of_property_read_u32_array(np, name, &result->min, cells);
> +
> +	return ret;
> +}
> +
> +static int of_video_free(struct display *disp)
> +{
> +	int i;
> +
> +	for (i=0; i<disp->num_modes; i++)
> +		kfree(disp->modes[i]);
> +	kfree(disp->modes);
> +
> +	return 0;
> +}
> +
> +int videomode_to_display_mode(struct display *disp, struct drm_display_mode *dmode, int index)
> +{
> +	struct videomode *vm;
> +
> +	memset(dmode, 0, sizeof(*dmode));
> +
> +	if (index > disp->num_modes) {
> +		pr_err("%s: wrong index: %d from %d\n", __func__, index, disp->num_modes);
> +		return -EINVAL;
> +	}
> +
> +	vm = disp->modes[index];
> +
> +	dmode->hdisplay = of_video_get_value(&vm->hactive);
> +	dmode->hsync_start = of_video_get_value(&vm->hactive) + of_video_get_value(&vm->hfront_porch);
> +	dmode->hsync_end = of_video_get_value(&vm->hactive) + of_video_get_value(&vm->hfront_porch)
> +			+ of_video_get_value(&vm->hsync_len);
> +	dmode->htotal = of_video_get_value(&vm->hactive) + of_video_get_value(&vm->hfront_porch)
> +			+ of_video_get_value(&vm->hsync_len) + of_video_get_value(&vm->hback_porch);
> +
> +	dmode->vdisplay = of_video_get_value(&vm->vactive);
> +	dmode->vsync_start = of_video_get_value(&vm->vactive) + of_video_get_value(&vm->vfront_porch);
> +	dmode->vsync_end = of_video_get_value(&vm->vactive) + of_video_get_value(&vm->vfront_porch)
> +			+ of_video_get_value(&vm->vsync_len);
> +	dmode->vtotal = of_video_get_value(&vm->vactive) + of_video_get_value(&vm->vfront_porch) +
> +			of_video_get_value(&vm->vsync_len) + of_video_get_value(&vm->vback_porch);
> +
> +	dmode->width_mm = disp->width_mm;
> +	dmode->height_mm = disp->height_mm;
> +
> +	dmode->clock = of_video_get_value(&vm->clock) / 1000;
> +
> +	if (vm->hah)
> +		dmode->flags |= DRM_MODE_FLAG_PHSYNC;
> +	else
> +		dmode->flags |= DRM_MODE_FLAG_NHSYNC;
> +	if (vm->vah)
> +		dmode->flags |= DRM_MODE_FLAG_PVSYNC;
> +	else
> +		dmode->flags |= DRM_MODE_FLAG_NVSYNC;
> +	if (vm->interlaced)
> +		dmode->flags |= DRM_MODE_FLAG_INTERLACE;
> +	if (vm->doublescan)
> +		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
> +
> +	drm_mode_set_name(dmode);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(videomode_to_display_mode);
> +
> +int videomode_to_fb_mode(struct display *disp, struct fb_videomode *fbmode, int index)
> +{
> +	struct videomode *vm;
> +
> +	memset(fbmode, 0, sizeof(*fbmode));
> +
> +	if (index > disp->num_modes) {
> +		pr_err("%s: wrong index: %d from %d\n", __func__, index, disp->num_modes);
> +		return -EINVAL;
> +	}
> +
> +	vm = disp->modes[index];
> +
> +	fbmode->xres = of_video_get_value(&vm->hactive);
> +	fbmode->left_margin = of_video_get_value(&vm->hback_porch);
> +	fbmode->right_margin = of_video_get_value(&vm->hfront_porch);
> +	fbmode->hsync_len = of_video_get_value(&vm->hsync_len);
> +
> +	fbmode->yres = of_video_get_value(&vm->vactive);
> +	fbmode->upper_margin = of_video_get_value(&vm->vback_porch);
> +	fbmode->lower_margin = of_video_get_value(&vm->vfront_porch);
> +	fbmode->vsync_len = of_video_get_value(&vm->vsync_len);
> +
> +	fbmode->pixclock = KHZ2PICOS(of_video_get_value(&vm->clock) / 1000);
> +
> +	if (vm->hah)
> +		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> +	if (vm->vah)
> +		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
> +	if (vm->interlaced)
> +		fbmode->vmode |= FB_VMODE_INTERLACED;
> +	if (vm->doublescan)
> +		fbmode->vmode |= FB_VMODE_DOUBLE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(videomode_to_fb_mode);
> +
> +int of_get_video_modes(struct device_node *np, struct display *disp)
> +{
> +	struct device_node *display_np;
> +	struct device_node *mode_np;
> +	struct device_node *modes_np;
> +	char *default_mode;
> +
> +	int ret = 0;
> +
> +	memset(disp, 0, sizeof(*disp));
> +	disp->modes = kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +
> +	if (!np) {
> +		pr_err("%s: no node provided\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	display_np = of_parse_phandle(np, "display", 0);
> +
> +	if (!display_np) {
> +		pr_err("%s: could not find display node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_u32(display_np, "width-mm", &disp->width_mm);
> +	of_property_read_u32(display_np, "height-mm", &disp->height_mm);
> +
> +	mode_np = of_parse_phandle(np, "default-mode", 0);
> +
> +	if (!mode_np) {
> +		pr_info("%s: no default-mode specified.\n", __func__);
> +		mode_np = of_find_node_by_name(np, "mode");
> +	}
> +
> +	if (!mode_np) {
> +		pr_err("%s: could not find any mode specification\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	default_mode = (char *)mode_np->full_name;
> +
> +	modes_np = of_find_node_by_name(np, "modes");
> +	for_each_child_of_node(modes_np, mode_np) {
> +		struct videomode *vm;
> +
> +		vm = kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +		disp->modes[disp->num_modes] = kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +
> +		ret |= of_video_parse_property(mode_np, "hback-porch", &vm->hback_porch);
> +		ret |= of_video_parse_property(mode_np, "hfront-porch", &vm->hfront_porch);
> +		ret |= of_video_parse_property(mode_np, "hactive", &vm->hactive);
> +		ret |= of_video_parse_property(mode_np, "hsync-len", &vm->hsync_len);
> +		ret |= of_video_parse_property(mode_np, "vback-porch", &vm->vback_porch);
> +		ret |= of_video_parse_property(mode_np, "vfront-porch", &vm->vfront_porch);
> +		ret |= of_video_parse_property(mode_np, "vactive", &vm->vactive);
> +		ret |= of_video_parse_property(mode_np, "vsync-len", &vm->vsync_len);
> +		ret |= of_video_parse_property(mode_np, "clock", &vm->clock);
> +
> +		if (ret)
> +			return -EINVAL;
> +
> +		vm->hah = of_property_read_bool(mode_np, "hsync-active-high");
> +		vm->vah = of_property_read_bool(mode_np, "vsync-active-high");
> +		vm->interlaced = of_property_read_bool(mode_np, "interlaced");
> +		vm->doublescan = of_property_read_bool(mode_np, "doublescan");
> +
> +		if (strcmp(default_mode,mode_np->full_name) = 0)
> +			disp->default_mode = disp->num_modes;
> +
> +		disp->modes[disp->num_modes] = vm;
> +		disp->num_modes++;
> +	}
> +	of_node_put(display_np);
> +
> +	pr_info("%s: found %d modelines. Using #%d as default\n", __func__,
> +		disp->num_modes, disp->default_mode + 1);
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_video_modes);
> +
> +int of_video_mode_exists(struct device_node *np)
> +{
> +	struct device_node *display_np;
> +	struct device_node *mode_np;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	display_np = of_parse_phandle(np, "display", 0);
> +
> +	if (!display_np)
> +		return -EINVAL;
> +
> +	mode_np = of_parse_phandle(np, "default-mode", 0);
> +
> +	if (mode_np)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(of_video_mode_exists);
> +
> +int of_get_display_mode(struct device_node *np, struct drm_display_mode *dmode, int index)
> +{
> +	struct display disp;
> +
> +	of_get_video_modes(np, &disp);
> +
> +	if (index = OF_MODE_SELECTION)
> +		index = disp.default_mode;
> +	if (dmode)
> +		videomode_to_display_mode(&disp, dmode, index);
> +
> +	of_video_free(&disp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_display_mode);
> +
> +int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fbmode, int index)
> +{
> +	struct display disp;
> +
> +	of_get_video_modes(np, &disp);
> +
> +	if (index = OF_MODE_SELECTION)
> +		index = disp.default_mode;
> +	if (fbmode)
> +		videomode_to_fb_mode(&disp, fbmode, index);
> +
> +	of_video_free(&disp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_fb_videomode);
> diff --git a/include/linux/of_videomode.h b/include/linux/of_videomode.h
> new file mode 100644
> index 0000000..5571ce3
> --- /dev/null
> +++ b/include/linux/of_videomode.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright 2012 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> + *
> + * OF helpers for videomodes.
> + *
> + * This file is released under the GPLv2
> + */
> +
> +#ifndef __LINUX_OF_VIDEOMODE_H
> +#define __LINUX_OF_VIDEOMODE_H
> +
> +#define OF_MODE_SELECTION -1
> +
> +struct mode_property {
> +	u32 min;
> +	u32 typ;
> +	u32 max;
> +};

For what purpose are the min and max values added? To specify hardware limitations?
If it is the latter, then I think it would be a better approach to split that off
in its own struct.

For V4L2 we made a separate capability struct:

http://hverkuil.home.xs4all.nl/spec/media.html#vidioc-dv-timings-cap

Regards,

	Hans

> +
> +struct display {
> +	u32 width_mm;
> +	u32 height_mm;
> +	struct videomode **modes;
> +	int default_mode;
> +	int num_modes;
> +};
> +
> +/* describe videomode in terms of hardware parameters */
> +struct videomode {
> +	struct mode_property hback_porch;
> +	struct mode_property hfront_porch;
> +	struct mode_property hactive;
> +	struct mode_property hsync_len;
> +
> +	struct mode_property vback_porch;
> +	struct mode_property vfront_porch;
> +	struct mode_property vactive;
> +	struct mode_property vsync_len;
> +
> +	struct mode_property clock;
> +
> +	bool hah;
> +	bool vah;
> +	bool interlaced;
> +	bool doublescan;
> +};
> +
> +int of_video_mode_exists(struct device_node *np);
> +int videomode_to_display_mode(struct display *disp, struct drm_display_mode *dmode, int index);
> +int videomode_to_fb_mode(struct display *disp, struct fb_videomode *fbmode, int index);
> +int of_get_video_modes(struct device_node *np, struct display *disp);
> +int of_video_mode_exists(struct device_node *np);
> +int of_get_display_mode(struct device_node *np, struct drm_display_mode *dmode, int index);
> +int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fbmode, int index);
> +#endif /* __LINUX_OF_VIDEOMODE_H */
> 
