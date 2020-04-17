From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 17 Apr 2020 17:14:53 +0000
Subject: Re: [PATCH 0/8] drm, fbdev: rework dependencies
Message-Id: <20200417171453.GS3456981@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, airlied@linux.ie, Andrzej Hajda <a.hajda@samsung.com>, Laurent.pinchart@ideasonboard.com, robert.jarzmik@free.fr, marex@denx.de, thellstrom@vmware.com, dsd@laptop.org, Jason Gunthorpe <jgg@ziepe.ca>, masahiroy@kernel.org, Saeed Mahameed <saeedm@mellanox.com>, linux-graphics-maintainer@vmware.com, geert@linux-m68k.org, haojian.zhuang@gmail.com, Nicolas Pitre <nico@fluxnic.net>, dri-devel@lists.freedesktop.org, jfrederich@gmail.com, linux-renesas-soc@vger.kernel.org, kieran.bingham+renesas@ideasonboard.com, daniel@zonque.org

On Fri, Apr 17, 2020 at 05:55:45PM +0200, Arnd Bergmann wrote:
> I tried to fix up some dependencies after the sii8620 "imply EXTCON"
> statementn broke, trying a few things but in the backing out a
> change that would completely reverse the LEDS_CLASS selects into
> a 'depends on'. 
> 
> However, what I got now are multiple changes that remove gratious
> "selects" that lead to circular dependencies for sii8620 and others:
> 
> - Anything doing "select FB" is now gone, or becomes "depends on FB",
> 
> - DDC support depends on I2C instead of selecting it
> 
> - backlight class device support is never selected by framebuffer
>   drivers but has proper dependencies
> 
> I have done thousands of randconfig build tests on this, but no
> runtime tests.
> 
> Some of the 'depends on FOO || !FOO' statements could be simplified
> into a new 'uses FOO' syntax based on a patch from Saeed Mahameed,
> but I would for the moment treat that as a cleanup that can be done
> later.
> 
> If we can agree on these changes, maybe someone can merge them
> through the drm-misc tree.
> 
> Please review

Biggest concern I have is that usability of make menuconfig is horrible,
and it's very hard to find options that are hidden by depends on. You can
use the search interface, if you happen to know the option.

Once you've surmounted that bar, the next one is trying to find what
exactly you need to enable. Which again means endless of recursive
screaming at Kconfig files, since make menuconfig doesn't help you at all.

That's pretty much why we've never pushed this in, and instead done the
selects. I'm vary applying all this, since after after there'll be all the
screaming again and we have to back it out.

I think to embrace this without regrets what we need is:
- some way to list the hidden options
- some way to browse the depedencies of those hidden options

menuconfig cant do that, gconfig I cant build here (it's some old gtk2
thing, where do you even get the deps for that). xconfig also cant do
this easily, dependencies aren't linked.

So yeah not sure this is a good idea at all, until at least menuconfig can
cope.
-Daniel

> 
>        Arnd
> 
> Arnd Bergmann (8):
>   fbdev: w100fb: clean up mach-pxa compile-time dependency
>   fbdev/ARM: pxa: avoid selecting CONFIG_FB
>   fbdev: rework FB_DDC dependencies
>   drm/rcar: stop using 'imply' for dependencies
>   drm/vmwgfx: make framebuffer support optional
>   drm: decouple from CONFIG_FB
>   fbdev: rework backlight dependencies
>   drm/bridge/sii8620: fix extcon dependency
> 
>  arch/arm/configs/pxa_defconfig      |  3 ++
>  arch/arm/mach-pxa/Kconfig           |  7 ---
>  arch/arm/mach-pxa/eseries.c         | 14 +----
>  arch/arm/mach-pxa/saar.c            |  2 +-
>  arch/arm/mach-pxa/tavorevb.c        |  2 +-
>  drivers/auxdisplay/Kconfig          |  1 +
>  drivers/gpu/drm/Kconfig             |  5 +-
>  drivers/gpu/drm/bridge/Kconfig      |  2 +-
>  drivers/gpu/drm/mxsfb/Kconfig       |  1 -
>  drivers/gpu/drm/rcar-du/Kconfig     | 23 +++++---
>  drivers/gpu/drm/vmwgfx/Kconfig      | 17 +++---
>  drivers/gpu/drm/vmwgfx/Makefile     |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 35 +++++++-----
>  drivers/gpu/drm/zte/Kconfig         |  1 -
>  drivers/macintosh/Kconfig           |  1 +
>  drivers/staging/fbtft/Kconfig       |  1 +
>  drivers/staging/olpc_dcon/Kconfig   |  2 +-
>  drivers/video/fbdev/Kconfig         | 31 ++++++++---
>  drivers/video/fbdev/w100fb.c        | 84 +++++------------------------
>  include/video/w100fb.h              |  6 +--
>  20 files changed, 101 insertions(+), 141 deletions(-)
> 
> -- 
> 2.26.0
> 
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Saeed Mahameed <saeedm@mellanox.com>
> Cc: <masahiroy@kernel.org>
> Cc: <Laurent.pinchart@ideasonboard.com>
> Cc: <linux-renesas-soc@vger.kernel.org>,
> Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
> Cc: <kieran.bingham+renesas@ideasonboard.com>,
> Cc: <airlied@linux.ie>
> Cc: daniel@zonque.org
> Cc: haojian.zhuang@gmail.com
> Cc: robert.jarzmik@free.fr
> Cc: daniel@ffwll.ch
> Cc: marex@denx.de
> Cc: stefan@agner.ch
> Cc: linux-graphics-maintainer@vmware.com
> Cc: thellstrom@vmware.com
> Cc: jfrederich@gmail.com
> Cc: dsd@laptop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: geert@linux-m68k.org

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
