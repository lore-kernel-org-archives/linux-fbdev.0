From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Mon, 14 Mar 2005 23:59:37 -0500
Message-ID: <1110862777.4044.592.camel@localhost>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110839873.5673.41.camel@gaston>
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
Cc: dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Tue, 2005-03-15 at 09:37 +1100, Benjamin Herrenschmidt wrote:
> > Be that as it may, it remains a fact that such a change would break
> > existing installations...
> >=20
> > I think that mode setting and memory allocation should be separated. X
> > will always reserve enough video RAM for the largest resolution it uses
> > for the screen contents.
>=20
> But X has no control on where fbdev will allocate memory.=20

My understanding is that so far, the fbdev API has pretty much implied
that any mode scans out the beginning of the memory accessed via the
framebuffer device, unless the panning ioctl is used. IIRC at least
DirectFB makes basically the same assumptions as X there.

> We are thinking with the "new model" in mind, and so far, a mode setting=20
> is under control of the framebuffer. Content of video memory (framebuffer=
,
> textures, overlay, whatever) simply cannot be considered as preserved
> accross mode switches.
>=20
> We can't also block all evolutions just because we have to support a
> broken model.=20

I'm not suggesting that, but I do think that tying together mode
switching and memory allocation would be a big mistake.

The EGL API for this is currently being discussed on the dri-egl list
(http://lists.freedesktop.org/mailman/listinfo/dri-egl), you may want to
join in there.

> We'll need to find a way to deal with that. An idea would be for me to=20
> do the clearing only when I come from a different bit depth or from text=20
> mode. That is, what i want to avoid, is those artifacts caused by=20
> incorrect bit depth content. A strict mode change isn't an issue in this=20
> case. That would solve my immediate problem.

Sounds good.

> _BUT_ in the long run, X will have to be smarter. Current UseFBDev or X
> "fbdev" can't support dual head properly on top of fbdev anyway,=20

Agreed for UseFBDev, but what's the problem with fbdev?


> But until all clients are DRI clients, we have a problem.

Keep in mind that basically the only driver-independent API exposed by
the DRI is OpenGL, so I'm afraid it's unlikely that all fbdev
applications will take that route.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
