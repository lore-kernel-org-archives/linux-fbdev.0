From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 18 Oct 2017 08:03:05 +0000
Subject: Re: [PATCH v2 1/4] video: fb: Make fbcon dmi quirks usuable for drm drivers too
Message-Id: <20171018080305.qijb6hfhuzb7jjyf@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171001153317.2343-1-hdegoede@redhat.com>
 <20171001153317.2343-2-hdegoede@redhat.com>
 <20171002080127.4vlziqjhcqt33vmw@phenom.ffwll.local>
 <693c6fd9-e405-869f-48d8-a0b0c30ff0c0@redhat.com>
In-Reply-To: <693c6fd9-e405-869f-48d8-a0b0c30ff0c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Hans de Goede <j.w.r.degoede@gmail.com>, Bastien Nocera <hadess@hadess.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>

On Tue, Oct 17, 2017 at 06:17:21PM +0200, Hans de Goede wrote:
> Hi,
> 
> Sorry for being slow to reply, I've been a bit overwhelmed with
> other stuff lately.
> 
> On 10/02/2017 10:01 AM, Daniel Vetter wrote:
> > On Sun, Oct 01, 2017 at 05:33:14PM +0200, Hans de Goede wrote:
> > > Some x86 clamshell design devices use portrait tablet LCD panels and a
> > > display engine which cannot (transparently) rotate in hardware, so we
> > > need to rotate things in software / let user space deal with this.
> > > 
> > > The fbcon code has a set of DMI based quirks to automatically detect
> > > such tablet LCD panels and rotate the fbcon to compensate.
> > > 
> > > The plan was for userspace (e.g. a Wayland compositor) to simply read
> > > /sys/class/graphics/fbcon/rotate and apply the rotation from there to
> > > the LCD panel to compensate.
> > > 
> > > However this will not work when an external monitor gets plugged in,
> > > since with fbcon rotation is not per output, so the fbcon quirk code
> > > disables the rotation when an external monitor is present.
> > > 
> > > Using /sys/class/graphics/fbcon/rotate will not help in that case
> > > since it will indicate no rotation is in use. So instead we are going
> > > to need a drm connecter property for this.
> > > 
> > > This commit is a preparation patch for adding the drm-connecter
> > > property, by making the fbcon quirk code generally usable so that
> > > the drm code can use it to check for rotation quirks.
> > > 
> > > Note this commit re-uses the FB_CMDLINE Kconfig option for selecting
> > > if the quirk code should be build, since that is already selected by
> > > both the drm and fbcon code.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Can we pls just outright move this out of fbdev? fbdev is dead, I don't
> > want to add/maintain new stuff in there (except fbcon, but that should not
> > deal with stuff like this).
> 
> Sure we can do that, but fbcon also needs access to the quirks, so then
> we need to have some part of the drm code which always gets builtin into
> the kernel and make the drm code export a function for this which the
> fbcon code uses.
> 
> The reason why fbcon uses this is because there are cases where the BIOS
> does not setup the EFIFB with the correct rotation, typically because
> the hardware does not support 90 / 270 degrees rotation and the
> screen has been mounted rotated 90 / 270 degrees rotation.

Oh dear, I hoped we could ignore that.

So yeah we need to load the same quirk table for efifb and for i915. How
much I wish we'd just have merged simpledrm by now :-)

I still don't think that fbcon should have access to the quirks directly,
but efifb and drm_fb_helper should set the same hint flags probably.

Wrt the location, I don't even think we need to have this built-in. Put a
new module for intel-quirks into drivers/gpu/platform and select that from
both, and it should all work out I think.

Or is there some other gotcha?

Thanks, Daniel

