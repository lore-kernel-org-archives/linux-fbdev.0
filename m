From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 08:01:38 +0200
Message-ID: <20050315060138.GA13064@sci.fi>
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Mon, Mar 14, 2005 at 11:59:37PM -0500, Michel D=E4nzer wrote:
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

DirectFB assumes all memory outside var.yres_virtual * fix.line_length is=
=20
preserved. A totally valid assumption in my opinion. It allocates all=20
offscreen memory starting from the top of the memory so overlaps with=20
fbdev are as rare as possible. Currently it doesn't handle multi head=20
except for Matrox G400/G450/G550 TV-out but that is handled without fbdev=
=20
so no API limitations get in the way.

I think that making the assumption that all memory is preserved when the=20
memory layout (virtual resolution and depth) doesn't change is perfectly=20
valid too. That would allow X to do it's Ctrl-Alt-+ and - things without=20
repainting the whole screen.

If radeonfb will allocate the buffer for the second head from the top of=20
the memory users would basically have to guess it's location. matroxfb=20
simply cuts the memory in two pieces and allocates the buffers from the=20
start of each piece. I don't really like that approach. Adding a simple=20
byte_offset field to fb_var_screeninfo would solve the problem quite=20
nicely but I don't know if such API changes are acceptable at this stage.

> > We are thinking with the "new model" in mind, and so far, a mode sett=
ing=20
> > is under control of the framebuffer. Content of video memory (framebu=
ffer,
> > textures, overlay, whatever) simply cannot be considered as preserved
> > accross mode switches.
> >=20
> > We can't also block all evolutions just because we have to support a
> > broken model.=20
>=20
> I'm not suggesting that, but I do think that tying together mode
> switching and memory allocation would be a big mistake.

Indeed.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
