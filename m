From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 21:51:08 +0200
Message-ID: <20050316195108.GA6651@sci.fi>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi>
	<200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston> <20050316014714.GA5387@sci.fi>
	<1110937887.649.101.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110937887.649.101.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, adaplas@pol.net, dri-devel@lists.sourceforge.net

On Wed, Mar 16, 2005 at 12:51:27PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 03:47 +0200, Ville Syrj=E4l=E4 wrote:
>=20
> > There's also the case with Matrox Millennium I/II cards. They must pl=
ace=20
> > the visible frame buffer so that no line crosses the boundary of memo=
ry=20
> > banks. matroxfb deals with that by moving the buffer and changing=20
> > smem_start and smem_len appropriately. But that is really bad for=20
> > DirectFB's offscreen memory management. After a mode switch the memor=
y=20
> > manager would need to know what kind of initial byte offset was used.=
 Of=20
> > couse it would be possible to determine that from smem_start by knowi=
ng=20
> > how the aperture must be aligned. Actually we already do that sort of=
=20
> > thing to allow hw accelerated rendering when used on matroxfb control=
led=20
> > G450/G450/G550 CRTC2. But in that case the offset won't change on mod=
e=20
> > switch.
>=20
> So it alls end up to -> mode switch has to bust memory layout, and any
> assumptions that DirectFB tries to do are incorrect.

I don't think so. Due to fbdev API limitations DirectFB just can't=20
accurately determine how much memory will be used by the fbdev buffer. It=
=20
can make an educated guess though. Just as long as you don't change the=20
fact that the fbdev buffer will be located at the beginning of the memory=
=20
that is.

> > > and because
> > > it seems that directFB has only been tested on little endian machin=
es
> > > (damn them !) and thus doesn't understand the problem with swapper =
on
> > > framebuffer access).
> >=20
> > Actually people do use it on big-endian systems but since neither the=
=20
> > mach64, ati128 or radeon drivers play with the swapper settings I can=
 only=20
> > assume that they haven't been tested very extensively.
>=20
> You are wrong here, all of those 3 drivers do play with the swapper
> setting, they all 3 set the swapper based on the bit depth of the
> screen, so writing an image to offscreen memory with a different bit
> depth will be broken. See usage of SURFACE_CNTL in radeonfb for example=
.

This was about the DirectFB drivers.

One thing just popped to my head though. If in the future we are going to=
=20
allow graphics cards to render to system memory, using the swapper will n=
o=20
longer work. I don't see any other solution that having the CPU perform=20
the byte swapping.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
