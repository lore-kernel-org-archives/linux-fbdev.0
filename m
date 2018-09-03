From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 03 Sep 2018 16:26:52 +0000
Subject: Re: [PATCH v3 00/13] remove_conflicting_framebuffers() cleanup
Message-Id: <20180903162652.GI21634@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
 <CGME20180903074322epcas4p1ce56cf44f5b169b5e1c1e3831bd5c038@epcas4p1.samsung.com>
 <20180903074315.GB21634@phenom.ffwll.local>
 <1705932.lAR3QV8q47@amdc3058>
In-Reply-To: <1705932.lAR3QV8q47@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, Sep 03, 2018 at 01:31:34PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, September 03, 2018 09:43:15 AM Daniel Vetter wrote:
> > On Sat, Sep 01, 2018 at 04:08:41PM +0200, Michał Mirosław wrote:
> > > This series cleans up duplicated code for replacing firmware FB
> > > driver with proper DRI driver and adds handover support to
> > > Tegra driver.
> > > 
> > > This is a sligtly updated version of a series sent on 24 Nov 2017.
> > > 
> > > ---
> > > v2:
> > >  - rebased on current drm-next
> > >  - dropped staging/sm750fb changes
> > >  - added kernel docs for DRM helpers
> > > v3:
> > >  - move kerneldoc to fbdev, where functions are implemented
> > >  - split kerneldoc for remove_conflicting_framebuffers()
> > 
> > Ah, that's not quite what I had in mind. I think having the docs (also) in
> > the drm helpers would be good, since that's where drm people will look,
> > and that's the function they'll call. I just wanted you to split the fbdev
> > and drm parts into 2 patches (since those are two different maintainers).
> > 
> > Anyway, this is ok too, so imo ready for merging. If you can resurrect the
> > drm docs (with a patch title of "drm/fb-helper: document fbdev remove
> > functions" or similar) that would be great.
> > 
> > Only thing we need for merging now is the ack from Bartlomiej.
> 
> For the whole patchset:
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks, entire patch set applied to drm-misc-next for 4.20.
-Daniel

> 
> > -Daniel
> > 
> > >  - propagate return value in remove_conflicting_pci_framebuffers()
> > > 
> > > ---
> > > Michał Mirosław (13):
> > >   fbdev: show fbdev number for debugging
> > >   fbdev: allow apertures = NULL in remove_conflicting_framebuffers()
> > >   fbdev: add kerneldoc do remove_conflicting_framebuffers()
> > >   fbdev: add remove_conflicting_pci_framebuffers()
> > >   drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/bochs: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/radeon: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/virtio: use simpler remove_conflicting_pci_framebuffers()
> > >   drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
> > >   drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
> > >   drm/tegra: kick out simplefb
> > > 
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +--------
> > >  drivers/gpu/drm/bochs/bochs_drv.c        | 18 +------
> > >  drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +--------
> > >  drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +-------
> > >  drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ----
> > >  drivers/gpu/drm/radeon/radeon_drv.c      | 23 +--------
> > >  drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +------
> > >  drivers/gpu/drm/tegra/drm.c              |  4 ++
> > >  drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-------
> > >  drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++-------
> > >  drivers/video/fbdev/core/fbmem.c         | 63 +++++++++++++++++++++++-
> > >  include/drm/drm_fb_helper.h              | 12 +++++
> > >  include/linux/fb.h                       |  2 +
> > >  13 files changed, 89 insertions(+), 172 deletions(-)
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
