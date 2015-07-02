From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 02 Jul 2015 06:44:45 +0000
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity concepts
Message-Id: <20150702064445.GC11824@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> When requested by a user, the PWM is assigned a default period and polari=
ty
> extracted from the DT, the platform data or statically set by the driver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere else
> once we have introduced the architecture allowing for hardware state
> retrieval.
>=20
> The pwm_set_default_polarity and pwm_set_default_period should only be
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
Would it make sense to put the prototypes of
pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
then?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
