From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Sep 2012 09:19:22 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <1348046362.2565.16.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-LQgo8dwyl86G74LmmECZ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1348042843-24673-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>


--=-LQgo8dwyl86G74LmmECZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-19 at 10:20 +0200, Steffen Trumtrar wrote:
> This patch adds a helper function for parsing videomodes from the devicet=
ree.
> The videomode can be either converted to a struct drm_display_mode or a
> struct fb_videomode.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>=20
> Hi!
>=20
> changes since v3:
> 	- print error messages
> 	- free alloced memory
> 	- general cleanup
>=20
> Regards
> Steffen
>=20
>  .../devicetree/bindings/video/displaymode          |   74 +++++
>  drivers/of/Kconfig                                 |    5 +
>  drivers/of/Makefile                                |    1 +
>  drivers/of/of_videomode.c                          |  283 ++++++++++++++=
++++++
>  include/linux/of_videomode.h                       |   56 ++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/displaymode
>  create mode 100644 drivers/of/of_videomode.c
>  create mode 100644 include/linux/of_videomode.h
>=20
> diff --git a/Documentation/devicetree/bindings/video/displaymode b/Docume=
ntation/devicetree/bindings/video/displaymode
> new file mode 100644
> index 0000000..990ca52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/displaymode
> @@ -0,0 +1,74 @@
> +videomode bindings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> + - hactive, vactive: Display resolution
> + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing param=
eters
> +   in pixels
> +   vfront-porch, vback-porch, vsync-len: Vertical display timing paramet=
ers in
> +   lines
> + - clock: displayclock in Hz
> +
> +Optional properties:
> + - width-mm, height-mm: Display dimensions in mm
> + - hsync-active-high (bool): Hsync pulse is active high
> + - vsync-active-high (bool): Vsync pulse is active high
> + - interlaced (bool): This is an interlaced mode
> + - doublescan (bool): This is a doublescan mode
> +
> +There are different ways of describing a display mode. The devicetree re=
presentation
> +corresponds to the one commonly found in datasheets for displays.
> +The description of the display and its mode is split in two parts: first=
 the display
> +properties like size in mm and (optionally) multiple subnodes with the s=
upported modes.
> +
> +Example:
> +
> +	display@0 {
> +		width-mm =3D <800>;
> +		height-mm =3D <480>;
> +		modes {
> +			mode0: mode@0 {
> +				/* 1920x1080p24 */
> +				clock =3D <52000000>;
> +				hactive =3D <1920>;
> +				vactive =3D <1080>;
> +				hfront-porch =3D <25>;
> +				hback-porch =3D <25>;
> +				hsync-len =3D <25>;
> +				vback-porch =3D <2>;
> +				vfront-porch =3D <2>;
> +				vsync-len =3D <2>;
> +				hsync-active-high;
> +			};
> +		};
> +	};
> +
> +Every property also supports the use of ranges, so the commonly used dat=
asheet
> +description with <min typ max>-tuples can be used.
> +
> +Example:
> +
> +	mode1: mode@1 {
> +		/* 1920x1080p24 */
> +		clock =3D <148500000>;
> +		hactive =3D <1920>;
> +		vactive =3D <1080>;
> +		hsync-len =3D <0 44 60>;
> +		hfront-porch =3D <80 88 95>;
> +		hback-porch =3D <100 148 160>;
> +		vfront-porch =3D <0 4 6>;
> +		vback-porch =3D <0 36 50>;
> +		vsync-len =3D <0 5 6>;
> +	};
> +
> +The videomode can be linked to a connector via phandles. The connector h=
as to
> +support the display- and default-mode-property to link to and select a m=
ode.
> +
> +Example:
> +
> +	hdmi@00120000 {
> +		status =3D "okay";
> +		display =3D <&benq>;
> +		default-mode =3D <&mode1>;
> +	};
> +
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index dfba3e6..a3acaa3 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -83,4 +83,9 @@ config OF_MTD
>  	depends on MTD
>  	def_bool y
> =20
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
> @@ -11,3 +11,4 @@ obj-$(CONFIG_OF_MDIO)	+=3D of_mdio.o
>  obj-$(CONFIG_OF_PCI)	+=3D of_pci.o
>  obj-$(CONFIG_OF_PCI_IRQ)  +=3D of_pci_irq.o
>  obj-$(CONFIG_OF_MTD)	+=3D of_mtd.o
> +obj-$(CONFIG_OF_VIDEOMODE)	+=3D of_videomode.o
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
> + * Copyright (c) 2012 Steffen Trumtrar <s.trumtrar@pengutronix.de>, Peng=
utronix
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
> +	return (prop->min >=3D prop->typ) ? prop->min : prop->typ;
> +}

