From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 31 Aug 2018 09:04:39 +0000
Subject: Re: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
Message-Id: <20180831090439.GT21634@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alex Deucher <alexander.deucher@amd.com>, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

On Thu, Aug 30, 2018 at 11:00:01PM +0200, Michał Mirosław wrote:
> This series cleans up duplicated code for replacing firmware FB
> driver with proper DRI driver and adds handover support to
> Tegra driver.
> 
> This is a sligtly updated version of a series sent on 24 Nov 2017.
> 
> v2:
>  - rebased on current drm-next
>  - dropped staging/sm750fb changes
>  - added kernel docs for DRM helpers
> 
> Michał Mirosław (12):
>   fbdev: show fbdev number for debugging
>   fbdev: allow apertures = NULL in remove_conflicting_framebuffers()
>   fbdev: add remove_conflicting_pci_framebuffers()
>   drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
>   drm/bochs: use simpler remove_conflicting_pci_framebuffers()
>   drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
>   drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
>   drm/radeon: use simpler remove_conflicting_pci_framebuffers()
>   drm/virtio: use simpler remove_conflicting_pci_framebuffers()
>   drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
>   drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
>   drm/tegra: kick out simplefb

Looks very neat. A bit confused about the drm changes in the fbdev-titled
patches 1&3, but I guess we can merge as-is. Up to you whether you want to
split or not I'd say.

Bartlomiej, ack for pullin in this entire pile through drm-misc?

Thanks, Daniel

> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +-------------
>  drivers/gpu/drm/bochs/bochs_drv.c        | 18 +----------
>  drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +-------------
>  drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +------------
>  drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ------
>  drivers/gpu/drm/radeon/radeon_drv.c      | 23 +-------------
>  drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +----------
>  drivers/gpu/drm/tegra/drm.c              |  4 +++
>  drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-----------
>  drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++------------
>  drivers/video/fbdev/core/fbmem.c         | 40 ++++++++++++++++++++++--
>  include/drm/drm_fb_helper.h              | 34 ++++++++++++++++++++
>  include/linux/fb.h                       |  2 ++
>  13 files changed, 88 insertions(+), 172 deletions(-)
> 
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
