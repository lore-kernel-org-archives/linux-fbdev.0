From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 16:00:05 +0200
Message-ID: <20050315140005.GB16051@sci.fi>
References: <1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi> <1110869983.29138.88.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110869983.29138.88.camel@gaston>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Tue, Mar 15, 2005 at 05:59:42PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2005-03-15 at 08:01 +0200, Ville Syrj=E4l=E4 wrote:
>=20
> > If radeonfb will allocate the buffer for the second head from the top=
 of=20
> > the memory users would basically have to guess it's location. matroxf=
b=20
> > simply cuts the memory in two pieces and allocates the buffers from t=
he=20
> > start of each piece. I don't really like that approach. Adding a simp=
le=20
> > byte_offset field to fb_var_screeninfo would solve the problem quite=20
> > nicely but I don't know if such API changes are acceptable at this st=
age.
>=20
> And we don't know if all HW would support it anyway.

Such hardware would be free to ignore any user supplied byte_offset and=20
place the buffer anywhere it wants. Even a read-only byte_offset field=20
would help. But using the second head would require all apps to be update=
d=20
to be aware of byte_offset :( Maybe some kind of API version thing could=20
help here ie. User sets flag X somewhere indicating byte_offset should be=
=20
used instead of changing smem_start.

> > > > We are thinking with the "new model" in mind, and so far, a mode =
setting=20
> > > > is under control of the framebuffer. Content of video memory (fra=
mebuffer,
> > > > textures, overlay, whatever) simply cannot be considered as prese=
rved
> > > > accross mode switches.
> > > >=20
> > > > We can't also block all evolutions just because we have to suppor=
t a
> > > > broken model.=20
> > >=20
> > > I'm not suggesting that, but I do think that tying together mode
> > > switching and memory allocation would be a big mistake.
> >=20
> > Indeed.
>=20
> The main issue hwoever, is access arbitration. I'd appreciate your
> DirectFB point of view on these things.

DirectFB has it's own asbitration mechanism. It doesn't support using=20
multiple framebuffer devices at the same time. For that to work DirectFB=20
would just have to know if some of the framebuffer devices are actually=20
different outputs of the same card so that it could associate both with=20
the same lock and accelerator state.

With the current system I don't see much chance of using accelerated fbco=
n=20
on one head and accelerated DirectFB (or something else) on the other.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