> 
> Regards,
> 
> Hans
> 
> 
> > This probably means some serious patch series acrobatics, or just breaking
> > the current fbcon-only hack and rebuilding it in drm (in the same series).
> >
> > -Daniel
> > 
> > > ---
> > > Changes in v2:
> > > -Rebased on 4.14-rc1
> > > ---
> > >   drivers/video/fbdev/core/Makefile                  |  6 +++---
> > >   .../core/{fbcon_dmi_quirks.c => fb_dmi_quirks.c}   | 15 +++++++++------
> > >   drivers/video/fbdev/core/fbcon.c                   | 22 ++++++++++++++--------
> > >   drivers/video/fbdev/core/fbcon.h                   |  6 ------
> > >   include/linux/fb.h                                 |  6 ++++++
> > >   5 files changed, 32 insertions(+), 23 deletions(-)
> > >   rename drivers/video/fbdev/core/{fbcon_dmi_quirks.c => fb_dmi_quirks.c} (91%)
> > > 
> > > diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> > > index 73493bbd7a15..06caf037a822 100644
> > > --- a/drivers/video/fbdev/core/Makefile
> > > +++ b/drivers/video/fbdev/core/Makefile
> > > @@ -1,4 +1,7 @@
> > >   obj-$(CONFIG_FB_CMDLINE)          += fb_cmdline.o
> > > +ifeq ($(CONFIG_DMI),y)
> > > +obj-$(CONFIG_FB_CMDLINE)          += fb_dmi_quirks.o
> > > +endif
> > >   obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
> > >   obj-$(CONFIG_FB)                  += fb.o
> > >   fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
> > > @@ -14,9 +17,6 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
> > >   fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
> > >   				     fbcon_ccw.o
> > >   endif
> > > -ifeq ($(CONFIG_DMI),y)
> > > -fb-y				  += fbcon_dmi_quirks.o
> > > -endif
> > >   endif
> > >   fb-objs                           := $(fb-y)
> > > diff --git a/drivers/video/fbdev/core/fbcon_dmi_quirks.c b/drivers/video/fbdev/core/fb_dmi_quirks.c
> > > similarity index 91%
> > > rename from drivers/video/fbdev/core/fbcon_dmi_quirks.c
> > > rename to drivers/video/fbdev/core/fb_dmi_quirks.c
> > > index 6904e47d1e51..d5fdf3245f83 100644
> > > --- a/drivers/video/fbdev/core/fbcon_dmi_quirks.c
> > > +++ b/drivers/video/fbdev/core/fb_dmi_quirks.c
> > > @@ -1,5 +1,5 @@
> > >   /*
> > > - *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
> > > + *  fb_dmi_quirks.c -- DMI based LCD panel rotation quirk detection
> > >    *
> > >    *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> > >    *
> > > @@ -11,7 +11,6 @@
> > >   #include <linux/dmi.h>
> > >   #include <linux/fb.h>
> > >   #include <linux/kernel.h>
> > > -#include "fbcon.h"
> > >   /*
> > >    * Some x86 clamshell design devices use portrait tablet screens and a display
> > > @@ -112,7 +111,11 @@ static const struct dmi_system_id rotate_data[] = {
> > >   	{}
> > >   };
> > > -int fbcon_platform_get_rotate(struct fb_info *info)
> > > +/*
> > > + * Note this function returns the rotation necessary to put the display
> > > + * the right way up, or -1 if there is no quirk.
> > > + */
> > > +int fb_get_panel_rotate_quirk(int width, int height)
> > >   {
> > >   	const struct dmi_system_id *match;
> > >   	const struct fbcon_dmi_rotate_data *data;
> > > @@ -124,8 +127,7 @@ int fbcon_platform_get_rotate(struct fb_info *info)
> > >   	     match = dmi_first_match(match + 1)) {
> > >   		data = match->driver_data;
> > > -		if (data->width != info->var.xres ||
> > > -		    data->height != info->var.yres)
> > > +		if (data->width != width || data->height != height)
> > >   			continue;
> > >   		if (!data->bios_dates)
> > > @@ -141,5 +143,6 @@ int fbcon_platform_get_rotate(struct fb_info *info)
> > >   		}
> > >   	}
> > > -	return FB_ROTATE_UR;
> > > +	return -1;
> > >   }
> > > +EXPORT_SYMBOL_GPL(fb_get_panel_rotate_quirk);
> > > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > > index 04612f938bab..2e17ea02c295 100644
> > > --- a/drivers/video/fbdev/core/fbcon.c
> > > +++ b/drivers/video/fbdev/core/fbcon.c
> > > @@ -963,10 +963,13 @@ static const char *fbcon_startup(void)
> > >   	ops->cur_rotate = -1;
> > >   	ops->cur_blink_jiffies = HZ / 5;
> > >   	info->fbcon_par = ops;
> > > -	if (initial_rotation != -1)
> > > -		p->con_rotate = initial_rotation;
> > > -	else
> > > -		p->con_rotate = fbcon_platform_get_rotate(info);
> > > +	p->con_rotate = initial_rotation;
> > > +	if (p->con_rotate = -1)
> > > +		p->con_rotate = fb_get_panel_rotate_quirk(info->var.xres,
> > > +							  info->var.yres);
> > > +	if (p->con_rotate = -1)
> > > +		p->con_rotate = FB_ROTATE_UR;
> > > +
> > >   	set_blitting_type(vc, info);
> > >   	if (info->fix.type != FB_TYPE_TEXT) {
> > > @@ -1103,10 +1106,13 @@ static void fbcon_init(struct vc_data *vc, int init)
> > >   	ops = info->fbcon_par;
> > >   	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
> > > -	if (initial_rotation != -1)
> > > -		p->con_rotate = initial_rotation;
> > > -	else
> > > -		p->con_rotate = fbcon_platform_get_rotate(info);
> > > +	p->con_rotate = initial_rotation;
> > > +	if (p->con_rotate = -1)
> > > +		p->con_rotate = fb_get_panel_rotate_quirk(info->var.xres,
> > > +							  info->var.yres);
> > > +	if (p->con_rotate = -1)
> > > +		p->con_rotate = FB_ROTATE_UR;
> > > +
> > >   	set_blitting_type(vc, info);
> > >   	cols = vc->vc_cols;
> > > diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
> > > index 18f3ac144237..3746828356ed 100644
> > > --- a/drivers/video/fbdev/core/fbcon.h
> > > +++ b/drivers/video/fbdev/core/fbcon.h
> > > @@ -261,10 +261,4 @@ extern void fbcon_set_rotate(struct fbcon_ops *ops);
> > >   #define fbcon_set_rotate(x) do {} while(0)
> > >   #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
> > > -#ifdef CONFIG_DMI
> > > -int fbcon_platform_get_rotate(struct fb_info *info);
> > > -#else
> > > -#define fbcon_platform_get_rotate(i) FB_ROTATE_UR
> > > -#endif /* CONFIG_DMI */
> > > -
> > >   #endif /* _VIDEO_FBCON_H */
> > > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > > index f4386b0ccf40..7527965c5b53 100644
> > > --- a/include/linux/fb.h
> > > +++ b/include/linux/fb.h
> > > @@ -814,6 +814,12 @@ extern int fb_find_mode(struct fb_var_screeninfo *var,
> > >   			const struct fb_videomode *default_mode,
> > >   			unsigned int default_bpp);
> > > +#ifdef CONFIG_DMI
> > > +int fb_get_panel_rotate_quirk(int width, int height);
> > > +#else
> > > +#define fb_get_panel_rotate_quirk(width, height) (-1)
> > > +#endif /* CONFIG_DMI */
> > > +
> > >   /* Convenience logging macros */
> > >   #define fb_err(fb_info, fmt, ...)					\
> > >   	pr_err("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
> > > -- 
> > > 2.14.2
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
