From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 09 Dec 2016 08:34:42 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
In-Reply-To: <1481234249.26959.55.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, Dec 09, 2016 at 08:57:29AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-12-09 at 08:34 +1100, Benjamin Herrenschmidt wrote:
> > As I mentioned earlier, probably 1 or 2 years ago, Dave made the
> > argument that shadowing through memory was necessary and precluded 2D
> > accel, though I don't fully remember the root of the argument. If that
> > is indeed not the case, then my main objection is lifted.
> 
> Things seem to change quickly as Daniel pointed out.
> 
> So ast and cirrus seem to still use a manual dirty tracking and
> shadowing (though I'm not sure why), but the infrastructure for
> that has moved from the drivers to the helpers.
> 
> bochs (qemu) doesn't seem to anymore from what I can see as it
> doesn't have a ->dirty callback.

Yeah if you have discrete vram then your dumb display driver isn't all
that pretty. We essentially just have the few drivers Dave hacked up to be
able to boot some servers. And there's definitely lots of room for more
shared code for those, and also some better infrastructure and helpers to
share more cod and make them better.

The massive pile of dumb framebuffers we all merged over the past 2 years
all use system/dma memory for scanout, and for those we have the very nice
cma helpers that take care of everything for you. So it is possible, only
reason vram dumb buffers look worse is that there's only 3 and no one
cares about them, vs about 20 and a very active community of contributors
(also for core drm improvements) for the other case.

Althought the MXSFB driver that just landed does use ttm and vram, so
maybe that's now improving too.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
