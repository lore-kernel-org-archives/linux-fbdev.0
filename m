From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 23 Feb 2016 18:14:48 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20160223181448.GA14754@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160223143859.GA27656@ulmo>
 <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 09:35:48AM -0800, Doug Anderson wrote:
> On Tue, Feb 23, 2016 at 6:38 AM, Thierry Reding <thierry.reding@gmail.com=
> wrote:
[...]
> > That's not quite what I was thinking. If hardware readout is supported
> > then whatever we report back should be the current hardware state unless
> > we're explicitly asked for something else. If we start mixing the state
> > and legacy APIs this way, we'll get into a situation where drivers that
> > support hardware readout behave differently than drivers that don't.
> >
> > For example: A PWM device that's controlled by a driver that supports
> > hardware readout has a current period of 50000 ns and the firmware set
> > the period to 25000 ns. pwm_get_period() for this PWM device will return
> > 50000 ns. If you reconfigure the PWM to generate a PWM signal with a
> > period of 30000 ns, pwm_get_period() would still return 50000 ns.
> >
> > A driver that doesn't support hardware readout, on the contrary, would
> > return 50000 ns from pwm_get_period() on the first call, but after you
> > have reconfigured it using pwm_config() it will return the new period.
>=20
> Ah, right!  I forgot that the existing API will be updated if you've
> reconfigured the period via pwm_config().  Ugh, you're right that's a
> little ugly then.
>=20
> So do we define it as:
>=20
> pwm_get_state(): always get the hardware state w/ no caching (maybe
> even pwm_get_raw_state() or pwm_get_hw_state())

Caching vs. no caching should be irrelevant here. Unless PWM hardware is
autonomous the current state will always match the hardware state after
the initial hardware readout.

> pwm_get_period(): get the period of the PWM; if the PWM has not yet
> been configured by software this gets the default period (possibly
> specified by the device tree).

No. I think we'll need a different construct for the period defined by
DT or board files. pwm_get_period() is the legacy API to retrieve the
"current" period, even if it was lying a little before the atomic API.

> Is that OK?  That is well defined and doesn't change the existing
> behavior of pwm_get_period().

pwm_get_period() is legacy API and in order to transition to the atomic
API it should be implemented in terms of atomic API. So the goal is to
get everything internally converted to deal with states only, then wrap
the existing API around that concept. pwm_get_period() would become:

	unsigned int pwm_get_period(struct pwm_device *pwm)
	{
		struct pwm_state state;

		pwm_get_state(pwm, &state);

		return state.period;
	}

If we don't do that, we'll never be able to get rid of the legacy API.

> >> > That way if you want to get the current voltage in the regulator-pwm
> >> > driver you'd simply do a pwm_get_state() and compute the voltage from
> >> > the period and duty cycle. If the PWM driver that you happen to use
> >> > doesn't support hardware readout, you'll get an initial output volta=
ge
> >> > of 0, which is as good as any, really.
> >>
> >> Sounds fine to me.  PWM regulator is in charge of calling
> >> pwm_get_state(), which can return 0 (or an error?) if driver (or
> >> underlying hardware) doesn't support hardware readout.  PWM regulator
> >> is in charge of using the resulting period / duty cycle to calculate a
> >> percentage.
> >
> > I'm not sure if pwm_get_state() should ever return an error. For drivers
> > that support hardware readout, the resulting state should match what's
> > programmed to the hardware.
> >
> > But for drivers without hardware readout support pwm_get_state() still
> > makes sense because after a pwm_apply_state() the internal logical state
> > would again match hardware.
>=20
> I guess it depends on how you define things.  With my above
> definitions it seems clearest if pwm_get_state() returns an error if
> hardware readout is not supported.  If we call it pwm_get_hw_state()
> it's even clearer that it should return an error.

Again, if we do this, we'll have to keep the legacy API around forever
and keep special-casing atomic vs. legacy API in every user. The goal is
to converge on the atomic API as the standard API in users so that the
legacy API can be removed when all users have been converted.

> > To allow your use-case to work we'd need to deal with two states: the
> > current hardware state and the "initial" state as defined by DT.
> > Unfortunately the PWM specifier in DT is not a full definition, it is
> > more like a partial initial configuration. The problem with that, and
> > I think that's what Mark was originally objecting to, is that it isn't
> > clear when to use the "initial" state and when to use the read hardware
> > state. After the first pwm_apply_state() you wouldn't ever have to use
> > the "initial" state again, because it's the same as the current state
> > (modulo the duty cycle).
> >
> > Also for drivers such as clk-pwm the usefulness of the "initial" state
> > is reduced even more, because it doesn't even need the period specified
> > in DT. It uses only the flags (if at all).
> >
> > Perhaps to avoid this confusion a new type of object, e.g. pwm_args,
> > could be introduced to hold configuration arguments given in the PWM
> > specifier (in DT) or the PWM lookup table (in board files).
> >
> > It would then be the responsibility of the users to deal with that
> > information in a sensible way. In (almost?) all cases I would expect
> > that to be to program the PWM device in the user's ->probe(). In the
> > case of regulator-pwm I'd expect that ->probe() would do something
> > along these lines (error handling excluded):
> >
> >         struct pwm_state state;
> >         struct pwm_args args;
> >         unsigned int ratio;
> >
> >         pwm =3D pwm_get(...);
> >
> >         pwm_get_state(pwm, &state);
> >         pwm_get_args(pwm, &args);
> >
> >         ratio =3D (state.duty_cycle * 100) / state.period;
> >
> >         state.duty_cycle =3D (ratio * args.period) / 100;
> >         state.period =3D args.period;
> >         state.flags =3D args.flags;
> >
> >         pwm_apply_state(pwm, &state);
> >
> > The ->set_voltage() implementation would then never need to care about
> > the PWM args, but rather do something like this:
> >
> >         struct pwm_state state;
> >         unsigned int ratio;
> >
> >         pwm_get_state(pwm, &state);
> >
> >         state.duty_cycle =3D (ratio * state.period) / 100;
> >
> >         pwm_apply_state(pwm, &state);
> >
> > Does that sound about right?
>=20
> That should work with one minor problem.  If HW readout isn't
> supported then pwm_get_state() in probe will presumably return 0 for
> the duty cycle.  That means it will change the voltage.  That's in
> contrast to how I think things work today where the voltage isn't
> changed until the first set_voltage() call.  At least the last time I
> tested things get_voltage() would simply report an incorrect value
> until the first set_voltage().  I think existing behavior (reporting
> the wrong value) is better than new behavior (change the value at
> probe).

