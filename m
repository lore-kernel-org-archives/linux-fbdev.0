From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 09 Dec 2016 13:35:12 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161209133512.nuohi42ho3rgghau@phenom.ffwll.local>
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
In-Reply-To: <1481284087.27965.13.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, Dec 09, 2016 at 10:48:07PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-12-09 at 09:41 +0100, Daniel Vetter wrote:
> >=20
> > And since I failed to make this clear: There's not really a
> > fundamental
> > reason ast and cirrus use the dirty tracking for fbdev. It's just that
> > doing it that way was the fastest way to get those servers booting, and
> > ever since no one cared. It's a bit tricky to do right because fbdev
> > assumes it always own the framebuffer and that it never moves,=20
>=20
> That can be worked around from my memories of hacking fbdev many years
> ago. Basically fbdev only owns it if it's the current VT and you can
> make it release it if the user switches to KD_GRAPHICS which userspace
> should always do before taking over.
>=20
> As for multi userspace client, well, swapping an mmap between HW and
> memory backing store is a somewhat solved problem already.

Hm, I didn't know that, but then all existing drm drivers have fairly
simplistic fbdev mmap implementations.

> > whereas drm has a multi-master model and proper isolation. IIrc we've h=
acked up
> > something once, and if there's indeed more interest into vram dumb buff=
er
> > drivers I'm pretty sure we can grow some nice ttm fb helpers (like the =
cma
> > fb helpers we have) to make it all pretty and nice and fast and
> > essentially plug-in-and-forget from a driver authors pov.
>=20
> That would be nice. I don't have the bandwidth to swap-in enough
> understanding of TTM guts right now but I might look into it some time ne=
xt=A0
> year if nobody beats me to it.

Probably best would be to first extract some helpers for ttm based vram
dumb buffer management, and then start to implement some of the
improvements so that all drivers can benefit. Like you've said it's not
rocket science, it just needs to be done ;-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
