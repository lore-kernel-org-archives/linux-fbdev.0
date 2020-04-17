From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 17 Apr 2020 19:08:54 +0000
Subject: Re: [PATCH 0/8] drm, fbdev: rework dependencies
Message-Id: <20200417190854.GI26002@ziepe.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417171453.GS3456981@phenom.ffwll.local>
In-Reply-To: <20200417171453.GS3456981@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, airlied@linux.ie, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Laurent.pinchart@ideasonboard.com, robert.jarzmik@free.fr, marex@denx.de, thellstrom@vmware.com, dsd@laptop.org, jfrederich@gmail.com, masahiroy@kernel.org, Saeed Mahameed <saeedm@mellanox.com>, geert@linux-m68k.org, linux-graphics-maintainer@vmware.com, Arnd Bergmann <arnd@arndb.de>, haojian.zhuang@gmail.com, Nicolas Pitre <nico@fluxnic.net>, linux-renesas-soc@vger.kernel.org, kieran.bingham+renesas@ideasonboard.com, daniel@zonque.org

On Fri, Apr 17, 2020 at 07:14:53PM +0200, Daniel Vetter wrote:
> On Fri, Apr 17, 2020 at 05:55:45PM +0200, Arnd Bergmann wrote:
> > I tried to fix up some dependencies after the sii8620 "imply EXTCON"
> > statementn broke, trying a few things but in the backing out a
> > change that would completely reverse the LEDS_CLASS selects into
> > a 'depends on'. 
> > 
> > However, what I got now are multiple changes that remove gratious
> > "selects" that lead to circular dependencies for sii8620 and others:
> > 
> > - Anything doing "select FB" is now gone, or becomes "depends on FB",
> > 
> > - DDC support depends on I2C instead of selecting it
> > 
> > - backlight class device support is never selected by framebuffer
> >   drivers but has proper dependencies
> > 
> > I have done thousands of randconfig build tests on this, but no
> > runtime tests.
> > 
> > Some of the 'depends on FOO || !FOO' statements could be simplified
> > into a new 'uses FOO' syntax based on a patch from Saeed Mahameed,
> > but I would for the moment treat that as a cleanup that can be done
> > later.
> > 
> > If we can agree on these changes, maybe someone can merge them
> > through the drm-misc tree.
> > 
> > Please review
> 
> Biggest concern I have is that usability of make menuconfig is horrible,
> and it's very hard to find options that are hidden by depends on. You can
> use the search interface, if you happen to know the option.
> 
> Once you've surmounted that bar, the next one is trying to find what
> exactly you need to enable. Which again means endless of recursive
> screaming at Kconfig files, since make menuconfig doesn't help you at all.

+1 on this. But this is a general kconfig problem, and not unique to
DRM, I've done this screaming for many different things now.. eg to
turn on every single RDMA driver.

I hackily delt with it by creating this rather insane script based on
the python kconfiglib to try and sort things out mostly automatically:

https://github.com/jgunthorpe/Kernel-Maintainer-Tools/blob/master/gj_tools/cmd_kconfig.py

It would be great if menuconfig had a key to say 'hey, really, turn
this on and everything it depends on, recursively'

Jason