Why is this needed? If the prop->min is higher than prop->typ, isn't
that an error in the DT data, and should be rejected when parsing?

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
> +	prop =3D of_find_property(np, name, &length);
> +	if (!prop) {
> +		pr_err("%s: could not find property %s\n", __func__,
> +			name);
> +		return -EINVAL;
> +	}
> +
> +	cells =3D length / sizeof(u32);
> +
> +	memset(result, 0, sizeof(*result));
> +
> +	ret =3D of_property_read_u32_array(np, name, &result->min, cells);
> +
> +	return ret;

Ah, I guess this is the reason for the of_video_get_value... Wouldn't it
be cleaner to be more explicit here? If there's one cell, it's the
typical value, otherwise if there are 3 cells, they are min/typ/max,
else it's an error. And I think the above also trashes memory if there
happens to be 4+ cells.

> +}
> +
> +static int of_video_free(struct display *disp)
> +{
> +	int i;
> +
> +	for (i=3D0; i<disp->num_modes; i++)
> +		kfree(disp->modes[i]);
> +	kfree(disp->modes);
> +
> +	return 0;
> +}
> +
> +int videomode_to_display_mode(struct display *disp, struct drm_display_m=
ode *dmode, int index)
> +{
> +	struct videomode *vm;
> +
> +	memset(dmode, 0, sizeof(*dmode));
> +
> +	if (index > disp->num_modes) {
> +		pr_err("%s: wrong index: %d from %d\n", __func__, index, disp->num_mod=
es);
> +		return -EINVAL;
> +	}
> +
> +	vm =3D disp->modes[index];
> +
> +	dmode->hdisplay =3D of_video_get_value(&vm->hactive);
> +	dmode->hsync_start =3D of_video_get_value(&vm->hactive) + of_video_get_=
value(&vm->hfront_porch);
> +	dmode->hsync_end =3D of_video_get_value(&vm->hactive) + of_video_get_va=
lue(&vm->hfront_porch)
> +			+ of_video_get_value(&vm->hsync_len);
> +	dmode->htotal =3D of_video_get_value(&vm->hactive) + of_video_get_value=
(&vm->hfront_porch)
> +			+ of_video_get_value(&vm->hsync_len) + of_video_get_value(&vm->hback_=
porch);
> +
> +	dmode->vdisplay =3D of_video_get_value(&vm->vactive);
> +	dmode->vsync_start =3D of_video_get_value(&vm->vactive) + of_video_get_=
value(&vm->vfront_porch);
> +	dmode->vsync_end =3D of_video_get_value(&vm->vactive) + of_video_get_va=
lue(&vm->vfront_porch)
> +			+ of_video_get_value(&vm->vsync_len);
> +	dmode->vtotal =3D of_video_get_value(&vm->vactive) + of_video_get_value=
(&vm->vfront_porch) +
> +			of_video_get_value(&vm->vsync_len) + of_video_get_value(&vm->vback_po=
rch);
> +
> +	dmode->width_mm =3D disp->width_mm;
> +	dmode->height_mm =3D disp->height_mm;
> +
> +	dmode->clock =3D of_video_get_value(&vm->clock) / 1000;
> +
> +	if (vm->hah)
> +		dmode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> +	else
> +		dmode->flags |=3D DRM_MODE_FLAG_NHSYNC;
> +	if (vm->vah)
> +		dmode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> +	else
> +		dmode->flags |=3D DRM_MODE_FLAG_NVSYNC;
> +	if (vm->interlaced)
> +		dmode->flags |=3D DRM_MODE_FLAG_INTERLACE;
> +	if (vm->doublescan)
> +		dmode->flags |=3D DRM_MODE_FLAG_DBLSCAN;
> +
> +	drm_mode_set_name(dmode);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(videomode_to_display_mode);
> +
> +int videomode_to_fb_mode(struct display *disp, struct fb_videomode *fbmo=
de, int index)
> +{
> +	struct videomode *vm;
> +
> +	memset(fbmode, 0, sizeof(*fbmode));
> +
> +	if (index > disp->num_modes) {
> +		pr_err("%s: wrong index: %d from %d\n", __func__, index, disp->num_mod=
es);
> +		return -EINVAL;
> +	}
> +
> +	vm =3D disp->modes[index];
> +
> +	fbmode->xres =3D of_video_get_value(&vm->hactive);
> +	fbmode->left_margin =3D of_video_get_value(&vm->hback_porch);
> +	fbmode->right_margin =3D of_video_get_value(&vm->hfront_porch);
> +	fbmode->hsync_len =3D of_video_get_value(&vm->hsync_len);
> +
> +	fbmode->yres =3D of_video_get_value(&vm->vactive);
> +	fbmode->upper_margin =3D of_video_get_value(&vm->vback_porch);
> +	fbmode->lower_margin =3D of_video_get_value(&vm->vfront_porch);
> +	fbmode->vsync_len =3D of_video_get_value(&vm->vsync_len);
> +
> +	fbmode->pixclock =3D KHZ2PICOS(of_video_get_value(&vm->clock) / 1000);
> +
> +	if (vm->hah)
> +		fbmode->sync |=3D FB_SYNC_HOR_HIGH_ACT;
> +	if (vm->vah)
> +		fbmode->sync |=3D FB_SYNC_VERT_HIGH_ACT;
> +	if (vm->interlaced)
> +		fbmode->vmode |=3D FB_VMODE_INTERLACED;
> +	if (vm->doublescan)
> +		fbmode->vmode |=3D FB_VMODE_DOUBLE;
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
> +	int ret =3D 0;
> +
> +	memset(disp, 0, sizeof(*disp));
> +	disp->modes =3D kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +
> +	if (!np) {
> +		pr_err("%s: no node provided\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	display_np =3D of_parse_phandle(np, "display", 0);
> +
> +	if (!display_np) {
> +		pr_err("%s: could not find display node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_u32(display_np, "width-mm", &disp->width_mm);
> +	of_property_read_u32(display_np, "height-mm", &disp->height_mm);
> +
> +	mode_np =3D of_parse_phandle(np, "default-mode", 0);
> +
> +	if (!mode_np) {
> +		pr_info("%s: no default-mode specified.\n", __func__);
> +		mode_np =3D of_find_node_by_name(np, "mode");
> +	}
> +
> +	if (!mode_np) {
> +		pr_err("%s: could not find any mode specification\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	default_mode =3D (char *)mode_np->full_name;
> +
> +	modes_np =3D of_find_node_by_name(np, "modes");
> +	for_each_child_of_node(modes_np, mode_np) {
> +		struct videomode *vm;
> +
> +		vm =3D kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +		disp->modes[disp->num_modes] =3D kmalloc(sizeof(struct videomode*), GF=
P_KERNEL);
> +
> +		ret |=3D of_video_parse_property(mode_np, "hback-porch", &vm->hback_po=
rch);
> +		ret |=3D of_video_parse_property(mode_np, "hfront-porch", &vm->hfront_=
porch);
> +		ret |=3D of_video_parse_property(mode_np, "hactive", &vm->hactive);
> +		ret |=3D of_video_parse_property(mode_np, "hsync-len", &vm->hsync_len)=
;
> +		ret |=3D of_video_parse_property(mode_np, "vback-porch", &vm->vback_po=
rch);
> +		ret |=3D of_video_parse_property(mode_np, "vfront-porch", &vm->vfront_=
porch);
> +		ret |=3D of_video_parse_property(mode_np, "vactive", &vm->vactive);
> +		ret |=3D of_video_parse_property(mode_np, "vsync-len", &vm->vsync_len)=
;
> +		ret |=3D of_video_parse_property(mode_np, "clock", &vm->clock);
> +
> +		if (ret)
> +			return -EINVAL;
> +
> +		vm->hah =3D of_property_read_bool(mode_np, "hsync-active-high");
> +		vm->vah =3D of_property_read_bool(mode_np, "vsync-active-high");
> +		vm->interlaced =3D of_property_read_bool(mode_np, "interlaced");
> +		vm->doublescan =3D of_property_read_bool(mode_np, "doublescan");
> +
> +		if (strcmp(default_mode,mode_np->full_name) =3D=3D 0)
> +			disp->default_mode =3D disp->num_modes;
> +
> +		disp->modes[disp->num_modes] =3D vm;
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
> +	display_np =3D of_parse_phandle(np, "display", 0);
> +
> +	if (!display_np)
> +		return -EINVAL;
> +
> +	mode_np =3D of_parse_phandle(np, "default-mode", 0);
> +
> +	if (mode_np)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(of_video_mode_exists);
> +
> +int of_get_display_mode(struct device_node *np, struct drm_display_mode =
*dmode, int index)
> +{
> +	struct display disp;
> +
> +	of_get_video_modes(np, &disp);
> +
> +	if (index =3D=3D OF_MODE_SELECTION)
> +		index =3D disp.default_mode;
> +	if (dmode)
> +		videomode_to_display_mode(&disp, dmode, index);
> +
> +	of_video_free(&disp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_display_mode);
> +
> +int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fbm=
ode, int index)
> +{
> +	struct display disp;
> +
> +	of_get_video_modes(np, &disp);
> +
> +	if (index =3D=3D OF_MODE_SELECTION)
> +		index =3D disp.default_mode;
> +	if (fbmode)
> +		videomode_to_fb_mode(&disp, fbmode, index);
> +
> +	of_video_free(&disp);
> +
> +	return 0;

This and of_get_display_mode() do not handle errors from
of_get_video_modes() nor from videomode_to_xxx_mode(). And I don't see a
reason for the if (fbmode) check (and the same for dmode), as there's no
reason to call these functions except to get the video modes.

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

I think the names display and videomode are a bit too generic here, and
could clash with names from kernel drivers. Also, the videomode is not
really a videomode, but a "template" (or something) for videomode. A
real videomode doesn't have min & max values, only the actual value.

Perhaps these should be prefixed with "of_"? Then again, they are not
really of specific either...

 Tomi


--=-LQgo8dwyl86G74LmmECZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQWY4aAAoJEPo9qoy8lh71ClwP/2ZHhy6SBvASrKyWcLrDnwkC
+xBvzllzS5cwKmMHcNABWTfLFjavw9yYTlCtUSl3newxcjNIDz+F5qZcZBpMClQR
c4Rt0jytxvifutt1k5xCH16zVPOGMOpvcPfr7Qne8eWFFqlBGbpZsn3Gc09XCR0H
ODazsQHSCklz9Txr6nq7vsoxSr5OXWNwRL7PNfsYeowT3MRwVxq93OADHxPpP825
t8Lzt0k4ZSbnrLq5qFU7z6mpNGmqNrWQ0ygPFPlavIn3rlaWPSsgq5MUq05YO+Y0
JFAeH2kxpeSPxpMZrwnFQbRbkJykXLOMsxh/79htcPYx4rPV8giadiO/TeeU9Lrn
+BwUxGPU8FfnMTX9YTt6VG8zO+UizkoD6IgCz1Wy3W1NTcfMoVgtFQgBNwtneOWd
7ziKMwtkMD4ai90SQnOVy1N2FgFxUWIKhAnXvvnJ4+lijYD1ZV3NX/x4xLNstkL7
dhdhwvKh8Qf0xShUWYNKfBFMeqx4ZM7TlB5zqxHsWlAdUSgISiwiAJV11XSJl77I
Y1KYwU79Vzodu3x0vjSetE9ST9ikm+EvgPTrd+2RfGWuU4uHGVjh5unB1HCTfFBg
6nkxe+q6ziKNnLefqkb1uZ7RwJE3D5xf+qm9pekvWL41kjPhdTrDonQuTZVhVOkP
QIx9VMoijSc23BSaoaEe
=kTqx
-----END PGP SIGNATURE-----

--=-LQgo8dwyl86G74LmmECZ--

