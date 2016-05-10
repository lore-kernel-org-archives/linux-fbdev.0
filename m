From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 10 May 2016 09:05:47 +0000
Subject: Re: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
Message-Id: <20160510090547.GQ30822@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5731A02A.2070309@ti.com>
In-Reply-To: <5731A02A.2070309@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Tomi,

On Tue, May 10, 2016 at 11:47:38AM +0300, Tomi Valkeinen wrote:
> On 04/05/16 12:43, Uwe Kleine-K=F6nig wrote:
> > this is v2 of the series which addresses the review comments I got vor
> > (implicit) v1.
> >=20
> > For patch 2 the question is still open if this is the right fix, but
> > without this the display doesn't stay on. Patches 1 and 3 should be
> > applicable independant of patch 2.
>=20
> I picked patches 1 and 3, they look fine.

Thanks.

> I still think patch 2 is just broken, it doesn't make sense to me.

What do you think should happen during startup? Something should call
the set_power callback to enable the device? Or should that only happen
when something writes to /dev/fb0?

> If the regulator is enabled in probe, then it's always on, and
> imxfb_lcd_set_power() should be removed as it never has any effect. But
> that doesn't sound correct, as presumably the imxfb_lcd_set_power() has
> worked at some point.

I think it worked back when unused regulators were not disabled during
boot.

> And shouldn't the regulator be disabled at least when suspending?

Yeah, but maybe the core should call set_power(off) then? (Don't know,
maybe that cannot work.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
