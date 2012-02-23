From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 23 Feb 2012 07:34:07 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <1329982447.24753.15.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
	<1775349.d0yvHiVdjB@avalon> <20120217095554.GA5511@phenom.ffwll.local>
	<2168398.Pv8ir5xFGf@avalon>
	<alpine.LFD.2.02.1202221559510.3721@casper.infradead.org>
	<20120222162424.GE4872@phenom.ffwll.local>
	<CAF6AEGs5iNbZB5SOcGWkvQu4Yh98KbWWkWkv3mS_noA76utExw@mail.gmail.com>
In-Reply-To: <CAF6AEGs5iNbZB5SOcGWkvQu4Yh98KbWWkWkv3mS_noA76utExw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Clark <rob@ti.com>
Cc: Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Pawel Osciak <pawel@osciak.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Mit, 2012-02-22 at 10:28 -0600, Rob Clark wrote:=20
> On Wed, Feb 22, 2012 at 10:24 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Feb 22, 2012 at 04:03:21PM +0000, James Simmons wrote:
> >>
> >> > > Imo we should ditch this - fb accel doesn't belong into the kernel=
. Even
> >> > > on hw that still has a blitter for easy 2d accel without a complet=
e 3d
> >> > > state setup necessary, it's not worth it. Chris Wilson from our te=
am once
> >> > > played around with implementing fb accel in the kernel (i915 hw st=
ill has
> >> > > a blitter engine in the latest generations). He quickly noticed th=
at to
> >> > > have decent speed, competitive with s/w rendering by the cpu he ne=
eds the
> >> > > entire batch and buffer management stuff from userspace. And to re=
ally
> >> > > beat the cpu, you need even more magic.
> >> > >
> >> > > If you want fast 2d accel, use something like cairo.
> >> >
> >> > Our conclusion on this is that we should not expose an explicit 2D
> >> > acceleration API at the kernel level. If really needed, hardware 2D
> >> > acceleration could be implemented as a DRM device to handle memory m=
anagement,
> >> > commands ring setup, synchronization, ... but I'm not even sure if t=
hat's
> >> > worth it. I might not have conveyed it well in my notes.
> >>
> >> Fbcon scrolling at be painful at HD or better modes. Fbcon needs 3
> >> possible accels; copyarea, imageblit, and fillrect. The first two coul=
d be
> >> hooked from the TTM layer. Its something I plan to experiment to see if
> >> its worth it.
> >
> > Let's bite into this ;-) I know that fbcon scrolling totally sucks on b=
ig
> > screens, but I also think it's a total waste of time to fix this. Imo
> > fbcon has 2 use-cases:
> > - display an OOSP.
> > - allow me to run fsck (or any other desaster-recovery stuff).
> >
> > It can do that quite fine already.
>=20
> and for just fbcon scrolling, if you really wanted to you could
> implement it by just shuffling pages around in a GART..

Keep in mind there are still discrete GPUs :), where scanning out from
anything but VRAM may not be feasible, and direct CPU access to
(especially reads from) VRAM tends to be very slow.

However, for fbcon that can be addressed in each driver (as is done e.g.
in nouveau), and has nothing to do with any userspace interface.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
