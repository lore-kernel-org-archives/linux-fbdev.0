From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2016 21:24:10 +0000
Subject: Re: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
Message-Id: <20160330212410.GX2350@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+1tcKVLXPU0QafK6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-31-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee


--+1tcKVLXPU0QafK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 10:03:53PM +0200, Boris Brezillon wrote:
> The continuous PWM voltage regulator is caching the voltage value in
> the ->volt_uV field. While most of the time this value should reflect the
> real voltage, sometime it can be sightly different if the PWM device
> rounded the set_duty_cycle request.
> Moreover, this value is not valid until someone has modified the regulator
> output.

Acked-by: Mark Brown <broonie@kernel.org>

--+1tcKVLXPU0QafK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/EP5AAoJECTWi3JdVIfQtmsH/ipnuxlqfguiud0BHLIawruP
udVbyxUF2cZ988A7zoAajtGLrRz0zNSluNU0PRxG+UJxeSR3AhH3sjFuNzFcLtcj
TMmiCOeDugMKtX0Zg1PZ7pcjqUhunn6+dsKEgyVxep94s4TujTvzOXpuYNbHsBuD
eGxym5NCDFRqepzQmD28j02zXOmgOYRK1mOT9tM0Ro7iGFRnkR53yaMpIR2c5aEj
7axjIkIEtaQNO9GsUPo1xGoG1pd8tVPnugL8mgA3PSJSJXCXm+lVscQd8anK8IZ9
Nl8qcTaJYIqe9RCo1Fyoi6zlmAGFaQwvf3jQS5+UzGi0T+gpZr0+ja99wawDCAg=
=m9XJ
-----END PGP SIGNATURE-----

--+1tcKVLXPU0QafK6--
