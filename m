From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Nov 2012 17:58:09 +0000
Subject: Re: [PATCHv13 5/7] fbmon: add of_videomode helpers
Message-Id: <2117247.Eyo66IqYf0@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353600015-6974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353600015-6974-6-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1353600015-6974-6-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Steffen,

On Thursday 22 November 2012 17:00:13 Steffen Trumtrar wrote:
> Add helper to get fb_videomode from devicetree.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This patch results in the following build warning:

drivers/video/fbmon.c: In function 'of_get_fb_videomode':
drivers/video/fbmon.c:1445: warning: passing argument 1 of 'of_get_videomode' 
discards qualifiers from pointer target type
include/linux/of_videomode.h:15: note: expected 'struct device_node *' but 
argument is of type 'const struct device_node *'

> ---
>  drivers/video/fbmon.c |   42 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/fb.h    |    6 ++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index a6a564d..cd0a035 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -31,7 +31,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <video/edid.h>
> -#include <linux/videomode.h>
> +#include <linux/of_videomode.h>
>  #ifdef CONFIG_PPC_OF
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
> @@ -1416,6 +1416,46 @@ int fb_videomode_from_videomode(const struct
> videomode *vm, EXPORT_SYMBOL_GPL(fb_videomode_from_videomode);
>  #endif
> 
> +#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
> +static inline void dump_fb_videomode(const struct fb_videomode *m)
> +{
> +	pr_debug("fb_videomode = %ux%u@%uHz (%ukHz) %u %u %u %u %u %u %u %u 
%u\n",
> +		 m->xres, m->yres, m->refresh, m->pixclock, m->left_margin,
> +		 m->right_margin, m->upper_margin, m->lower_margin,
> +		 m->hsync_len, m->vsync_len, m->sync, m->vmode, m->flag);
> +}
> +
> +/**
> + * of_get_fb_videomode - get a fb_videomode from devicetree
> + * @np: device_node with the timing specification
> + * @fb: will be set to the return value
> + * @index: index into the list of display timings in devicetree
> + *
> + * DESCRIPTION:
> + * This function is expensive and should only be used, if only one mode is
> to be + * read from DT. To get multiple modes start with
> of_get_display_timings ond + * work with that instead.
> + */
> +int of_get_fb_videomode(const struct device_node *np, struct fb_videomode
> *fb, +			unsigned int index)
> +{
> +	struct videomode vm;
> +	int ret;
> +
> +	ret = of_get_videomode(np, &vm, index);
> +	if (ret)
> +		return ret;
> +
> +	fb_videomode_from_videomode(&vm, fb);
> +
> +	pr_info("%s: got %dx%d display mode from %s\n", __func__, vm.hactive,
> +		vm.vactive, np->name);
> +	dump_fb_videomode(fb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_fb_videomode);
> +#endif
> 
>  #else
>  int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 4404ec2..43a2f81 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -20,6 +20,7 @@ struct fb_info;
>  struct device;
>  struct file;
>  struct videomode;
> +struct device_node;
> 
>  /* Definitions below are used in the parsed monitor specs */
>  #define FB_DPMS_ACTIVE_OFF	1
> @@ -715,6 +716,11 @@ extern void fb_destroy_modedb(struct fb_videomode
> *modedb); extern int fb_find_mode_cvt(struct fb_videomode *mode, int
> margins, int rb); extern unsigned char *fb_ddc_read(struct i2c_adapter
> *adapter);
> 
> +#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
> +extern int of_get_fb_videomode(const struct device_node *np,
> +			       struct fb_videomode *fb,
> +			       unsigned int index);
> +#endif
>  #if IS_ENABLED(CONFIG_VIDEOMODE)
>  extern int fb_videomode_from_videomode(const struct videomode *vm,
>  				       struct fb_videomode *fbmode);
-- 
Regards,

Laurent Pinchart

