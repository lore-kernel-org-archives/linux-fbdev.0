From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 10 Feb 2010 08:26:54 +0000
Subject: Re: [PATCH 1/3] imxfb: add support for i.MX25
Message-Id: <20100210082654.GC10185@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<0bea69783cf8f6b04c64fed75f10c3dd3c567fb4.1265786237.git.baruch@tkos.co.il>
	<20100210075007.GA10185@pengutronix.de>
	<20100210081512.GA29489@jasper.tkos.co.il>
In-Reply-To: <20100210081512.GA29489@jasper.tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Baruch,

On Wed, Feb 10, 2010 at 10:15:13AM +0200, Baruch Siach wrote:
> On Wed, Feb 10, 2010 at 08:50:07AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Feb 10, 2010 at 09:25:18AM +0200, Baruch Siach wrote:
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > ---
> > >  drivers/video/Kconfig |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index 5a5c303..7ff9acc 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -402,7 +402,7 @@ config FB_SA1100
> > > =20
> > >  config FB_IMX
> > >  	tristate "Motorola i.MX LCD support"
> > > -	depends on FB && (ARCH_MX1 || ARCH_MX2)
> > > +	depends on FB && (ARCH_MX1 || ARCH_MX2 || ARCH_MX25)
> > Can we make this
> >=20
> > 	depends on FB && HAVE_FB_IMX
> >=20
> > and let the archs select HAVE_FB_IMX?
>=20
> I just wanted to do the minimal working change. Do you want me to send a =
patch=20
> updating each ARCH's Kconfig?
Of course this should go in a seperate patch, so this is your chance to
increase your patch count even further :-)

For now I'd do the following to minimize inter-tree dependencies:

	* remove all explicit dependencies on FB in the above block
	* define
		config HAVE_FB_IMX
		bool
	  just before config FB_IMX and add it to the latter's
	  dependencies, such that it reads:

		depends on HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2

and when this change hit's Linus' tree let ARCH_MX1 and ARCH_MX2 select
HAVE_FB_IMX, too and remove it from the list.

I don't care when you add ARCH_MX25 as everything is more or less
orthogonal here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
