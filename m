From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 09 Dec 2016 13:19:15 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481289555.8389.1.camel@pengutronix.de>
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
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <1481283856.27965.11.camel@kernel.crashing.org>
In-Reply-To: <1481283856.27965.11.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

Am Freitag, den 09.12.2016, 22:44 +1100 schrieb Benjamin Herrenschmidt:
> On Fri, 2016-12-09 at 09:34 +0100, Daniel Vetter wrote:
> > Yeah if you have discrete vram then your dumb display driver isn't all
> > that pretty. We essentially just have the few drivers Dave hacked up to be
> > able to boot some servers. And there's definitely lots of room for more
> > shared code for those, and also some better infrastructure and helpers to
> > share more cod and make them better.
> > 
> > The massive pile of dumb framebuffers we all merged over the past 2 years
> > all use system/dma memory for scanout, and for those we have the very nice
> > cma helpers that take care of everything for you. 
> 
> Do they work if the system/DMA memory has to be physically contiguous
> and at a fixed address ? The AST "ARM side" GPU is like that.

Yes, CMA is exactly the solution for that. It provides contiguous memory
that doesn't need to be removed from the normal Linux memory handling
and allows for the CMA region to be at specific places if needed. It's
just a matter of describing the constraints properly.

Regards,
Lucas

