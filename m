From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Tue, 15 Oct 2019 18:28:27 +0000
Subject: Re: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
Message-Id: <20191015182827.GJ1208@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191015143318.GP11828@phenom.ffwll.local>
 <5241e699-f66a-d212-03a5-bb736639e66b@suse.de>
 <CAKMK7uGTAxYNhS7TqEFVA+Gd+-4WOMq7JXPZRF8_a9EP69TkTQ@mail.gmail.com>
 <20191015181337.GG1208@intel.com>
In-Reply-To: <20191015181337.GG1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jonathan Corbet <corbet@lwn.net>, Mathieu Malaterre <malat@debian.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Zimmermann <tzimmermann@suse.de>, Sean Paul <sean@poorly.run>

On Tue, Oct 15, 2019 at 09:13:37PM +0300, Ville Syrj=E4l=E4 wrote:
> On Tue, Oct 15, 2019 at 07:48:29PM +0200, Daniel Vetter wrote:
> > On Tue, Oct 15, 2019 at 7:28 PM Thomas Zimmermann <tzimmermann@suse.de>=
 wrote:
> > >
> > > Hi Daniel
> > >
> > > Am 15.10.19 um 16:33 schrieb Daniel Vetter:
> > > > Hi Thomas,
> > > >
> > > > On Mon, Oct 14, 2019 at 04:04:01PM +0200, Thomas Zimmermann wrote:
> > > >> (was: DRM driver for fbdev devices)
> > > >>
> > > >> This is version 2 of the fbdev conversion helpers. It's more or le=
ss a
> > > >> rewrite of the original patchset.
> > > >>
> > > >> The fbdev subsystem is considered legacy and will probably be remo=
ved at
> > > >> some point. This would mean the loss of a signifanct number of dri=
vers.
> > > >> Some of the affected hardware is not in use any longer, but some h=
ardware
> > > >> is still around and provides good(-enough) framebuffers.
> > > >>
> > > >> The fbconv helpers allow for running the current DRM stack on top =
of fbdev
> > > >> drivers. It's a set of functions that convert between fbdev interf=
aces and
> > > >> DRM interfaces. Based on SHMEM and simple KMS helpers, it only off=
ers the
> > > >> basic functionality of a framebuffer, but should be compatible wit=
h most
> > > >> existing fbdev drivers.
> > > >>
> > > >> A DRM driver using fbconv helpers consists of
> > > >>
> > > >>   * DRM stub code that calls into fbconv helpers, and
> > > >>   * the original fbdev driver code.
> > > >>
> > > >> The fbdev driver code has to be modified to register itself with t=
he
> > > >> stub driver instead of the fbdev core framework. A tutorial on how=
 to use
> > > >> the helpers is part of this patchset. The resulting driver hybrid =
can be
> > > >> refactored into a first-class DRM driver. The fbconv helpers conta=
in a
> > > >> number of comments, labeled 'DRM porting note', which explain the =
required
> > > >> steps.
> > > >>
> > > >> I tested the current patchset with the following drivers: atyfb, a=
ty128fb,
> > > >> matroxfb, pm2fb, pm3fb, rivafb, s3fb, savagefb, sisfb, tdfxfb and =
tridentfb.
> > > >> With each, I was able to successfully start with fbcon enabled, ru=
n weston and
> > > >> X11. The drivers are available at [1]. For reference, the patchset=
 includes
> > > >> the Matrox stub driver.
> > > >
> > > > So I really don't want to rain on the parade here, since if you thi=
nk this
> > > > is useful when converting fbdev drivers I'll buy that, and I'm all =
for
> > > > getting more modern drivers into drm.
> > > >
> > > > But I have a bunch of concerns with the approach you're proposing h=
ere:
> > > >
> > > > - we've tried staging for drm driver refactoring, it hurts. Separat=
e tree
> > > >   plus the quick pace in refactoring create lots of pains. And for =
small
> > > >   drivers refacotoring before it's not buying you anything above
> > > >   refactoring in your own personal tree. And for big drivers we're =
fairly
> > > >   lenient with merging drivers that aren't fully polished yet, if t=
here's
> > > >   a team serious enough with cleaning up the mess. I think even mer=
ging
> > > >   partial drivers directly under drivers/gpu (but behind CONFIG_BRO=
KEN) is
> > > >   better than staging.
> > >
> > > I mostly put this into staging, because it's the kind of code you'd
> > > expect there.
> >=20
> > Yeah, except we tried, it's a real pain. Conclusion by everyone
> > involved is that staging doesn't work for the drm subsystem.
> >=20
> > > > - we've had conversion helpers before (for the legacy kms -> atomic
> > > >   upgrade). They constantly broke, pretty much every release when s=
omeone
> > > >   wanted to use them they first had to fix them up again. I think h=
aving
> > > >   those helpers is good, but better to just have them in some branch
> > > >   somewhere where it's clear that they might not work anymore on la=
test
> > > >   upstream.
> > > >
> > > > - especially for some of these simple fbdev drivers I feel like just
> > > >   typing a new driver from scratch might be simpler.
> > > >
> > > > A few more concerns specifically for your mga example:
> > > >
> > > > - We already have a mga driver. Might be better to integrate suppor=
t for
> > > >   older mgas into that than have a parallel driver.
> > >
> > > Two colleagues of mine, Takashi and Egbert, send a patch that added
> > > support for desktop G200s to mgag200. [1] But it was rejected because
> > > the devices are two old and not relevant any longer. If that opinion =
has
> > > changed in the meantime, I wouldn't mind adding support for desktop G=
PUs
> > > to the driver.
> >=20
> > Hm that seems to have petered out inconclusive. I definitely think a
> > merged mga driver is better than 2 drm atomic kms drivers for roughly
> > the same hardware. I'm also assuming that at least for now no one
> > plans to resurrect the 3d acceleration support for these old chips.
> > But even then it's fairly easy to disable all that on the server
> > chips.
> >=20
> > > > - Your helper is based on simple display pipe, and I think for thes=
e old
> > > >   mga chips (especially the dual pipe mga 450 and 550) simple displ=
ay pipe
> > > >   helper is more a hindering detour than actual help. From a quick =
read
> > > >   through the code (especially all the custom ioctls) you definitel=
y want
> > > >   separate TV-out connector to expose all the tv mode properties (i=
nstead
> > > >   of the custom ioctls).
> > >
> > > Around the G100, there's something like a change in generation. Befor=
e,
> > > devices had only a single output and less than 8 MiB of RAM. This wor=
ks
> > > well with GEM SHMEM and simple KMS. Afterwards, devices have 8 MiB or
> > > more and multiple outputs. GEM VRAM and the full set of helpers fit t=
his
> > > much better. Maybe having 2 drivers that share common code (or 3 with
> > > the Server Engine chipsets) makes most sense.
> >=20
> > Yeah if that's the case maybe a mga100 and mga200g driver fits better.
> > Former based on simple display pipe.
>=20
> The display hardware differences are quite minimal from=20
> 1064SG to G200. G400 did add the second CRTC but essentially
> nothing else changed from G200 display. G450/G550 changed
> the PLLS around a bit just for the heck of it, and integrated=20
> the TMDS transmitter and TV encoder. And then they did even
> more PLL madness with the different G200 server chip variants.
>=20
> So IMO from display hw POV G100 vs. G200 split doesn't really
> make sense.

Ah, I did forget that G100 and earlier don't support the
cursor 16 color mode that G200+ have. So I guess there is a
little bit of a difference there.

--=20
Ville Syrj=E4l=E4
Intel
