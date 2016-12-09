From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2016 11:48:07 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481284087.27965.13.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <20161209084154.rp4wqzv46tuvf3jv@phenom.ffwll.local>
In-Reply-To: <20161209084154.rp4wqzv46tuvf3jv@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2016-12-09 at 09:41 +0100, Daniel Vetter wrote:
> 
> And since I failed to make this clear: There's not really a
> fundamental
> reason ast and cirrus use the dirty tracking for fbdev. It's just that
> doing it that way was the fastest way to get those servers booting, and
> ever since no one cared. It's a bit tricky to do right because fbdev
> assumes it always own the framebuffer and that it never moves, 

That can be worked around from my memories of hacking fbdev many years
ago. Basically fbdev only owns it if it's the current VT and you can
make it release it if the user switches to KD_GRAPHICS which userspace
should always do before taking over.

As for multi userspace client, well, swapping an mmap between HW and
memory backing store is a somewhat solved problem already.

> whereas drm has a multi-master model and proper isolation. IIrc we've hacked up
> something once, and if there's indeed more interest into vram dumb buffer
> drivers I'm pretty sure we can grow some nice ttm fb helpers (like the cma
> fb helpers we have) to make it all pretty and nice and fast and
> essentially plug-in-and-forget from a driver authors pov.

That would be nice. I don't have the bandwidth to swap-in enough
understanding of TTM guts right now but I might look into it some time next 
year if nobody beats me to it.

> Cheers, Daniel
> 
> > The massive pile of dumb framebuffers we all merged over the past 2 years
> > all use system/dma memory for scanout, and for those we have the very nice
> > cma helpers that take care of everything for you. So it is possible, only
> > reason vram dumb buffers look worse is that there's only 3 and no one
> > cares about them, vs about 20 and a very active community of contributors
> > (also for core drm improvements) for the other case.
> > 
> > Althought the MXSFB driver that just landed does use ttm and vram, so
> > maybe that's now improving too.
> > -Daniel
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> 
