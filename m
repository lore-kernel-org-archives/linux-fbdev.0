From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 14:25:09 +0000
Subject: Re: [PATCH v5 02/46] backlight: pwm_bl: remove useless call to pwm_set_period()
Message-Id: <20160412142509.GA25006@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110350.GH18882@ulmo.ba.sec>
 <20160412141653.GJ8094@x1>
In-Reply-To: <20160412141653.GJ8094@x1>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 03:16:53PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
>=20
> > On Wed, Mar 30, 2016 at 10:03:25PM +0200, Boris Brezillon wrote:
> > > The PWM period will be set when calling pwm_config. Remove this usele=
ss
> > > call to pwm_set_period(), which might mess up with the internal PWM s=
tate.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > Applied, thanks.
>=20
> Applied?

You Acked it, so I assumed you were fine with me taking it through the
PWM tree to take care of the dependencies.

Did I assume wrongly?

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDQVCAAoJEN0jrNd/PrOhO+sQAIcwHY4cYUR6sTtIxCo+Uou4
i+Kuc1PlVOg+nbjWKFt5fFgMPE0F7MLYXS7CqwOMZ0iPyR+9kuWXJG+TxjbQiQGv
HpSirq5pUiCGPfRaHrLmdSWa4U5T1iKEAuh3Vld8czk49n3Dnj1fUVI80QkxRx2G
4JoNuACtNWMlJyJ1ZkAoka4GDT7OebN1BTOSotPNAArUoQpQubKm7HEcycreqkCK
F7btmSUexRfEloxATYnAuqaMRnSur/WA4FgTeDenIsZnQf4fHEtYe4wou3yCfJCm
ESKcjFc/knCBWrCswm5jI1kRrk4I5O7Me1rEeRWWQdf1x5IVKRZyq68PA2o74LgD
em16YvdYaaM2jMjiJ4TDueo6g97UC9mHKTLM6dTtqgdaodJWtu2FHXya37oda7nx
wsfpK8KUdguLkt6cJqptQx4KYdACm5QFDYW+vJyeL12QSisXmZ8sxKFGPO/dxb/t
YIw3W4WniASa4pBx6ZrOCTIJOqMv2eZqbJW3XjK+XpLv8o7zYovXYL+CgXPXCwXW
ZrQsJrqK9Uaz20U4+7NFDX5F1d2PyIJYiZ7XrGxFlk2e59maGpQg7Z/Nbra7L/ui
asd0pSLdkFDghkrSgmQvHF4yek/09FNNSTpoDa3MBifUEwfdy1MONB1orHaN+6n1
9KLxLpBo4dslwwYODbl/
=JTlp
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
