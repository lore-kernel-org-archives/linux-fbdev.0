From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Tue, 15 Mar 2005 08:52:50 +1100
Message-ID: <1110837171.5863.16.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110817205.4004.527.camel@localhost>
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

On Mon, 2005-03-14 at 11:20 -0500, Michel D=E4nzer wrote:
> On Mon, 2005-03-14 at 18:12 +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2005-03-13 at 23:28 -0500, Michel D=E4nzer wrote:
> > > On Sun, 2005-03-13 at 17:43 +1100, Benjamin Herrenschmidt wrote:
> > > >=20
> > > > And finally, I want to blank the screen (using the accel engine) =
before
> > > > setting the new mode, so that we come out "clean" of the mode set=
ting
> > > > (without ugly artifact), and I will probably clean both fb's (sim=
pler).
> > >=20
> > > That would break X with UseFBDev.
> >=20
> > How so ?
>=20
> X assumes that the framebuffer (as in video RAM) contents are preserved
> on mode switches.

Which I consider bogus :) Oh well... does it do a lot of other crappy
assumptions like that ? What if I just can't allocate it and decide to
put it elsewhere in vram ? (unlikely with my current scheme but
possible). X needs to be fixed.

Ben.
