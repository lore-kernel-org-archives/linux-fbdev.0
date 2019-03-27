From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Mar 2019 09:41:57 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
 <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
In-Reply-To: <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Mar 27, 2019 at 10:10 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi,
>
> first of all, thanks for the detailed feedback.
>
> Am 26.03.19 um 15:53 schrieb Daniel Vetter:
> > On Tue, Mar 26, 2019 at 10:17:33AM +0100, Thomas Zimmermann wrote:
> >> Hi,
> >>
> >> this RFC patch set implements fbdevdrm, a DRM driver on top of fbdev
> >> drivers. I'd appreciate feedback on the code and the idea in general.
> >>
> >> The fbdev subsystem is considered legacy and will probably be removed at
> >> some point. This would mean the loss of a signifanct number of drivers.
> >> Some of the affected hardware is probably not in use any longer, but some
> >> hardware is still around and provides good(-enough) framebuffers.
> >>
> >> OTOH, userspace programs that want to support a wide range of graphics
> >> hardware have to implement support for both DRM and fbdev interfaces. Such
> >> software would benefit from a single interface.
> >>
> >> The fbdevdrm driver provides a way of running drivers for old and new
> >> hardware from the DRM subsystem and interfaces.
> >>
> >> It's not intended to add new features or drivers to fbdev. Instead fbdevdrm
> >> is supposed to be a template for converting fbdev drivers to DRM. It contains
> >> a number of comments (labeled 'DRM porting note') that explain the required
> >> steps. The license is fairly liberal to allow for combination with existing
> >> fbdev code.
> >>
> >> I tested the current patch set with the following drivers: atyfb, aty128fb,
> >> matroxfb, pm2fb, s3fb, savagefb, sisfb, tdfxfb and tridentfb. I was able to
> >> successfully start with fbcon enabled and then run weston or X.
> >>
> >> Thomas Zimmermann (11):
> >>   drm/fbdevdrm: Add driver skeleton
> >>   drm/fbdevdrm: Add fbdevdrm device
> >>   drm/fbdevdrm: Add memory management
> >>   drm/fbdevdrm: Add file operations
> >>   drm/fbdevdrm: Add GEM and dumb interfaces
> >>   drm/fbdevdrm: Add modesetting infrastructure
> >>   drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
> >>   drm/fbdevdrm: Add mode conversion DRM <-> fbdev
> >>   drm/fbdevdrm: Add primary plane
> >>   drm/fbdevdrm: Add CRTC
> >>   drm/fbdevdrm: Detect and validate display modes
> >
> > Looks surprisingly clean, at least from a quick read. Only big thing I
> > noticed on the implementation side is that you probably want to use the
> > simple display helpers. At least that's a much better fit for simple
> > display hw supported by these fbdev drivers.
>
> I thought about using the simple-DRM helpers, but found that a full DRM
> driver would be more helpful for porting over fbdev drivers. Unless
> simple DRM is a hard requirement, I'd prefer to leave it this way.
>
> For those devices that only support a single pipeline, the conversion to
> simple DRM should then be mandatory during the porting process.

fbdev only supports a single output, all multi-head extensions are
driver specific ioctl hacks. Given that all you can do is switch it on
or off (with a given mode), simple pipe helpers are the perfect fit
for fbdev.

Some drivers might support more (like multiple heads, or at least
different outputs), and those we should convert over. But at least for
step 1 in converting fbdev drivers over, simple pipe is the right
starting point I think.

> > What I'm not sure at all on is whether this is a good idea. It's a quick
> > way of supporting a few drivers we might need from fbdev. But I fear for
> > long-term ecosystem health it'll be a loss: Much less motivation to port
> > the drivers to be native kms ones, and as a result, much less
> > opportunities to extract helpers to make driver writing for such hw easier
> > for everyone.
> >
> > And the latter is really important, if you look at all the work people
> > have done to improve the modeset helpers. Nowadays we have some examples
> > where the kms native port of an fbdev driver turned out to be 2-3x
> > smaller.
>
> I don't disagree with any of this. My intention is to simplify the
> graphics stack *without* loosing support for all the old hardware. I see
> fbdevdrm as help for porting drivers, or short-term solution for getting
> old framebuffer to work.

Simplify for whom? If the goal is to make life easier for userspace
I'm not sure - you already need at least legacy kms and atomic kms
backends (except for the simplest stuff). And I'm not sure how many
lines of code an fbdev backend really is.

Definitely won't simplify things for the kernel, since this way we'll
never know which fbdev drivers are dead and which ones we need to keep
supporting. This isn't the first time we've just dropped a pile of old
hw support on the floor. What we should aim for though is to make the
transition as easy as possible for those few drivers that aren't
ported yet, but still needed.

