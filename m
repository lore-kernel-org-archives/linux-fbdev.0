From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 17:45:16 +1100
Message-ID: <1110869116.29137.78.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110862777.4044.592.camel@localhost>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Mon, 2005-03-14 at 23:59 -0500, Michel D=E4nzer wrote:
> On Tue, 2005-03-15 at 09:37 +1100, Benjamin Herrenschmidt wrote:
> > > Be that as it may, it remains a fact that such a change would break
> > > existing installations...
> > >=20
> > > I think that mode setting and memory allocation should be separated=
. X
> > > will always reserve enough video RAM for the largest resolution it =
uses
> > > for the screen contents.
> >=20
> > But X has no control on where fbdev will allocate memory.=20
>=20
> My understanding is that so far, the fbdev API has pretty much implied
> that any mode scans out the beginning of the memory accessed via the
> framebuffer device, unless the panning ioctl is used. IIRC at least
> DirectFB makes basically the same assumptions as X there.

But that will not be true with dual head unless I put the second
framebuffer into some fixed location in memory, thus making life more
difficult for the allocator.

> I'm not suggesting that, but I do think that tying together mode
> switching and memory allocation would be a big mistake.
>=20
> The EGL API for this is currently being discussed on the dri-egl list
> (http://lists.freedesktop.org/mailman/listinfo/dri-egl), you may want t=
o
> join in there.

I'll try, I'm near by bandwidth limit already though.

> > We'll need to find a way to deal with that. An idea would be for me t=
o=20
> > do the clearing only when I come from a different bit depth or from t=
ext=20
> > mode. That is, what i want to avoid, is those artifacts caused by=20
> > incorrect bit depth content. A strict mode change isn't an issue in t=
his=20
> > case. That would solve my immediate problem.
>=20
> Sounds good.
>=20
> > _BUT_ in the long run, X will have to be smarter. Current UseFBDev or=
 X
> > "fbdev" can't support dual head properly on top of fbdev anyway,=20
>=20
> Agreed for UseFBDev, but what's the problem with fbdev?

Read the rest of the email.
>=20
> > But until all clients are DRI clients, we have a problem.
>=20
> Keep in mind that basically the only driver-independent API exposed by
> the DRI is OpenGL, so I'm afraid it's unlikely that all fbdev
> applications will take that route.

I meant DRM. That is some arbitration & locking. There is simply _NO_
way we can have something that works with both independant multiple
heads and direct banging of the framebuffer without arbitration. There
is no magic here. It _can_ be made to work in _some_ cases using the
separate swappers, but that won't help if one of the heads try to do
accel....

Ben.
