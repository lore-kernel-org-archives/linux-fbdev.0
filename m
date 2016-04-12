From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 14:05:46 +0000
Subject: Re: [PATCH v5 15/46] pwm: introduce the pwm_state concept
Message-Id: <20160412140546.GS18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="b2ktwntdbf0dPnbx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
 <20160412114904.GM18882@ulmo.ba.sec>
 <20160412141718.5fe4cf24@bbrezillon>
 <20160412122141.GP18882@ulmo.ba.sec>
 <20160412144508.2ee181fe@bbrezillon>
 <20160412131118.GQ18882@ulmo.ba.sec>
 <20160412152644.45ff517a@bbrezillon>
In-Reply-To: <20160412152644.45ff517a@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--b2ktwntdbf0dPnbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 03:26:44PM +0200, Boris Brezillon wrote:
> On Tue, 12 Apr 2016 15:11:18 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Apr 12, 2016 at 02:45:08PM +0200, Boris Brezillon wrote:
> > > On Tue, 12 Apr 2016 14:21:41 +0200
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > > On Tue, Apr 12, 2016 at 02:17:18PM +0200, Boris Brezillon wrote:
> > > > > On Tue, 12 Apr 2016 13:49:04 +0200
> > > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > >=20
> > > > > > On Wed, Mar 30, 2016 at 10:03:38PM +0200, Boris Brezillon wrote:
> > > > > > > The PWM state, represented by its period, duty_cycle and pola=
rity,
> > > > > > > is currently directly stored in the PWM device.
> > > > > > > Declare a pwm_state structure embedding those field so that w=
e can later
> > > > > > > use this struct to atomically update all the PWM parameters a=
t once.
> > > > > > >=20
> > > > > > > All pwm_get_xxx() helpers are now implemented as wrappers aro=
und
> > > > > > > pwm_get_state().
> > > > > > >=20
> > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electron=
s.com>
> > > > > > > ---
> > > > > > >  drivers/pwm/core.c  |  8 ++++----
> > > > > > >  include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++=
++++++------------
> > > > > > >  2 files changed, 46 insertions(+), 16 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > > > > index 6433059..f3f91e7 100644
> > > > > > > --- a/drivers/pwm/core.c
> > > > > > > +++ b/drivers/pwm/core.c
> > > > > > > @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_=
chip *chip,
> > > > > > >  		pwm->chip =3D chip;
> > > > > > >  		pwm->pwm =3D chip->base + i;
> > > > > > >  		pwm->hwpwm =3D i;
> > > > > > > -		pwm->polarity =3D polarity;
> > > > > > > +		pwm->state.polarity =3D polarity;
> > > > > >=20
> > > > > > Would this not more correctly be assigned to pwm->args.polarity=
? After
> > > > > > all this is setting up the "initial" state, much like DT or the=
 lookup
