From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 17:59:42 +1100
Message-ID: <1110869983.29138.88.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315060138.GA13064@sci.fi>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Tue, 2005-03-15 at 08:01 +0200, Ville Syrj=E4l=E4 wrote:

> If radeonfb will allocate the buffer for the second head from the top o=
f=20
> the memory users would basically have to guess it's location. matroxfb=20
> simply cuts the memory in two pieces and allocates the buffers from the=
=20
> start of each piece. I don't really like that approach. Adding a simple=
=20
> byte_offset field to fb_var_screeninfo would solve the problem quite=20
> nicely but I don't know if such API changes are acceptable at this stag=
e.

And we don't know if all HW would support it anyway.

> > > We are thinking with the "new model" in mind, and so far, a mode se=
tting=20
> > > is under control of the framebuffer. Content of video memory (frame=
buffer,
> > > textures, overlay, whatever) simply cannot be considered as preserv=
ed
> > > accross mode switches.
> > >=20
> > > We can't also block all evolutions just because we have to support =
a
> > > broken model.=20
> >=20
> > I'm not suggesting that, but I do think that tying together mode
> > switching and memory allocation would be a big mistake.
>=20
> Indeed.

The main issue hwoever, is access arbitration. I'd appreciate your
DirectFB point of view on these things.

Ben.
