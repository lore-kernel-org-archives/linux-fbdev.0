From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 20 Jul 2015 08:22:42 +0000
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity concepts
Message-Id: <20150720082241.GJ29614@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVh9lyqKgK19OcEf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150702064445.GC11824@pengutronix.de>
 <20150702094955.4b1c9254@bbrezillon> <20150720080313.GF29614@ulmo>
 <20150720101443.180ebddb@bbrezillon>
In-Reply-To: <20150720101443.180ebddb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:14:43AM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Mon, 20 Jul 2015 10:03:14 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Jul 02, 2015 at 09:49:55AM +0200, Boris Brezillon wrote:
> > > On Thu, 2 Jul 2015 08:44:45 +0200
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >=20
> > > > On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > > > > When requested by a user, the PWM is assigned a default period an=
d polarity
> > > > > extracted from the DT, the platform data or statically set by the=
 driver.
> > > > > Those default values are currently stored in the period and polar=
ity
> > > > > fields of the pwm_device struct, but they will be stored somewher=
e else
> > > > > once we have introduced the architecture allowing for hardware st=
ate
> > > > > retrieval.
> > > > >=20
> > > > > The pwm_set_default_polarity and pwm_set_default_period should on=
ly be
> > > > > used by PWM drivers or the PWM core infrastructure to specify the
> > > > > default period and polarity values.
> > > > Would it make sense to put the prototypes of
> > > > pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private=
=2Eh
> > > > then?
> > > >=20
> > >=20
> > > Yes, definitely. I was thinking about moving those functions/prototyp=
es
> > > into include/linux/pwm-provider.h, but I'm fine with
> > > drivers/pwm/pwm-private.h too.
> > >=20
> > > Thierry, any opinion ?
> >=20
> > I'm not sure I see the need for this. If they are the default values and
> > drivers have no need to change them, then storing them in the regular
> > period and polarity fields seems just fine (they'll be propagated into
> > new state objects as they get created).
> >=20
> > And if the driver has a need to change them, then why would it ever care
> > about the default values?
>=20
> Because the period is often directly extracted from the DT, and this
> extracted period may not match the one configured by the bootloader.
>=20
> If the driver wants to display the current status without changing the
> PWM state, then the driver will use the current state. ITOH, if it
> has to apply a new config, the driver will use the default period
> value (extracted from the DT) and change the duty-cycle depending on its
> needs.
> This is the case we have with the pwm-regulator driver: we want to
> display the initial voltage value without changing the PWM config, and
> when someone decides to change the voltage, we want to use the default
> period instead of keeping the one configured by the bootloader.

Wouldn't it make more sense to postpone this until the introduction of
the default state, then? That way we'd be getting a more consistent way
of dealing with default vs. initial by looking only at state objects.

Ideally initial state should be the same as the default state. Except
maybe for the duty-cycle, which won't be encoded in the default state
anyway.

Thierry

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrK/RAAoJEN0jrNd/PrOh3LMP/3AEp+fqaBT1N7VSJN/V58L9
t0vzOQGMhJem4CWzT/8d2FlnjZbte43xW/smRaPJMAun88XVLw/dM8dZGfAmhsnu
b0PqoN0CkjyRtePMo8Kay4o9tD4rox2MwBKuCKOo9Ql6vECl5yRR347LNKmDQyVi
cyF00Pd2A9bbZlcMM9vPm8Jt3tvLDF6fB4fODNMyLDYLmuymZKsapNPRZ6/dwGFF
+aWOGtdMGQ4z8WU10JcDR0N8sJW1HqHxkImTk2PAFGFHSqmCbuxKfcShN9V/B+eF
MX60rkq0UM6vyftDfmXJOnlCcE+z39SmAMPOu4kYJYgerWkvEOQnn5ofH2uW1ih9
gTTj8gkuu100F8ewERRmDSvN6KYgTjbYB3nKNBolJ719d0+m9Pj6pKCYsSKoATHR
WfSNc/qv1sH77MKA+MqEB/Z1QP7CXVOuUze9hurtLmVVAVmeXMvrX3Le2r+C2zto
tC7btaBChO6i2nAKNyqfgpb81ud7/odhyyvqkC80ZMY6nuKIsJPwJ+VD0OtvAS/l
c+7DumiXtwHECB+A3vU+DML5j1F4XPaXD6lNjhj0fzoozRnMQDSZ3abnTxMEI99c
rYB/nRk4+oVzUC2Sa5FQh+re2Ma6/0LhcYUAYRsEC6oXOX4CFY4Lusr8808UvHN8
I1dJRtSZ5Wxb/nWnojGZ
=TDkp
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
