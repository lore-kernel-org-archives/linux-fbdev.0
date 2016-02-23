From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 23 Feb 2016 14:38:59 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20160223143859.GA27656@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego> <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
In-Reply-To: <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 11:15:09AM -0800, Doug Anderson wrote:
> Thierry,
>=20
> On Mon, Feb 22, 2016 at 9:59 AM, Thierry Reding <thierry.reding@gmail.com=
> wrote:
[...]
> >> When we add a new feature then it's expected that only updated drivers
> >> will support that feature.
> >>
> >> We need to make sure that we don't regress / negatively change the
> >> behavior for anyone running non-updated drivers.  ...and we should
> >> strive to require as few changes to drivers as possible.  ...but if
> >> the best we can do requires changes to the PWM driver API then we will
> >> certainly have differences depending on the PWM driver.
> >
> > How so? Drivers should behave consistently, irrespective of the API. Of
> > course if you need to change behaviour of the user driver depending on
> > the availability of a certain feature, that's perfectly fine.
> >
> > Furthermore it's out of the question that changes to the API will be
> > required. That's precisely the reason why the atomic PWM proposal came
> > about. It's an attempt to solve the shortcomings of the current API for
> > cases such as Rockchip.
>=20
> I _think_ we're on the same page here.  If there are shortcomings with
> the current API that make it impossible to implement a feature, we've
> got to change and/or add to the existing API.  ...but we don't want to
> break existing users / drivers.
>=20
> Note that historically I remember that Linus Torvalds has stated that
> there is no stable API within the Linux kernel and that forcing the
> in-kernel API to never change was bad for software development.  I
> tracked down my memory and found
> <http://lwn.net/1999/0211/a/lt-binary.html>.  Linus is rabid about not
> breaking userspace, but in general there's no strong requirement to
> never change the driver API inside the kernel.  That being said,
> changing the driver API causes a lot of churn, so presumably changing
> it in a backward compatible way (like adding to the API instead of
> changing it) will make things happier.

I didn't say anything about stable API. All I said is that new API
should be well-thought-out. Those are two very different things.

> >> So all we need is a new API call that lets you read the hardware
> >> values and make sure that the PWM regulator calls that before anyone
> >> calls pwm_config().  That's roughly B) above.
> >
> > Yes. I'm thinking that we should have a pwm_get_state() which retrieves
> > the current state of the PWM. For drivers that support hardware readout
> > this state should match the hardware state. For other drivers it should
> > reflect whatever was specified in DT; essentially what pwm_get_period()
> > and friends return today.
>=20
> Excellent, so pwm_get_period() gets the period as specified in the
> device tree (or other board config) and pwm_get_state() returns the
> hardware state.  SGTM.

That's not quite what I was thinking. If hardware readout is supported
then whatever we report back should be the current hardware state unless
we're explicitly asked for something else. If we start mixing the state
and legacy APIs this way, we'll get into a situation where drivers that
support hardware readout behave differently than drivers that don't.

For example: A PWM device that's controlled by a driver that supports
hardware readout has a current period of 50000 ns and the firmware set
the period to 25000 ns. pwm_get_period() for this PWM device will return
50000 ns. If you reconfigure the PWM to generate a PWM signal with a
period of 30000 ns, pwm_get_period() would still return 50000 ns.

A driver that doesn't support hardware readout, on the contrary, would
return 50000 ns from pwm_get_period() on the first call, but after you
have reconfigured it using pwm_config() it will return the new period.

> > That way if you want to get the current voltage in the regulator-pwm
> > driver you'd simply do a pwm_get_state() and compute the voltage from
> > the period and duty cycle. If the PWM driver that you happen to use
> > doesn't support hardware readout, you'll get an initial output voltage
> > of 0, which is as good as any, really.
>=20
> Sounds fine to me.  PWM regulator is in charge of calling
> pwm_get_state(), which can return 0 (or an error?) if driver (or
> underlying hardware) doesn't support hardware readout.  PWM regulator
> is in charge of using the resulting period / duty cycle to calculate a
> percentage.

I'm not sure if pwm_get_state() should ever return an error. For drivers
that support hardware readout, the resulting state should match what's
programmed to the hardware.

But for drivers without hardware readout support pwm_get_state() still
makes sense because after a pwm_apply_state() the internal logical state
would again match hardware.

The simplest way to get rid of this would be to change the core to apply
an initial configuration on probe. However that's probably going to
break your use-case again (it would set a 0 duty cycle because it isn't
configured in DT).

To allow your use-case to work we'd need to deal with two states: the
current hardware state and the "initial" state as defined by DT.
Unfortunately the PWM specifier in DT is not a full definition, it is
more like a partial initial configuration. The problem with that, and
I think that's what Mark was originally objecting to, is that it isn't
clear when to use the "initial" state and when to use the read hardware
state. After the first pwm_apply_state() you wouldn't ever have to use
the "initial" state again, because it's the same as the current state
(modulo the duty cycle).