> > > > > > tables would for duty cycle and period.
> > > > >=20
> > > > > Yes, I wasn't sure about the pwm_add_with_polarity() meaning. To =
me,
> > > > > all the reference info should be extracted from DT, PWM lookup ta=
ble or
> > > > > driver specific ->request() implementation, but I can definitely
> > > > > initialize the args.polarity here too.
> > > > >=20
> > > > > Should I keep the pwm->state.polarity assignment (to set the init=
ial
> > > > > polarity when the driver does not support hardware readout)?
> > > >=20
> > > > Wouldn't this work automatically as part of the pwm_apply_args() he=
lper
> > > > if we extended it with this setting?
> > >=20
> > > Well, as you explained in you answer to patch 5, pwm_apply_args()
> > > should be called on a per-request basis (each time a PWM device is
> > > requested), while the initial polarity setting should only be applied
> > > when registering the PWM chip (and its devices). After that, the
> > > framework takes care of keeping the PWM state in sync with the hardwa=
re
> > > state.
> > >=20
> > > Let's take a real (though a bit unusual) example. Say you have a sing=
le
> > > PWM device referenced by two different users. Only one user can be
> > > enabled at a time, but each of them has its own reference config
> > > (different polarity, different period).
> > >=20
> > > User1 calls pwm_get() and applies its own polarity and period. Then
> > > user1 is unregistered and release the PWM device, leaving the polarity
> > > and period untouched.
> > >=20
> > > User2 is registered and request the same PWM device, but user2 is
> > > smarter and tries to extract the current PWM state before adapting the
> > > config according to pwm_args. If you just reset pwm->state.polarity
> > > each time pwm_apply_args() is called (and you suggested to call it as
> > > part of the request procedure), then this means the PWM state is no
> > > longer in sync with the hardware state.
> >=20
> > In that case neither will be the period or duty cycle. Essentially this
> > gets us back to square one where we need to decide how to handle current
> > state vs. initial arguments.
>=20
> That's not true. Now we clearly differentiate the reference config
> (content of pwm_args which is only a subset of what you'll find in
> pwm_state) and the PWM state (represented by pwm_state).
>=20
> We should be safe as long as we keep those 2 elements as 2 orthogonal
> concepts:
> - pwm_args is supposed to give some hint to the PWM user to help him
>   configure it's PWM appropriately
> - pwm_state is here to reflect the real PWM state, and apply new
>   configs
>=20
> >=20
> > But I don't think this is really going to be an issue because this is
> > all moot until we've moved over to the atomic API, at which point this
> > is all going to go away anyway.
>=20
> As stated in my answer to patch 5, I think I misunderstood your
> suggestion. pwm_apply_args() is supposed to adjust the PWM config to
> match the period and polarity specified in pwm_args, right?
>=20
> If that's the case, my question is, should we really call this function
> each time a new user requests a PWM instead of letting those users call
> the function on-demand (not all users want to adapt the current PWM
> config to the pwm_args, some may just want to apply a completely new
> config).

I think we're still talking past each other. I didn't mean for this to
be a proper part of the API. Like you said the struct pwm_args doesn't
contain enough data to construct a complete state and apply it.

What I was suggesting is to factor out the individual calls to the
various pwm_set_*() functions into a single call. So we wouldn't be
changing semantics, just refactoring to make it easier to get rid of
again in one of the subsequent patches.

That is, pwm_apply_args() would go away again within this very series,
at the same point that you're currently removing the pwm_set_*() calls.

Thierry

--b2ktwntdbf0dPnbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDQC4AAoJEN0jrNd/PrOhNRIP/2xHjheMKjW3cDj9MGWxNkwk
1o4JPOi0T9Ztmf2SMavPa5y7DQnbeUKt9pEuo9kcvcXfMUhtu2VuO5SsuQ2vfesI
Hox5be77LMUIjuLDjZhMYpSWGaEAsREzOIDwSgCrgdkTKjNsxjKkZl+7iIS/WVIW
oNrM+AbxpHYWlS0mYSBJMq/SVl3dXDZh0cOTvFbKDmP9fAEcqyRM425eZFz4QWzb
1SOciVJQ7XupH/eNpNQTBrMIfmjHaixwWO+82hx3urVewdBzJUg741aO66RFhkNh
adTRZF2WmhiNEqtwCkLuNGH+b+9XxhzRboL8jA/lQO8xTqpifP5WFRaCPYZTmrJy
bgcilFAECJWYlLF40/zaVzDGKFa8IcLv3bX8B64J930Gz+dp5JZR9eGjUoPez73z
QypS+rDnXN7x2TDt8PmuxK2yU1UYeFJ9R/7MwivVA/wJyPyHEe1Cm402eHqgPUkf
Nt3UK4PnE+43xIhdOQwujQfHBo5shCEAgeQfWVEvpygAaF5oFPZXMDrIFdcHps2z
Dinx6Et3ETJ/U8ehtVYUB8LI1fgBSLqbPZ7msclKwyHKu/43N5c1zhqlG4BcstVo
HUVoNBZ3GYFA0NNHO/2y/jyhI0Ar3ZKFRw4N9+smgYy91Nn0i1RyBkdB/rtF3GHN
POyJEJ6ZOkEz98CDQS/O
=Peoo
-----END PGP SIGNATURE-----

--b2ktwntdbf0dPnbx--
