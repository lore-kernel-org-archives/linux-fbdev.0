From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 18:53:01 -0500
Message-ID: <1111017181.5530.89.camel@localhost>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston> <20050316014714.GA5387@sci.fi>
	<1110937887.649.101.camel@gaston>  <20050316195108.GA6651@sci.fi>
	<1111006826.5533.68.camel@localhost> <1111015726.15510.60.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1111015726.15510.60.camel@gaston>
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
Content-Type: text/plain; charset="euc-kr"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org

On Thu, 2005-03-17 at 10:28 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 16:00 -0500, Michel D=C3=A4nzer wrote:
> > On Wed, 2005-03-16 at 21:51 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > >=20
> > > One thing just popped to my head though. If in the future we are goin=
g to=20
> > > allow graphics cards to render to system memory, using the swapper wi=
ll no=20
> > > longer work. I don't see any other solution that having the CPU perfo=
rm=20
> > > the byte swapping.
> >=20
> > Sane hardware should have a way to deal with this as well. Either way,
> > this is hardware specific, so it will probably have to be handled by th=
e
> > hardware driver(s) somehow.
>=20
> Of course, and radeonfb is what if not a hardware driver ?

Who said it was anything else? Is radeonfb gonna handle the offscreen
surfaces though? My point was that the hardware driver(s) should be
involved in the decision on what format/byte order/... should be used
for a surface, instead of just hardcoding fixed formats and having the
CPU do possibly unnecessary byte swapping.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
