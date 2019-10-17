From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 17 Oct 2019 19:44:04 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017194404.vvjfgt2wdrfoq7l2@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo>
 <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
In-Reply-To: <20191017125932.GB3768303@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pengutronix.de, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Adam Ford <aford173@gmail.com>

Hello Thierry,

On Thu, Oct 17, 2019 at 02:59:32PM +0200, Thierry Reding wrote:
> On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index ae11d8577f18..4113d5cd4c62 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > [...]
> >=20
> > I wonder if it would be more sensible to do this in the pwm core
> > instead. Currently there are two drivers known with this problem. I
> > wouldn't be surprised if there were more.
>=20
> I've inspected all the drivers and didn't spot any beyond cros-ec and
> i.MX that have this problem.

I took a look, too, and I'd say pwm-atmel.c, pwm-imx-tpm.c, pwm-lpss.c,
pwm-meson.c, pwm-sifive.c, pwm-sprd.c and pwm-stm32-lp.c are affected.

> So the core would have to rely on state->duty_cycle that is passed in,
> but then the offending commit becomes useless because the whole point
> was to return the state as written to hardware (rather than the
> software state which was being returned before that patch).

I like allowing lowlevel drivers to implement the .enabled =3D false case
lazily as there is little value in calculating the needed register
values for a request like

	.duty_cycle =3D X, .period =3D Y, .enabled =3D false

even if the next request might be

	.duty_cycle =3D X, .period =3D Y, .enabled =3D true

because quite likely the same calculation is done for the second request
again and there is no benefit to save X and Y in the hardware (or the
driver if the hardware is incapable) apart from returning it to a
consumer who maybe even doesn't care because these values don't tell
anything at all about the implemented wave form and so it seems natural
to me that the lowlevel driver shouldn't care.

> > If we want to move clients to not rely on .period and .duty_cycle for a
> > disabled PWM (do we?) a single change in the core is also beneficial
> > compared to fixing several lowlevel drivers.
>=20
> These are really two orthogonal problems. We don't currently consider
> enabled =3D 0 to be equivalent to duty_cycle =3D 0 at an API level. I'm n=
ot
> prepared to do that at this point in the release cycle either.

Yeah, I fully agree that we should not do that now. Given the number of
affected drivers I opt for reverting and retrying again more carefully
later.
=20
> What this here has shown is that we have at least two drivers that don't
> behave the way they are supposed to according to the API and they break
> consumers. If they break for pwm-backlight, it's possible that they will
> break for other consumers as well. So the right thing to do is fix the
> two drivers that are broken.

In my eyes shifting the definition of "expected behaviour" and adapting
the core code accordingly to make this invisible to consumers is also a
viable option. Also shifting the definition and adapt all consumers not
to rely on the old behaviour is fine. But as above, this is not a good
idea at the current point in time.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
