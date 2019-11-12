From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 12 Nov 2019 14:31:33 +0000
Subject: Re: [PATCH 1/4] drm/udl: Replace fbdev code with generic emulation
Message-Id: <CAKMK7uHiXtg=FCpqv7ekpopd=2Hofrs7oR3qPNsf8e_E_Wv08w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191108123333.25274-1-tzimmermann@suse.de>
 <20191108123333.25274-2-tzimmermann@suse.de>
 <e8b90928-fdae-36e0-f116-8b49159c4aad@tronnes.org>
 <1704c1d6-ec08-211b-0677-6c22f96ca7aa@suse.de>
 <CAKMK7uF7M60NcPTGicQVJ=09pqf4ua4kWaCmdCcDaC13AgTFQw@mail.gmail.com>
 <6da6c49a-572a-343a-ddb1-103ca7080ccd@suse.de>
In-Reply-To: <6da6c49a-572a-343a-ddb1-103ca7080ccd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, dri-devel <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>, Emil Velikov <emil.velikov@collabora.com>

On Tue, Nov 12, 2019 at 3:03 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 12.11.19 um 14:40 schrieb Daniel Vetter:
> > On Tue, Nov 12, 2019 at 12:55 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> Hi
> >>
> >> Am 08.11.19 um 16:37 schrieb Noralf Trønnes:
> >>>
> >>>
> >>> Den 08.11.2019 13.33, skrev Thomas Zimmermann:
> >>>> The udl driver can use the generic fbdev implementation. Convert it.
> >>>>
> >>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>>> ---
> >>>
> >>>> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> >>>> index 563cc5809e56..55c0f9dfee29 100644
> >>>> --- a/drivers/gpu/drm/udl/udl_drv.c
> >>>> +++ b/drivers/gpu/drm/udl/udl_drv.c
> >>>
> >>>> @@ -47,6 +48,8 @@ static struct drm_driver driver = {
> >>>>      .driver_features = DRIVER_MODESET | DRIVER_GEM,
> >>>>      .release = udl_driver_release,
> >>>>
> >>>> +    .lastclose = drm_fb_helper_lastclose,
> >>>> +
> >>>
> >>> No need to set this, it's already wired up:
> >>>
> >>> drm_lastclose -> drm_client_dev_restore -> drm_fbdev_client_restore ->
> >>> drm_fb_helper_lastclose
> >>>
> >>>>      /* gem hooks */
> >>>>      .gem_create_object = udl_driver_gem_create_object,
> >>>>
> >>>
> >>>> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> >>>> index f8153b726343..afe74f892a2b 100644
> >>>> --- a/drivers/gpu/drm/udl/udl_fb.c
> >>>> +++ b/drivers/gpu/drm/udl/udl_fb.c
> >>>> @@ -20,19 +20,9 @@
> >>>>
> >>>>  #include "udl_drv.h"
> >>>>
> >>>> -#define DL_DEFIO_WRITE_DELAY    (HZ/20) /* fb_deferred_io.delay in jiffies */
> >>>> -
> >>>> -static int fb_defio = 0;  /* Optionally enable experimental fb_defio mmap support */
> >>>>  static int fb_bpp = 16;
> >>>>
> >>>>  module_param(fb_bpp, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
> >>>
> >>> Maybe fb_bpp can be dropped too?
> >>
> >> Sure, makes sense.
> >>
> >> The driver exposes a preferred color depth of 24 bpp, which we may want
> >> to change to 16 then. The internal framebuffer is only 16 bpp anyway.
> >
> > Just something that crossed my mind: Should we ensure that the
> > preferred format of the primary plane (should be the first in the
> > format array) matches up with the preferred bpp setting? Maybe even
> > enforce that for drivers with an explicit primary plane (i.e. atomic
> > drivers). I think tiny drivers get this right already.
>
> IMHO that makes if the userspace can handle it. The preferred bpp could
> also be retrieved from the formats array automatically. What about HW
> with multiple CRTCs with different format defaults (sounds weird, I know)?

Ime I haven't seen such a case yet. What I have seen is that the most
preferred format might be some fancy compressed format, which not all
formats support. But which you can't render into without mesa anyway,
so really doesn't matter for preferred bpp.

> WRT udl: For v3 of this patchset I've set the preferred color depth to
> 32 bpp; although the internal FB is always at 16 bpp. Because when I
> tested with a dual-screen setup (radeon + udl) X11 didn't support the 16
> bpp output on the second screen (the one driven by udl). Only setting
> both screen to 32 bpp worked out of the box. And the preferred 24 bpp
> are not even supported by udl.

Uh, if we can only set preferred bpp to make X happy, and X can only
support one preferred bpp, then everyone needs to set 32bit. Which
defeats the point (and we'd need to hardcode it to 32bpp). Is this
really the case?
-Daniel

>
> Best regards
> Thomas
>
> > -Daniel
> >
> >>
> >> Best regards
> >> Thomas
> >>
> >>>
> >>> It's possible to set it on the command line:
> >>>
> >>> video=<xres>x<yres>-<bpp>
> >>>
> >>> I haven't tried it so I can't say for certain that it actually works>
> >>> Ref: Documentation/fb/modedb.rst and drm_fb_helper_single_fb_probe()
> >>>
> >>>> -module_param(fb_defio, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
> >>>> -
> >>>
> >>>> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> >>>> index bc1ab6060dc6..1517d5e881b8 100644
> >>>> --- a/drivers/gpu/drm/udl/udl_modeset.c
> >>>> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> >>>
> >>>> @@ -422,7 +423,7 @@ static int udl_crtc_init(struct drm_device *dev)
> >>>>
> >>>>  static const struct drm_mode_config_funcs udl_mode_funcs = {
> >>>>      .fb_create = udl_fb_user_fb_create,
> >>>> -    .output_poll_changed = NULL,
> >>>> +    .output_poll_changed = drm_fb_helper_output_poll_changed,
> >>>
> >>> No need to set this, it's already wired up:
> >>>
> >>> drm_kms_helper_hotplug_event -> drm_client_dev_hotplug ->
> >>> drm_fbdev_client_hotplug -> drm_fb_helper_hotplug_event
> >>>
> >>> Noralf.
> >>>
> >>>>  };
> >>>>
> >>>>  int udl_modeset_init(struct drm_device *dev)
> >>>>
> >>
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Maxfeldstr. 5, 90409 Nürnberg, Germany
> >> (HRB 36809, AG Nürnberg)
> >> Geschäftsführer: Felix Imendörffer
> >>
> >
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
