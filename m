From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 08 Mar 2016 08:30:52 +0000
Subject: Re: [PATCH 1/3] video: fbdev: imxfb: fix semantic of .get_power and .set_power
Message-Id: <20160308083051.GA8136@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457423730.4174.4.camel@pengutronix.de>
In-Reply-To: <1457423730.4174.4.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Mar 08, 2016 at 08:55:30AM +0100, Philipp Zabel wrote:
> Hi Uwe,
>=20
> Am Montag, den 07.03.2016, 20:53 +0100 schrieb Uwe Kleine-K=F6nig:
> > .set_power gets passed an FB_BLANK_XXX value, not a bool. So 0 signals
> > on; and >1 means off. The same applies for return values of .get_power.
>=20
> I'd try to somehow work this information into the code to avoid future
> confusion.

I integrated your changes into my code, you're obviously right here.

Jean-Christophe, Tomi: Do you agree in principle with these changes? If
so I can resend. If you won't take the changes anyhow, I wouldn't.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
