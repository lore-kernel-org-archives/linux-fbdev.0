From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 12:51:27 +1100
Message-ID: <1110937887.649.101.camel@gaston>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston>  <20050316014714.GA5387@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316014714.GA5387@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, adaplas@pol.net, dri-devel@lists.sourceforge.net

On Wed, 2005-03-16 at 03:47 +0200, Ville Syrj=E4l=E4 wrote:

> There's also the case with Matrox Millennium I/II cards. They must plac=
e=20
> the visible frame buffer so that no line crosses the boundary of memory=
=20
> banks. matroxfb deals with that by moving the buffer and changing=20
> smem_start and smem_len appropriately. But that is really bad for=20
> DirectFB's offscreen memory management. After a mode switch the memory=20
> manager would need to know what kind of initial byte offset was used. O=
f=20
> couse it would be possible to determine that from smem_start by knowing=
=20
> how the aperture must be aligned. Actually we already do that sort of=20
> thing to allow hw accelerated rendering when used on matroxfb controlle=
d=20
> G450/G450/G550 CRTC2. But in that case the offset won't change on mode=20
> switch.

So it alls end up to -> mode switch has to bust memory layout, and any
assumptions that DirectFB tries to do are incorrect.

The only sane thing that could be done is along the lines you suggested,
that is move most of "fix" into "var" so that the card can tell in
advance what the layout looks like.

But again, this is all going nowhere in the long run. One of the plans
we have is to have the mode setting be independant of the client. While
a client might "lock" it, we want a model where the user triggers a mode
setting via some mode setting & desktop geometry management library that
interfaces to fbdev, and clients be "notified". For that to work, it
also requires proper arbitration though, so we may end up again limit
that functionality to clients using the DRM for artbitration and lock
everything when some guy like DirectFB enters the picture.

> > and because
> > it seems that directFB has only been tested on little endian machines
> > (damn them !) and thus doesn't understand the problem with swapper on
> > framebuffer access).
>=20
> Actually people do use it on big-endian systems but since neither the=20
> mach64, ati128 or radeon drivers play with the swapper settings I can o=
nly=20
> assume that they haven't been tested very extensively.

You are wrong here, all of those 3 drivers do play with the swapper
setting, they all 3 set the swapper based on the bit depth of the
screen, so writing an image to offscreen memory with a different bit
depth will be broken. See usage of SURFACE_CNTL in radeonfb for example.

Ben.
 =20
