From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 00:14:45 -0500
Message-ID: <9e47339105031421145a4476d2@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
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
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Mon, 14 Mar 2005 23:59:37 -0500, Michel D=E4nzer <michel@daenzer.net> wr=
ote:
> On Tue, 2005-03-15 at 09:37 +1100, Benjamin Herrenschmidt wrote:
> > > Be that as it may, it remains a fact that such a change would break
> > > existing installations...
> > >
> > > I think that mode setting and memory allocation should be separated. =
X
> > > will always reserve enough video RAM for the largest resolution it us=
es
> > > for the screen contents.
> >
> > But X has no control on where fbdev will allocate memory.
>=20
> My understanding is that so far, the fbdev API has pretty much implied
> that any mode scans out the beginning of the memory accessed via the
> framebuffer device, unless the panning ioctl is used. IIRC at least
> DirectFB makes basically the same assumptions as X there.

We are working on adding secondary head support on radeonfb.=20
Where does the second buffer go when fbdev is running standalone?

>=20
> > We are thinking with the "new model" in mind, and so far, a mode settin=
g
> > is under control of the framebuffer. Content of video memory (framebuff=
er,
> > textures, overlay, whatever) simply cannot be considered as preserved
> > accross mode switches.
> >
> > We can't also block all evolutions just because we have to support a
> > broken model.
>=20
> I'm not suggesting that, but I do think that tying together mode
> switching and memory allocation would be a big mistake.

If fbdev is running standalone and two heads are active, there has to
be some very primitive buffer management going on. This may be as
simple as fb0 starts at 0, and fb1 is at the end of CONFIG_APER_SIZE.

When DRM loads it can install hooks to a more sophisticated memory manager.

>=20
> The EGL API for this is currently being discussed on the dri-egl list
> (http://lists.freedesktop.org/mailman/listinfo/dri-egl), you may want to
> join in there.

help me out with the relevant attribute/value pairs for modes

>=20
> > We'll need to find a way to deal with that. An idea would be for me to
> > do the clearing only when I come from a different bit depth or from tex=
t
> > mode. That is, what i want to avoid, is those artifacts caused by
> > incorrect bit depth content. A strict mode change isn't an issue in thi=
s
> > case. That would solve my immediate problem.
>=20
> Sounds good.
>=20
> > _BUT_ in the long run, X will have to be smarter. Current UseFBDev or X
> > "fbdev" can't support dual head properly on top of fbdev anyway,
>=20
> Agreed for UseFBDev, but what's the problem with fbdev?
>=20
>=20
> > But until all clients are DRI clients, we have a problem.
>=20
> Keep in mind that basically the only driver-independent API exposed by
> the DRI is OpenGL, so I'm afraid it's unlikely that all fbdev
> applications will take that route.

There is a 300K OpenGL-ES to framebuffer implementation on sourceforge
that someone might get working in this model.

There is also a big difference between sharing the system with XGL and
an app writen to use fbdev versus supporting an embedded system where
only the fbdev app is running.

>=20
> --
> Earthling Michel D=E4nzer      |     Debian (powerpc), X and DRI develope=
r
> Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg
>=20


--=20
Jon Smirl
jonsmirl@gmail.com
