From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Dec 2016 21:34:37 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481232877.26959.52.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
In-Reply-To: <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Thu, 2016-12-08 at 16:21 +0100, Daniel Vetter wrote:
> Yeah, small drivers like these we have piles now, things exploded a lot
> after atomic landed two years ago. And they seem to shrink with every
> release a bit more (since lots more drivers gives you lots more insight
> into what other refactorings would make sense). Those we have a big pile
> of, and nowadays (at least with developers expirienced with upstream, but
> not necessarily with drm) it takes but a few weeks from initial submission
> to getting them merged.
> 
> What we don't yet have a nice tidy example driver of is the even simpler
> "dumb framebuffer behind a slow bus with explicit/manual upload", for like
> small i2c/spi panels (and conceptually also usb, even though there bw and
> panel size are a bit scaled up). We've gained some really nice helpers for
> this this year, and there's 3 drivers in-flight to make use of it. But
> since that's right now just a hobbyist effort it's moving a bit slower
> (and I was mistaken a few weeks back where I assumed that one of them
> landed already).

What I find usually confusing is the interaction with the TTM and
overall fb memory management, when trying to plumb in simple 2d accel
to speed up fbcon mostly (but I don't mind making it available to user
space via ioctls, though that's not a priority).

As I mentioned earlier, probably 1 or 2 years ago, Dave made the
argument that shadowing through memory was necessary and precluded 2D
accel, though I don't fully remember the root of the argument. If that
is indeed not the case, then my main objection is lifted.

Cheers,
Ben.