Also for drivers such as clk-pwm the usefulness of the "initial" state
is reduced even more, because it doesn't even need the period specified
in DT. It uses only the flags (if at all).

Perhaps to avoid this confusion a new type of object, e.g. pwm_args,
could be introduced to hold configuration arguments given in the PWM
specifier (in DT) or the PWM lookup table (in board files).

It would then be the responsibility of the users to deal with that
information in a sensible way. In (almost?) all cases I would expect
that to be to program the PWM device in the user's ->probe(). In the
case of regulator-pwm I'd expect that ->probe() would do something
along these lines (error handling excluded):

	struct pwm_state state;
	struct pwm_args args;
	unsigned int ratio;

	pwm =3D pwm_get(...);

	pwm_get_state(pwm, &state);
	pwm_get_args(pwm, &args);

	ratio =3D (state.duty_cycle * 100) / state.period;

	state.duty_cycle =3D (ratio * args.period) / 100;
	state.period =3D args.period;
	state.flags =3D args.flags;

	pwm_apply_state(pwm, &state);

The ->set_voltage() implementation would then never need to care about
the PWM args, but rather do something like this:

	struct pwm_state state;
	unsigned int ratio;

	pwm_get_state(pwm, &state);

	state.duty_cycle =3D (ratio * state.period) / 100;

	pwm_apply_state(pwm, &state);

Does that sound about right?

> I _think_ the end result of all this is just:
>=20
> 1. Introduce pwm_get_state() that gets hardware state.  Up for debate
> if this returns 0 or ERROR if a driver doesn't implement this.

Like I said above, I don't think pwm_get_state() should ever fail. It
should simply return the current state of the PWM, which might coincide
with the hardware state (for drivers that support hardware readout) or
will be the logical state (for drivers that don't).

Note that in the above example the logical state of the PWM, in cases
where the driver doesn't support hardware readout, the duty cycle will
be assumed to be 0, so the regulator-pwm driver would at ->probe() time
disable the regulator, at which point hardware state and logical state
will coincide again.

> 2. PWM regulator calls pwm_get_state at probe time to get hardware
> state, calculates a percentage (and voltage) with this.

I don't think that's enough. If we do this, we'll keep carrying around
the mismatch between hardware state and logical state indefinitely.

> 3. PWM regulator does nothing else until it is asked to set the
> voltage, but uses the voltage calculated from #2 to satisfy any "get
> voltage" calls.

This should work out of the box in the above. The initial state would
yield a voltage of 0 if hardware readout is not supported, whereas for
drivers that support hardware readout, the proper value can be derived
=66rom duty cycle, period and the lookup table.

> 4. When asked to set the voltage, PWM regulator uses pwm_get_period()
> and calculates a duty cycle based on that, just like it does today.
> This uses pwm_config() which includes a duty cycle and period and is
> thus "atomic".

pwm_config() isn't atomic. pwm_apply_state() would be. The difference is
that pwm_config() can't at the same time enable/disable the PWM or set
the polarity.

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWzG8AAAoJEN0jrNd/PrOhnFwP/0wllQCIFyA536qI6l87Dog9
o+cnOkMYyIsDZmjpKqPmaRCvOcD1MpaVY6FfsTezR0eXIK7iT9vVm/SNPUPUNZS+
9z6P0DCIR9imuA9rBHT7OCDGl5GimOEm9jO0Zd744cxmUglC4jZBJ05wivK6hVac
x8peqH+YWmZINGqlyfPTqvINGAAFlh9AY9XJU6n/6Xbgsmkp2cMY6/ih465pfdlq
26YbkFvwaBW/VnDEbjWb9x6Cwqrp/FAP+doVia20lQUUXj6Wauk48r1nYqAGzLCE
3C6/n8AwxC8BoFwUAoPg5hsnZF61kAuZZqfFno7G3PGEbq9eYNnuWl4VyDvT6Rmt
M05LKKKqkyU4hSgazUzupsnUp05UN15RAKrhK2aheAtsd+QD+QKNEaf3s88GkJWR
g+dN5qC7x1bcWFCNxH/K24yDjFhVjGJvUzAXqUJ8gw5qONCvodpaToFBHug5qRmz
EIMliSgpbadJmnsCGGs0rlow6pr0qv3tt7bkfYTjjfxuPiKX82FcgLChGMKNYCwB
5ROQ/WGfRKKj0NFKvrU6LoX48kIxLGLCWtwMmPtBnFkxy6vME60xPmxBLtpUa/9v
T5KlXjO7OuH1RbQi0nuuh0v2UsAgmoiombCnOSWzJaF/JKk3WqFgclifZRs42v69
1draPMmNsj1pGI9rooCk
=uYOH
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
