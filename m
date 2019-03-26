From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 26 Mar 2019 14:53:20 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <20190326145320.GJ2665@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

On Tue, Mar 26, 2019 at 10:17:33AM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> this RFC patch set implements fbdevdrm, a DRM driver on top of fbdev
> drivers. I'd appreciate feedback on the code and the idea in general.
> 
> The fbdev subsystem is considered legacy and will probably be removed at
> some point. This would mean the loss of a signifanct number of drivers.
> Some of the affected hardware is probably not in use any longer, but some
> hardware is still around and provides good(-enough) framebuffers.
> 
> OTOH, userspace programs that want to support a wide range of graphics
> hardware have to implement support for both DRM and fbdev interfaces. Such
> software would benefit from a single interface.
> 
> The fbdevdrm driver provides a way of running drivers for old and new
> hardware from the DRM subsystem and interfaces.
> 
> It's not intended to add new features or drivers to fbdev. Instead fbdevdrm
> is supposed to be a template for converting fbdev drivers to DRM. It contains
> a number of comments (labeled 'DRM porting note') that explain the required
> steps. The license is fairly liberal to allow for combination with existing
> fbdev code.
> 
> I tested the current patch set with the following drivers: atyfb, aty128fb,
> matroxfb, pm2fb, s3fb, savagefb, sisfb, tdfxfb and tridentfb. I was able to
> successfully start with fbcon enabled and then run weston or X.
> 
> Thomas Zimmermann (11):
>   drm/fbdevdrm: Add driver skeleton
>   drm/fbdevdrm: Add fbdevdrm device
>   drm/fbdevdrm: Add memory management
>   drm/fbdevdrm: Add file operations
>   drm/fbdevdrm: Add GEM and dumb interfaces
>   drm/fbdevdrm: Add modesetting infrastructure
>   drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
>   drm/fbdevdrm: Add mode conversion DRM <-> fbdev
>   drm/fbdevdrm: Add primary plane
>   drm/fbdevdrm: Add CRTC
>   drm/fbdevdrm: Detect and validate display modes

Looks surprisingly clean, at least from a quick read. Only big thing I
noticed on the implementation side is that you probably want to use the
simple display helpers. At least that's a much better fit for simple
display hw supported by these fbdev drivers.

What I'm not sure at all on is whether this is a good idea. It's a quick
way of supporting a few drivers we might need from fbdev. But I fear for
long-term ecosystem health it'll be a loss: Much less motivation to port
the drivers to be native kms ones, and as a result, much less
opportunities to extract helpers to make driver writing for such hw easier
for everyone.

And the latter is really important, if you look at all the work people
have done to improve the modeset helpers. Nowadays we have some examples
where the kms native port of an fbdev driver turned out to be 2-3x
smaller.

But I also see the benefit of making the fbdev->kms transition smoother.
For discussion here's a pretty wild idea that we might want to consider:

- move the ttm based gem code into a helper library like the cma gem
  helpers. Only special piece we need to pass it is the fb_info structure,
  for that we can use the same hooks the cma helpers use to allow drivers
  to specify the right struct device to use for cma allocations. plus ofc
  an init function for the memory manager and all that, which drivers can
  put into their driver private device structure

- move the modeset compat code into a helper based on top of the simple
  display pipe helpers. 

- for each fbdev driver we care about:
  1. create bare-bones kms driver
  2. copypaste the entire fbdev driver code into the drm driver
  3. hook up the above two helper libraries, remove the
  register_framebuffer - I think we can still allocate the fb_info and all
  that for transition
  4. transition the driver over. If we have the helpers a bit split up
  between display and buffer management side that should be a lot more
  gradual, and with the fbdevdrm midlayer inserted in the middle.

- Improve the other helpers we have as needed - there's probably room for
  a simple ttm version, inspired by all these simple display chips (e.g.
  ast/cirrus/bochs/mga all solve similar problems like this).

- Treat any such drivers as CONFIG_STAGING until they've become fully
  native, i.e. if no one bothers to convert them, we'll drop them again.

The above is kinda similar in spirit to the transitional helpers we've
used to upgrade the big drivers from legacy kms to atomic.

Thoughts?

Cheers, Daniel

> 
>  drivers/gpu/drm/Kconfig                     |   2 +
>  drivers/gpu/drm/Makefile                    |   1 +
>  drivers/gpu/drm/fbdevdrm/Kconfig            |  13 +
>  drivers/gpu/drm/fbdevdrm/Makefile           |  11 +
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c      | 276 ++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h      |  58 ++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |  96 +++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |  55 ++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     | 347 +++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c  | 441 ++++++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h  |  26 +
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   | 195 +++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |  53 ++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 746 ++++++++++++++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  38 +
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 +++++++++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 +
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c     | 202 ++++++
>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h     |  35 +
>  19 files changed, 3120 insertions(+)
>  create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
>  create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
> 
> --
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
