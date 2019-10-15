From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Tue, 15 Oct 2019 18:13:37 +0000
Subject: Re: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
Message-Id: <20191015181337.GG1208@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191015143318.GP11828@phenom.ffwll.local>
 <5241e699-f66a-d212-03a5-bb736639e66b@suse.de>
 <CAKMK7uGTAxYNhS7TqEFVA+Gd+-4WOMq7JXPZRF8_a9EP69TkTQ@mail.gmail.com>
In-Reply-To: <CAKMK7uGTAxYNhS7TqEFVA+Gd+-4WOMq7JXPZRF8_a9EP69TkTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jonathan Corbet <corbet@lwn.net>, Mathieu Malaterre <malat@debian.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Zimmermann <tzimmermann@suse.de>, Sean Paul <sean@poorly.run>

On Tue, Oct 15, 2019 at 07:48:29PM +0200, Daniel Vetter wrote:
> On Tue, Oct 15, 2019 at 7:28 PM Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
> >
> > Hi Daniel
> >
> > Am 15.10.19 um 16:33 schrieb Daniel Vetter:
> > > Hi Thomas,
> > >
> > > On Mon, Oct 14, 2019 at 04:04:01PM +0200, Thomas Zimmermann wrote:
> > >> (was: DRM driver for fbdev devices)
> > >>
> > >> This is version 2 of the fbdev conversion helpers. It's more or less=
 a
> > >> rewrite of the original patchset.
> > >>
> > >> The fbdev subsystem is considered legacy and will probably be remove=
d at
> > >> some point. This would mean the loss of a signifanct number of drive=
rs.
> > >> Some of the affected hardware is not in use any longer, but some har=
dware
> > >> is still around and provides good(-enough) framebuffers.
> > >>
> > >> The fbconv helpers allow for running the current DRM stack on top of=
 fbdev
> > >> drivers. It's a set of functions that convert between fbdev interfac=
es and
> > >> DRM interfaces. Based on SHMEM and simple KMS helpers, it only offer=
s the
> > >> basic functionality of a framebuffer, but should be compatible with =
most
> > >> existing fbdev drivers.
> > >>
> > >> A DRM driver using fbconv helpers consists of
> > >>
> > >>   * DRM stub code that calls into fbconv helpers, and
> > >>   * the original fbdev driver code.
> > >>
> > >> The fbdev driver code has to be modified to register itself with the
> > >> stub driver instead of the fbdev core framework. A tutorial on how t=
o use
> > >> the helpers is part of this patchset. The resulting driver hybrid ca=
n be
> > >> refactored into a first-class DRM driver. The fbconv helpers contain=
 a
> > >> number of comments, labeled 'DRM porting note', which explain the re=
quired
> > >> steps.
> > >>
> > >> I tested the current patchset with the following drivers: atyfb, aty=
128fb,
> > >> matroxfb, pm2fb, pm3fb, rivafb, s3fb, savagefb, sisfb, tdfxfb and tr=
identfb.
> > >> With each, I was able to successfully start with fbcon enabled, run =
weston and
> > >> X11. The drivers are available at [1]. For reference, the patchset i=
ncludes
> > >> the Matrox stub driver.
> > >
> > > So I really don't want to rain on the parade here, since if you think=
 this
> > > is useful when converting fbdev drivers I'll buy that, and I'm all for
> > > getting more modern drivers into drm.
> > >
> > > But I have a bunch of concerns with the approach you're proposing her=
e:
> > >
> > > - we've tried staging for drm driver refactoring, it hurts. Separate =
tree
> > >   plus the quick pace in refactoring create lots of pains. And for sm=
all
> > >   drivers refacotoring before it's not buying you anything above
> > >   refactoring in your own personal tree. And for big drivers we're fa=
irly
> > >   lenient with merging drivers that aren't fully polished yet, if the=
re's
> > >   a team serious enough with cleaning up the mess. I think even mergi=
ng
> > >   partial drivers directly under drivers/gpu (but behind CONFIG_BROKE=
N) is
> > >   better than staging.
> >
> > I mostly put this into staging, because it's the kind of code you'd
> > expect there.
>=20
> Yeah, except we tried, it's a real pain. Conclusion by everyone
> involved is that staging doesn't work for the drm subsystem.
>=20
> > > - we've had conversion helpers before (for the legacy kms -> atomic
> > >   upgrade). They constantly broke, pretty much every release when som=
eone
> > >   wanted to use them they first had to fix them up again. I think hav=
ing
> > >   those helpers is good, but better to just have them in some branch
> > >   somewhere where it's clear that they might not work anymore on late=
st
> > >   upstream.
> > >
> > > - especially for some of these simple fbdev drivers I feel like just
> > >   typing a new driver from scratch might be simpler.
> > >
> > > A few more concerns specifically for your mga example:
> > >
> > > - We already have a mga driver. Might be better to integrate support =
for
> > >   older mgas into that than have a parallel driver.
> >
> > Two colleagues of mine, Takashi and Egbert, send a patch that added
> > support for desktop G200s to mgag200. [1] But it was rejected because
> > the devices are two old and not relevant any longer. If that opinion has
> > changed in the meantime, I wouldn't mind adding support for desktop GPUs
> > to the driver.
>=20
> Hm that seems to have petered out inconclusive. I definitely think a
> merged mga driver is better than 2 drm atomic kms drivers for roughly
> the same hardware. I'm also assuming that at least for now no one
> plans to resurrect the 3d acceleration support for these old chips.
> But even then it's fairly easy to disable all that on the server
> chips.
>=20
> > > - Your helper is based on simple display pipe, and I think for these =
old
> > >   mga chips (especially the dual pipe mga 450 and 550) simple display=
 pipe
> > >   helper is more a hindering detour than actual help. From a quick re=
ad
> > >   through the code (especially all the custom ioctls) you definitely =
want
> > >   separate TV-out connector to expose all the tv mode properties (ins=
tead
> > >   of the custom ioctls).
> >
> > Around the G100, there's something like a change in generation. Before,
> > devices had only a single output and less than 8 MiB of RAM. This works
> > well with GEM SHMEM and simple KMS. Afterwards, devices have 8 MiB or
> > more and multiple outputs. GEM VRAM and the full set of helpers fit this
> > much better. Maybe having 2 drivers that share common code (or 3 with
> > the Server Engine chipsets) makes most sense.
>=20
> Yeah if that's the case maybe a mga100 and mga200g driver fits better.
> Former based on simple display pipe.

The display hardware differences are quite minimal from=20
1064SG to G200. G400 did add the second CRTC but essentially
nothing else changed from G200 display. G450/G550 changed
the PLLS around a bit just for the heck of it, and integrated=20
the TMDS transmitter and TV encoder. And then they did even
more PLL madness with the different G200 server chip variants.

So IMO from display hw POV G100 vs. G200 split doesn't really
make sense.

And if you go to the effort of supporting dual head on G400+ then
the single head case on earlier platforms is just the same as the
single head "trivial" case on G400+, so totally different drivers
doesn't make sense there either. Also not all G400 cards have
the TVO/TMDS chip present in which case you can only use a
single head anyway (it's almost identical to a G200 card at
that point, assuming you drive the single output with the
primary CRTC).

--=20
Ville Syrj=E4l=E4
Intel
