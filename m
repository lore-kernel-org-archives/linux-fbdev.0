From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:28:46 +1100
Message-ID: <1111015726.15510.60.camel@gaston>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston> <20050316014714.GA5387@sci.fi>
	<1110937887.649.101.camel@gaston>  <20050316195108.GA6651@sci.fi>
	<1111006826.5533.68.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1111006826.5533.68.camel@localhost>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, adaplas@pol.net, dri-devel@lists.sourceforge.net

On Wed, 2005-03-16 at 16:00 -0500, Michel D=E4nzer wrote:
> On Wed, 2005-03-16 at 21:51 +0200, Ville Syrj=E4l=E4 wrote:
> >=20
> > One thing just popped to my head though. If in the future we are goin=
g to=20
> > allow graphics cards to render to system memory, using the swapper wi=
ll no=20
> > longer work. I don't see any other solution that having the CPU perfo=
rm=20
> > the byte swapping.
>=20
> Sane hardware should have a way to deal with this as well. Either way,
> this is hardware specific, so it will probably have to be handled by th=
e
> hardware driver(s) somehow.

Of course, and radeonfb is what if not a hardware driver ?

Ben.
