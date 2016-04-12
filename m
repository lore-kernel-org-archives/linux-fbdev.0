From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 11:39:12 +0000
Subject: Re: [PATCH v5 05/46] pwm: introduce the pwm_args concept
Message-Id: <20160412113912.GK18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Ah40dssYA/cDqAW1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-6-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:28PM +0200, Boris Brezillon wrote:
> Currently the PWM core mixes the current PWM state with the per-platform
> reference config (specified through the PWM lookup table, DT definition or
> directly hardcoded in PWM drivers).
>=20
> Create a pwm_args struct to store this reference config, so that PWM users
> can differentiate the current config from the reference one.
>=20
> Patch all places where pwm->args should be initialized. We keep the
> pwm_set_polarity/period() calls until all PWM users are patched to
> use pwm_args instead of pwm_get_period/polarity().

Perhaps a helper would be useful? Something like:

	static inline void
	pwm_apply_args(struct pwm_device *pwm, const struct pwm_args *args)
	{
		pwm_set_duty_cycle(pwm, args->duty_cycle);
		pwm_set_period(pwm, args->period);
	}

? That would make it slightly easier to get rid of it again after all
clients have been converted.

With the exception of pwm-clps711x all of these args are set at of_xlate
time (for DT) or from the lookup table in pwm_get() (for non-DT), so it
might even be possible to move this call to the core, so that removal of
it will be a one-liner.

Thierry

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDN5dAAoJEN0jrNd/PrOhqrMP/1GyMeElT/9kJJHiSyaOgN5n
MPhuI5mth5V2b9E7zzGZAOxnp4JIdGhPiIGKWaJeqc8LkwXK8oQanTtKlQjFZC7J
AvB4RezK7kN5+8c5QqQ3jeGTpGO2FebGf0kJld9MkH2V4P0CuwCdMChxApXXK728
SMsYxDkNl0PupxKV6ZDRqbSZIEwoQZihKNUNqAalJbl6l2v0NVAEP+YhS+NnUO9p
IB+D2kwvYg2+ke3vi0GNkrdeFujbuu+oVbvgdejHJHxy8RSKDNCUOUlAA0pXQ9N5
34jUD1kWFlepf6PN5DEMJ6oL8YpSfzYgPJ+NcSKa/5incyinTqtVLMhPx4naFZa6
dwBIC3foyIs2D1Ef7xPVLthV4qVTdw2LSipTteCJL5P/xwvATGsauf8AQNBZyGxO
5wwxvePJgJ14fvIkcINXxXvnmTa1B5L+WeKaUozZ+yJp+RzCmluCEsylJR8905nX
4M8j3cSl4yE3rSWCDyYh2+JbquVrX+enZrx2C/jb/3J7BbbLd8C3H47VMHElbvPu
n6/tLKj8V9BhvrEg+hoPVJzuSERa44pq0F5rEusaw47OGZgW59/v3aa4dPWcbT8k
BNaX/tTpFt1tzzZun42of7mFkMSaLr9Rd/WPk7fymbi3jlFniDWe0ZAJKKYIT/a7
k0UlPqmhLACboj5tC/qq
=+BbA
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
