From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 16:09:48 +0200
Message-ID: <20050316140948.GA20074@sci.fi>
References: <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <1110929582.25201.34.camel@gaston>
	<1110950509.5594.31.camel@localhost>
	<1110954676.5271.2.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110954676.5271.2.camel@gaston>
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
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Wed, Mar 16, 2005 at 05:31:16PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 00:21 -0500, Michel D=E4nzer wrote:
>=20
> > > >=20
> > > > Actually people do use it on big-endian systems but since neither=
 the=20
> > > > mach64, ati128 or radeon drivers play with the swapper settings I=
 can only=20
> > > > assume that they haven't been tested very extensively.
> > >=20
> > > You are wrong here, all of those 3 drivers do play with the swapper
> > > setting, [...]
> >=20
> > I think he was referring to the DirectFB drivers.

Exactly. I prorably should have mentioned that explicitly.

> Well, do they "revert" it after atyfb/aty128fb/radeonfb set it then ?
> it's definitely set on mode switch.

The point is that there can be offscreen surfaces with different depth=20
than the fbdev surface.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
