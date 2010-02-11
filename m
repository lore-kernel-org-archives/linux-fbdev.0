From: Baruch Siach <baruch@tkos.co.il>
Date: Thu, 11 Feb 2010 06:04:57 +0000
Subject: Re: [PATCH v2] imxfb: add support for i.MX25
Message-Id: <20100211060457.GA10514@jasper.tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100210082654.GC10185@pengutronix.de>
	<4a9d6157ec463ea6142ab6cc20dac0a6eb761fc7.1265806123.git.baruch@tkos.co.il>
	<20100210162942.GA15883@pengutronix.de>
In-Reply-To: <20100210162942.GA15883@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 05:29:42PM +0100, Uwe Kleine-K=F6nig wrote:
> did you verify that dropping "FB" works correctly?

No, I didn't, and it doesn't. The "endmenu" at the end of=20
drivers/video/Kconfig ends the "menu" block, not the "menuconfig" block, wh=
ich=20
does not require an explicit block end statement. So, the FB dependency is =

required. I'll post an updated patch shortly.

> Other than that
>=20
> 	Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for your review, comments, and ack.

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
