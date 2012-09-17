From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Mon, 17 Sep 2012 18:35:43 +0000
Subject: Re: [PATCH v3] of: Add videomode helper
Message-Id: <6AE080B68D46FC4BA2D2769E68D765B70805C179@039-SN2MPN1-023.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347639842-13509-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1347639842-13509-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

On Fri, Sep 14, 2012 at 11:24 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:

> +/* FIXME */
> +static u32 of_video_get_value(struct mode_property *prop)
> +{
> +       return (prop->min >= prop->typ) ? prop->min : prop->typ;
> +}
> +
> +/* read property into new mode_property */
> +static int of_video_parse_property(struct device_node *np, char *name,
> +                               struct mode_property *result)
> +{
> +       struct property *prop;
> +       int length;
> +       int cells;
> +       int ret;
> +
> +       prop = of_find_property(np, name, &length);
> +       if (!prop)
> +               return -EINVAL;
> +
> +       cells = length / sizeof(u32);
> +
> +       memset(result, 0, sizeof(*result));
> +
> +       ret = of_property_read_u32_array(np, name, &result->min, cells);
> +       of_video_get_value(result);

What's the point of calling of_video_get_value() here?  It doesn't do anything.

> +       return ret;
> +}
> +
> +int videomode_to_display_mode(struct display *disp, struct drm_display_mode *dmode, int index)
> +{
> +       struct videomode *vm;
> +
> +        memset(dmode, 0, sizeof(*dmode));

Indentation problem.

> +int of_get_video_mode(struct device_node *np, struct display *disp)
> +{
> +       struct device_node *display_np;
> +       struct device_node *mode_np;
> +       struct device_node *modes_np;
> +       char *default_mode;
> +
> +       int ret = 0;
> +
> +       memset(disp, 0, sizeof(*disp));
> +       disp->modes = kmalloc(sizeof(struct videomode*), GFP_KERNEL);
> +       if (!np)
> +               return -EINVAL;
> +
> +       display_np = of_parse_phandle(np, "display", 0);
> +
> +       if (!display_np)
> +               return -EINVAL;
> +
> +       of_property_read_u32(display_np, "width-mm", &disp->width_mm);
> +       of_property_read_u32(display_np, "height-mm", &disp->height_mm);
> +
> +       mode_np = of_parse_phandle(np, "default-mode", 0);
> +
> +       if (!mode_np)
> +               mode_np = of_find_node_by_name(np, "mode");
> +
> +       if (!mode_np)
> +               return -EINVAL;
> +
> +       default_mode = (char *)mode_np->full_name;
> +
> +       modes_np = of_find_node_by_name(np, "modes");
> +       for_each_child_of_node(modes_np, mode_np) {
> +               struct videomode *vm;

Blank line after variable declarations, please.

> +               vm = kmalloc(sizeof(struct videomode), GFP_KERNEL);
> +               disp->modes[disp->num_modes] = kmalloc(sizeof(struct videomode*), GFP_KERNEL);

Are you sure this is right?

> +               ret |= of_video_parse_property(mode_np, "hback-porch", &vm->hback_porch);
> +               ret |= of_video_parse_property(mode_np, "hfront-porch", &vm->hfront_porch);
> +               ret |= of_video_parse_property(mode_np, "hactive", &vm->hactive);
> +               ret |= of_video_parse_property(mode_np, "hsync-len", &vm->hsync_len);
> +               ret |= of_video_parse_property(mode_np, "vback-porch", &vm->vback_porch);
> +               ret |= of_video_parse_property(mode_np, "vfront-porch", &vm->vfront_porch);
> +               ret |= of_video_parse_property(mode_np, "vactive", &vm->vactive);
> +               ret |= of_video_parse_property(mode_np, "vsync-len", &vm->vsync_len);
> +               ret |= of_video_parse_property(mode_np, "clock", &vm->clock);
> +
> +               if (ret)
> +                       return -EINVAL;
> +
> +               vm->hah = of_property_read_bool(mode_np, "hsync-active-high");
> +               vm->vah = of_property_read_bool(mode_np, "vsync-active-high");
> +               vm->interlaced = of_property_read_bool(mode_np, "interlaced");
> +               vm->doublescan = of_property_read_bool(mode_np, "doublescan");
> +
> +               if (strcmp(default_mode,mode_np->full_name) = 0) {
> +                       printk("%s: default_node = %d\n", __func__, disp->num_modes);

Please use a KERN_ macro here, or a pr_xxx function.  Even better
would be to use a dev_xxx function.

In general, I'd like to see more error reporting of bad device tree
properties, to help debugging.

> +                       disp->default_mode = disp->num_modes;
> +               }
> +
> +               disp->modes[disp->num_modes] = vm;

Isn't this a memory leak?

> +               disp->num_modes++;
> +       }
> +       of_node_put(display_np);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_video_mode);

-- 
Timur Tabi
Linux kernel developer at Freescale