That's exactly the point. Reporting a wrong value isn't really a good
option. Changing the voltage on boot is the only way to make the logical
state match the hardware state on boot. Chances are that if you don't
have hardware readout support you probably don't care what state your
regulator will be in.

Then again, if we don't support hardware readout, setting up the logical
state with data from DT (or board files) and defaulting the duty cycle
to 0, we end up with exactly what we had before, even with the atomic
API, right? Maybe that's okay, too.

> I'm curious, though.  In your proposal, how does pwm_get_period()
> behave?  To be backward compatible, I'd imagine that even in your
> proposal we'd have the same definition as I had above:
>=20
> pwm_get_period(): get the period of the PWM; if the PWM has not yet
> been configured by software this gets the default period (possibly
> specified by the device tree).

It would simply return the logical period of the PWM. For drivers that
support hardware readout it would always match the hardware period, but
for drivers that don't it might be wrong until state is first applied.

> If you have a different definition of pwm_get_period() in your
> proposal, please let me know!  If my definition matches your thoughts
> then I think we can actually just not touch the "set_voltage" call.
> It can always use pwm_get_period() and always use pwm_config() just
> like today.
>=20
> ...and if set_voltage() remains untouched then we can solve my probe
> problem by renaming pwm_get_state() to pwm_get_hw_state() and having
> it return an error if HW readout is not supported.  Then we only call
> pwm_get_args() / pwm_apply_state() when we support HW readout.

The problem is that we make the API clumsy to use. If we don't sync the
"initial" state (as defined by DT or board files) to hardware at any
point, then we need to add the pwm_args construct and always stick to
it. I think it weird to have to use the pwm_args.period instead of the
current period.

So we're back to square one, really. That's exactly what Mark brought up
originally.

> Thus, if HW readout:
>=20
> * In probe, we read HW state (pwm_get_hw_state) and atomically adjust
> (pwm_apply_state) based on arguments (pwm_get_args).
>=20
> * In set_voltage we use pwm_get_period which will return the period we
> applied in pwm_apply_state() and use pwm_config() to change the duty
> cycle.
>=20
>=20
> If no HW readout, no behavior change at all from today:
>=20
> * In probe we don't do anything to change the PWM
>=20
> * Upon the first set_voltage we use pwm_get_period() to get the period
> as specified in DT and use pwm_config() to change the duty cycle.
>=20
>=20
> That seems pretty sane to me.  What do you think?

This has the big disadvantage of having to special case hardware readout
vs. non-hardware readout providers. I think that makes the API really
difficult to use. It requires too many details to be aware of.

I guess this boils down to whether applying the "initial" state on probe
really is problematic.

Thierry

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWzKGUAAoJEN0jrNd/PrOhoO0QAJ8uOmB5+Erk/F1iFwnX7s2E
SvK0ldRjbK/veU2/YaGQww9DbI6osPlk2ZQostrU1iY4qQB8E5TqtR8MLQ0dkPoL
rtA81Lf9TmdQeb1upJeGHIifyY7M9nf5HSrq2kyqqGDHxoT+JtziGH0qDvSVy04e
it9fdfaIoXBuJGnVtZ+GKG7AtRRdw8R5+yePPzJCiozxyFeo8oHhddorCWI/0yiF
IlgAeRrNSDtm3G1udh9nu+8zgdISV+YKj1FvROY1OL7mm3C11FqNX4WKyzxSMuh5
BsOFBEB8O58dWIWL/1WtDozF9LHKjG1qWCfBpwIC9yMJ/DZ/Z90awTJzxL+vhadB
SFVUF3ZBFrXcyEES9onODaryvSsMTKJXB6OVPi0yT64yQ3WHh4gfZXRj5yLfjASk
u3Acw73pI5npf+YeKdhjgqxaTr9cyTmwPUSEEwEjXkDoYXHu76AR+yGfTILntREj
Qtt7lRmAWpQjRjqB+k+KoaR+oS2g6QS6vFflmukm4eTyuhQ18o3qXwhwZ6g1O4Mz
SRfrIbfzocIEdBTcvaEmflqp+J/r2LgosLXiBX3jx7pHXhsuhvUWg7mNoDjAuF9s
3KBr5xHjZ/7S+jqCCbg1onAG3Nk2ko0V78y1yKTW6BiUOmz0vlyGtli8zREH51zH
49t8r47Sx9sKIc3KkxhU
=FdvZ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
