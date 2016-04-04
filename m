From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 04 Apr 2016 15:30:29 +0000
Subject: Re: [PATCH v5 34/46] clk: pwm: switch to the atomic API
Message-Id: <20160404153029.GC17856@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ctP54qlpMx3WjD+/"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
 <20160330220149.GU18567@codeaurora.org>
 <20160331085735.3574970b@bbrezillon>
In-Reply-To: <20160331085735.3574970b@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 08:57:35AM +0200, Boris Brezillon wrote:
> Hi Stephen,
>=20
> On Wed, 30 Mar 2016 15:01:49 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
>=20
> > On 03/30, Boris Brezillon wrote:
> > > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > > index ebcd738..49ec5b1 100644
> > > --- a/drivers/clk/clk-pwm.c
> > > +++ b/drivers/clk/clk-pwm.c
> > > @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct c=
lk_hw *hw)
> > >  static int clk_pwm_prepare(struct clk_hw *hw)
> > >  {
> > >  	struct clk_pwm *clk_pwm =3D to_clk_pwm(hw);
> > > +	struct pwm_state pstate;
> > > =20
> > > -	return pwm_enable(clk_pwm->pwm);
> > > +	pwm_get_state(clk_pwm->pwm, &pstate);
> > > +	if (pstate.enabled)
> > > +		return 0;
> > > +
> > > +	pstate.enabled =3D true;
> > > +
> > > +	return pwm_apply_state(clk_pwm->pwm, &pstate);
> >=20
> > This doesn't seem atomic anymore if we're checking the state and
> > then not calling apply_state if it's already enabled. But I
> > assume this doesn't matter because we "own" the pwm here?
>=20
> Yep. Actually it's not atomic in term of concurrency (maybe the
> 'atomic' word is not appropriate here). Atomicity is here referring to
> the fact that we're now providing all the PWM parameters in the same
> request instead of splitting it in pwm_config() + pwm_enable/disable()
> calls.

It's usually not possible to do really atomic updates with PWM hardware.
The idea is merely that we should be able to submit one request and the
framework (and drivers) will be responsible for making sure it is
applied as a whole or not at all. With the legacy API it is possible for
users to set the duty cycle and period, but then fail to enable/disable
the PWM.

pwm_apply_state() reporting success should indicate that the hardware
state is now what software wanted it to be. That kind of implies that
the application is serialized.

This doesn't imply that hardware state won't change between a call to
pwm_get_state() and pwm_apply_state(), though technically this is what
will usually happen because PWM devices are exclusively used by a single
user. Users are responsible for synchronizing accesses within their own
code.

> Concurrent accesses still have to be controlled by the PWM user (which
> is already the case for this driver, thanks to the locking
> infrastructure in the CCF).
>=20
> > Otherwise I would think this would be unconditional apply state
> > and duplicates would be ignored in the pwm framework.
> >=20
>=20
> Yep, I'll remove the if (pstate.enabled) branch.

Yes, it should be the PWM framework's job to check for changes in state
and discard no-ops.

Thierry

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXAoiUAAoJEN0jrNd/PrOh770QAL7A4P9FXDqUgGYy3Fh1Z0tC
W1sLVSxLFyxsC7iFVKWBqTGcTPdXVC5vQ7BJ/CViZxPN0zLRFE2XPIlLHbXfALGI
ioNodJFDMt7ZXy2vsiIUnhs1fQKD1xkulE0KmQE03GGX9U80wdw5eN6fTZ1WgoCj
x+vjcPFZ/FKpJ7krY6AC08Rj8EA9Ki8CDmy5BhqalWSJEqN3Wbj6XYmzJbBKUMQ9
I6UG9Zp+qrgz202OKeRNUdV2wn8ZbguomNCKC32Ue38uI1J2hp8bbyV363QQ3pSy
cIdiGfbZUfabQtSKDj/qqZ4C77yRigh4Aw70AJtC5cUkGzWH74IcVt9zBeI0k4ZY
qbJ5RnprnryDWVpvjB1kVW8mdqVjcd6IqK6YyvmqPG4ziaAo6Vjvpl2UaWmnu4NV
PcbYFAi8H8ySIUQnnvCYvZuJVbQ8szDkjrovYbnKcGF+7mcp8ltT81VJHG9FM0Y7
xULfQYeQeI8twq4v0Vjq7LzpMjCSeFlzVMS1aqUhmtIUJVDI8E+ZHcKV8+SsPel2
OAKBx6rcm/edT9r1OtIQmFaK7fPPaIStQPJBPf8RXxXta0+NmYn3nHsvFNO9CV0f
fsIYD3t6rCXMEzMkCT6gSTFDFex2ouabZ440jyFMqSFoZeePpKfNhHs/DrS5rU+K
VpRarTkMkp5A7DwPIDbk
=rj9Q
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
