From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 24 Jun 2019 15:46:28 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
Message-Id: <20190624154628.rq7ykltms7ovhawx@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <1561386717.20436.0@crapouillou.net>
In-Reply-To: <1561386717.20436.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Cercueil <paul@crapouillou.net>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, od@zcrc.me, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Jun 24, 2019 at 04:31:57PM +0200, Paul Cercueil wrote:
>=20
>=20
> Le lun. 24 juin 2019 =E0 13:28, Daniel Thompson <daniel.thompson@linaro.o=
rg> a
> =E9crit :
> > On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> > >  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > >  > On 22/05/2019 17:34, Paul Cercueil wrote:
> > >  > > When the driver probes, the PWM pin is automatically configured
> > > to its
> > >  > > default state, which should be the "pwm" function.
> > >  >
> > >  > At which point in the probe... and by who?
> > >=20
> > >  The driver core will select the "default" state of a device right
> > > before
> > >  calling the driver's probe, see:
> > >=20
> > >  	drivers/base/pinctrl.c: pinctrl_bind_pins()
> > >=20
> > >  which is called from:
> > >=20
> > >  	drivers/base/dd.c: really_probe()
> > >=20
> >=20
> > Thanks. I assumed it would be something like that... although given
> > pwm-backlight is essentially a wrapper driver round a PWM I wondered why
> > the pinctrl was on the backlight node (rather than the PWM node).
> >=20
> > Looking at the DTs in the upstream kernel it looks like ~20% of the
> > backlight drivers have pinctrl on the backlight node. Others presumable
> > have none or have it on the PWM node (and it looks like support for
> > sleeping the pins is *very* rare amoung the PWM drivers).
>=20
> If your PWM driver has more than one channel and has the pinctrl node, you
> cannot fine-tune the state of individual pins. They all share the same
> state.

Good point. Thanks.


> > >  > > However, at this
> > >  > > point we don't know the actual level of the pin, which may be
> > > active or
> > >  > > inactive. As a result, if the driver probes without enabling the
> > >  > > backlight, the PWM pin might be active, and the backlight would
> > > be
> > >  > > lit way before being officially enabled.
> > >  > >
> > >  > > To work around this, if the probe function doesn't enable the
> > > backlight,
> > >  > > the pin is set to its sleep state instead of the default one,
> > > until the
> > >  > > backlight is enabled. Whenk the backlight is disabled, the pin
> > > is reset
> > >  > > to its sleep state.
> > >  > Doesn't this workaround result in a backlight flash between
> > > whatever enables
> > >  > it and the new code turning it off again?
> > >=20
> > >  Yeah, I think it would. I guess if you're very careful on how you
> > > set up
> > >  the device tree you might be able to work around it. Besides the
> > > default
> > >  and idle standard pinctrl states, there's also the "init" state. The
> > >  core will select that instead of the default state if available.
> > > However
> > >  there's also pinctrl_init_done() which will try again to switch to
> > > the
> > >  default state after probe has finished and the driver didn't switch
> > > away
> > >  from the init state.
> > >=20
> > >  So you could presumably set up the device tree such that you have
> > > three
> > >  states defined: "default" would be the one where the PWM pin is
> > > active,
> > >  "idle" would be used when backlight is off (PWM pin inactive) and
> > > then
> > >  another "init" state that would be the same as "idle" to be used
> > > during
> > >  probe. During probe the driver could then switch to the "idle"
> > > state so
> > >  that the pin shouldn't glitch.
> > >=20
> > >  I'm not sure this would actually work because I think the way that
> > >  pinctrl handles states both "init" and "idle" would be the same
> > > pointer
> > >  values and therefore pinctrl_init_done() would think the driver
> > > didn't
> > >  change away from the "init" state because it is the same pointer
> > > value
> > >  as the "idle" state that the driver selected. One way to work around
> > >  that would be to duplicate the "idle" state definition and
> > > associate one
> > >  instance of it with the "idle" state and the other with the "init"
> > >  state. At that point both states should be different (different
> > > pointer
> > >  values) and we'd get the init state selected automatically before
> > > probe,
> > >  select "idle" during probe and then the core will leave it alone.
> > > That's
> > >  of course ugly because we duplicate the pinctrl state in DT, but
> > > perhaps
> > >  it's the least ugly solution.
> > >  Adding Linus for visibility. Perhaps he can share some insight.
> >=20
> > To be honest I'm happy to summarize in my head as "if it flashes then
> > it's not
> > a pwm_bl.c's problem" ;-).
>=20
> It does not flash. But the backlight lits way too early, so we have a 1-2
> seconds
> of "white screen" before the panel driver starts.

That's the current behaviour.

What I original asked about is whether a panel that was dark before the
driver probes could end up flashing after the patch because it is
activated pre-probe and only goes to sleep afterwards.

Anyhow I got an answer; if it flashes after the patch then the problem
does not originate in pwm_bl.c and is likely a problem with the handling
of the pinctrl idel state (i.e. probably DT misconfiguration)

So I think that just leaves my comment about the spurious sleep in the
probe function.


Daniel.
