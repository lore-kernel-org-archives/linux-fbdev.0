From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2016 20:27:03 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481315223.17253.15.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <20161209084154.rp4wqzv46tuvf3jv@phenom.ffwll.local>
 <1481284087.27965.13.camel@kernel.crashing.org>
 <20161209133512.nuohi42ho3rgghau@phenom.ffwll.local>
In-Reply-To: <20161209133512.nuohi42ho3rgghau@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, 2016-12-09 at 14:35 +0100, Daniel Vetter wrote:
> > As for multi userspace client, well, swapping an mmap between HW and
> > memory backing store is a somewhat solved problem already.
> 
> Hm, I didn't know that, but then all existing drm drivers have fairly
> simplistic fbdev mmap implementations.

Hrm, I though the TTM did it ... I remember talking with Thomas
Hellstrom about that back in the day... you use unmap_mapping_range
to unmap the existing mappings basically so you can take new faults
and route them to a different page, but I can't see a call in there
so maybe he ended up not doing it.

We used to do that on Cell to "context switch" the local memory of
the SPU engines between the real SPU and the backing store. It's not
very hard to do.
 
The main issue is that the mapping attributes change between cached
and non-cached under the hood, so users have to be careful not to do
things like use instructions that only work on one type of mapping
(or do things like misaligned accesses).

> > > whereas drm has a multi-master model and proper isolation. IIrc we've hacked up
> > > something once, and if there's indeed more interest into vram dumb buffer
> > > drivers I'm pretty sure we can grow some nice ttm fb helpers (like the cma
> > > fb helpers we have) to make it all pretty and nice and fast and
> > > essentially plug-in-and-forget from a driver authors pov.
> > 
> > That would be nice. I don't have the bandwidth to swap-in enough
> > understanding of TTM guts right now but I might look into it some time next 
> > year if nobody beats me to it.
> 
> Probably best would be to first extract some helpers for ttm based vram
> dumb buffer management, and then start to implement some of the
> improvements so that all drivers can benefit. Like you've said it's not
> rocket science, it just needs to be done ;-)

Right :-)

Though getting ones head around the infrastructure in the DRM does take
time :-) There's a lot of stuff in there, between TTM, GEM etc... and
not all of it completely "obvious" ...

Cheers,
Ben.

> -Daniel
> -- 
