From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Apr 2016 04:42:03 +0000
Subject: Re: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
Message-Id: <20160412044203.GW3351@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xsILJLaVOAbiPmXa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
 <20160330212410.GX2350@sirena.org.uk>
 <20160407235431.788dc24a@bbrezillon>
In-Reply-To: <20160407235431.788dc24a@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee


--xsILJLaVOAbiPmXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 11:54:31PM +0200, Boris Brezillon wrote:

> Is there any reason for calling set_machine_constraints() after
> device_register() in regulator_register()?

I'm not sure there's a strong one, we don't really use the class device
for anything, but without doing a full audit I couldn't guarantee that.

--xsILJLaVOAbiPmXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDHyaAAoJECTWi3JdVIfQ6DgH/2y6DxyL0olPRjq8kiN0Mw6a
b3LLXd3ddx4NsYasp/3lDQK53ChTu4nF8prj70B5jGVh8vBk73k8kOHBpGr8weeq
HERNBp+ZZ5S3c7o/MaM2E08uFQKAKyf8ufmw6qpSBWPrINUoLwWsKzngBp05Q2S8
/CTQ7wnM2TTgA7BsPf8SNJDz6/KmKyMahe54Cf+UGBfW6ctYLP4tkvpAwSe3601x
OUlYcWYzGWzV1ZdF+3b3LACnjV5FtwR3cTfSO+VcZ4jfwTN0VQbXnRZ+A8RaO9r+
VVYDNlHQ+/58wHW+oLThZW0nuPw8mC3P7FA2R9I9dkonKHA60ep7jUekQgssG/c=
=WLfE
-----END PGP SIGNATURE-----

--xsILJLaVOAbiPmXa--
