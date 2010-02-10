From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 08:33:31 +0000
Subject: Re: [PATCH 2/3] mx25: add platform support for imxfb
Message-Id: <20100210083331.GB29489@jasper.tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
	<20100210075315.GB10185@pengutronix.de>
In-Reply-To: <20100210075315.GB10185@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 08:53:15AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 10, 2010 at 09:25:19AM +0200, Baruch Siach wrote:
> > @@ -233,6 +242,9 @@ int __init mx25_clocks_init(void)
> >  	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
> >  	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
> > =20
> > +	/* Clock source for lcdc is upll */
> > +	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7), CRM_BASE + 0x64);
> > +
> 0x64?  Please define a register name for that constant.

I just followed the precedence set in the get_rate_per() routine above. =20
Defining a register name is obviously better.

> Ditto for 7.

See arch/arm/mach-mx3/clock.c:mx31_clocks_init() and=20
arch/arm/mach-mx3/clock-imx35.c:mx35_clocks_init(). This is probably a matt=
er=20
for a separate cleanup patch.

> Note I didn't look in the hardware manual, but I wonder if that should
> better go in the enable routine for lcdc?

OK. I'll do it there.

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
