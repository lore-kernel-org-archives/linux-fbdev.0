From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 08:15:13 +0000
Subject: Re: [PATCH 1/3] imxfb: add support for i.MX25
Message-Id: <20100210081512.GA29489@jasper.tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<0bea69783cf8f6b04c64fed75f10c3dd3c567fb4.1265786237.git.baruch@tkos.co.il>
	<20100210075007.GA10185@pengutronix.de>
In-Reply-To: <20100210075007.GA10185@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 08:50:07AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 10, 2010 at 09:25:18AM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/video/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 5a5c303..7ff9acc 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -402,7 +402,7 @@ config FB_SA1100
> > =20
> >  config FB_IMX
> >  	tristate "Motorola i.MX LCD support"
> > -	depends on FB && (ARCH_MX1 || ARCH_MX2)
> > +	depends on FB && (ARCH_MX1 || ARCH_MX2 || ARCH_MX25)
> Can we make this
>=20
> 	depends on FB && HAVE_FB_IMX
>=20
> and let the archs select HAVE_FB_IMX?

I just wanted to do the minimal working change. Do you want me to send a pa=
tch=20
updating each ARCH's Kconfig?

> And is "FB" really necessary?  The snipplet above is in an
>=20
> 	menuconfig FB
> 		...
> 	endmenu
>=20
> block.  (And there are many other items depending explicitly on FB.)

I don't know. As above, I'd rather do the minimal change.

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
