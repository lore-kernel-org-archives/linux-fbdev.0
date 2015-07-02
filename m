From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 02 Jul 2015 07:49:55 +0000
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity concepts
Message-Id: <20150702094955.4b1c9254@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150702064445.GC11824@pengutronix.de>
In-Reply-To: <20150702064445.GC11824@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 2 Jul 2015 08:44:45 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > When requested by a user, the PWM is assigned a default period and pola=
rity
> > extracted from the DT, the platform data or statically set by the drive=
r.
> > Those default values are currently stored in the period and polarity
> > fields of the pwm_device struct, but they will be stored somewhere else
> > once we have introduced the architecture allowing for hardware state
> > retrieval.
> >=20
> > The pwm_set_default_polarity and pwm_set_default_period should only be
> > used by PWM drivers or the PWM core infrastructure to specify the
> > default period and polarity values.
> Would it make sense to put the prototypes of
> pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
> then?
>=20

Yes, definitely. I was thinking about moving those functions/prototypes
into include/linux/pwm-provider.h, but I'm fine with
drivers/pwm/pwm-private.h too.

Thierry, any opinion ?


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
