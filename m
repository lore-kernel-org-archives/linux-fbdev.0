From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 00:21:49 -0500
Message-ID: <1110950509.5594.31.camel@localhost>
References: <1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi>  <1110929582.25201.34.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110929582.25201.34.camel@gaston>
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
Content-Type: text/plain; charset="utf-8"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Wed, 2005-03-16 at 10:33 +1100, Benjamin Herrenschmidt wrote:
>=20
> Now, I agree that cutting the vram in half, and reserving  both halves
> to the "offscreen" needs to each head may help avoiding mode switch on
> one head busting things used by whoever works on the second head, but
> I'm not sure that fits the DRM needs very well..

It probably doesn't, but it seems to me like that's all that can be done
with the current fbdev API.


On Wed, 2005-03-16 at 12:51 +1100, Benjamin Herrenschmidt wrote:=20
> On Wed, 2005-03-16 at 03:47 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>=20
> > There's also the case with Matrox Millennium I/II cards. They must plac=
e=20
> > the visible frame buffer so that no line crosses the boundary of memory=
=20
> > banks. [...]

That still doesn't require any changes on mode switches as long as the
pitch stays the same, does it?

> So it alls end up to -> mode switch has to bust memory layout, [...]

Why? All that a mode switch changes is how the current screen surface is
scanned out. It shouldn't have any implicit effect on memory allocation
or even contents.


> [...] For that to work, it also requires proper arbitration though, so we=
=20
> may end up again limit that functionality to clients using the DRM for=20
> artbitration and lock everything when some guy like DirectFB enters the=20
> picture.

I was thinking about something like that as well, may be the only way to
preserve the current fbdev API and offer something more sophisticated.


> > > and because
> > > it seems that directFB has only been tested on little endian machines
> > > (damn them !) and thus doesn't understand the problem with swapper on
> > > framebuffer access).
> >=20
> > Actually people do use it on big-endian systems but since neither the=20
> > mach64, ati128 or radeon drivers play with the swapper settings I can o=
nly=20
> > assume that they haven't been tested very extensively.
>=20
> You are wrong here, all of those 3 drivers do play with the swapper
> setting, [...]

I think he was referring to the DirectFB drivers.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
