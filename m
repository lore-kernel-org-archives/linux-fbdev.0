From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 08 Dec 2016 15:21:34 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
In-Reply-To: <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

[back from my walk, the sunset here is stellar ;-)]

On Thu, Dec 08, 2016 at 03:44:30PM +0100, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Thu, Dec 8, 2016 at 3:37 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > On Thu, 8 Dec 2016 15:22:09 +0100, Geert Uytterhoeven wrote:
> >> > Wut. We have like 20+ small atomic drivers nowdays.
> >>
> >> That's fast! Only two weeks ago you said:
> >>
> >> | Bummer, they still haven't landed. But afaik there's at least 4 of
> >> | them floating around in various places ...
> >
> > You're not talking about the same thing I believe.
> >
> > When Daniel says "small atomic drivers", he talks about the relatively
> > small DRM drivers for SoC display controllers, such as the ones you can
> > find in ARM SoCs.
> >
> > When you say "small driver", you're thinking about drivers for I2C or
> > SPI connected displays.
> 
> No, I wasn't thinking about I2C or SPI connected displays, but about simple
> dumb memory-mapped frame buffers, which is what fbdev was initially
> developed for.

Yeah, small drivers like these we have piles now, things exploded a lot
after atomic landed two years ago. And they seem to shrink with every
release a bit more (since lots more drivers gives you lots more insight
into what other refactorings would make sense). Those we have a big pile
of, and nowadays (at least with developers expirienced with upstream, but
not necessarily with drm) it takes but a few weeks from initial submission
to getting them merged.

What we don't yet have a nice tidy example driver of is the even simpler
"dumb framebuffer behind a slow bus with explicit/manual upload", for like
small i2c/spi panels (and conceptually also usb, even though there bw and
panel size are a bit scaled up). We've gained some really nice helpers for
this this year, and there's 3 drivers in-flight to make use of it. But
since that's right now just a hobbyist effort it's moving a bit slower
(and I was mistaken a few weeks back where I assumed that one of them
landed already).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