> > But I also see the benefit of making the fbdev->kms transition smoother.
> > For discussion here's a pretty wild idea that we might want to consider:
> >
> > - move the ttm based gem code into a helper library like the cma gem
> >   helpers. Only special piece we need to pass it is the fb_info structure,
> >   for that we can use the same hooks the cma helpers use to allow drivers
> >   to specify the right struct device to use for cma allocations. plus ofc
> >   an init function for the memory manager and all that, which drivers can
> >   put into their driver private device structure
> >
> > - move the modeset compat code into a helper based on top of the simple
> >   display pipe helpers.
> >
> > - for each fbdev driver we care about:
> >   1. create bare-bones kms driver
> >   2. copypaste the entire fbdev driver code into the drm driver
> >   3. hook up the above two helper libraries, remove the
> >   register_framebuffer - I think we can still allocate the fb_info and all
> >   that for transition
> >   4. transition the driver over. If we have the helpers a bit split up
> >   between display and buffer management side that should be a lot more
> >   gradual, and with the fbdevdrm midlayer inserted in the middle.
>
> I use the current approach because it does not require modifications to
> DRM or fbdev. Not copying the fbdev driver code has the advantage that
> any fix that goes into fbdev is also used by fbdevdrm.
>
> OTOH, that has some problems. At least the event-reporting hooks appear
> to be fragile. You mentioned that you have patches for replacing it. I'd
> be happy to use something else. Filtering out generic and DRM-based
> drivers is also not optimal.
>
> Instead of adding the porting helpers to the DRM core, I'd suggest to
> add them to fbdevdrm. Fbdevdrm would have to duplicate some of the fbdev
> functionality and provide a replacement for register_framebuffer.
>
> Porting would then mean to
>
>  1) create a new DRM driver by copying fbdevdrm, and
>  2) copy the fbdev driver code to the new DRM driver and rename the
> function calls accordingly. At this point the new driver should already
> work to some extend.
>  3) Finally, do the refactoring and get it out of staging.

Maybe the idea behind helpers isn't fully clear:

https://blog.ffwll.ch/2016/12/midlayers-once-more-with-feeling.html

The idea with helpers is essentially to have all the flexibility of
copypasting (you can refactor as you see fit), without having to
actually copypaste a lot of the code. That's why I think an fbdevdrm
helper suits, at least as long as we're actively transitioning. Worked
fairly well for the atomic transition at least.

Wrt what you need to provide: I think all that needs to be replaced is
(un)register_framebuffer - all other fbdev functions and
datastructures we should be able to continue to use, even for such a
frankendriver transitioning from fbdev to drm.

> If the fbdev subsystem is ever going to be removed, the remaining
> drivers could be moved under fbdevdrm and have their function calls
> adapted. If anyone cares about a driver, it'd be available for
> refactoring; otherwise it'd just sit there doing nothing. It's all
> self-contained and doesn't pollute the DRM core.

Maybe some confusions:
- We're not going to remove fbdev as long as there's users left. So
this scenario isn't one to optimize for. The only thing that's not
going to happen is adding more features/drivers to fbdev (except
through drm drivers and drm's fbdev compat code).
- I don't think we need to port all drivers over to drm. Most of them
are irrelevant by now, letting them quietly die feels like the best
action. One reason for copypasting drivers to drm was to make sure
there's someone who actually cares enough about that specific driver.

> > - Improve the other helpers we have as needed - there's probably room for
> >   a simple ttm version, inspired by all these simple display chips (e.g.
> >   ast/cirrus/bochs/mga all solve similar problems like this).
>
> Makes sense, but appears to be unrelated.

It's the main reason to have drivers in upstream - sharing code and
infrastructure. At least for me the main benefit in porting a bunch
more fbdev drivers over isn't the old hw support (that hw is quietly
dying anyway, we just have to wait). But improving support for new hw
that fills similar niches, and making it easier for everyone else. Ofc
I'm not going to stop anyone who's going to do all the porting work,
but we can't realistically require it (e.g. legacy kms drivers also
don't support atomic, since simply not possible without rewriting the
driver).

Cheers, Daniel
>
> Best regards
> Thomas
>
> > - Treat any such drivers as CONFIG_STAGING until they've become fully
> >   native, i.e. if no one bothers to convert them, we'll drop them again.
> >
> > The above is kinda similar in spirit to the transitional helpers we've
> > used to upgrade the big drivers from legacy kms to atomic.
> >
> > Thoughts?
> >
> > Cheers, Daniel
> >
> >>
> >>  drivers/gpu/drm/Kconfig                     |   2 +
> >>  drivers/gpu/drm/Makefile                    |   1 +
> >>  drivers/gpu/drm/fbdevdrm/Kconfig            |  13 +
> >>  drivers/gpu/drm/fbdevdrm/Makefile           |  11 +
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c      | 276 ++++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h      |  58 ++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |  96 +++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |  55 ++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     | 347 +++++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c  | 441 ++++++++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h  |  26 +
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   | 195 +++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |  53 ++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 746 ++++++++++++++++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  38 +
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 +++++++++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 +
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c     | 202 ++++++
> >>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h     |  35 +
> >>  19 files changed, 3120 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
> >>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
> >>
> >> --
> >> 2.21.0
> >>
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
